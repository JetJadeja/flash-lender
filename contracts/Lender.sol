pragma solidity ^0.5.0;


import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

import "@openzeppelin/contracts/token/erc20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

import "./interfaces/IBorrower.sol";


/**
    @title Flash Lender
    @author Jet Jadeja <jet.j.developing@gmail.com>
    @notice This contract uses the funds provided by the supplier to execute Flash Loans and ensure the money is returned
*/
contract Lender is Ownable, ReentrancyGuard{
    using SafeMath for uint256;

    ///@dev An unsigned integer that represents the loan fee
    uint256 public fee;

    /**
    @dev Confirms that the Supplier has sufficient funds and enforce the token is payed back (with the calculated fee)
    @param token The ERC20 Token Address
    @param amount The amount being borrowed
    */
    modifier isReturned(address token, uint256 amount) {
        _;
    }

    constructor(uint256 _fee) public {
        fee = _fee;
    }

    /**
    @dev Set a new fee
    @param _fee The new fee
    */
    function setFee(uint256 _fee) external onlyOwner {
        fee = _fee;
    }

    /**
    @dev Borrow money from the supplier and lend it to the Borrower
    @param token The ERC20 Token Address
    @param amount The amount being borrowed
    */
    function loan(address token, uint256 amount) external isReturned(token, amount) returns(bool) {
        return IBorrower(msg.sender).borrow(token, amount);
    }

}