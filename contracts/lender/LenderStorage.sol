pragma solidity 0.7.3;

abstract contract LenderStorage {
    /** @dev Address of the supplier contract */
    address public supplier;

    /** @dev The fee factor, scaled by 1e18 */
    uint256 public feeFactor;
}
