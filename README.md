# warping-contracts
Example Solidity contracts transpiled to Cairo using Warp

Transpiles in Warp with in Solidity 0.8.14 with:

```shell
bin/warp transpile exampleContracts/chainlink/api/getEthUsdUint256.sol
```

Modified:

-Commented out most of the Yul buffer logic in BufferChainlink.sol, might cause client to fail but transpiles

-Changed "v0.8" to "v0_8" since Warp transpiler does not like "." characters in file paths

-Calculated bytes32 jobId in Remix IDE since this logic does not transpile
s
