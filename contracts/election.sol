//SPDX-License-Identifier: UNLICENSED
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
   
    constructor(string memory _name, uint _start, uint _end) {
        name = _name;
        range = Range(_start, _end);
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
        range = Range(_start, _end);
    }
    
    function setName(string memory _name) public onlyAdmin() {
        name = _name;        
    }
}

contract ElectionFactory {
    uint numElections = 0;
    Election[] public elections;
    
    address factoryAdmin;
    
    constructor() {
        factoryAdmin = msg.sender;
    }
    
    modifier onlyFactoryAdmin() {
        require(msg.sender == factoryAdmin, "Must be factory admin");
        _;
    }
    
    function createElection(string memory _name, uint _start, uint _end) public onlyFactoryAdmin() {
        Election election = new Election(_name, _start, _end);
        elections.push(election);
    }
}
