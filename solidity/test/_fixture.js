const { ethers } = require("hardhat");
const hre = require("hardhat");

async function defaultFixture() {
  await deployments.fixture();
  const cVaultCore = await ethers.getContract("VaultCore");
  const cOUSD = await ethers.getContract("OUSD");

  return {
    cVaultCore,
    cOUSD,
  };
}

module.exports = {
  defaultFixture,
};
