//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Auction {
    
    address payable public currentLeader;
    uint256 public highestBid;

    struct Refund {
        address payable addr;
        uint amount;
    }

    Refund[] public refunds;

    function bid() external payable {
        require(msg.value > highestBid, "Not Enough Money!");

        if(currentLeader != address(0)) {
            refunds.push(Refund(currentLeader, highestBid));
        }

        currentLeader = payable(msg.sender);
        highestBid = msg.value;
    }

    function refundAll() external {
        for(uint i; i < refunds.length; i++) {
            (bool sent, ) = refunds[i].addr.call{ value : refunds[i].amount }("");
            require(sent, "Refund is not properly");
        }
        delete refunds;
    }
}
