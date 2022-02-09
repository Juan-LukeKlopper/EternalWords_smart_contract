const main = async () =>  {
const [ deployer ] = await hre.ethers.getSigners()
const accountBalance = await deployer.getBalance()

console.log("Deploying contract with account ", deployer.address);
console.log("Account Balance: ",accountBalance.toString());

const messageContractFactory = await hre.ethers.getContractFactory("EternalWords");
const messageContract = await messageContractFactory.deploy({value: hre.ethers.utils.parseEther("0.01"),});
await messageContract.deployed();

console.log("Contract deployed to: ", messageContract.address);
};

const runMain = async () => {
 try {
  await main();
  process.exit(0);
 } catch(error){
  console.log(error);
  process.exit(1);
   }
};

runMain();
