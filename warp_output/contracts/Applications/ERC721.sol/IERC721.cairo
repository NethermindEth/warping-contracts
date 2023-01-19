%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IERC721


@contract_interface
namespace IERC721{
func balanceOf_70a08231(owner : felt)-> (balance : Uint256){
}
func ownerOf_6352211e(tokenId : Uint256)-> (owner : felt){
}
func safeTransferFrom_42842e0e(__warp_0_from : felt, to : felt, tokenId : Uint256)-> (){
}
func safeTransferFrom_b88d4fde(__warp_1_from : felt, to : felt, tokenId : Uint256, data_len : felt, data : felt*)-> (){
}
func transferFrom_23b872dd(__warp_2_from : felt, to : felt, tokenId : Uint256)-> (){
}
func approve_095ea7b3(to : felt, tokenId : Uint256)-> (){
}
func getApproved_081812fc(tokenId : Uint256)-> (operator : felt){
}
func setApprovalForAll_a22cb465(operator : felt, _approved : felt)-> (){
}
func isApprovedForAll_e985e9c5(owner : felt, operator : felt)-> (__warp_3 : felt){
}
func supportsInterface_01ffc9a7(interfaceID : felt)-> (__warp_0 : felt){
}
}