%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC20


@contract_interface
namespace IERC20{
func transfer_a9059cbb(__warp_0 : felt, __warp_1 : Uint256)-> (__warp_2 : felt){
}
func transferFrom_23b872dd(__warp_3 : felt, __warp_4 : felt, __warp_5 : Uint256)-> (__warp_6 : felt){
}
}