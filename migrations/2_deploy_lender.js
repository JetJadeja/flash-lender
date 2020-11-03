const Lender = artifacts.require("Lender");
const ExampleBorrower = artifacts.require("ExampleBorrower");
const ExampleToken = artifacts.require("ExampleToken");

module.exports = function(deployer, network) {
    if (network == "test") { //If we are testing, deploy example contracts
        deployer.deploy(ExampleBorrower);
        deployer.deploy(Lender, 0).then(function() {;
            return deployer.deploy(ExampleToken, Lender.address);
        });
    }

    else if(network == "mainnet") { //If we are actually deploying, deploy only the lender contract
        deployer.deploy(Lender, 0);
    }
}