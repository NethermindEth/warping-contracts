%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC721


@contract_interface
namespace IERC721{
func safeTransferFrom_42842e0e(__warp_0_from : felt, to : felt, tokenId : Uint256)-> (){
}
}