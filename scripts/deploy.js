// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.

const { ethers } = require('hardhat');

async function main() {
  // Load the Crowdfunding contract ABI and bytecode
  const contractJson = require('./artifacts/contracts/Crowdfunding.sol/Crowdfunding.json');
  const contractAbi = contractJson.abi;
  const contractBytecode = '0x' + contractJson.bytecode;

  // Set the gas price and gas limit for the transaction
  const gasPrice = await ethers.provider.getGasPrice();
  const gasLimit = 210000;

  // Create an instance of the contract
  const contractFactory = new ethers.ContractFactory(contractAbi, contractBytecode, ethers.signer);
  const contract = await contractFactory.deploy(10000, { gasPrice, gasLimit }); // Replace 10000 with the goal amount

  console.log('Crowdfunding contract deployed to:', contract.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

