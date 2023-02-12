# warping-contracts

Testing optimized experimental contracts from the somlate library:

Note: contracts must not be abstract to compile with Warp, contracts modified for this. 

https://github.com/transmissions11/solmate

## solmate: 


## Tokens:

### ERC20: 

-🟢solmate ERC20 works

-🔴fails with EIP-2612 STORAGE (commented out for now)

### WETH:
 
-🟢can work as a generic ERC-20 that doesn't use msg.value

-🔴depends on ether:

        -deposit depends on msg.value sent to contract
        -withdraw depends on msg.value sent user
        -receive and fallback (not supported yet)
        -utils/SafeTransferLib.sol uses:
                -call
                -gas
            
### ERC721:

-🔴cannot check for wallet address in: 
        
-Solidity: 
    
```solidity
address.to.code
```      
-Assembly (Yul)     

```solidity
function isWallet(address account) public view returns (bool) {
        uint size;
        assembly {
                size := extcodesize(account)
        }
        return size == 0;
}
``` 

-🔴abstract contract type impacts:
  
```solidity
    function tokenURI(uint256 id) public view virtual returns (string memory);
```

### ERC1155:

-🔴cannot check for wallet address in: 
        
-Solidity: 
    
```solidity
address.to.code
```      
-Assembly (Yul)     

```solidity
function isWallet(address account) public view returns (bool) {
        uint size;
        assembly {
                size := extcodesize(account)
        }
        return size == 0;
}
```      

-🔴abstract contract type impacts:
  
```solidity
function uri(uint256 id) public view virtual returns (string memory);
```

            