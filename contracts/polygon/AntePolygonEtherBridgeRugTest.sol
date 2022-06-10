// SPDX-License-Identifier: GPL-3.0-only

// ┏━━━┓━━━━━┏┓━━━━━━━━━┏━━━┓━━━━━━━━━━━━━━━━━━━━━━━
// ┃┏━┓┃━━━━┏┛┗┓━━━━━━━━┃┏━━┛━━━━━━━━━━━━━━━━━━━━━━━
// ┃┗━┛┃┏━┓━┗┓┏┛┏━━┓━━━━┃┗━━┓┏┓┏━┓━┏━━┓━┏━┓━┏━━┓┏━━┓
// ┃┏━┓┃┃┏┓┓━┃┃━┃┏┓┃━━━━┃┏━━┛┣┫┃┏┓┓┗━┓┃━┃┏┓┓┃┏━┛┃┏┓┃
// ┃┃ ┃┃┃┃┃┃━┃┗┓┃┃━┫━┏┓━┃┃━━━┃┃┃┃┃┃┃┗┛┗┓┃┃┃┃┃┗━┓┃┃━┫
// ┗┛ ┗┛┗┛┗┛━┗━┛┗━━┛━┗┛━┗┛━━━┗┛┗┛┗┛┗━━━┛┗┛┗┛┗━━┛┗━━┛
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

pragma solidity ^0.7.0;

import "../AnteTest.sol";
import "@openzeppelin-contracts-old/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";

/// @title Polygon Ether Bridge Doesn't Rug
/// @notice Ante Test to check if Polygon Ether Bridge Doesn't drop below 20%
contract AntePolygonEtherBridgeRugTest is AnteTest("Polygon Ether Bridge Doesn't Drop below 20%") {
    // https://etherscan.io/address/0x8484Ef722627bf18ca5Ae6BcF031c23E6e922B30
    address public constant polygonBridgeAddr = 0x8484Ef722627bf18ca5Ae6BcF031c23E6e922B30;

    uint256 public immutable threshold;

    constructor() {
        protocolName = "Polygon";
        testedContracts = [polygonBridgeAddr];
        threshold = (20 * polygonBridgeAddr.balance) / 100;
    }

    /// @notice test to check value of ether on Polygon Ether Bridge is not rugged
    /// @return true if bridge has more than 20% of assets from when it was deployed
    function checkTestPasses() external view override returns (bool) {
        return polygonBridgeAddr.balance > threshold;
    }
}
