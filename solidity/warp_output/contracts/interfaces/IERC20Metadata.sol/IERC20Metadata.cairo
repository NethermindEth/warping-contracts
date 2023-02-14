%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC20Metadata

//  @dev Interface for the optional metadata functions from the ERC20 standard.
// _Available since v4.1._
@contract_interface
namespace IERC20Metadata{
func name_06fdde03()-> (__warp_0_len : felt, __warp_0 : felt*){
}
func symbol_95d89b41()-> (__warp_1_len : felt, __warp_1 : felt*){
}
func decimals_313ce567()-> (__warp_2 : felt){
}
func totalSupply_18160ddd()-> (__warp_1 : Uint256){
}
func balanceOf_70a08231(account : felt)-> (__warp_2 : Uint256){
}
func transfer_a9059cbb(to : felt, amount : Uint256)-> (__warp_3 : felt){
}
func allowance_dd62ed3e(owner : felt, spender : felt)-> (__warp_4 : Uint256){
}
func approve_095ea7b3(spender : felt, amount : Uint256)-> (__warp_5 : felt){
}
func transferFrom_23b872dd(__warp_6_from : felt, to : felt, amount : Uint256)-> (__warp_7 : felt){
}
}