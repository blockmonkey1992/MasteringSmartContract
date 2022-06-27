//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

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
        uint amountDeposited = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        
        // payable(msg.sender).transfer(amountDeposited); // 2300 gas Limited Should be ERR;

        (bool success, ) = payable(msg.sender).call{ value : amountDeposited }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}
