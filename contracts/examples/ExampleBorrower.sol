pragma solidity ^0.5.0;

import "../interfaces/IBorrower.sol";
import "@openzeppelin/contracts/token/erc20/ERC20.sol";
import "../Lender.sol";

contract ExampleBorrower is IBorrower {
    function borrow(address token, uint256 amount) external returns (bool) {
        Lender(msg.sender).repayTokens();
        return true;
    }
}