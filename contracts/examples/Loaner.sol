pragma solidity ^0.5.0;

import "../interfaces/Borrower.sol";
import "@openzeppelin/contracts/token/erc20/ERC20.sol";

contract Loaner is Borrower {
    function borrow(address token, address supplier, uint256 amount) external returns (bool) {
        return ERC20(token).transfer(supplier, amount);
    }
}