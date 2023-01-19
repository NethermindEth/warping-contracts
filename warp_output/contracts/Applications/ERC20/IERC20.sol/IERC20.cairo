%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC20


@contract_interface
namespace IERC20{
func totalSupply_18160ddd()-> (__warp_0 : Uint256){
}
func balanceOf_70a08231(account : felt)-> (__warp_1 : Uint256){
}
func transfer_a9059cbb(recipient : felt, amount : Uint256)-> (__warp_2 : felt){
}
func allowance_dd62ed3e(owner : felt, spender : felt)-> (__warp_3 : Uint256){
}
func approve_095ea7b3(spender : felt, amount : Uint256)-> (__warp_4 : felt){
}
func transferFrom_23b872dd(sender : felt, recipient : felt, amount : Uint256)-> (__warp_5 : felt){
}
}