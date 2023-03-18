%lang starknet


from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from starkware.starknet.common.syscalls import get_contract_address
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int8


func external_input_check_dynamic_array0{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
    warp_external_input_check_int8(ptr[0]);
    external_input_check_dynamic_array0(len = len - 1, ptr = ptr + 1);
    return ();
}


// Contract Def burnERC721


namespace burnERC721{

    // Dynamic variables - Arrays and Maps

    // Static variables

}


    @external
    func onERC721Received_150b7a02{syscall_ptr : felt*, range_check_ptr : felt}(__warp_0 : felt, __warp_1 : felt, __warp_2 : Uint256, __warp_3_len : felt, __warp_3 : felt*)-> (__warp_4 : felt){
    alloc_locals;


        
        external_input_check_dynamic_array0(__warp_3_len, __warp_3);
        
        warp_external_input_check_int256(__warp_2);
        
        warp_external_input_check_address(__warp_1);
        
        warp_external_input_check_address(__warp_0);
        
        let (__warp_se_0) = get_contract_address();
        
        
        
        return (__warp_se_0.onERC721Received_150b7a02.selector,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;


        
        
        
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


// Contract Def burnERC721@interface


@contract_interface
namespace burnERC721_warped_interface_1{
func onERC721Received_150b7a02(__warp_0 : felt, __warp_1 : felt, __warp_2 : Uint256, __warp_3_len : felt, __warp_3 : felt*)-> (__warp_4 : felt){
}
}