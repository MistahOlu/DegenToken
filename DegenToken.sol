

// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20("salvador", "savy"), Ownable(msg.sender){
    
    enum Asset{
        Amour, 
        Sword,
        Bow
    }

    mapping (address => Asset) public assetOwned;

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

    function getOwnedAssert() external view returns(Asset) {
       return assetOwned[msg.sender];
    }

    function burnToken(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
