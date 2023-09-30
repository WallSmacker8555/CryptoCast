const hre = require("hardhat");
const { ethers } = require("ethers");

async function getData() {
    const electionFactory = global.contract;
    
    const numElections = await electionFactory.numElections();
    let elections;
    for (let i = 0; i < numElections; i++) {
        elections[i] = await electionFactory.elections(i);
    }
    
    return elections;
}


function main() {
    console.alert("Hi");
}