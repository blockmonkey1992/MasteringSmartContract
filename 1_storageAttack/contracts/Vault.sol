//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.13;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Vault is Ownable {
    bytes32 private mySecret;

    constructor(bytes32 _secret) {
        mySecret = _secret;
    }

    event valueReceived(address user, uint amount);

    receive() external payable {
        emit valueReceived(msg.sender, msg.value);
    }

    modifier checkSecret(bytes32 _secret) {
        require(mySecret == _secret, "Wrong Secret!");
        _;
    }
    
    function deposit() external payable onlyOwner {}

    function withdraw(bytes32 _secret) external checkSecret(_secret) {
        payable(msg.sender).transfer(address(this).balance);
    }
}
