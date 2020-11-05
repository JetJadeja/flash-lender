pragma solidity ^0.5.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

import "@openzeppelin/contracts/token/erc20/IERC20.sol";
import "@openzeppelin/contracts/token/erc20/SafeERC20.sol";

import './Lender.sol';

/**
    @title Lending Pool
    @author Jet Jadeja <jet.j.developing@gmail.com>
    @notice This Contract stores tokens, funding Flash Loans and distributing rewards to depositors.
*/
contract LendingPool is Ownable{

    ///@dev The address of the Flash Lender contract
    address public flashLenderContract;

    constructor(address _flashLenderContract) public {
        flashLenderContract = _flashLenderContract;
    }

    ///@dev Set a new Flash Lender smart contract. Can only be called by the Owner
    function setNewFlashLender(address _flashLenderContract) public onlyOwner {
        flashLenderContract = _flashLenderContract;
    }

    

}