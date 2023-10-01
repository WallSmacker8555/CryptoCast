require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    buildbear: {
      url: "https://rpc.buildbear.io/warm-ki-adi-mundi-fb8ba0a1"
    }
  }
};
