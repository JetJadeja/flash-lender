const Lender = artifacts.require("Lender");
const ExampleBorrower = artifacts.require("ExampleBorrower");
const ExampleToken = artifacts.require("ExampleToken");

module.exports = function(deployer) {
    deployer.deploy(ExampleBorrower);
    deployer.deploy(Lender, 0).then(function() {;
        return deployer.deploy(ExampleToken, Lender.address);
    });
}