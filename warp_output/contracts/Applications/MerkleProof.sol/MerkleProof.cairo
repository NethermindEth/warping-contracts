%lang starknet


from warplib.memory import wm_read_256, wm_new, wm_dyn_array_length, wm_index_dyn
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.uint256 import Uint256
from warplib.maths.utils import felt_to_uint256
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.dict_access import DictAccess
from warplib.maths.lt import warp_lt256
from warplib.maths.mod import warp_mod256
from warplib.maths.eq import warp_eq256
from warplib.keccak import warp_keccak
from warplib.maths.div import warp_div256
from warplib.maths.add import warp_add256
from warplib.maths.sub import warp_sub256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak


struct cd_dynarray_Uint256{
     len : felt ,
     ptr : Uint256*,
}

func extern_input_check0{range_check_ptr : felt}(len: felt, ptr : Uint256*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
warp_external_input_check_int256(ptr[0]);
   extern_input_check0(len = len - 1, ptr = ptr + 2);
    return ();
}

func cd_to_memory0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata: Uint256*, mem_start: felt, length: felt){
    alloc_locals;
    if (length == 0){
        return ();
    }
dict_write{dict_ptr=warp_memory}(mem_start, calldata[0].low);
dict_write{dict_ptr=warp_memory}(mem_start+1, calldata[0].high);
    return cd_to_memory0_elem(calldata + 2, mem_start + 2, length - 1);
}
func cd_to_memory0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata : cd_dynarray_Uint256) -> (mem_loc: felt){
    alloc_locals;
    let (len256) = felt_to_uint256(calldata.len);
    let (mem_start) = wm_new(len256, Uint256(0x2, 0x0));
    cd_to_memory0_elem(calldata.ptr, mem_start + 2, calldata.len);
    return (mem_start,);
}

func abi_encode_packed0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : Uint256, param1 : Uint256) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let (bytes_array : felt*) = alloc();
fixed_bytes256_to_felt_dynamic_array(bytes_index,bytes_array,0,param0);
let bytes_index = bytes_index +  32;
fixed_bytes256_to_felt_dynamic_array(bytes_index,bytes_array,0,param1);
let bytes_index = bytes_index +  32;
  let (max_length256) = felt_to_uint256(bytes_index);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_index);
  return (mem_ptr,);
}


// Contract Def MerkleProof


namespace MerkleProof{

    // Dynamic variables - Arrays and Maps

    // Static variables


    func __warp_while0{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256)-> (__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256){
    alloc_locals;


        
            
            let (__warp_se_0) = wm_dyn_array_length(__warp_0_proof_mem);
            
            let (__warp_se_1) = warp_lt256(__warp_6_i, __warp_se_0);
            
            if (__warp_se_1 != 0){
            
                
                    
                        
                        let (__warp_se_2) = wm_index_dyn(__warp_0_proof_mem, __warp_6_i, Uint256(low=2, high=0));
                        
                        let (__warp_7_proofElement) = wm_read_256(__warp_se_2);
                        
                        let (__warp_se_3) = warp_mod256(__warp_3_index, Uint256(low=2, high=0));
                        
                        let (__warp_se_4) = warp_eq256(__warp_se_3, Uint256(low=0, high=0));
                        
                        if (__warp_se_4 != 0){
                        
                            
                                
                                let (__warp_se_5) = abi_encode_packed0(__warp_5_hash, __warp_7_proofElement);
                                
                                let (__warp_se_6) = warp_keccak(__warp_se_5);
                                
                                let __warp_5_hash = __warp_se_6;
                            
                            let (__warp_6_i, __warp_td_0, __warp_3_index, __warp_5_hash) = __warp_while0_if_part2(__warp_3_index, __warp_6_i, __warp_0_proof_mem, __warp_5_hash);
                            
                            let __warp_0_proof_mem = __warp_td_0;
                            
                            
                            
                            return (__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
                        }else{
                        
                            
                                
                                let (__warp_se_7) = abi_encode_packed0(__warp_7_proofElement, __warp_5_hash);
                                
                                let (__warp_se_8) = warp_keccak(__warp_se_7);
                                
                                let __warp_5_hash = __warp_se_8;
                            
                            let (__warp_6_i, __warp_td_1, __warp_3_index, __warp_5_hash) = __warp_while0_if_part2(__warp_3_index, __warp_6_i, __warp_0_proof_mem, __warp_5_hash);
                            
                            let __warp_0_proof_mem = __warp_td_1;
                            
                            
                            
                            return (__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
                        }
            }else{
            
                
                    
                    let __warp_6_i = __warp_6_i;
                    
                    let __warp_0_proof_mem = __warp_0_proof_mem;
                    
                    let __warp_3_index = __warp_3_index;
                    
                    let __warp_5_hash = __warp_5_hash;
                    
                    
                    
                    return (__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
            }

    }


    func __warp_while0_if_part2{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_3_index : Uint256, __warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_5_hash : Uint256)-> (__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256){
    alloc_locals;


        
            
                
                let (__warp_se_9) = warp_div256(__warp_3_index, Uint256(low=2, high=0));
                
                let __warp_3_index = __warp_se_9;
            
            let (__warp_pse_0) = warp_add256(__warp_6_i, Uint256(low=1, high=0));
            
            let __warp_6_i = __warp_pse_0;
            
            warp_sub256(__warp_pse_0, Uint256(low=1, high=0));
        
        let (__warp_6_i, __warp_td_3, __warp_3_index, __warp_5_hash) = __warp_while0_if_part1(__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
        
        let __warp_0_proof_mem = __warp_td_3;
        
        
        
        return (__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);

    }


    func __warp_while0_if_part1{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256)-> (__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256){
    alloc_locals;


        
        
        
        let (__warp_6_i, __warp_td_4, __warp_3_index, __warp_5_hash) = __warp_while0(__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
        
        let __warp_0_proof_mem = __warp_td_4;
        
        
        
        return (__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);

    }

}


    @view
    func verify_21fb335c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_proof_len : felt, __warp_0_proof : Uint256*, __warp_1_root : Uint256, __warp_2_leaf : Uint256, __warp_3_index : Uint256)-> (__warp_4 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_3_index);
        
        warp_external_input_check_int256(__warp_2_leaf);
        
        warp_external_input_check_int256(__warp_1_root);
        
        extern_input_check0(__warp_0_proof_len, __warp_0_proof);
        
        local __warp_0_proof_dstruct : cd_dynarray_Uint256 = cd_dynarray_Uint256(__warp_0_proof_len, __warp_0_proof);
        
        let (__warp_0_proof_mem) = cd_to_memory0(__warp_0_proof_dstruct);
        
        let __warp_5_hash = __warp_2_leaf;
        
            
            let __warp_6_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_0, __warp_td_5, __warp_tv_2, __warp_tv_3) = MerkleProof.__warp_while0(__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
                
                let __warp_tv_1 = __warp_td_5;
                
                let __warp_5_hash = __warp_tv_3;
                
                let __warp_3_index = __warp_tv_2;
                
                let __warp_0_proof_mem = __warp_tv_1;
                
                let __warp_6_i = __warp_tv_0;
        
        let (__warp_se_10) = warp_eq256(__warp_5_hash, __warp_1_root);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (__warp_se_10,);
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