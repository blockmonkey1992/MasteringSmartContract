const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Interaction Test", function () {
  let deployer, user;
  
  beforeEach(async() => {
    [deployer, user] = await ethers.getSigners();

    const SavingsAccount = await ethers.getContractFactory("SavingsAccount", deployer);
    this.savingsAccount = await SavingsAccount.deploy();

    const Investor = await ethers.getContractFactory("Investor", deployer);
    this.investor = await Investor.deploy(this.savingsAccount.address);
  })

  it("Deposit Test", async () => {
    expect(await this.savingsAccount.balanceOf(user.address)).to.eq(0);
    await this.savingsAccount.connect(user).deposit({ value : 100 });
    expect(await this.savingsAccount.balanceOf(user.address)).to.eq(100);
  })

  it("Withdraw Test", async () => {
    expect(await this.savingsAccount.balanceOf(user.address)).to.eq(0);
    await this.savingsAccount.connect(user).deposit({ value : 100 });
    expect(await this.savingsAccount.balanceOf(user.address)).to.eq(100);

    await this.investor.withdrawFromSavingsAccount();
    expect(await this.savingsAccount.balanceOf(this.investor.address)).to.eq(0);
  })
});

