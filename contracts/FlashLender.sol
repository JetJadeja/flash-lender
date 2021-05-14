pragma solidity 0.7.3;

/* Interfaces */
import {IFlashLender} from "./interfaces/IFlashLender.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {ISupplier} from "./interfaces/ISupplier.sol";
import {IBorrower} from "./interfaces/IBorrower.sol";

/* Contracts */
import {LenderStorage} from "./lender/LenderStorage.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/Initializable.sol";

/* Libraries */
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";

/**
    @title Flash Lender
    @author Jet Jadeja <jet@rari.capital>
    @dev Lends flash loans
*/
contract FlashLender is LenderStorage, IFlashLender, Initializable {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    /*************
     * Modifiers *
     *************/
    modifier isRepaid(address token, uint256 amount) {
        uint256 fee = amount.mul(feeFactor).div(1e18);
        uint256 balance = IERC20(token).balanceOf(supplier);
        _;
        require(
            IERC20(token).balanceOf(supplier) >= balance.add(fee),
            "Required amount has not been repaid"
        );
    }

    /***************
     * Constructor *
     ***************/
    function initialize(address _supplier, uint256 _feeFactor) external initializer {
        supplier = _supplier;
        feeFactor = _feeFactor;
    }

    /********************
     * External Functions *
     ********************/

    /** @dev Initiate a Flash Loan */
    function borrow(
        address token,
        uint256 amount,
        address to
    ) external override {
        ISupplier(supplier).borrow(token, amount);
        IERC20(token).safeTransfer(to, amount);

        IBorrower(to).execute(token, amount);
    }
}
