%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def OperatorInterface


@contract_interface
namespace OperatorInterface{
func operatorRequest_3c6d41b9(sender : felt, payment : Uint256, specId : Uint256, callbackFunctionId : felt, nonce : Uint256, dataVersion : Uint256, data_len : felt, data : felt*)-> (){
}
func fulfillOracleRequest2_6ae0bc76(requestId : Uint256, payment : Uint256, callbackAddress : felt, callbackFunctionId : felt, expiration : Uint256, data_len : felt, data : felt*)-> (__warp_0 : felt){
}
func ownerTransferAndCall_902fc370(to : felt, value : Uint256, data_len : felt, data : felt*)-> (success : felt){
}
func distributeFunds_6bd59ec0(receivers_len : felt, receivers : felt*, amounts_len : felt, amounts : Uint256*)-> (){
}
func getAuthorizedSenders_2408afaa()-> (__warp_1_len : felt, __warp_1 : felt*){
}
func setAuthorizedSenders_ee56997b(senders_len : felt, senders : felt*)-> (){
}
func getForwarder_a0042526()-> (__warp_2 : felt){
}
func oracleRequest_40429946(sender : felt, requestPrice : Uint256, serviceAgreementID : Uint256, callbackAddress : felt, callbackFunctionId : felt, nonce : Uint256, dataVersion : Uint256, data_len : felt, data : felt*)-> (){
}
func cancelOracleRequest_6ee4d553(requestId : Uint256, payment : Uint256, callbackFunctionId : felt, expiration : Uint256)-> (){
}
func fulfillOracleRequest_4ab0d190(requestId : Uint256, payment : Uint256, callbackAddress : felt, callbackFunctionId : felt, expiration : Uint256, data : Uint256)-> (__warp_0 : felt){
}
func isAuthorizedSender_fa00763a(node : felt)-> (__warp_1 : felt){
}
func withdraw_f3fef3a3(recipient : felt, amount : Uint256)-> (){
}
func withdrawable_50188301()-> (__warp_2 : Uint256){
}
}