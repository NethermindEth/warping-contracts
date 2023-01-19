%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC721Receiver


@contract_interface
namespace IERC721Receiver{
func onERC721Received_150b7a02(operator : felt, __warp_0_from : felt, tokenId : Uint256, data_len : felt, data : felt*)-> (__warp_1 : felt){
}
}