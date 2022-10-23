const { ContractFactory } = require("ethers");
const hre = require("hardhat");

const contractName = "Dao";

async function main() {
    const contract = await deployContract(contractName);
    await contract.printMsg();
}

async function deployContract (_cn){
    const Contract = await hre.ethers.getContractFactory(_cn); 
    const contract = await Contract.deploy();
    await contract.deployed()
    console.log("Contract deployed to:",contract.address);
    return contract;
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
