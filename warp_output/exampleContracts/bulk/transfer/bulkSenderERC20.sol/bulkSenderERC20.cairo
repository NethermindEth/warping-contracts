%lang starknet


from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from starkware.cairo.common.default_dict import default_dict_finalize, default_dict_new
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.uint256 import Uint256
from starkware.starknet.common.syscalls import get_caller_address, get_contract_address
from warplib.maths.add_unsafe import warp_add_unsafe256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.lt import warp_lt256
from warplib.maths.mul import warp_mul256
from warplib.maths.utils import felt_to_uint256
from warplib.memory import wm_dyn_array_length, wm_index_dyn, wm_new, wm_read_felt


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}


func cd_to_memory_dynamic_array0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata: felt*, mem_start: felt, length: felt){
    alloc_locals;
    if (length == 0){
        return ();
    }
dict_write{dict_ptr=warp_memory}(mem_start, calldata[0]);
    return cd_to_memory_dynamic_array0_elem(calldata + 1, mem_start + 1, length - 1);
}
func cd_to_memory_dynamic_array0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata : cd_dynarray_felt) -> (mem_loc: felt){
    alloc_locals;
    let (len256) = felt_to_uint256(calldata.len);
    let (mem_start) = wm_new(len256, Uint256(0x1, 0x0));
    cd_to_memory_dynamic_array0_elem(calldata.ptr, mem_start + 2, calldata.len);
    return (mem_start,);
}


func external_input_check_dynamic_array0{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
    warp_external_input_check_address(ptr[0]);
    external_input_check_dynamic_array0(len = len - 1, ptr = ptr + 1);
    return ();
}


// Contract Def bulkSenderERC20


namespace bulkSenderERC20{

    // Dynamic variables - Arrays and Maps

    // Static variables


    func __warp_while0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_2_i : Uint256, __warp_1_myArray_mem : felt, __warp_0_tokenAddress : felt)-> (__warp_2_i : Uint256, __warp_1_myArray_mem : felt, __warp_0_tokenAddress : felt){
    alloc_locals;


        
            
            let (__warp_se_0) = wm_dyn_array_length(__warp_1_myArray_mem);
            
            let (__warp_se_1) = warp_lt256(__warp_2_i, __warp_se_0);
            
                
                if (__warp_se_1 != 0){
                
                    
                        
                        let (__warp_se_2) = wm_index_dyn(__warp_1_myArray_mem, __warp_2_i, Uint256(low=1, high=0));
                        
                        let (__warp_se_3) = wm_read_felt(__warp_se_2);
                        
                        ERC20_warped_interface.transfer_a9059cbb(__warp_0_tokenAddress, __warp_se_3, Uint256(low=1000000000000000000, high=0));
                        
                            
                            let (__warp_se_4) = warp_add_unsafe256(__warp_2_i, Uint256(low=1, high=0));
                            
                            let __warp_2_i = __warp_se_4;
                    tempvar warp_memory = warp_memory;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar keccak_ptr = keccak_ptr;
                    tempvar __warp_2_i = __warp_2_i;
                    tempvar __warp_1_myArray_mem = __warp_1_myArray_mem;
                    tempvar __warp_0_tokenAddress = __warp_0_tokenAddress;
                }else{
                
                    
                    let __warp_2_i = __warp_2_i;
                    
                    let __warp_1_myArray_mem = __warp_1_myArray_mem;
                    
                    let __warp_0_tokenAddress = __warp_0_tokenAddress;
                    
                    
                    
                    return (__warp_2_i, __warp_1_myArray_mem, __warp_0_tokenAddress);
                }
                tempvar warp_memory = warp_memory;
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_2_i = __warp_2_i;
                tempvar __warp_1_myArray_mem = __warp_1_myArray_mem;
                tempvar __warp_0_tokenAddress = __warp_0_tokenAddress;
        
        let (__warp_2_i, __warp_td_0, __warp_0_tokenAddress) = __warp_while0(__warp_2_i, __warp_1_myArray_mem, __warp_0_tokenAddress);
        
        let __warp_1_myArray_mem = __warp_td_0;
        
        
        
        return (__warp_2_i, __warp_1_myArray_mem, __warp_0_tokenAddress);

    }

}


    @external
    func bulkSend_90e2fb63{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_tokenAddress : felt, __warp_1_myArray_len : felt, __warp_1_myArray : felt*)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        external_input_check_dynamic_array0(__warp_1_myArray_len, __warp_1_myArray);
        
        warp_external_input_check_address(__warp_0_tokenAddress);
        
        local __warp_1_myArray_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_1_myArray_len, __warp_1_myArray);
        
        let (__warp_1_myArray_mem) = cd_to_memory_dynamic_array0(__warp_1_myArray_dstruct);
        
        let (__warp_se_5) = get_caller_address();
        
        let (__warp_se_6) = get_contract_address();
        
        let (__warp_se_7) = wm_dyn_array_length(__warp_1_myArray_mem);
        
        let (__warp_se_8) = warp_mul256(__warp_se_7, Uint256(low=1000000000000000000, high=0));
        
        ERC20_warped_interface.transferFrom_23b872dd(__warp_0_tokenAddress, __warp_se_5, __warp_se_6, __warp_se_8);
        
            
            let __warp_2_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_0, __warp_td_1, __warp_tv_2) = bulkSenderERC20.__warp_while0(__warp_2_i, __warp_1_myArray_mem, __warp_0_tokenAddress);
                
                let __warp_tv_1 = __warp_td_1;
                
                let __warp_0_tokenAddress = __warp_tv_2;
                
                let __warp_1_myArray_mem = __warp_tv_1;
                
                let __warp_2_i = __warp_tv_0;
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
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


// Contract Def ERC20@interface


@contract_interface
namespace ERC20_warped_interface{
func approve_095ea7b3(__warp_10_spender : felt, __warp_11_amount : Uint256)-> (__warp_12 : felt){
}
func transfer_a9059cbb(__warp_13_to : felt, __warp_14_amount : Uint256)-> (__warp_15 : felt){
}
func transferFrom_23b872dd(__warp_16_from : felt, __warp_17_to : felt, __warp_18_amount : Uint256)-> (__warp_19 : felt){
}
func name_06fdde03()-> (__warp_25_len : felt, __warp_25 : felt*){
}
func symbol_95d89b41()-> (__warp_26_len : felt, __warp_26 : felt*){
}
func decimals_313ce567()-> (__warp_27 : felt){
}
func totalSupply_18160ddd()-> (__warp_28 : Uint256){
}
func balanceOf_70a08231(__warp_29__i0 : felt)-> (__warp_30 : Uint256){
}
func allowance_dd62ed3e(__warp_31__i0 : felt, __warp_32__i1 : felt)-> (__warp_33 : Uint256){
}
}