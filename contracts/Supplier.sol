pragma solidity 0.7.3;

/* Interfaces */
import {ISupplier} from "./interfaces/ISupplier.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {ISupplier} from "./interfaces/ISupplier.sol";
import {IBorrower} from "./interfaces/IBorrower.sol";

/* Contracts */
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/* Libraries */
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";

/** 
    @title Supplier
    @author Jet Jadeja <jet@rari.capital>
*/
contract Supplier is ERC721, ISupplier {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    /*************
     * Variables *
     *************/
    address public lender;

    /** @dev Maps NFT id to position struct */
    mapping(uint256 => Position) positionById;

    /** @dev Maps user address to token address to the NFT id */
    mapping(address => mapping(address => uint256)) tokenPositionByUser;

    struct Position {
        address token;
        uint256 amount;
        address supplier;
    }

    constructor(address _lender) ERC721("Flash Loan Supplier", "LNDR") {
        lender = _lender;
    }

    function deposit(address token, uint256 amount) external override {
        uint256 currentPositionId = tokenPositionByUser[msg.sender][token];
        uint256 currentBalance =
            currentPositionId == 0 ? 0 : positionById[currentPositionId].amount;
    }

    function withdraw(address token, uint256 amount) external override {}

    function borrow(address token, uint256 amount) external override {}
}
