pragma solidity ^0.4.17;

contract ENS {
    address public owner;
    mapping(string=>address)  ensmap;
    mapping(address=>string)  addressmap;
    
    constructor() public {
        owner = msg.sender;
    }
     //????
     function setEns(string newEns,address addr) onlyOwner public{
          ensmap[newEns] = addr;
          addressmap[addr] = newEns;
     }
     
    //??ens??0x??
     function getAddress(string aens) view public returns(address) {
           return ensmap[aens];
     }
	 //??address????
     function getEns(address addr) view public returns(string) {
           return addressmap[addr];
     }
    //?????
    function transferOwnership(address newOwner) onlyOwner public {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }

     //????? 
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
  
}