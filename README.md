# ERC721 Batch Transfer

ERC721BatchTransfer can transfer multiple ERC721 tokens to multiple addresses in a single transaction.

To use this contract, first run `setApproveForAll` or `approve` in the ERC721 contract from the wallet that will be transfering the tokens.

## Deployments

| Chain   | [Chain ID](https://chainlist.org) | Address                                                                                                               |
| ------- | --------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| Mainnet | 1                                 | [0x055c942A5396460f0d36295bEd65436cd970Aa11](https://etherscan.io/address/0x055c942A5396460f0d36295bEd65436cd970Aa11) |

## Benchmarks

Gas cost of the transaction when transfering 5 tokens. **Note:** this is not 100% accurate.

- Those values are not 100% accurate but they are close enough
- The benchmarks are made using the OpenZeppelin ERC721 contract. If you use ERC721A for example, the amount of gas used will be very different.

**Transfer of 5 tokens when recipients doesn't own any tokens of the collection**

| function                           | gas units |
| ---------------------------------- | --------- |
| batchTransferToSingleWallet        | 119669    |
| safeBatchTransferToSingleWallet    | 123651    |
| batchTransferToMultipleWallets     | 221350    |
| safeBatchTransferToMultipleWallets | 235266    |

**Transfer of 5 tokens when recipients do own one or more tokens of the collection**

| function                           | gas units |
| ---------------------------------- | --------- |
| batchTransferToSingleWallet        | 102547    |
| safeBatchTransferToSingleWallet    | 106595    |
| batchTransferToMultipleWallets     | 116650    |
| safeBatchTransferToMultipleWallets | 120566    |

## Human-Readable ABI

Below is the human-readable ABI. This can be directly passed into an ethers.js Contract or Interface constructor.

```ts
const ERC721_BATCH_TRANSFER_ABI = [
  // https://github.com/alephao/erc721-batch-transfer
  "function batchTransferToSingleWallet(IERC721 erc721Contract, address to, uint256[] calldata tokenIds) external",
  "function safeBatchTransferToSingleWallet(IERC721 erc721Contract, address to, uint256[] calldata tokenIds) external",
  "function batchTransferToMultipleWallets(IERC721 erc721Contract, address[] calldata tos, uint256[] calldata tokenIds) external",
  "function safeBatchTransferToMultipleWallets(IERC721 erc721Contract, address[] calldata tos, uint256[] calldata tokenIds) external",
];
```

## Acknowledgements

- README inspired by https://github.com/mds1/multicall
- This contract was intially built for the Gen C NFT collection of [Oddworx](https://oddworx.com)
