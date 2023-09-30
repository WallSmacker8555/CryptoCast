pragma solidity >0.5.1;

contract Election {
    mapping(uint => VotingStatus) public voters;
    mapping(uint => uint) public candidates;
    
    string public name = "Default Name";
    address public admin;
    Range public range = Range(0, 0);
    
    enum VotingStatus {
        notRegistered,
        registered,
        alreadyVoted
    }

    struct Range {
        uint openTime;
        uint closeTime;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "only adminstrator can call this function");
        _;
    }
   
    constructor(String memory _name, uint _start, uint _end) {
        name = _name;
        range = Range(_start, _end);
        admin = msg.sender;
    } 

    constructor() {
        admin = msg.sender;
    } 
    
    function register(uint _voterHash) public {
        require(block.timestamp >= range.openTime);
        require(block.timestamp <= range.closeTime);
        require(voters[_voterHash] == VotingStatus.notRegistered, "Voted can only register once");
        
        voters[_voterHash] = VotingStatus.registered;
    }
    
    function vote(uint _voterHash, uint _candidateHash) public {
        require(block.timestamp >= range.openTime);
        require(block.timestamp <= range.closeTime);
        require(voters[_voterHash] != VotingStatus.notRegistered, "voter must be registered"); 
        require(voters[_voterHash] != VotingStatus.alreadyVoted, "voter can only vote once"); 
        
        candidates[_candidateHash] += 1;
        voters[_voterHash] = VotingStatus.alreadyVoted;
    }
    

   function setValidRange(uint _start, uint _end) public onlyAdmin() {
        range = new Range(_start, _end);
    }
    
    function setName(string memory _name) public onlyAdmin() {
        name = _name;        
    }
}

contract ElectionFactory {
    uint numElections = 0;
    election[] public elections;
    
    address factoryAdmin
    
    constructor() public {
        msg.sender = factoryAdmin;
    }
    
    modifier onlyFactoryAdmin() {
        require(msg.sender == factoryAdmin, "Must be factory admin");
        _;
    }
    
    function createElection() public onlyFactoryAdmin() {
        Election election = new Election();
        elections.push(election)
    }
}
