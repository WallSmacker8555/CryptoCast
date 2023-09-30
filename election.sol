pragma solidity >0.5.1;

contract Election {
    mapping(uint => VotingStatus) public voters;
//    mapping(string => uint) public canditates;
    
    string public name = "Default Name";
    address public admin;
    Range public range = Range(0, 0);
    
    enum VotingStatus {
        notRegistered,
        registered,
        alreadyVoted
    }

    struct Range {
        uint256 openTime;
        uint256 closeTime;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "only adminstrator can call this function");
        _;
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
    
    function vote(uint _voterHash) public {
        require(block.timestamp >= range.openTime);
        require(block.timestamp <= range.closeTime);
        require(voters[_voterHash] != VotingStatus.notRegistered, "voter must be registered"); 
        require(voters[_voterHash] != VotingStatus.alreadyVoted, "voter can only vote once"); 
        voters[_voterHash] = VotingStatus.alreadyVoted;
    }
    
   function setValidRange(uint256 _start, uint256 _end) public onlyAdmin() {
        range = Range(_start, _end);
    }
    
    function setName(string memory _name) public onlyAdmin() {
        name = _name;        
    }
}
