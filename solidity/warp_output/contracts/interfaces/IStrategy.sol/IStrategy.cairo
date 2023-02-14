%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IStrategy

//  @title Platform interface to integrate with lending platform like Compound, AAVE etc.
@contract_interface
namespace IStrategy{
func deposit_47e7ef24(_asset : felt, _amount : Uint256)-> (){
}
func depositAll_de5f6268()-> (){
}
func withdraw_d9caed12(_recipient : felt, _asset : felt, _amount : Uint256)-> (){
}
func withdrawAll_853828b6()-> (){
}
func checkBalance_5f515226(_asset : felt)-> (balance : Uint256){
}
func supportsAsset_aa388af6(_asset : felt)-> (__warp_0 : felt){
}
func collectRewardTokens_5a063f63()-> (){
}
func getRewardTokenAddresses_f6ca71b0()-> (__warp_1_len : felt, __warp_1 : felt*){
}
}