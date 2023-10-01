//import { ethers } from 'ethers';

//var fs = require('fs'); //Get abi reference
//var jsonFile = "./artifacts/contracts/election.sol/ElectionFactory.json";
//var parsed= JSON.parse(fs.readFileSync(jsonFile));
//var abi = parsed.abi;
const candidates = [0, 0, 0];

var v_id = {}

function getRegData() {
    let hash = 0;
    var info = document.getElementById("reg_info");
    var id;
    for (let i = 0; i < info.length; i++) {
        if (i == 7) {
            id = info[i].value;
        }
        console.log(info[i]);
    }
    for (let j = 0; j < id.length; j++) {
        char = id.charCodeAt(j);
        hash = ((hash << 5) - hash) + char;
        hash = hash & hash;
    }
    v_id[hash] = 0
}

function countVote() {
    var info = document.getElementById("ballot_info")
    for (let i = 0; i < info.length; i++) {
        if (info[i].checked)
            if (i == 1)
                candidates[0] += 1
            if (i == 2)
                candidates[1] += 1
            if (i == 3)
                candidates[2] += 1
    }
}

function getVoterData() {
    let hash = 0;
    var info = document.getElementById("vote_info");
    var id;
    for (let i = 0; i < info.length; i++) {
        if (i == 7) {
            id = info[i].value;
        }
        console.log(info[i]);
    }
    for (let j = 0; j < id.length; j++) {
        char = id.charCodeAt(j);
        hash = ((hash << 5) - hash) + char;
        hash = hash & hash;
    }
    v_id[hash] = 1
}

function createElection() {
    console.log("hi");
    const name = document.getElementById("name").value;
    const start = document.getElementById("start").value;
    const end = document.getElementById("end").value;
    const can1 = document.getElementById("can1").value;
    const can2 = document.getElementById("can2").value;
    const can3 = document.getElementById("can3").value;



    const provider = new ethers.providers.Web3Provider(window.ethereum);

    console.log(name);
    // const API_URL = "https://rpc.buildbear.io/warm-ki-adi-mundi-fb8ba0a1";
    // const provider = new JsonRpcProvider(API_URL);

    const addr_deployed = "0x54468eae23961A167E637F341Ada0CE9DFCe8841";
    const electionFactory = new ethers.Contract(addr_deployed, abi, provider);

   
    electionFactory.createElection(name, start, end);
}