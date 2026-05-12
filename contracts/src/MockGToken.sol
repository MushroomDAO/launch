// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.25;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

/**
 * @title MockGToken
 * @notice Test-network governance token. Owner can mint; anyone can burn their own balance.
 *         Used for the second iteration of the launch sale ($200K cap).
 *         Production GToken will be a separate, audited contract.
 */
contract MockGToken is ERC20, ERC20Burnable, Ownable {
    constructor(address initialOwner) ERC20("Governance Token (Mock)", "GToken") Ownable(initialOwner) {}

    /// @notice Mint new tokens. Owner only.
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
