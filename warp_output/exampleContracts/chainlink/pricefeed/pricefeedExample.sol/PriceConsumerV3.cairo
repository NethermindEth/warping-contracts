%lang starknet


from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from warplib.maths.external_input_check_ints import warp_external_input_check_int256


func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}


func WS0_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}


// Contract Def PriceConsumerV3


namespace PriceConsumerV3{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const __warp_0_priceFeed = 0;


    func __warp_init_PriceConsumerV3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_priceFeed, 155680397429899150176167208149732158272590442051);
        
        
        
        return ();

    }

}


    @view
    func getLatestPrice_8e15f473{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_1 : Uint256){
    alloc_locals;


        
        let (__warp_se_0) = WS0_READ_felt(PriceConsumerV3.__warp_0_priceFeed);
        
        let (__warp_gv0, __warp_2_price, __warp_gv1, __warp_gv2, __warp_gv3) = AggregatorV3Interface_warped_interface.latestRoundData_feaf968c(__warp_se_0);
        
        warp_external_input_check_int256(__warp_2_price);
        
        
        
        return (__warp_2_price,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(1);


        
        PriceConsumerV3.__warp_init_PriceConsumerV3();
        
        
        
        return ();

    }

@storage_var
func WARP_STORAGE(index: felt) -> (val: felt){
}
@storage_var
func WARP_USED_STORAGE() -> (val: felt){
}
@storage_var
func WARP_NAMEGEN() -> (name: felt){
}
func readId{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) -> (val: felt){
    alloc_locals;
    let (id) = WARP_STORAGE.read(loc);
    if (id == 0){
        let (id) = WARP_NAMEGEN.read();
        WARP_NAMEGEN.write(id + 1);
        WARP_STORAGE.write(loc, id + 1);
        return (id + 1,);
    }else{
        return (id,);
    }
}


// Contract Def AggregatorV3Interface@interface


@contract_interface
namespace AggregatorV3Interface_warped_interface{
func decimals_313ce567()-> (__warp_0 : felt){
}
func description_7284e416()-> (__warp_1_len : felt, __warp_1 : felt*){
}
func version_54fd4d50()-> (__warp_2 : Uint256){
}
func getRoundData_9a6fc8f5(_roundId : felt)-> (roundId : felt, answer : Uint256, startedAt : Uint256, updatedAt : Uint256, answeredInRound : felt){
}
func latestRoundData_feaf968c()-> (roundId : felt, answer : Uint256, startedAt : Uint256, updatedAt : Uint256, answeredInRound : felt){
}
}