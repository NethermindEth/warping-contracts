%lang starknet


from warplib.memory import wm_alloc, wm_write_256, wm_read_felt, wm_read_id, wm_read_256, wm_new, wm_index_dyn, wm_dyn_array_length, wm_index_static
from starkware.cairo.common.uint256 import Uint256, uint256_lt, uint256_add
from starkware.cairo.common.dict import dict_write
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from warplib.maths.utils import felt_to_uint256, narrow_safe
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes_to_felt_dynamic_array
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
from warplib.maths.gt import warp_gt256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak


struct cd_dynarray_Uint256{
     len : felt ,
     ptr : Uint256*,
}

func WM0_d_arr{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt, e8: felt, e9: felt, e10: felt, e11: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0xe, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0xc, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
dict_write{dict_ptr=warp_memory}(start + 7, e5);
dict_write{dict_ptr=warp_memory}(start + 8, e6);
dict_write{dict_ptr=warp_memory}(start + 9, e7);
dict_write{dict_ptr=warp_memory}(start + 10, e8);
dict_write{dict_ptr=warp_memory}(start + 11, e9);
dict_write{dict_ptr=warp_memory}(start + 12, e10);
dict_write{dict_ptr=warp_memory}(start + 13, e11);
    return (start,);
}

func WM1_d_arr{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt, e8: felt, e9: felt, e10: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0xd, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0xb, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
dict_write{dict_ptr=warp_memory}(start + 7, e5);
dict_write{dict_ptr=warp_memory}(start + 8, e6);
dict_write{dict_ptr=warp_memory}(start + 9, e7);
dict_write{dict_ptr=warp_memory}(start + 10, e8);
dict_write{dict_ptr=warp_memory}(start + 11, e9);
dict_write{dict_ptr=warp_memory}(start + 12, e10);
    return (start,);
}

func WM2_d_arr{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt, e8: felt, e9: felt, e10: felt, e11: felt, e12: felt, e13: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x10, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0xe, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
dict_write{dict_ptr=warp_memory}(start + 7, e5);
dict_write{dict_ptr=warp_memory}(start + 8, e6);
dict_write{dict_ptr=warp_memory}(start + 9, e7);
dict_write{dict_ptr=warp_memory}(start + 10, e8);
dict_write{dict_ptr=warp_memory}(start + 11, e9);
dict_write{dict_ptr=warp_memory}(start + 12, e10);
dict_write{dict_ptr=warp_memory}(start + 13, e11);
dict_write{dict_ptr=warp_memory}(start + 14, e12);
dict_write{dict_ptr=warp_memory}(start + 15, e13);
    return (start,);
}

func WM3_s_arr{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x4, 0x0));
dict_write{dict_ptr=warp_memory}(start, e0);
dict_write{dict_ptr=warp_memory}(start + 1, e1);
dict_write{dict_ptr=warp_memory}(start + 2, e2);
dict_write{dict_ptr=warp_memory}(start + 3, e3);
    return (start,);
}

func WARP_DARRAY0_Uint256_IDX{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(ref: felt, index: Uint256) -> (res: felt){
    alloc_locals;
    let (length) = WARP_DARRAY0_Uint256_LENGTH.read(ref);
    let (inRange) = uint256_lt(index, length);
    assert inRange = 1;
    let (existing) = WARP_DARRAY0_Uint256.read(ref, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 2);
        WARP_DARRAY0_Uint256.write(ref, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}

func WARP_DARRAY0_Uint256_PUSHV0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr: BitwiseBuiltin*}(loc: felt, value: Uint256) -> (){
    alloc_locals;
    let (len) = WARP_DARRAY0_Uint256_LENGTH.read(loc);
    let (newLen, carry) = uint256_add(len, Uint256(1,0));
    assert carry = 0;
    WARP_DARRAY0_Uint256_LENGTH.write(loc, newLen);
    let (existing) = WARP_DARRAY0_Uint256.read(loc, len);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 2);
        WARP_DARRAY0_Uint256.write(loc, len, used);
WS_WRITE0(used, value);
    }else{
WS_WRITE0(existing, value);
    }
    return ();
}

func WS0_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
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

func abi_encode_packed_inline_array0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(
  bytes_index : felt,
  bytes_array : felt*,
  mem_index : felt,
  mem_length : felt,
  mem_ptr : felt,
) -> (final_bytes_index : felt){
  alloc_locals;
  if (mem_index == mem_length){
     return (final_bytes_index=bytes_index);
  }
  let (mem_index256) = felt_to_uint256(mem_index);
let (elem_loc : felt) = wm_index_dyn(mem_ptr, mem_index256, Uint256(0x1, 0x0));
  let (elem) = wm_read_felt(elem_loc);
  fixed_bytes_to_felt_dynamic_array(bytes_index,bytes_array,0,elem,1);
let new_bytes_index = bytes_index +  1;
  return abi_encode_packed_inline_array0(
     new_bytes_index,
     bytes_array,
     mem_index + 1,
     mem_length,
     mem_ptr
  );
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

func abi_encode_packed1{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let (bytes_array : felt*) = alloc();
let (length256) = wm_dyn_array_length(param0);
let (length) = narrow_safe(length256);
let (bytes_index) = abi_encode_packed_inline_array0(bytes_index, bytes_array, 0, length, param0);
  let (max_length256) = felt_to_uint256(bytes_index);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_index);
  return (mem_ptr,);
}

@storage_var
func WARP_DARRAY0_Uint256(name: felt, index: Uint256) -> (resLoc : felt){
}
@storage_var
func WARP_DARRAY0_Uint256_LENGTH(name: felt) -> (index: Uint256){
}


// Contract Def TestMerkleProof


namespace TestMerkleProof{

    // Dynamic variables - Arrays and Maps

    const __warp_0_hashes = 1;

    // Static variables


    func __warp_while4{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256)-> (__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256){
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
                            
                            let (__warp_6_i, __warp_td_0, __warp_3_index, __warp_5_hash) = __warp_while4_if_part2(__warp_3_index, __warp_6_i, __warp_0_proof_mem, __warp_5_hash);
                            
                            let __warp_0_proof_mem = __warp_td_0;
                            
                            
                            
                            return (__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
                        }else{
                        
                            
                                
                                let (__warp_se_7) = abi_encode_packed0(__warp_7_proofElement, __warp_5_hash);
                                
                                let (__warp_se_8) = warp_keccak(__warp_se_7);
                                
                                let __warp_5_hash = __warp_se_8;
                            
                            let (__warp_6_i, __warp_td_1, __warp_3_index, __warp_5_hash) = __warp_while4_if_part2(__warp_3_index, __warp_6_i, __warp_0_proof_mem, __warp_5_hash);
                            
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


    func __warp_while4_if_part2{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_3_index : Uint256, __warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_5_hash : Uint256)-> (__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256){
    alloc_locals;


        
            
                
                let (__warp_se_9) = warp_div256(__warp_3_index, Uint256(low=2, high=0));
                
                let __warp_3_index = __warp_se_9;
            
            let (__warp_pse_0) = warp_add256(__warp_6_i, Uint256(low=1, high=0));
            
            let __warp_6_i = __warp_pse_0;
            
            warp_sub256(__warp_pse_0, Uint256(low=1, high=0));
        
        let (__warp_6_i, __warp_td_3, __warp_3_index, __warp_5_hash) = __warp_while4_if_part1(__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
        
        let __warp_0_proof_mem = __warp_td_3;
        
        
        
        return (__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);

    }


    func __warp_while4_if_part1{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256)-> (__warp_6_i : Uint256, __warp_0_proof_mem : felt, __warp_3_index : Uint256, __warp_5_hash : Uint256){
    alloc_locals;


        
        
        
        let (__warp_6_i, __warp_td_4, __warp_3_index, __warp_5_hash) = __warp_while4(__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
        
        let __warp_0_proof_mem = __warp_td_4;
        
        
        
        return (__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);

    }


    func __warp_while3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_3_n : Uint256, __warp_4_offset : Uint256)-> (__warp_3_n : Uint256, __warp_4_offset : Uint256){
    alloc_locals;


        
            
            let (__warp_se_10) = warp_gt256(__warp_3_n, Uint256(low=0, high=0));
            
            if (__warp_se_10 != 0){
            
                
                    
                        
                        let __warp_5_i = Uint256(low=0, high=0);
                        
                            
                            let (__warp_tv_0, __warp_tv_1, __warp_tv_2) = __warp_while2(__warp_5_i, __warp_3_n, __warp_4_offset);
                            
                            let __warp_4_offset = __warp_tv_2;
                            
                            let __warp_3_n = __warp_tv_1;
                            
                            let __warp_5_i = __warp_tv_0;
                    
                    let (__warp_se_11) = warp_add256(__warp_4_offset, __warp_3_n);
                    
                    let __warp_4_offset = __warp_se_11;
                    
                    let (__warp_se_12) = warp_div256(__warp_3_n, Uint256(low=2, high=0));
                    
                    let __warp_3_n = __warp_se_12;
                
                let (__warp_3_n, __warp_4_offset) = __warp_while3_if_part1(__warp_3_n, __warp_4_offset);
                
                
                
                return (__warp_3_n, __warp_4_offset);
            }else{
            
                
                    
                    let __warp_3_n = __warp_3_n;
                    
                    let __warp_4_offset = __warp_4_offset;
                    
                    
                    
                    return (__warp_3_n, __warp_4_offset);
            }

    }


    func __warp_while3_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_3_n : Uint256, __warp_4_offset : Uint256)-> (__warp_3_n : Uint256, __warp_4_offset : Uint256){
    alloc_locals;


        
        
        
        let (__warp_3_n, __warp_4_offset) = __warp_while3(__warp_3_n, __warp_4_offset);
        
        
        
        return (__warp_3_n, __warp_4_offset);

    }


    func __warp_while2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_5_i : Uint256, __warp_3_n : Uint256, __warp_4_offset : Uint256)-> (__warp_5_i : Uint256, __warp_3_n : Uint256, __warp_4_offset : Uint256){
    alloc_locals;


        
            
            let (__warp_se_13) = warp_sub256(__warp_3_n, Uint256(low=1, high=0));
            
            let (__warp_se_14) = warp_lt256(__warp_5_i, __warp_se_13);
            
            if (__warp_se_14 != 0){
            
                
                    
                        
                        let (__warp_se_15) = warp_add256(__warp_4_offset, __warp_5_i);
                        
                        let (__warp_se_16) = WARP_DARRAY0_Uint256_IDX(__warp_0_hashes, __warp_se_15);
                        
                        let (__warp_se_17) = WS0_READ_Uint256(__warp_se_16);
                        
                        let (__warp_se_18) = warp_add256(__warp_4_offset, __warp_5_i);
                        
                        let (__warp_se_19) = warp_add256(__warp_se_18, Uint256(low=1, high=0));
                        
                        let (__warp_se_20) = WARP_DARRAY0_Uint256_IDX(__warp_0_hashes, __warp_se_19);
                        
                        let (__warp_se_21) = WS0_READ_Uint256(__warp_se_20);
                        
                        let (__warp_se_22) = abi_encode_packed0(__warp_se_17, __warp_se_21);
                        
                        let (__warp_se_23) = warp_keccak(__warp_se_22);
                        
                        WARP_DARRAY0_Uint256_PUSHV0(__warp_0_hashes, __warp_se_23);
                    
                    let (__warp_se_24) = warp_add256(__warp_5_i, Uint256(low=2, high=0));
                    
                    let __warp_5_i = __warp_se_24;
                
                let (__warp_5_i, __warp_3_n, __warp_4_offset) = __warp_while2_if_part1(__warp_5_i, __warp_3_n, __warp_4_offset);
                
                
                
                return (__warp_5_i, __warp_3_n, __warp_4_offset);
            }else{
            
                
                    
                    let __warp_5_i = __warp_5_i;
                    
                    let __warp_3_n = __warp_3_n;
                    
                    let __warp_4_offset = __warp_4_offset;
                    
                    
                    
                    return (__warp_5_i, __warp_3_n, __warp_4_offset);
            }

    }


    func __warp_while2_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_5_i : Uint256, __warp_3_n : Uint256, __warp_4_offset : Uint256)-> (__warp_5_i : Uint256, __warp_3_n : Uint256, __warp_4_offset : Uint256){
    alloc_locals;


        
        
        
        let (__warp_5_i, __warp_3_n, __warp_4_offset) = __warp_while2(__warp_5_i, __warp_3_n, __warp_4_offset);
        
        
        
        return (__warp_5_i, __warp_3_n, __warp_4_offset);

    }


    func __warp_while1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_2_i : Uint256, __warp_1_transactions : felt)-> (__warp_2_i : Uint256, __warp_1_transactions : felt){
    alloc_locals;


        
            
            let (__warp_se_25) = warp_lt256(__warp_2_i, Uint256(low=4, high=0));
            
            if (__warp_se_25 != 0){
            
                
                    
                        
                        let (__warp_se_26) = wm_index_static(__warp_1_transactions, __warp_2_i, Uint256(low=1, high=0), Uint256(low=4, high=0));
                        
                        let (__warp_se_27) = wm_read_id(__warp_se_26, Uint256(low=2, high=0));
                        
                        let (__warp_se_28) = abi_encode_packed1(__warp_se_27);
                        
                        let (__warp_se_29) = warp_keccak(__warp_se_28);
                        
                        WARP_DARRAY0_Uint256_PUSHV0(__warp_0_hashes, __warp_se_29);
                    
                    let (__warp_pse_1) = warp_add256(__warp_2_i, Uint256(low=1, high=0));
                    
                    let __warp_2_i = __warp_pse_1;
                    
                    warp_sub256(__warp_pse_1, Uint256(low=1, high=0));
                
                let (__warp_2_i, __warp_td_5) = __warp_while1_if_part1(__warp_2_i, __warp_1_transactions);
                
                let __warp_1_transactions = __warp_td_5;
                
                
                
                return (__warp_2_i, __warp_1_transactions);
            }else{
            
                
                    
                    let __warp_2_i = __warp_2_i;
                    
                    let __warp_1_transactions = __warp_1_transactions;
                    
                    
                    
                    return (__warp_2_i, __warp_1_transactions);
            }

    }


    func __warp_while1_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_2_i : Uint256, __warp_1_transactions : felt)-> (__warp_2_i : Uint256, __warp_1_transactions : felt){
    alloc_locals;


        
        
        
        let (__warp_2_i, __warp_td_7) = __warp_while1(__warp_2_i, __warp_1_transactions);
        
        let __warp_1_transactions = __warp_td_7;
        
        
        
        return (__warp_2_i, __warp_1_transactions);

    }


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_se_30) = WM0_d_arr(97, 108, 105, 99, 101, 32, 45, 62, 32, 98, 111, 98);
        
        let (__warp_se_31) = WM1_d_arr(98, 111, 98, 32, 45, 62, 32, 100, 97, 118, 101);
        
        let (__warp_se_32) = WM2_d_arr(99, 97, 114, 111, 108, 32, 45, 62, 32, 97, 108, 105, 99, 101);
        
        let (__warp_se_33) = WM1_d_arr(100, 97, 118, 101, 32, 45, 62, 32, 98, 111, 98);
        
        let (__warp_1_transactions) = WM3_s_arr(__warp_se_30, __warp_se_31, __warp_se_32, __warp_se_33);
        
            
            let __warp_2_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_3, __warp_td_8) = __warp_while1(__warp_2_i, __warp_1_transactions);
                
                let __warp_tv_4 = __warp_td_8;
                
                let __warp_1_transactions = __warp_tv_4;
                
                let __warp_2_i = __warp_tv_3;
        
        let __warp_3_n = Uint256(low=4, high=0);
        
        let __warp_4_offset = Uint256(low=0, high=0);
        
            
            let (__warp_tv_5, __warp_tv_6) = __warp_while3(__warp_3_n, __warp_4_offset);
            
            let __warp_4_offset = __warp_tv_6;
            
            let __warp_3_n = __warp_tv_5;
        
        
        
        return ();

    }

}


    @view
    func getRoot_5ca1e165{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (__warp_6 : Uint256){
    alloc_locals;


        
        let (__warp_se_34) = WARP_DARRAY0_Uint256_LENGTH.read(TestMerkleProof.__warp_0_hashes);
        
        let (__warp_se_35) = warp_sub256(__warp_se_34, Uint256(low=1, high=0));
        
        let (__warp_se_36) = WARP_DARRAY0_Uint256_IDX(TestMerkleProof.__warp_0_hashes, __warp_se_35);
        
        let (__warp_se_37) = WS0_READ_Uint256(__warp_se_36);
        
        
        
        return (__warp_se_37,);

    }


    @view
    func hashes_501895ae{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_7__i0 : Uint256)-> (__warp_8 : Uint256){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_7__i0);
        
        let (__warp_se_38) = WARP_DARRAY0_Uint256_IDX(TestMerkleProof.__warp_0_hashes, __warp_7__i0);
        
        let (__warp_se_39) = WS0_READ_Uint256(__warp_se_38);
        
        
        
        return (__warp_se_39,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(){
    alloc_locals;
    WARP_USED_STORAGE.write(1);
    WARP_NAMEGEN.write(1);
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        TestMerkleProof.__warp_constructor_0();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
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
            
                
                let (__warp_tv_7, __warp_td_9, __warp_tv_9, __warp_tv_10) = TestMerkleProof.__warp_while4(__warp_6_i, __warp_0_proof_mem, __warp_3_index, __warp_5_hash);
                
                let __warp_tv_8 = __warp_td_9;
                
                let __warp_5_hash = __warp_tv_10;
                
                let __warp_3_index = __warp_tv_9;
                
                let __warp_0_proof_mem = __warp_tv_8;
                
                let __warp_6_i = __warp_tv_7;
        
        let (__warp_se_40) = warp_eq256(__warp_5_hash, __warp_1_root);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (__warp_se_40,);
    }
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