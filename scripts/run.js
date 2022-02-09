const main = async () =>  {
const messageContractFactory = await hre.ethers.getContractFactory("EternalWords");
const messageContract = await messageContractFactory.deploy({value: hre.ethers.utils.parseEther("0.01"),});
await messageContract.deployed();

console.log("Contract deployed to: ", messageContract.address);

let contractBalance = await hre.ethers.provider.getBalance(messageContract.address);
console.log("Contract balance:",hre.ethers.utils.formatEther(contractBalance));

const messageTX = await messageContract.storeMessage("First ever message to this contract");
await messageTX.wait();

contractBalance = await hre.ethers.provider.getBalance(messageContract.address);
console.log("Contract balance:",hre.ethers.utils.formatEther(contractBalance));

messageCount = await messageContract.getTotalMessages();
let allMessages = await messageContract.getAllMessages();
  console.log(allMessages);
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
