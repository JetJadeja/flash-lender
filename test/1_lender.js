// Ensure that the Transaction is cancelled if not repaid. 

const chai = require("chai");
const chaiAsPromised = require("chai-as-promised");

chai.use(chaiAsPromised);

const Lender = artifacts.require("Lender");
const Token = artifacts.require("ExampleToken");
const Borrower = artifacts.require("ExampleBorrower");
chai.should();


contract("Lender", accounts => {
    let lender;
    let token;
    
    const [owner, borrower] = accounts;

    before(async () => {
        lender = await Lender.deployed(0, {from: owner});
        token = await Token.deployed(lender.address, {from: owner});
    });

    it("should revert if Borrower does not repay", async () => {
        await lender
            .loan(token.address, 10, {from: borrower})
            .should.be.rejectedWith('revert');
    });

});