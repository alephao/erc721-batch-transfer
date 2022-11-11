// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";

contract ERC721Mock is ERC721 {
    // solhint-disable-next-line no-empty-blocks
    constructor() ERC721("MOCK", "M") {}

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function mintMany(address to, uint256[] calldata tokenIds) external {
        uint256 length = tokenIds.length;
        for (uint256 i; i < length; ) {
            _mint(to, tokenIds[i]);
            unchecked {
                ++i;
            }
        }
    }
}
