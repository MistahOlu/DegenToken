# DegenToken

DegenToken is an ERC-20 token deployed on the Avalanche Fuji Testnet. It is designed for use in a gaming ecosystem where players can redeem tokens for various in-game assets. This repository contains the smart contract code for DegenToken, along with instructions for deployment and usage.

## Overview

The DegenToken contract implements the ERC-20 token standard and includes additional functionalities for minting, burning, and redeeming tokens for specific assets. The contract is written in Solidity and uses OpenZeppelin libraries for standard token and ownership functionalities.

## Token Details

- **Name:** Degen
- **Symbol:** DGN

## Features

- **Minting:** Only the owner can mint new tokens.
- **Burning:** Any holder can burn their tokens.
- **Redeeming:** Users can redeem tokens for in-game assets (Amour, Sword, Bow) by transferring tokens to the contract.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- [Remix](https://remix.ethereum.org/)
- [Avalanche Fuji Testnet account](https://docs.avax.network/build/tutorials/platform/create-a-fuji-testnet-faucet/)


### Verification

After deploying the contract, verify it on Snowtrace:

1. Copy the contract address from the deployment output.
2. Go to [Snowtrace](https://snowtrace.io/).
3. Follow the instructions to verify the contract.

## Smart Contract

The smart contract is located in the `contracts` directory. Here is the code:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20("Degen", "DGN"), Ownable {
    
    enum Asset {
        Amour, 
        Sword,
        Bow
    }

    mapping (address => Asset) public assetOwned;

    constructor() Ownable() {}

    function mintToken() external onlyOwner {
        _mint(msg.sender, 1000);
    }

    function redeemToken(uint choice) external {
        if (choice == 1){
            _transfer(msg.sender, address(this), 80);
            assetOwned[msg.sender] = Asset.Amour;
        }
        else if (choice == 2) {
            _transfer(msg.sender, address(this), 60);
            assetOwned[msg.sender] = Asset.Bow;
        }
        else if (choice == 3) {
            _transfer(msg.sender, address(this), 40);
            assetOwned[msg.sender] = Asset.Sword;
        }
        else revert("invalid input");
    }

    function burnToken(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
```

## Usage

### Minting Tokens

Only the owner can mint new tokens:

```solidity
function mintToken() external onlyOwner
```

### Redeeming Tokens

Users can redeem tokens for in-game assets:

```solidity
function redeemToken(uint choice) external
```

- Choice 1: Amour (80 DGN)
- Choice 2: Bow (60 DGN)
- Choice 3: Sword (40 DGN)

### Burning Tokens

Any holder can burn their tokens:

```solidity
function burnToken(uint256 amount) external
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

---

This README provides a clear overview of the DegenToken project. It should help other developers understand and work with the project effectively.
