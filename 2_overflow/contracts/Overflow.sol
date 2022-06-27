//SPDX-License-Identifier: Unlicense
pragma solidity 0.6.0;

contract Overflow {
    uint8 public score = 0;

    function up(uint8 _amount) external returns (uint){
        score += _amount;
    }

    function down(uint8 _amount) external returns (uint){
        score -= _amount;
    }
}
