// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";

import {TestBase} from "$/test/utils/TestBase.sol";
import {Errors} from "$/test/utils/Errors.sol";
import {A} from "$/test/utils/Addresses.sol";
import {ERC721Mock} from "$/test/utils/ERC721Mock.sol";

import {ERC721BatchTransfer} from "$/src/ERC721BatchTransfer.sol";
import {IERC721} from "$/src/IERC721.sol";

// solhint-disable func-name-mixedcase
contract SafeBatchTransferToSingleWalletWhenWalletsOwnNoTokensBenchmarkTest is
    TestBase
{
    ERC721Mock internal _erc721;
    IERC721 internal erc721;
    ERC721BatchTransfer internal sut;

    uint256[] internal alephaoTokens;
    uint256[] internal bobTokens;

    address[] internal tos = new address[](5);

    function setUp() public {
        HEVM.startPrank(A.deployer);
        _erc721 = new ERC721Mock();
        erc721 = IERC721(address(_erc721));
        sut = new ERC721BatchTransfer();
        HEVM.stopPrank();

        uint256[] memory tokenIds = new uint256[](5);
        tokenIds[0] = 1;
        tokenIds[1] = 2;
        tokenIds[2] = 3;
        tokenIds[3] = 4;
        tokenIds[4] = 5;
        alephaoTokens = tokenIds;
        _erc721.mintMany(A.alephao, tokenIds);

        tokenIds[0] = 6;
        tokenIds[1] = 7;
        tokenIds[2] = 8;
        tokenIds[3] = 9;
        tokenIds[4] = 10;
        bobTokens = tokenIds;
        _erc721.mintMany(A.bob, tokenIds);

        HEVM.prank(A.alephao);
        _erc721.setApprovalForAll(address(sut), true);

        tos[0] = A.biba;
        tos[1] = A.cassie;
        tos[2] = A.deployer;
        tos[3] = A.sofia;
        tos[4] = A.dido;
    }

    function test_safeBatchTransferToMultipleWallets_5_WhenWalletsOwnNoTokens()
        public
    {
        HEVM.prank(A.alephao);
        sut.safeBatchTransferToMultipleWallets(erc721, tos, alephaoTokens);
    }
}

contract SafeBatchTransferToSingleWalletWhenWalletsOwnTokensBenchmarkTest is
    TestBase
{
    ERC721Mock internal _erc721;
    IERC721 internal erc721;
    ERC721BatchTransfer internal sut;

    uint256[] internal alephaoTokens;
    uint256[] internal bobTokens;

    address[] internal tos = new address[](5);

    function setUp() public {
        HEVM.startPrank(A.deployer);
        _erc721 = new ERC721Mock();
        erc721 = IERC721(address(_erc721));
        sut = new ERC721BatchTransfer();
        HEVM.stopPrank();

        uint256[] memory tokenIds = new uint256[](5);
        tokenIds[0] = 1;
        tokenIds[1] = 2;
        tokenIds[2] = 3;
        tokenIds[3] = 4;
        tokenIds[4] = 5;
        alephaoTokens = tokenIds;
        _erc721.mintMany(A.alephao, tokenIds);

        tokenIds[0] = 6;
        tokenIds[1] = 7;
        tokenIds[2] = 8;
        tokenIds[3] = 9;
        tokenIds[4] = 10;
        bobTokens = tokenIds;
        _erc721.mintMany(A.bob, tokenIds);

        HEVM.prank(A.alephao);
        _erc721.setApprovalForAll(address(sut), true);

        tos[0] = A.bob;
        tos[1] = A.bob;
        tos[2] = A.bob;
        tos[3] = A.bob;
        tos[4] = A.bob;
    }

    function test_safeBatchTransferToMultipleWallets_5_WhenWalletsOwnTokens()
        public
    {
        HEVM.prank(A.alephao);
        sut.safeBatchTransferToMultipleWallets(erc721, tos, alephaoTokens);
    }
}
// solhint-enable func-name-mixedcase
