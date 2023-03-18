%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC1155Receiver


@contract_interface
namespace IERC1155Receiver{
func onERC1155Received_f23a6e61(operator : felt, __warp_0_from : felt, id : Uint256, value : Uint256, data_len : felt, data : felt*)-> (__warp_1 : felt){
}
func onERC1155BatchReceived_bc197c81(operator : felt, __warp_2_from : felt, ids_len : felt, ids : Uint256*, values_len : felt, values : Uint256*, data_len : felt, data : felt*)-> (__warp_3 : felt){
}
func supportsInterface_01ffc9a7(interfaceId : felt)-> (__warp_0 : felt){
}
}