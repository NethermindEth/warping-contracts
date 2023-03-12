# warping-contracts

Transpiles in Warp with no errors in Solidity 0.8.14 with:

```shell
bin/warp transpile exampleContracts/chainlink/token/LinkTokenExperimental.sol
```

Modified:

-Does not check if an address is a contract for 
```solidity
  function transferAndCall(
    address to,
    uint value,
    bytes memory data
  )
    public
    override
    virtual
    returns (bool success) 
```
inside ERC-677 https://github.com/ethereum/EIPs/issues/677, since this depends on 
```solidity
assembly { length := extcodesize(addr) }
```
and there seems to be no other working way to check if an address has contract data in Warp currently.

Contract from:

https://github.com/MarcusWentz/Web3_Get_Set_Contract_Metamask/tree/main/Contracts




