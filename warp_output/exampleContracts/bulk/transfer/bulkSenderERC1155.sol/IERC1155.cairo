%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC1155


@contract_interface
namespace IERC1155{
func safeBatchTransferFrom_2eb2c2d6(__warp_0_from : felt, to : felt, ids_len : felt, ids : Uint256*, amounts_len : felt, amounts : Uint256*, data_len : felt, data : felt*)-> (){
}
}