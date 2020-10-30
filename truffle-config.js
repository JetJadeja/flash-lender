module.exports = {
  networks: {
    "live": {
      network_id: 5777,
      host: "127.0.0.1",
      port: 8546   // Different than the default below
    }
  },

  rpc: {
    host: "127.0.0.1",
    port: 8545
  }
};