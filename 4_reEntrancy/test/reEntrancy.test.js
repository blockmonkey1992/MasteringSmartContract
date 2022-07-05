const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Test Re-Entrancy", function () {
  let deployer, user, attacker;

  beforeEach(async ()=> {
    [deployer, user, attacker] = await ethers.getSigners();

    const SavingsAccounts = await ethers.getContractFactory("SavingsAccount", deployer);
    this.savingsAccounts = await SavingsAccounts.deploy();

    await this.savingsAccounts.deposit({ value : ethers.utils.parseEther("100")});
    await this.savingsAccounts.connect(user).deposit({ value : ethers.utils.parseEther("55")});

    const Investor = await ethers.getContractFactory("Investor", attacker);
    this.investor = await Investor.deploy(this.savingsAccounts.address);
  });

  it.skip("check Balance", async () => {
    console.log("this.savingsAccounts BalanceOf");

    const balanceOfDeployer = await this.savingsAccounts.balanceOf(deployer.address);
    const balanceOfUser = await this.savingsAccounts.balanceOf(user.address);

    console.log(`balanceOfDeployer : ${balanceOfDeployer}`);
    console.log(`balanceOfUser : ${balanceOfUser}`);

    await this.savingsAccounts.withdraw();

    const balanceOfDeployer_after = await this.savingsAccounts.balanceOf(deployer.address);
    const balanceOfUser_after = await this.savingsAccounts.balanceOf(user.address);

    console.log(`balanceOfDeployer_after : ${balanceOfDeployer_after}`);
    console.log(`balanceOfUser_after : ${balanceOfUser_after}`);
  });

  it("Re-Entrancy Attack", async () => {
    await this.investor.attack({ value : ethers.utils.parseEther("1") });
  })
});
