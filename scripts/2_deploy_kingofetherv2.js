const { ethers,upgrades } = require("hardhat");

const proxyAddress = '0xF4c89f95b91234e690A6f04dF923f8866f7B15a2';

async function main(){
    console.log("Deploying KingOfEtherV2...");
    const KingOfEtherV2 = await ethers.getContractFactory("KingOfEtherV2");
    const kingofetherv2 = await upgrades.upgradeProxy(proxyAddress,KingOfEtherV2);
    await kingofetherv2.deployed();
    console.log("KingOfEtherV2 proxy contract deployed at : ",kingofetherv2.address);
    console.log("KingOfEtherV2 contract deployed at : ",await upgrades.erc1967.getImplementationAddress(kingofetherv2.address));
}

main();