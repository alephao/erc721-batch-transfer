// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import {DSTest} from "@ds-test/test.sol";
import {Vm} from "@forge-std/Vm.sol";

contract TestBase is DSTest {
    Vm internal constant HEVM = Vm(HEVM_ADDRESS);
}
