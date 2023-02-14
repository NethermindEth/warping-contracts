%lang starknet


from starkware.cairo.common.uint256 import Uint256


// Contract Def IOracle


@contract_interface
namespace IOracle{
func price_aea91078(asset : felt)-> (__warp_0 : Uint256){
}
}