pragma solidity 0.7.3;

/**
    @title Supplier
    @author Jet Jadeja <jet@rari.capital>
*/
interface ISupplier {
    function deposit(address, uint256) external;

    function withdraw(address, uint256) external;

    function borrow(address, uint256) external;
}
