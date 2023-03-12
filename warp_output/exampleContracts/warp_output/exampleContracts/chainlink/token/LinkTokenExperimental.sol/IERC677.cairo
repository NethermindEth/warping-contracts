%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC677


@contract_interface
namespace IERC677{
func transferAndCall_4000aea0(to : felt, value : Uint256, data_len : felt, data : felt*)-> (success : felt){
}
}