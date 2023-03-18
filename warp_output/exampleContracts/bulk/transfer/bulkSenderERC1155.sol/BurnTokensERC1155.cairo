%lang starknet


from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from starkware.starknet.common.syscalls import get_contract_address
from warplib.maths.eq import warp_eq
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int32, warp_external_input_check_int8


func external_input_check_dynamic_array0{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
    warp_external_input_check_int8(ptr[0]);
    external_input_check_dynamic_array0(len = len - 1, ptr = ptr + 1);
    return ();
}


func external_input_check_dynamic_array1{range_check_ptr : felt}(len: felt, ptr : Uint256*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
    warp_external_input_check_int256(ptr[0]);
    external_input_check_dynamic_array1(len = len - 1, ptr = ptr + 2);
    return ();
}


// Contract Def BurnTokensERC1155


namespace BurnTokensERC1155{

    // Dynamic variables - Arrays and Maps

    // Static variables


    func __warp_conditional_supportsInterface_01ffc9a7_1(__warp_0_interfaceId : felt)-> (__warp_rc_0 : felt, __warp_0_interfaceId : felt){
    alloc_locals;


        
        let (__warp_se_2) = warp_eq(__warp_0_interfaceId, 1310921440);
        
        if (__warp_se_2 != 0){
        
            
            let __warp_rc_0 = 1;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_0_interfaceId = __warp_0_interfaceId;
            
            
            
            return (__warp_rc_0, __warp_0_interfaceId);
        }else{
        
            
            let (__warp_pse_0) = s4_supportsInterface_01ffc9a7(__warp_0_interfaceId);
            
            let __warp_rc_0 = __warp_pse_0;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_0_interfaceId = __warp_0_interfaceId;
            
            
            
            return (__warp_rc_0, __warp_0_interfaceId);
        }

    }


    func s4_supportsInterface_01ffc9a7(__warp_0_interfaceId : felt)-> (__warp_1 : felt){
    alloc_locals;


        
        let (__warp_se_3) = warp_eq(__warp_0_interfaceId, 33540519);
        
        
        
        return (__warp_se_3,);

    }

}


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;


        
        
        
        return ();

    }


    @external
    func onERC1155Received_f23a6e61{syscall_ptr : felt*, range_check_ptr : felt}(__warp_0 : felt, __warp_1 : felt, __warp_2 : Uint256, __warp_3 : Uint256, __warp_4_len : felt, __warp_4 : felt*)-> (__warp_5 : felt){
    alloc_locals;


        
        external_input_check_dynamic_array0(__warp_4_len, __warp_4);
        
        warp_external_input_check_int256(__warp_3);
        
        warp_external_input_check_int256(__warp_2);
        
        warp_external_input_check_address(__warp_1);
        
        warp_external_input_check_address(__warp_0);
        
        let (__warp_se_0) = get_contract_address();
        
        
        
        return (__warp_se_0.onERC1155Received_f23a6e61.selector,);

    }


    @external
    func onERC1155BatchReceived_bc197c81{syscall_ptr : felt*, range_check_ptr : felt}(__warp_6 : felt, __warp_7 : felt, __warp_8_len : felt, __warp_8 : Uint256*, __warp_9_len : felt, __warp_9 : Uint256*, __warp_10_len : felt, __warp_10 : felt*)-> (__warp_11 : felt){
    alloc_locals;


        
        external_input_check_dynamic_array0(__warp_10_len, __warp_10);
        
        external_input_check_dynamic_array1(__warp_9_len, __warp_9);
        
        external_input_check_dynamic_array1(__warp_8_len, __warp_8);
        
        warp_external_input_check_address(__warp_7);
        
        warp_external_input_check_address(__warp_6);
        
        let (__warp_se_1) = get_contract_address();
        
        
        
        return (__warp_se_1.onERC1155BatchReceived_bc197c81.selector,);

    }


    @view
    func supportsInterface_01ffc9a7{syscall_ptr : felt*, range_check_ptr : felt}(__warp_0_interfaceId : felt)-> (__warp_1 : felt){
    alloc_locals;


        
        warp_external_input_check_int32(__warp_0_interfaceId);
        
        let __warp_rc_0 = 0;
        
            
            let (__warp_tv_0, __warp_tv_1) = BurnTokensERC1155.__warp_conditional_supportsInterface_01ffc9a7_1(__warp_0_interfaceId);
            
            let __warp_0_interfaceId = __warp_tv_1;
            
            let __warp_rc_0 = __warp_tv_0;
        
        
        
        return (__warp_rc_0,);

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


// Contract Def ERC1155Holder@interface


@contract_interface
namespace ERC1155Holder_warped_interface{
func onERC1155Received_f23a6e61(__warp_0 : felt, __warp_1 : felt, __warp_2 : Uint256, __warp_3 : Uint256, __warp_4_len : felt, __warp_4 : felt*)-> (__warp_5 : felt){
}
func onERC1155BatchReceived_bc197c81(__warp_6 : felt, __warp_7 : felt, __warp_8_len : felt, __warp_8 : Uint256*, __warp_9_len : felt, __warp_9 : Uint256*, __warp_10_len : felt, __warp_10 : felt*)-> (__warp_11 : felt){
}
func supportsInterface_01ffc9a7(__warp_0_interfaceId : felt)-> (__warp_1 : felt){
}
}