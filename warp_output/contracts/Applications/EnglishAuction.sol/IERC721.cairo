%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC721


@contract_interface
namespace IERC721{
func safeTransferFrom_42842e0e(__warp_0_from : felt, to : felt, tokenId : Uint256)-> (){
}
func transferFrom_23b872dd(__warp_1 : felt, __warp_2 : felt, __warp_3 : Uint256)-> (){
}
}