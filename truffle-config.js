
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
      gas: 6721975, // Gas limit
      gasPrice: 20000000000  // Match any network id
    },
  },
  contracts_directory: './contracts/',
  contracts_build_directory: 'dex-frontend/src/build/',
  compilers: {
    solc: {
      version: "0.8.20", // Fetch exact version from solc-bin (default: truffle's version)
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        },
      }
    }
  },
};
