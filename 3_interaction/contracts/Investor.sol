// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

interface ISavingsAccount {
    function deposit() external payable;

    function withdraw() external;
}

contract Investor {
    ISavingsAccount public immutable savingsAccount;
    address private owner;
    
    constructor(address _savingsAccountAddress) {
        savingsAccount = ISavingsAccount(_savingsAccountAddress);
        owner = msg.sender;
    }

    function depositIntoSavingsAccount()
    external payable 
    {
        savingsAccount.deposit{ value : msg.value }();
    }

    function withdrawFromSavingsAccount()
    external payable
    {
        savingsAccount.withdraw();
    }

    receive() external payable {
        payable(owner).transfer(address(this).balance);
    }
}