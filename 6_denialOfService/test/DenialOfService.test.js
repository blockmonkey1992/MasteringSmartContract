const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DoS", function () {
  let deployer, attacker, user;

  beforeEach(async function() {
    [deployer, attacker, user] = await ethers.getSigners();

    const Auction = await ethers.getContractFactory("Auction", deployer);
    this.auction = await Auction.deploy();

    this.auction.bid({ value : 100 });
  })

  it("Bid Lower", function()=> {
    await expect(this.auction.connect(user))
  })

  
});
