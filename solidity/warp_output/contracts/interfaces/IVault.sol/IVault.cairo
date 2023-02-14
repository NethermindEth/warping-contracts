%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IVault


@contract_interface
namespace IVault{
func transferGovernance_d38bfff4(_newGovernor : felt)-> (){
}
func claimGovernance_5d36b190()-> (){
}
func owner_8da5cb5b()-> (__warp_0 : felt){
}
func setPriceProvider_372aa224(_priceProvider : felt)-> (){
}
func priceProvider_b888879e()-> (__warp_1 : felt){
}
func setRedeemFeeBps_eb03654b(_redeemFeeBps : Uint256)-> (){
}
func redeemFeeBps_09f6442c()-> (__warp_2 : Uint256){
}
func setVaultBuffer_8ec489a2(_vaultBuffer : Uint256)-> (){
}
func vaultBuffer_1edfe3da()-> (__warp_3 : Uint256){
}
func setAutoAllocateThreshold_b2c9336d(_threshold : Uint256)-> (){
}
func autoAllocateThreshold_9fa1826e()-> (__warp_4 : Uint256){
}
func setRebaseThreshold_b890ebf6(_threshold : Uint256)-> (){
}
func rebaseThreshold_52d38e5d()-> (__warp_5 : Uint256){
}
func setStrategistAddr_773540b3(_address : felt)-> (){
}
func strategistAddr_570d8e1d()-> (__warp_6 : felt){
}
func setMaxSupplyDiff_663e64ce(_maxSupplyDiff : Uint256)-> (){
}
func maxSupplyDiff_8e510b52()-> (__warp_7 : Uint256){
}
func setTrusteeAddress_2da845a8(_address : felt)-> (){
}
func trusteeAddress_49c1d54d()-> (__warp_8 : felt){
}
func setTrusteeFeeBps_0acbda75(_basis : Uint256)-> (){
}
func trusteeFeeBps_207134b0()-> (__warp_9 : Uint256){
}
func ousdMetaStrategy_18ce56bd()-> (__warp_10 : felt){
}
func supportAsset_4cd55c2d(_asset : felt)-> (){
}
func approveStrategy_3b8ae397(_addr : felt)-> (){
}
func removeStrategy_175188e8(_addr : felt)-> (){
}
func setAssetDefaultStrategy_bc90106b(_asset : felt, _strategy : felt)-> (){
}
func assetDefaultStrategies_a403e4d5(_asset : felt)-> (__warp_11 : felt){
}
func pauseRebase_c5f00841()-> (){
}
func unpauseRebase_09f49bf5()-> (){
}
func rebasePaused_53ca9f24()-> (__warp_12 : felt){
}
func pauseCapital_3dbc911f()-> (){
}
func unpauseCapital_94828ffd()-> (){
}
func capitalPaused_e6cc5432()-> (__warp_13 : felt){
}
func transferToken_1072cbea(_asset : felt, _amount : Uint256)-> (){
}
func priceUSDMint_10d3fdac(asset : felt)-> (__warp_14 : Uint256){
}
func priceUSDRedeem_8c5cbb89(asset : felt)-> (__warp_15 : Uint256){
}
func withdrawAllFromStrategy_597c8910(_strategyAddr : felt)-> (){
}
func withdrawAllFromStrategies_c9919112()-> (){
}
func reallocate_7fe2d393(_strategyFromAddress : felt, _strategyToAddress : felt, _assets_len : felt, _assets : felt*, _amounts_len : felt, _amounts : Uint256*)-> (){
}
func withdrawFromStrategy_ae69f3cb(_strategyFromAddress : felt, _assets_len : felt, _assets : felt*, _amounts_len : felt, _amounts : Uint256*)-> (){
}
func depositToStrategy_840c4c7a(_strategyToAddress : felt, _assets_len : felt, _assets : felt*, _amounts_len : felt, _amounts : Uint256*)-> (){
}
func mint_156e29f6(_asset : felt, _amount : Uint256, _minimumOusdAmount : Uint256)-> (){
}
func mintForStrategy_ab80dafb(_amount : Uint256)-> (){
}
func redeem_7cbc2373(_amount : Uint256, _minimumUnitAmount : Uint256)-> (){
}
func burnForStrategy_6217f3ea(_amount : Uint256)-> (){
}
func redeemAll_7136a7a6(_minimumUnitAmount : Uint256)-> (){
}
func allocate_abaa9916()-> (){
}
func rebase_af14052c()-> (){
}
func totalValue_d4c3eea0()-> (value : Uint256){
}
func checkBalance_5f515226(_asset : felt)-> (__warp_16 : Uint256){
}
func calculateRedeemOutputs_67bd7ba3(_amount : Uint256)-> (__warp_17_len : felt, __warp_17 : Uint256*){
}
func getAssetCount_a0aead4d()-> (__warp_18 : Uint256){
}
func getAllAssets_2acada4d()-> (__warp_19_len : felt, __warp_19 : felt*){
}
func getStrategyCount_31e19cfa()-> (__warp_20 : Uint256){
}
func getAllStrategies_c3b28864()-> (__warp_21_len : felt, __warp_21 : felt*){
}
func isSupportedAsset_9be918e6(_asset : felt)-> (__warp_22 : felt){
}
func netOusdMintForStrategyThreshold_7a2202f3()-> (__warp_23 : Uint256){
}
func setOusdMetaStrategy_d58e3b3a(_ousdMetaStrategy : felt)-> (){
}
func setNetOusdMintForStrategyThreshold_636e6c40(_threshold : Uint256)-> (){
}
func netOusdMintedForStrategy_e45cc9f0()-> (__warp_24 : Uint256){
}
}