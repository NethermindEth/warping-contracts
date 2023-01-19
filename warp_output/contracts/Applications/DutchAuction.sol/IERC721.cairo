%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC721


@contract_interface
namespace IERC721{
func transferFrom_23b872dd(_from : felt, _to : felt, _nftId : Uint256)-> (){
}
}