%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def LinkTokenInterface


@contract_interface
namespace LinkTokenInterface{
func allowance_dd62ed3e(owner : felt, spender : felt)-> (remaining : Uint256){
}
func approve_095ea7b3(spender : felt, value : Uint256)-> (success : felt){
}
func balanceOf_70a08231(owner : felt)-> (balance : Uint256){
}
func decimals_313ce567()-> (decimalPlaces : felt){
}
func decreaseApproval_66188463(spender : felt, addedValue : Uint256)-> (success : felt){
}
func increaseApproval_d73dd623(spender : felt, subtractedValue : Uint256)-> (){
}
func name_06fdde03()-> (tokenName_len : felt, tokenName : felt*){
}
func symbol_95d89b41()-> (tokenSymbol_len : felt, tokenSymbol : felt*){
}
func totalSupply_18160ddd()-> (totalTokensIssued : Uint256){
}
func transfer_a9059cbb(to : felt, value : Uint256)-> (success : felt){
}
func transferAndCall_4000aea0(to : felt, value : Uint256, data_len : felt, data : felt*)-> (success : felt){
}
func transferFrom_23b872dd(__warp_0_from : felt, to : felt, value : Uint256)-> (success : felt){
}
}