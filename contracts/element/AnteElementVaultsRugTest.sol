// SPDX-License-Identifier: GPL-3.0-only

pragma solidity ^0.8.0;

import "../AnteTest.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title Element Finance rug test
/// @notice Ante Test to check if Element Finance "rugs" 90% of its top 3 vaults value (as of test deployment)
contract AnteElementVaultsRugTest is AnteTest("Element.fi top 3 vaults doesn't rug 90% of its value") {
    // https://etherscan.io/address/0xdA816459F1AB5631232FE5e97a05BBBb94970c95
    address public constant YVDAI_VAULT_ADDRESS = 0xdA816459F1AB5631232FE5e97a05BBBb94970c95;
    // https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F
    address public constant DAI_ADDRESS = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    // https://etherscan.io/address/0xa354F35829Ae975e850e23e9615b11Da1B3dC4DE
    address public constant YVUSDC_VAULT_ADDRESS = 0xa354F35829Ae975e850e23e9615b11Da1B3dC4DE;
    // https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
    address public constant USDC_ADDRESS = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    IERC20 public daiToken = IERC20(DAI_ADDRESS);
    IERC20 public usdcToken = IERC20(USDC_ADDRESS);

    uint256 public immutable daiBalanceAtDeploy;
    uint256 public immutable usdcBalanceAtDeploy;

    constructor() {
        protocolName = "Element Finance";
        testedContracts = [YVDAI_VAULT_ADDRESS, YVUSDC_VAULT_ADDRESS];

        daiBalanceAtDeploy = daiToken.balanceOf(YVDAI_VAULT_ADDRESS);
        usdcBalanceAtDeploy = usdcToken.balanceOf(YVUSDC_VAULT_ADDRESS);
    }

    /// @notice test to check value of top 3 vaults on Element.fi is not rugged
    /// @return true if vault has more than 10% of assets from when it was deployed
    function checkTestPasses() external view override returns (bool) {
        return ((daiBalanceAtDeploy / 10) < daiToken.balanceOf(YVDAI_VAULT_ADDRESS) &&
            (usdcBalanceAtDeploy / 10) < usdcToken.balanceOf(YVUSDC_VAULT_ADDRESS));
    }
}
