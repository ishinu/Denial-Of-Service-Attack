const { ethers, upgrades } = require("hardhat");

async function main(){
  console.log("Deploying KingOfEther contract...");
  const KingOfEther = await ethers.getContractFactory("KingOfEther");
  const kingofether = await upgrades.deployProxy(KingOfEther,{initializer:'initialize',kind:'uups'});
  await kingofether.deployed(); 
  console.log("KingOfEther Proxy Contract deployed at : ",kingofether.address);
  console.log("KingOfEther Implementation address via (getImplementationAddress) : ",await upgrades.erc1967.getImplementationAddress(kingofether.address));

  console.log("Deploying DOS Attack contract...");
  const DOSAttack = await ethers.getContractFactory("DOSAttack");
  const dosattack = await upgrades.deployProxy(DOSAttack,[kingofether.address],{initializer:'initialize',kind:'uups'});
  await dosattack.deployed();
  console.log("DOS Attack Proxy Contract deployed at : ",dosattack.address);
  console.log("DOS Attack Implementation address via (getImplementationAddress) : ",await upgrades.erc1967.getImplementationAddress(dosattack.address));
}

main();