# warping-contracts

Transpiles in Warp with no errors in Solidity 0.8.14 with:

```shell
bin/warp transpile exampleContracts/chainlink/VRFv2/VRFD20.sol
```

Modified:

-replaced revert custom error 
```solidity
error OnlyCoordinatorCanFulfill(address have, address want)
```
with 
```solidity
require(msg.sender == vrfCoordinator, "OnlyCoordinatorCanFulfill")
```
in VRFConsumerBaseV2.sol since Warp does not currently handle custom errors.

Contract:

https://remix.ethereum.org/#url=https://docs.chain.link/samples/VRF/VRFD20.sol

Found in the Chainlink Documentation here with button
```
Open in Remix
```

https://docs.chain.link/getting-started/intermediates-tutorial/#house-function
