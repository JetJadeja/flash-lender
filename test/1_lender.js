// Tests for the "Lender" Contract that lends ERC20 tokens to borrowers (via Flash Loans)

const chai = require("chai");
const chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);

const Lender = artifacts.require("Lender"); //Lender Contract
const Token = artifacts.require("ExampleToken"); //Example ERC20 Token Contract 
const Borrower = artifacts.require("ExampleBorrower"); //Example Borrower Contract
chai.should();


contract("Lender", accounts => {
    let lender;
    let token;
    
    const [owner, borrower] = accounts;

    beforeEach(async () => { //beforeEach is run before every test
        lender = await Lender.deployed(0, {from: owner}); //Deploy a new instance of lender
        token = await Token.deployed(lender.address, {from: owner}); //Deploy a new instance of Token
    });

    it("should revert if the borrower does not repay", async () => {
        /**
         * Call the Lender.loan function to borrow 10 units of our "ExampleToken". 
         * However, since "Borrower" cannot repay the money within the same Transaction, the code should revert.
         */
        await lender
            .loan(token.address, 10, {from: borrower})
            .should.be.rejectedWith('revert');
    });

    it("should allow the owner to set the fee", async () => {
        /**
         * Call the Lender.setFee function and change the fee so that it is equal to 1
         */
        await lender
            .setFee(1, {from: owner}) //Sent from owner
            .should.not.be.rejectedWith('revert');
    });

    it("should revert if someone tries to set the fee", async() => {
        /**
         * Call the lender.setFee function, but, from a random address that isn't the owner. 
         * Since we only want the owner to modify the fee, this code should revert.
         */
        await lender
            .setFee(2, {from: borrower}) //Sent from borrower (not an owner)
            .should.be.rejectedWith('revert');
    });
});