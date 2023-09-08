// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
// forge install Cyfrin/foundry-devops --no-commit
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;
    function fundFundMe(address mostRecentlyDelpoyed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDelpoyed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Dunded FundMe with %s", SEND_VALUE);
    }
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(mostRecentlyDeployed);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDelpoyed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDelpoyed)).withdraw();
        vm.stopBroadcast();
    }
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(mostRecentlyDeployed);
    }
}