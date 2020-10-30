const { Test } = require("mocha");

const Lender = artifacts.require("Lender");
const Bank = artifacts.require("Bank");
const Loaner = artifacts.require("Loaner");
const TestToken = artifacts.require("TestToken");

module.exports = function(deployer) {
    deployer.deploy(Loaner);

    deployer.deploy(Bank).then(function() 
    {
        deployer.deploy(Lender, Bank.address, 0);
        return deployer.deploy(TestToken, Bank.address);
    });
}