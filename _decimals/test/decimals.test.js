const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Test Decimals", function async() {
  let deployer, user;

  before(async() => {
    [deployer, user] = await ethers.getSigners();
    const Decimals_artifacts = await ethers.getContractFactory("Decimals", deployer);
    this.decimals_contract = await Decimals_artifacts.deploy();
  })

  it("Deploy Test", async() => {
    const result = await this.decimals_contract.div(10, 4);
    console.log(result);
  })
});
