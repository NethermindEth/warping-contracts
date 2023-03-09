# warping-contracts

Transpiles in Warp with no errors in Solidity 0.8.14 with:

```shell
bin/warp transpile exampleContracts/chainlink/pricefeed/pricefeedExample.sol
```

Modified:

-put contract AggregatorV3Interface.sol 
https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol 
directly into the pricefeed example contract instead of importing it to get around syntax transpiler issue.

Contract from:

https://docs.chain.link/data-feeds/using-data-feeds/#examine-the-sample-contract

