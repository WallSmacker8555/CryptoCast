const hre = require("hardhat");

async function getData() {
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