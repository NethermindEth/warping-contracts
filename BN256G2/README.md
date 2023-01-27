# Transpiled [BN256G2.sol](https://github.com/musalbas/solidity-BN256G2) library.

A few changes needed to be made to the contract in order for warp to transpile it correctly. 
- The keyword "library" needed to be changed to "contract"
- Solidity version needed to be updated to 0.8.0
- YUL part of the code in expmod() function needed to be reimplemented in cairo
- Contract deployed to goerli: https://goerli.voyager.online/contract/0x0039cac499b6cb4cb9e5f327a6accaf791a3049cb96ac6b42832a8216f977aa8

This contract doesn't work properly on starknet because expmod is too heavy for the current implementation of the sequencer in starknet. One expmod with 256 bit as exponent takes 500k steps.
That's why it is imposible to test this.


However, there is a version that can be tested locally with protostar: BN256-uint256_mod_inv.cairo.
Be sure to add --max-steps 20000000 and note that it takes ~10-15mins to execute the ectwistadd or ectwistmul. I have tested it with the generator points and works the same as solidity contract.

This version uses uint256_mod_inv which is waiting to be approved and whitelisted on cairo-libs since it uses hint and it's not working with starknet currently.
PR: https://github.com/starkware-libs/cairo-lang/pull/144

