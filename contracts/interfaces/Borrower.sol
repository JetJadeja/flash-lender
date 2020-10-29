pragma solidity ^0.5.0;


/**
@title Flash Loan Borrower
@author Jet Jadeja <jet.j.developing@gmail.com>
@notice Contracts that inherit from this interface are used by the Borrower of the Flash Loan. 
*/

interface Borrower {
    function borrow(address token, address supplier, uint256 amount) external returns (bool);
}