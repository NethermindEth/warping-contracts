# warping-contracts

Transpiles in Warp with no errors with Solidity 0.8.14 with:

```shell
bin/warp transpile exampleContracts/solmate/utils/Bytes32AddressLib.sol
```

Modified:

-library into contract to compile output file

-Solidity changes:
```solidity
// return address(uint160(uint256(bytesValue)));
return address(uint256(bytesValue));
```
and
```solidity
// return bytes32(bytes20(addressValue));
return bytes32(addressValue);
```