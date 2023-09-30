pragma solidity 0.5.1;

contract Election {
    mapping(uint => bool) public voters;
//    mapping(string => uint) public canditates;
    
    string name;
    address owner;
    
    struct Range {
        uint256 openTime;
        uint256 closeTime;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
   
    constructor() public {
        owner = msg.sender
    } 
    
    function register(uint memory _voterHash) public {
        require(block.timestamp >= openTime);
        require(block.timestamp <= closeTime);
        people[_voterhash] = true;
    }
    
    function vote(uint memory _voterHash) public {
        require(block.timestamp >= openTime);
        require(block.timestamp <= closeTime);
        require(people[_voterHash]); 
        people[_voterhash] = false;
    }
    
   function setValidRange(uint256 memory _start, uint256 memory _end) public onlyOwner() {
        range = Range(_start, _end);
    }
    
    function setName(string memory _name) public onlyOwner {
        name = _name;        
    }
}
