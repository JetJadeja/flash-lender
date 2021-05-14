pragma solidity 0.7.3;

/**
    @title Flash Lender
    @author Jet Jadeja <jet@rari.capital>
*/
interface IFlashLender {
    function borrow(
        address,
        uint256,
        address
    ) external;
}
