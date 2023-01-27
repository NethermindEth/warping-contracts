# Transpiled [BN256G2.sol](https://github.com/musalbas/solidity-BN256G2) library.

Few changes needed to be made on contract in order for warp to transpile it correctly. 
- Keyword "library" needed to be changed to "contract"
- Solidity version needed to be updated to 0.8.0
- YUL part of the code in expmod() function needed to be reimplemented in cairo
- Contract deployed to goerli: https://goerli.voyager.online/contract/0x0039cac499b6cb4cb9e5f327a6accaf791a3049cb96ac6b42832a8216f977aa8


There is also a file BN256G2-uint256_modinv.cairo which uses uint256_mod_inv
which is waiting to be approved on cairo-libs since it uses hint and it's not working with starknet.
PR: https://github.com/starkware-libs/cairo-lang/pull/144
