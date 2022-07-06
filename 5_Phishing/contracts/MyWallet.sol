//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "hardhat/console.sol";

contract MyWallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    event Withdraw(address _recipient, uint _value, uint _caBalance);

    receive() external payable {
        emit Withdraw(owner, msg.value, address(this).balance);
    }

    function withdraw(address _recipient)
        external 
        {
            require(tx.origin == owner, "Caller Not Authorized");
            payable(_recipient).call{value : address(this).balance}("");
        }
}
