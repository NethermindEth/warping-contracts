%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def ChainlinkRequestInterface


@contract_interface
namespace ChainlinkRequestInterface{
func oracleRequest_40429946(sender : felt, requestPrice : Uint256, serviceAgreementID : Uint256, callbackAddress : felt, callbackFunctionId : felt, nonce : Uint256, dataVersion : Uint256, data_len : felt, data : felt*)-> (){
}
func cancelOracleRequest_6ee4d553(requestId : Uint256, payment : Uint256, callbackFunctionId : felt, expiration : Uint256)-> (){
}
}