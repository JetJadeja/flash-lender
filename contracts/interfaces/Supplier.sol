pragma solidity ^0.5.0;


/**
@title Fund Supplier
@author Jet Jadeja <jet.j.developing@gmail.com>
@notice Contracts that inherit from this interface are used to supply money for the Flash Loans
*/

interface Supplier {
    function supplyOf(address token) external returns (uint256);
    function lendTo(address token, address toBorrower, uint256 amount) external;
    function repay(address token, uint256 amount) external;
}