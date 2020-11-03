# flash-lender
ERC20 Flash Loan Smart Contracts written in Solidity for Ethereum. 

## What are Flash Loans?
A Flash Loan is a type of loan, but with a catch: they are only valid within one transaction. This means that, when you use a Flash Loan, you borrow, use, and return the money within the same transaction! The best part is that if you can't repay the money, the transaction reverts, never actually going through. 

## How does it work?
There are two main contracts that this system uses, `Lender` and `Borrower`. The Lender contract supplies the money and ensures that it is repaid. The Borrower contract is deployed by the user, and they can use the Token for whatever they want (as long as they repay)!

`Borrower` contracts must inherit from the `IBorrower` interface. The `Lender` contract will then call the `Borrower.borrow()` function. To repay, the borrower must run the `Lender.repayTokens()` function.




