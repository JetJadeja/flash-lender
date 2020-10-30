const Lender = artifacts.require("Lender");
const ExampleSupplier = artifacts.require("ExampleSupplier");
const ExampleBorrower = artifacts.require("ExampleBorrower");
const ExampleToken = artifacts.require("ExampleToken");

module.exports = function(deployer) {
    deployer.deploy(ExampleBorrower);

    deployer.deploy(ExampleSupplier).then(function() 
    {
        deployer.deploy(Lender, ExampleSupplier.address, 0);
        return deployer.deploy(ExampleToken, ExampleSupplier.address);
    });
}