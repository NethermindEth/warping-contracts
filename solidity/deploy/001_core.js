require("hardhat");
const { utils } = require("ethers");
const { deployments, ethers, getNamedAccounts } = require("hardhat");
const { parseUnits, formatUnits } = require("ethers").utils;
const { getTokenAddresses, isFork } = require("../utils/helpers");
const {
  deployWithConfirmation,
  withConfirmation,
  log,
} = require("../utils/deploy");

const deployCore = async () => {
  const dVault = await deployWithConfirmation("VaultCore");
  await deployWithConfirmation("OUSD", [
    "Origin Dollar",
    "OUSD",
    dVault.address,
  ]);
};

const main = async () => {
  await deployCore();
};

main.id = "001_core";
main.skip = () => isFork;
module.exports = main;
