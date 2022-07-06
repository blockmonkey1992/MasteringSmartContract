const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Phishing Attack Test", function () {
  let deployer, attacker, user;

  beforeEach(async () => {
    [deployer, attacker, user] = await ethers.getSigners();

    const WalletContract = await ethers.getContractFactory("MyWallet", deployer);
    this.myWallet = await WalletContract.deploy();

    await deployer.sendTransaction({ to : this.myWallet.address, value : 10000 });

    const AttackerContract = await ethers.getContractFactory("Attacker", attacker);
    this.attacker = await AttackerContract.deploy(this.myWallet.address);
  })

  it("Deposit Test", async() => {
    const balanceOf = await ethers.provider.getBalance(this.myWallet.address);
    expect(balanceOf).to.eq(10000);
  })

  it("Should Allow the owner to execute withdraw()", async() => {
    const initBalance_User = await ethers.provider.getBalance(user.address);

    await this.myWallet.withdraw(user.address);

    expect(await ethers.provider.getBalance(this.myWallet.address)).to.eq(0);
    expect(await ethers.provider.getBalance(user.address)).to.eq(initBalance_User.add(10000));
  })

  it("Test Attacking", async() => {
    const initBalance_CA = await ethers.provider.getBalance(this.myWallet.address);
    const initBalance_Attacker = await ethers.provider.getBalance(attacker.address);
    console.log(`initBalance_CA : ${initBalance_CA}`);
    console.log(`initBalance_Attacker : ${initBalance_Attacker}`);

    await deployer.sendTransaction({ to : this.attacker.address, value : 1});

    const afterBalance_CA = await ethers.provider.getBalance(this.myWallet.address);
    const afterBalance_Attacker = await ethers.provider.getBalance(attacker.address);

    console.log(`afterBalance_CA : ${afterBalance_CA}`);
    console.log(`afterBalance_Attacker : ${afterBalance_Attacker}`);

    expect(afterBalance_CA).to.eq(0);
    expect(afterBalance_Attacker).to.eq(initBalance_Attacker.add(10000));
  })

});
