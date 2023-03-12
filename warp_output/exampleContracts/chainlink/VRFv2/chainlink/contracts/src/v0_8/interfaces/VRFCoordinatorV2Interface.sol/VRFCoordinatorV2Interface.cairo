%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def VRFCoordinatorV2Interface


@contract_interface
namespace VRFCoordinatorV2Interface{
func getRequestConfig_00012291()-> (__warp_0 : felt, __warp_1 : felt, __warp_2_len : felt, __warp_2 : Uint256*){
}
func requestRandomWords_5d3b1d30(keyHash : Uint256, subId : felt, minimumRequestConfirmations : felt, callbackGasLimit : felt, numWords : felt)-> (requestId : Uint256){
}
func createSubscription_a21a23e4()-> (subId : felt){
}
func getSubscription_a47c7696(subId : felt)-> (balance : felt, reqCount : felt, owner : felt, consumers_len : felt, consumers : felt*){
}
func requestSubscriptionOwnerTransfer_04c357cb(subId : felt, newOwner : felt)-> (){
}
func acceptSubscriptionOwnerTransfer_82359740(subId : felt)-> (){
}
func addConsumer_7341c10c(subId : felt, consumer : felt)-> (){
}
func removeConsumer_9f87fad7(subId : felt, consumer : felt)-> (){
}
func cancelSubscription_d7ae1d30(subId : felt, to : felt)-> (){
}
func pendingRequestExists_e82ad7d4(subId : felt)-> (__warp_3 : felt){
}
}