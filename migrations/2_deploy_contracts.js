// migrations/2_deploy_contracts.js
const DEX = artifacts.require("DEX");
const ERC20Token = artifacts.require("ERC20Token");

module.exports = async function(deployer, network, accounts) {
  const owner = accounts[0]; // Use the first account as the owner
  const initialSupply = web3.utils.toWei('1000', 'ether'); // Example: 1000 tokens

  // Deploy the ERC20Token contracts with the initial supply
  await deployer.deploy(ERC20Token, "Token1", "TK1", initialSupply);
  const token1Instance = await ERC20Token.deployed();

  await deployer.deploy(ERC20Token, "Token2", "TK2", initialSupply);
  const token2Instance = await ERC20Token.deployed();

  // Deploy the DEX contract with the owner's address
  await deployer.deploy(DEX, owner);
  const dexInstance = await DEX.deployed();

  // If you have more tokens, you can deploy them similarly
  // await deployer.deploy(ERC20Token, "Token3", "TK3", initialSupply);
  // const token3Instance = await ERC20Token.deployed();
};



