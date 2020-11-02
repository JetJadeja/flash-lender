pragma solidity ^0.5.0;


import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

import "@openzeppelin/contracts/token/erc20/IERC20.sol";
import "@openzeppelin/contracts/token/erc20/SafeERC20.sol";
import "./interfaces/IBorrower.sol";


/**
    @title Flash Lender
    @author Jet Jadeja <jet.j.developing@gmail.com>
    @notice This is the main contract behind the Flash Loan system. It lends money to the borrower and ensures it is paid back.
*/
contract Lender is Ownable, ReentrancyGuard{
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    ///@dev An unsigned integer that represents the loan fee
    uint256 public fee;

    ///@dev Stores the amount and token owed
    struct Owed {
        address token;
        uint256 amount;
    }

    ///@dev The amount of money that each user owes
    mapping(address => Owed) internal principal;


    event loanedTo(address indexed _to, uint256 _amount);
    event repaid(address indexed _from, uint256 _amount);

    /**
    @dev Confirms that the Supplier has sufficient funds and enforce the token is payed back (with the calculated fee)
    @param token The ERC20 Token Address
    @param amount The amount being borrowed
    */
    modifier isReturned(address token, address borrower, uint256 amount) {

        require(balanceOf(token)/2 > amount); // Cannot borrow more than half of supply
        principal[borrower] = Owed(token, amount);
        _;
        require(principal[borrower].amount == 0);

    }

    constructor(uint256 _fee) Ownable() public {
        fee = _fee;
    }

    /**
    @dev Set a new fee
    @param _fee The new fee
    */
    function setFee(uint256 _fee) external onlyOwner {
        fee = _fee;
    }

    function balanceOf(address token) public view returns(uint256) {
        return IERC20(token).balanceOf(address(this));
    }

    /**
    @dev Lend money to the Borrower
    @param token The ERC20 Token Address
    @param amount The amount being borrowed
    */
    function loan(address token, uint256 amount) external isReturned(token, msg.sender, amount) returns(bool) { 
        emit loanedTo(msg.sender, amount);
        
        IERC20(token).transfer(msg.sender, amount);
        return IBorrower(msg.sender).borrow(token, amount);
    }

    /**
    @dev Repay tokens lended to the borrower
    */
    function repayTokens() external{
        IERC20(principal[msg.sender].token).safeTransferFrom
        (
            msg.sender, 
            address(this), 
            principal[msg.sender].amount
        );

        emit repaid(msg.sender, principal[msg.sender].amount);
        delete principal[msg.sender];
    }

}