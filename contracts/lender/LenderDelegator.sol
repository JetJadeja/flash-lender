pragma solidity 0.7.3;

/* Interfaces */
import {LenderStorage} from "./LenderStorage.sol";

/* Contracts */
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
    @title Lender Delegator
    @author Jet Jadeja <jet@rari.capital>
    @dev Proxy contract that makes delegatecalls to the Flash Lender contract
*/
contract LenderDelegator is LenderStorage, Ownable {
    /*************
     * Variables *
     *************/
    address public implementation;

    /***************
     * Constructor *
     ***************/
    constructor(
        address _implementation,
        address supplier,
        uint256 fee
    ) Ownable() {
        implementation = _implementation;
        delegateTo(
            implementation,
            abi.encodeWithSignature("initialize(address,uint256)", supplier, fee)
        );
    }

    /**********************
     * Fallback Functions *
     **********************/

    fallback() external payable {
        require(msg.value == 0, "RariTankDelegator: Cannot send funds to contract");

        (bool success, ) = implementation.delegatecall(msg.data);

        assembly {
            let free_mem_ptr := mload(0x40)
            returndatacopy(free_mem_ptr, 0, returndatasize())

            switch success
                case 0 {
                    revert(free_mem_ptr, returndatasize())
                }
                default {
                    return(free_mem_ptr, returndatasize())
                }
        }
    }

    /********************
     * Internal Functions *
     *********************/

    function delegateTo(address callee, bytes memory data)
        internal
        returns (bytes memory)
    {
        (bool success, bytes memory returnData) = callee.delegatecall(data);
        assembly {
            if eq(success, 0) {
                revert(add(returnData, 0x20), returndatasize())
            }
        }
        return returnData;
    }
}
