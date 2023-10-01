function createElection() {
    const name = document.getElementById("name").value;
    const start = document.getElementById("start").value;
    const end = document.getElementById("end").value;

    console.log(name);
    // call solidity
    const contract = localStorage.getItem("contract", electionFactory);
    electionFactory.createElection(name, start, end);
}