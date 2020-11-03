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
        lender = await Lender.deployed(4, {from: owner}); //Deploy a new instance of lender
        token = await Token.deployed(lender.address, {from: owner}); //Deploy a new instance of Token
    });

    it("should allow the owner to set the fee", async () => {
        /**
         * Call the Lender.setFee method and change the fee so that it is equal to 1
         */
        await lender
            .setFee(1, {from: owner}) //Sent from owner
            .should.not.be.rejectedWith("revert");
    });

    it("should revert if the address setting the fee isn't an owner", async() => {
        /**
         * Call the lender.setFee method, but, from an address that isn't permitted to set the fee. 
         * Since we only want the owner to modify the fee, this code should revert.
         */
        await lender
            .setFee(2, {from: borrower}) //Sent from borrower (not an owner)
            .should.be.rejectedWith("revert");
    });

    it("should revert if the borrowed amount is too great", async() => {
        /**
         * Call the lender.loan() method, but, set the amount parameter to a value that is too great.
         */
        await lender
            .loan(token.address, 100000)
            .should.be.rejectedWith("revert Requested amount too large");
    });

    it("should revert if the borrowed amount is not sufficient", async() => {
        /**
         * Call the lender.loan() method, but, set the amount parameter to a value that is too small.
         * This would result in 0 fees, so we must prevent this
         */
        await lender
            .loan(token.address, 10)
            .should.be.rejectedWith("revert Requested amount is not sufficient");
    });

    it("should allow small loans, if the fee is 0", async() => {
        /**
         * If we set the fee to 0, we should be allowed to take loans of any size (that isn't larger than the total supply).
         */
        await lender.setFee(0, {from: owner}); // Set the fee to 0
        await lender
            .loan(token.address, 10) //Take a small Flash Loan
            .should.not.be.rejectedWith("revert Requested amount is not sufficient");
    });

});