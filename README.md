# flash-lender

> **_NOTE:_** This was my first Solidity project. In early May, I decided to rewrite it, however it is currently unfinished.

ERC20 Flash Loan Smart Contracts written in Solidity for Ethereum.

## What are Flash Loans?

A Flash Loan is a type of loan, but with a catch: they are only valid within one transaction. This means that, when you use a Flash Loan, you borrow, use, and return the money within the same transaction! The best part is that if you can't repay the money, the transaction reverts, never actually going through.

## How does it work?

There are two main contracts. The Lender (`FlashLender`) and the Supplier (`Supplier`).

The `Supplier` contract allows users to deposit their ERC20 tokens into the contract and uses them to supply loans. Since the Lender contract charges a small fee whenever a flash loan is initialized, part of this loan is distributed among depositors. Since users can deposit whichever tokens they'd like, **positions are represents using ERC721 NFTs**.

The Lender contract simply uses funds from the Supplier to lend capital to borrowers. It ensures that the tokens are paid back (along with the fee), earning interest for the protocol/maintainer of the contracts, as well as the liquidity providers.

### Tests

To test, you can run: `npx hardhat test`, however the tests have not been written yet.
