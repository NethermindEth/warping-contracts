%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC677Receiver


@contract_interface
namespace IERC677Receiver{
func onTokenTransfer_a4c0ed36(sender : felt, value : Uint256, data_len : felt, data : felt*)-> (){
}
}