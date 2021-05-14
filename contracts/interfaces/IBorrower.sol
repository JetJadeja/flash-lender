pragma solidity 0.7.3;

/** 
    @title borrower
    @author Jet Jadeja <jet@rari.capital>
*/
interface IBorrower {
    function execute(address, uint256) external;
}
