%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def AggregatorV3Interface


@contract_interface
namespace AggregatorV3Interface{
func decimals_313ce567()-> (__warp_0 : felt){
}
func description_7284e416()-> (__warp_1_len : felt, __warp_1 : felt*){
}
func version_54fd4d50()-> (__warp_2 : Uint256){
}
func getRoundData_9a6fc8f5(_roundId : felt)-> (roundId : felt, answer : Uint256, startedAt : Uint256, updatedAt : Uint256, answeredInRound : felt){
}
func latestRoundData_feaf968c()-> (roundId : felt, answer : Uint256, startedAt : Uint256, updatedAt : Uint256, answeredInRound : felt){
}
}