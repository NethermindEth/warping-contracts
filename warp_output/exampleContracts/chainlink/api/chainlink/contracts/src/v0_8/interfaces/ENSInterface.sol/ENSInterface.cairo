%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def ENSInterface


@contract_interface
namespace ENSInterface{
func setSubnodeOwner_06ab5923(node : Uint256, label : Uint256, owner : felt)-> (){
}
func setResolver_1896f70a(node : Uint256, resolver : felt)-> (){
}
func setOwner_5b0fc9c3(node : Uint256, owner : felt)-> (){
}
func setTTL_14ab9038(node : Uint256, ttl : felt)-> (){
}
func owner_02571be3(node : Uint256)-> (__warp_0 : felt){
}
func resolver_0178b8bf(node : Uint256)-> (__warp_1 : felt){
}
func ttl_16a25cbd(node : Uint256)-> (__warp_2 : felt){
}
}