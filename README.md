# warping-contracts

Testing optimized experimental contracts from the somlate library:

Note: contracts must not be abstract to compile with Warp, contracts modified for this. 

https://github.com/transmissions11/solmate

## solmate: 


## Tokens:

### ERC20.sol: 

        -🟢solmate ERC20 works
        -🔴fails with EIP-2612 STORAGE (commented out for now)

### WETH.sol:
 
        -🟢can work as a generic ERC-20 that doesn't use msg.value
        -🔴depends on ether
        -deposit{value:msg.value}
        -withdraw(amount)
        -receive and fallback (not supported yet)
        -utils/SafeTransferLib.sol uses:
            -call
            -gas
            
### ERC721.sol:

        -🟡see if there is an alternative for Warp to transpile: 
      
```solidity
address.to.code
``` 

        -🔴abstract contract type impacts:
  
```solidity
    function tokenURI(uint256 id) public view virtual returns (string memory);
```

### ERC1155.sol:

        -🟡see if there is an alternative for Warp to transpile: 
    
```solidity
address.to.code
```      

        -🔴abstract contract type impacts:
  
```solidity
function uri(uint256 id) public view virtual returns (string memory);
```

            