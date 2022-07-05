//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "hardhat/console.sol";

contract SavingsAccount {
    mapping(address => uint256) public balanceOf;

    function deposit()
    external payable
    {
        balanceOf[msg.sender] += msg.value;
    }

    function withdraw()
    external
    {
        require(balanceOf[msg.sender] > 0, "Msg.sender have No Balance");
        uint depositedAmount = balanceOf[msg.sender];
        payable(msg.sender).call{value : depositedAmount}("");
        balanceOf[msg.sender] = 0;
    }
}
