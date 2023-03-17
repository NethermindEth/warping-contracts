%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def OracleInterface


@contract_interface
namespace OracleInterface{
func fulfillOracleRequest_4ab0d190(requestId : Uint256, payment : Uint256, callbackAddress : felt, callbackFunctionId : felt, expiration : Uint256, data : Uint256)-> (__warp_0 : felt){
}
func isAuthorizedSender_fa00763a(node : felt)-> (__warp_1 : felt){
}
func withdraw_f3fef3a3(recipient : felt, amount : Uint256)-> (){
}
func withdrawable_50188301()-> (__warp_2 : Uint256){
}
}