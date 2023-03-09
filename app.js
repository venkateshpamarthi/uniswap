const Web3=require('web3')
const swap = require('./build/contracts/TransferSwap.json')

//deployed uniswap contact address
const address = '0x43d7BE4b84BC1b75cDe1218539D4988439222AbD' 

const url = 'https://rpc-mumbai.maticvigil.com/'
const web3= new Web3(url)

const swapInstance = new web3.eth.Contract(swap.abi,address)
async function getEstimatedAmount(){
let puniAmount = "10"
puniAmount = await web3.utils.toWei(puniAmount,'ether')

//console.log(swapInstance)
let requiredvky = await swapInstance.methods.getEstimated(puniAmount).call();
requiredvky = await web3.utils.fromWei(requiredvky,'ether')
console.log(requiredvky)

}
getEstimatedAmount()



// const requiredEth = (await myContract.getEstimatedETHforDAI(daiAmount).call())[0];
// const sendEth = requiredEth * 1.1;