//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract EternalWords{
 uint256 totalEternalMessages;
 uint256 private seed;
 
 event NewEternalWord(address indexed from, uint256 timestamp, string message);

 struct EternalMessage {
 	address sender; 
 	string message;
 	uint256 timestamp;
 }

 EternalMessage[] ems;

 mapping(address => uint256) public lastMessagedAt;
 
 constructor() payable {
   console.log("Send a message to this contract to immortalize it on the Ethereum blockchain!");
   seed = (block.timestamp + block.difficulty) % 100;
   }

function storeMessage(string memory _message) public {
   require(lastMessagedAt[msg.sender] + 60 minutes < block.timestamp,"You are only allow to send a message every 60 minutes!");
   lastMessagedAt[msg.sender] = block.timestamp;
   
   totalEternalMessages += 1;
   console.log("%s has sent a message", msg.sender);
   
   ems.push(EternalMessage(msg.sender, _message, block.timestamp));
   seed = (block.timestamp + block.difficulty) % 100;
   console.log("Random # generated: %d", seed);
   if (seed <= 50) {
      console.log("%s won!", msg.sender);
      uint256 prizeAmount = 0.0001 ether;
      require(
         prizeAmount <= address(this).balance,
         "Trying to withdraw more money than the contract has."
      );
     (bool success, ) = (msg.sender).call{value: prizeAmount}("");
     require(success, "Failed to withdraw money from contract.");
    }
   
   emit NewEternalWord(msg.sender, block.timestamp, _message);
}

function getAllMessages() public view returns (EternalMessage[] memory) {
        return ems;
    }
    
function getTotalMessages() public view returns (uint256){
  console.log("This contract has received %s total messages", totalEternalMessages);
  return totalEternalMessages;
  }
}

