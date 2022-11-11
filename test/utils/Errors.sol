// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.4;

// The code in this file was generate. Do not modify!
// solhint-disable const-name-snakecase,func-name-mixedcase
library Errors {
    function InvalidArguments() internal pure returns (bytes memory) {
        return abi.encodeWithSignature("InvalidArguments()");
    }

    function InvalidCaller() internal pure returns (bytes memory) {
        return abi.encodeWithSignature("InvalidCaller()");
    }

    function NotOwnerOfToken() internal pure returns (bytes memory) {
        return abi.encodeWithSignature("NotOwnerOfToken()");
    }
}
// solhint-enable const-name-snakecase
