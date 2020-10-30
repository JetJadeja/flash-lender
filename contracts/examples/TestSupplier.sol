pragma solidity ^0.5.0;

import "../interfaces/Supplier.sol";
import "@openzeppelin/contracts/token/erc20/ERC20.sol";


contract ExampleSupplier is Supplier {
        
    function supplyOf(address token) external returns(uint256) {
        return ERC20(token).balanceOf(address(this));
    }

    function lendTo(address token, address to, uint256 amount) external {
        require(ERC20(token).transferFrom(address(this), to, amount));
    }

    function repay(address token, uint256 amount) external {
        require(ERC20(token).transferFrom(msg.sender, address(this), amount));
    }

}