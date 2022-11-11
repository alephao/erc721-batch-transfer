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
contract ERC721BatchTransferToMultipleWalletsUnitTest is TestBase {
    ERC721Mock internal _erc721;
    IERC721 internal erc721;
    ERC721BatchTransfer internal sut;

    uint256[] internal alephaoTokens;
    uint256[] internal bobTokens;

    address[] internal tos = new address[](5);

    // Setup A.alephao with tokens from 1~5
    // Setup A.bob with tokens from 6~10
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

        tos[0] = A.bob;
        tos[1] = A.cassie;
        tos[2] = A.deployer;
        tos[3] = A.sofia;
        tos[4] = A.bob;
    }

    function test_batchTransferToMultipleWallets_WhenAlephaoTransferItsTokens()
        public
    {
        HEVM.startPrank(A.alephao);
        _erc721.setApprovalForAll(address(sut), true);
        sut.batchTransferToMultipleWallets(erc721, tos, alephaoTokens);
        HEVM.stopPrank();

        assertEq(_erc721.ownerOf(1), A.bob);
        assertEq(_erc721.ownerOf(2), A.cassie);
        assertEq(_erc721.ownerOf(3), A.deployer);
        assertEq(_erc721.ownerOf(4), A.sofia);
        assertEq(_erc721.ownerOf(5), A.bob);
    }

    function test_batchTransferToMultipleWallets_WhenAlephaoTransferItsTokensUsingApprove()
        public
    {
        HEVM.startPrank(A.alephao);
        _erc721.approve(address(sut), 1);
        _erc721.approve(address(sut), 2);
        _erc721.approve(address(sut), 3);
        _erc721.approve(address(sut), 4);
        _erc721.approve(address(sut), 5);
        sut.batchTransferToMultipleWallets(erc721, tos, alephaoTokens);
        HEVM.stopPrank();

        assertEq(_erc721.ownerOf(1), A.bob);
        assertEq(_erc721.ownerOf(2), A.cassie);
        assertEq(_erc721.ownerOf(3), A.deployer);
        assertEq(_erc721.ownerOf(4), A.sofia);
        assertEq(_erc721.ownerOf(5), A.bob);
    }

    function test_batchTransferToMultipleWallets_WhenAlephaoTransferItsOwnTokensButContractIsNotApproved()
        public
    {
        HEVM.prank(A.alephao);
        HEVM.expectRevert("ERC721: caller is not token owner or approved");
        sut.batchTransferToMultipleWallets(erc721, tos, alephaoTokens);
    }

    function test_batchTransferToMultipleWallets_WhenAlephaoTransferNonApprovedTokens()
        public
    {
        HEVM.startPrank(A.alephao);
        _erc721.approve(address(sut), 1);
        HEVM.expectRevert("ERC721: caller is not token owner or approved");
        sut.batchTransferToMultipleWallets(erc721, tos, alephaoTokens);
    }

    function test_batchTransferToMultipleWallets_WhenAlephaoTransfersBobTokens()
        public
    {
        HEVM.startPrank(A.alephao);
        _erc721.setApprovalForAll(address(sut), true);
        HEVM.expectRevert(Errors.NotOwnerOfToken());
        sut.batchTransferToMultipleWallets(erc721, tos, bobTokens);
        HEVM.stopPrank();
    }

    function test_batchTransferToMultipleWallets_WhenAlephaoTransferingSomeAlephaoTokensAndSomeBobTokens()
        public
    {
        uint256[] memory tokenIds = new uint256[](5);
        tokenIds[0] = alephaoTokens[0];
        tokenIds[1] = bobTokens[0];

        HEVM.startPrank(A.alephao);
        _erc721.setApprovalForAll(address(sut), true);
        HEVM.expectRevert(Errors.NotOwnerOfToken());
        sut.batchTransferToMultipleWallets(erc721, tos, tokenIds);
        HEVM.stopPrank();
    }
}
// solhint-enable func-name-mixedcase
