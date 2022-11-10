// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import {IERC721} from "$/src/IERC721.sol";

/// @title ERC721 Batch Transfer
/// @author Aleph Retamal (https://github.com/alephao)
/// @notice Transfer ERC721 tokens in batches to a single wallet or multiple wallets.
contract ERC721BatchTransfer {
    error InvalidArguments();
    error NotOwnerOfToken();
    error InvalidCaller();

    event BatchTransferToSingle(address indexed contractAddress, address indexed to, uint256[] tokenIds);

    modifier noZero() {
        if (msg.sender == address(0)) revert InvalidCaller();
        _;
    }

    function batchTransferToSingleWallet(
        IERC721 erc721Contract,
        address to,
        uint256[] calldata tokenIds
    ) external noZero {
        uint256 length = tokenIds.length;
        for (uint256 i; i < length; ) {
            uint256 tokenId = tokenIds[i];
            address owner = erc721Contract.ownerOf(tokenId);
            if (msg.sender != owner) {
                revert NotOwnerOfToken();
            }
            erc721Contract.transferFrom(
                owner,
                to,
                tokenId
            );
            unchecked {
                ++i;
            }
        }
    }

    function safeBatchTransferToSingleWallet(
        IERC721 erc721Contract,
        address to,
        uint256[] calldata tokenIds
    ) external noZero {
        uint256 length = tokenIds.length;
        for (uint256 i; i < length; ) {
            uint256 tokenId = tokenIds[i];
            address owner = erc721Contract.ownerOf(tokenId);
            if (msg.sender != owner) {
                revert NotOwnerOfToken();
            }
            erc721Contract.safeTransferFrom(
                owner,
                to,
                tokenId
            );
            unchecked {
                ++i;
            }
        }
    }

    function batchTransferToMultipleWallets(
        IERC721 erc721Contract,
        address[] calldata tos,
        uint256[] calldata tokenIds
    ) external noZero {
        if (msg.sender == address(0)) revert InvalidCaller();
        uint256 length = tokenIds.length;
        if (tos.length != length) revert InvalidArguments();

        for (uint256 i; i < length; ) {
            uint256 tokenId = tokenIds[i];
            address owner = erc721Contract.ownerOf(tokenId);
            address to = tos[i];
            if (msg.sender != owner) {
                revert NotOwnerOfToken();
            }
            erc721Contract.transferFrom(
                owner,
                to,
                tokenId
            );
            unchecked {
                ++i;
            }
        }
    }

    function safeBatchTransferToMultipleWallets(
        IERC721 erc721Contract,
        address[] calldata tos,
        uint256[] calldata tokenIds
    ) external noZero {
        if (msg.sender == address(0)) revert InvalidCaller();
        uint256 length = tokenIds.length;
        if (tos.length != length) revert InvalidArguments();

        for (uint256 i; i < length; ) {
            uint256 tokenId = tokenIds[i];
            address owner = erc721Contract.ownerOf(tokenId);
            address to = tos[i];
            if (msg.sender != owner) {
                revert NotOwnerOfToken();
            }
            erc721Contract.safeTransferFrom(
                owner,
                to,
                tokenId
            );
            unchecked {
                ++i;
            }
        }
    }
}
