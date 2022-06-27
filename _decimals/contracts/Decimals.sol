//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Decimals {
    function div (uint numer, uint domi) // 10 / 4
    public view
    returns(uint, uint)
    {
        uint decimals = 10 ** 2;
        uint quotient = numer / domi; // 10 / 4의 정수값
        uint remainder = (numer * decimals / domi) % decimals; // 10 / 4 의 소수값
        console.log(remainder);
        return (quotient, remainder);
    }
}

contract Percentage {
    // 1.85 Percent Of commision
    function calculateFee(uint amount) external pure returns(uint) {
        return amount * 185 / 10000;
    }
}
