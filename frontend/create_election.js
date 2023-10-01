import { ethers } from 'ethers';

var fs = require('fs'); //Get abi reference
var jsonFile = "./artifacts/contracts/election.sol/ElectionFactory.json";
var parsed= JSON.parse(fs.readFileSync(jsonFile));
var abi = parsed.abi;

function createElection() {
    console.log("hi");
    const name = document.getElementById("name").value;
    const start = document.getElementById("start").value;
    const end = document.getElementById("end").value;



    const provider = new ethers.providers.Web3Provider(window.ethereum);

    console.log(name);
    // const API_URL = "https://rpc.buildbear.io/warm-ki-adi-mundi-fb8ba0a1";
    // const provider = new JsonRpcProvider(API_URL);

    const addr_deployed = "0x54468eae23961A167E637F341Ada0CE9DFCe8841";
    const electionFactory = new ethers.Contract(addr_deployed, abi, provider);

   
    electionFactory.createElection(name, start, end);
}