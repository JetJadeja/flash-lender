# flash-lender

> **_NOTE:_** This was my first Solidity project. In early May, I decided to rewrite it, however it is currently unfinished.

ERC20 Flash Loan Smart Contracts written in Solidity for Ethereum.

## What are Flash Loans?

A flash loan is a type of uncollateralized loan that utilizes smart contracts and blockchain technology to allow users to borrow large sums of money without any consequences. However, flash loans are only valid within a single transaction, which means that you must borrow and return funds within the same transaction, otherwise the transaction fails. However, as a result of this, the usecases for flash loans are completely different than that of other types of loans. Flash loans are more commonly used for arbitration, collateral swaps, and more recently to hack DeFi protocols. 

## How does it work?

There are two main contracts. The Lender (`FlashLender`) and the Supplier (`Supplier`).

The `Supplier` contract allows users to deposit their ERC20 tokens into the contract and uses them to supply loans. Since the Lender contract charges a small fee whenever a flash loan is initialized, part of this loan is distributed among depositors. Since users can deposit whichever tokens they'd like, **positions are represents using ERC721 NFTs**.

The Lender contract simply uses funds from the Supplier to lend capital to borrowers. It ensures that the tokens are paid back (along with the fee), earning interest for the protocol/maintainer of the contracts, as well as the liquidity providers.

### Tests

To test, you can run: `npx hardhat test`, however the tests have not been written yet.
