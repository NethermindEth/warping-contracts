%lang starknet


from warplib.memory import wm_read_256, wm_read_felt, wm_write_256, wm_new, wm_index_dyn, wm_dyn_array_length, wm_to_felt_array
from starkware.cairo.common.uint256 import uint256_sub, uint256_add, Uint256
from starkware.cairo.common.alloc import alloc
from warplib.maths.utils import narrow_safe, felt_to_uint256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_bool import warp_external_input_check_bool
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int8, warp_external_input_check_int32
from starkware.cairo.common.dict import dict_write
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array_spl
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from warplib.keccak import felt_array_concat, pack_bytes_felt
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from starkware.cairo.common.dict_access import DictAccess
from warplib.maths.lt import warp_lt256
from warplib.maths.int_conversions import warp_int256_to_int248
from warplib.maths.add_unsafe import warp_add_unsafe256
from warplib.maths.sub import warp_sub256
from warplib.maths.add import warp_add256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.eq import warp_eq, warp_eq256
from warplib.maths.neq import warp_neq


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

struct cd_dynarray_Uint256{
     len : felt ,
     ptr : Uint256*,
}

func wm_to_calldata0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(mem_loc: felt) -> (retData: cd_dynarray_Uint256){
    alloc_locals;
    let (len_256) = wm_read_256(mem_loc);
    let (ptr : Uint256*) = alloc();
    let (len_felt) = narrow_safe(len_256);
    wm_to_calldata1(len_felt, ptr, mem_loc + 2);
    return (cd_dynarray_Uint256(len=len_felt, ptr=ptr),);
}


func wm_to_calldata1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(len: felt, ptr: Uint256*, mem_loc: felt) -> (){
    alloc_locals;
    if (len == 0){
         return ();
    }
let (mem_read0) = wm_read_256(mem_loc);
assert ptr[0] = mem_read0;
    wm_to_calldata1(len=len - 1, ptr=ptr + 2, mem_loc=mem_loc + 2);
    return ();
}

func wm_to_calldata3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(mem_loc: felt) -> (retData: cd_dynarray_felt){
    alloc_locals;
    let (len_256) = wm_read_256(mem_loc);
    let (ptr : felt*) = alloc();
    let (len_felt) = narrow_safe(len_256);
    wm_to_calldata4(len_felt, ptr, mem_loc + 2);
    return (cd_dynarray_felt(len=len_felt, ptr=ptr),);
}


func wm_to_calldata4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(len: felt, ptr: felt*, mem_loc: felt) -> (){
    alloc_locals;
    if (len == 0){
         return ();
    }
let (mem_read0) = wm_read_felt(mem_loc);
assert ptr[0] = mem_read0;
    wm_to_calldata4(len=len - 1, ptr=ptr + 1, mem_loc=mem_loc + 1);
    return ();
}

func WS0_READ_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = readId(loc);
    return (read0,);
}

func WS1_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}

func WS2_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}

func WS_WRITE1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}

func extern_input_check0{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
warp_external_input_check_int8(ptr[0]);
   extern_input_check0(len = len - 1, ptr = ptr + 1);
    return ();
}

func extern_input_check1{range_check_ptr : felt}(len: felt, ptr : Uint256*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
warp_external_input_check_int256(ptr[0]);
   extern_input_check1(len = len - 1, ptr = ptr + 2);
    return ();
}

func extern_input_check2{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
warp_external_input_check_address(ptr[0]);
   extern_input_check2(len = len - 1, ptr = ptr + 1);
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

func abi_encode_tail_dynamic_array0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(
  bytes_index : felt,
  bytes_offset : felt,
  bytes_array : felt*,
  element_offset : felt,
  index : felt,
  length : felt,
  mem_ptr : felt
) -> (final_offset : felt){
  alloc_locals;
  if (index == length){
     return (final_offset=bytes_offset);
  }
  let (index256) = felt_to_uint256(index);
  let (elem_loc) = wm_index_dyn(mem_ptr, index256, Uint256(0x2, 0x0));
  let (elem) = wm_read_256(elem_loc);
  fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, elem);
let new_bytes_index = bytes_index + 32;
let new_bytes_offset = bytes_offset;
  return abi_encode_tail_dynamic_array0(new_bytes_index, new_bytes_offset, bytes_array, element_offset, index + 1, length, mem_ptr);
}

func abi_encode_head_dynamic_array1{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(
  bytes_index: felt,
  bytes_offset: felt,
  bytes_array: felt*,
  element_offset: felt,
  mem_ptr : felt
) -> (final_bytes_index : felt, final_bytes_offset : felt){
  alloc_locals;
  // Storing pointer to data
  let (bytes_offset256) = felt_to_uint256(bytes_offset - element_offset);
  fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, bytes_offset256);
  let new_index = bytes_index + 32;
  // Storing the length
  let (length256) = wm_dyn_array_length(mem_ptr);
  fixed_bytes256_to_felt_dynamic_array(bytes_offset, bytes_array, 0, length256);
  let bytes_offset = bytes_offset + 32;
  // Storing the data
  let (length) = narrow_safe(length256);
  let bytes_offset_offset = bytes_offset + length * 32;
  let (extended_offset) = abi_encode_tail_dynamic_array0(
    bytes_offset,
    bytes_offset_offset,
    bytes_array,
    bytes_offset,
    0,
    length,
    mem_ptr
  );
  return (
    final_bytes_index=new_index,
    final_bytes_offset=extended_offset
  );
}

func abi_encode0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 32;
  let (bytes_array : felt*) = alloc();
let (param0256) = felt_to_uint256(param0);
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param0256);
let bytes_index = bytes_index + 32;
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}

func abi_encode1{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 32;
  let (bytes_array : felt*) = alloc();
let (param0256) = felt_to_uint256(param0);
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param0256);
let bytes_index = bytes_index + 32;
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}

func abi_encode2{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : Uint256, param1 : Uint256) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 64;
  let (bytes_array : felt*) = alloc();
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param0);
let bytes_index = bytes_index + 32;
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param1);
let bytes_index = bytes_index + 32;
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}

func abi_encode3{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt, param1 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 64;
  let (bytes_array : felt*) = alloc();
let (bytes_index, bytes_offset) = abi_encode_head_dynamic_array1(
  bytes_index,
  bytes_offset,
  bytes_array,
  0,
  param0
);
let (bytes_index, bytes_offset) = abi_encode_head_dynamic_array1(
  bytes_index,
  bytes_offset,
  bytes_array,
  0,
  param1
);
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}

func __warp_emit_ApprovalForAll_17307eab39ab6107e8899845ad3d59bd9653f200f220920489ca2b5937696c31{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : felt){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x9653f200f220920489ca2b5937696c31, 0x17307eab39ab6107e8899845ad3d59bd);// keccak of event signature: ApprovalForAll(address,address,bool)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode0(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode1(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func __warp_emit_TransferSingle_c3d58168c5ae7397731d063d5bbf3d657854427343f4c083240f7aacaa2d0f62{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : felt, param3 : Uint256, param4 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x7854427343f4c083240f7aacaa2d0f62, 0xc3d58168c5ae7397731d063d5bbf3d65);// keccak of event signature: TransferSingle(address,address,address,uint256,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode0(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode0(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode2(param3,param4);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func __warp_emit_TransferBatch_4a39dc06d4c0dbc64b70af90fd698a233a518aa5d07e595d983b8c0526c8f7fb{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : felt, param3 : felt, param4 : felt){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x3a518aa5d07e595d983b8c0526c8f7fb, 0x4a39dc06d4c0dbc64b70af90fd698a23);// keccak of event signature: TransferBatch(address,address,address,uint256[],uint256[])
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode0(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode0(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode3(param3,param4);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

@storage_var
func WARP_MAPPING0(name: felt, index: Uint256) -> (resLoc : felt){
}
func WS0_INDEX_Uint256_to_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: Uint256) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING0.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 2);
        WARP_MAPPING0.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}

@storage_var
func WARP_MAPPING1(name: felt, index: felt) -> (resLoc : felt){
}
func WS1_INDEX_felt_to_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING1.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_MAPPING1.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}

@storage_var
func WARP_MAPPING2(name: felt, index: felt) -> (resLoc : felt){
}
func WS2_INDEX_felt_to_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING2.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_MAPPING2.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}


// Contract Def ERC1155

// @notice Minimalist and gas efficient standard ERC1155 implementation.
// @author Solmate (https://github.com/transmissions11/solmate/blob/main/src/tokens/ERC1155.sol)


// @event
// func TransferSingle(operator : felt, __warp_2_from : felt, to : felt, id : Uint256, amount : Uint256){
// }


// @event
// func TransferBatch(operator : felt, __warp_3_from : felt, to : felt, ids : felt, amounts : felt){
// }


// @event
// func ApprovalForAll(owner : felt, operator : felt, approved : felt){
// }


// @event
// func URI(value : felt, id : Uint256){
// }

namespace ERC1155{

    // Dynamic variables - Arrays and Maps

    const __warp_0_balanceOf = 1;

    const __warp_1_isApprovedForAll = 2;

    // Static variables


    func __warp_while1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_22_i : Uint256, __warp_19_owners_dstruct : cd_dynarray_felt, __warp_21_balances : felt, __warp_20_ids_dstruct : cd_dynarray_Uint256)-> (__warp_22_i : Uint256, __warp_19_owners_dstruct : cd_dynarray_felt, __warp_21_balances : felt, __warp_20_ids_dstruct : cd_dynarray_Uint256){
    alloc_locals;


        
            
            let (__warp_se_0) = felt_to_uint256(__warp_19_owners_dstruct.len);
            
            let (__warp_se_1) = warp_lt256(__warp_22_i, __warp_se_0);
            
                
                if (__warp_se_1 != 0){
                
                    
                        
                        let (__warp_se_2) = wm_index_dyn(__warp_21_balances, __warp_22_i, Uint256(low=2, high=0));
                        
                        let (__warp_se_3) = warp_int256_to_int248(__warp_22_i);
                        
                        let (__warp_se_4) = WS1_INDEX_felt_to_warp_id(__warp_0_balanceOf, __warp_19_owners_dstruct.ptr[__warp_se_3]);
                        
                        let (__warp_se_5) = WS0_READ_warp_id(__warp_se_4);
                        
                        let (__warp_se_6) = warp_int256_to_int248(__warp_22_i);
                        
                        let (__warp_se_7) = WS0_INDEX_Uint256_to_Uint256(__warp_se_5, __warp_20_ids_dstruct.ptr[__warp_se_6]);
                        
                        let (__warp_se_8) = WS1_READ_Uint256(__warp_se_7);
                        
                        wm_write_256(__warp_se_2, __warp_se_8);
                    
                    let (__warp_se_9) = warp_add_unsafe256(__warp_22_i, Uint256(low=1, high=0));
                    
                    let __warp_22_i = __warp_se_9;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar __warp_22_i = __warp_22_i;
                    tempvar __warp_19_owners_dstruct = __warp_19_owners_dstruct;
                    tempvar __warp_21_balances = __warp_21_balances;
                    tempvar __warp_20_ids_dstruct = __warp_20_ids_dstruct;
                }else{
                
                    
                    let __warp_22_i = __warp_22_i;
                    
                    let __warp_19_owners_dstruct = __warp_19_owners_dstruct;
                    
                    let __warp_21_balances = __warp_21_balances;
                    
                    let __warp_20_ids_dstruct = __warp_20_ids_dstruct;
                    
                    
                    
                    return (__warp_22_i, __warp_19_owners_dstruct, __warp_21_balances, __warp_20_ids_dstruct);
                }
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar __warp_22_i = __warp_22_i;
                tempvar __warp_19_owners_dstruct = __warp_19_owners_dstruct;
                tempvar __warp_21_balances = __warp_21_balances;
                tempvar __warp_20_ids_dstruct = __warp_20_ids_dstruct;
        
        let (__warp_22_i, __warp_td_4, __warp_td_5, __warp_td_6) = __warp_while1(__warp_22_i, __warp_19_owners_dstruct, __warp_21_balances, __warp_20_ids_dstruct);
        
        let __warp_19_owners_dstruct = __warp_td_4;
        
        let __warp_21_balances = __warp_td_5;
        
        let __warp_20_ids_dstruct = __warp_td_6;
        
        
        
        return (__warp_22_i, __warp_19_owners_dstruct, __warp_21_balances, __warp_20_ids_dstruct);

    }


    func __warp_while0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_18_i : Uint256, __warp_13_ids_dstruct : cd_dynarray_Uint256, __warp_16_id : Uint256, __warp_17_amount : Uint256, __warp_14_amounts_dstruct : cd_dynarray_Uint256, __warp_11_from : felt, __warp_12_to : felt)-> (__warp_18_i : Uint256, __warp_13_ids_dstruct : cd_dynarray_Uint256, __warp_16_id : Uint256, __warp_17_amount : Uint256, __warp_14_amounts_dstruct : cd_dynarray_Uint256, __warp_11_from : felt, __warp_12_to : felt){
    alloc_locals;


        
            
            let (__warp_se_10) = felt_to_uint256(__warp_13_ids_dstruct.len);
            
            let (__warp_se_11) = warp_lt256(__warp_18_i, __warp_se_10);
            
                
                if (__warp_se_11 != 0){
                
                    
                        
                        let (__warp_se_12) = warp_int256_to_int248(__warp_18_i);
                        
                        let __warp_16_id = __warp_13_ids_dstruct.ptr[__warp_se_12];
                        
                        let (__warp_se_13) = warp_int256_to_int248(__warp_18_i);
                        
                        let __warp_17_amount = __warp_14_amounts_dstruct.ptr[__warp_se_13];
                        
                        let __warp_cs_4 = __warp_16_id;
                        
                        let __warp_cs_5 = __warp_11_from;
                        
                        let (__warp_se_14) = WS1_INDEX_felt_to_warp_id(__warp_0_balanceOf, __warp_cs_5);
                        
                        let (__warp_se_15) = WS0_READ_warp_id(__warp_se_14);
                        
                        let (__warp_se_16) = WS0_INDEX_Uint256_to_Uint256(__warp_se_15, __warp_cs_4);
                        
                        let (__warp_se_17) = WS1_INDEX_felt_to_warp_id(__warp_0_balanceOf, __warp_cs_5);
                        
                        let (__warp_se_18) = WS0_READ_warp_id(__warp_se_17);
                        
                        let (__warp_se_19) = WS0_INDEX_Uint256_to_Uint256(__warp_se_18, __warp_cs_4);
                        
                        let (__warp_se_20) = WS1_READ_Uint256(__warp_se_19);
                        
                        let (__warp_se_21) = warp_sub256(__warp_se_20, __warp_17_amount);
                        
                        WS_WRITE0(__warp_se_16, __warp_se_21);
                        
                        let __warp_cs_6 = __warp_16_id;
                        
                        let __warp_cs_7 = __warp_12_to;
                        
                        let (__warp_se_22) = WS1_INDEX_felt_to_warp_id(__warp_0_balanceOf, __warp_cs_7);
                        
                        let (__warp_se_23) = WS0_READ_warp_id(__warp_se_22);
                        
                        let (__warp_se_24) = WS0_INDEX_Uint256_to_Uint256(__warp_se_23, __warp_cs_6);
                        
                        let (__warp_se_25) = WS1_INDEX_felt_to_warp_id(__warp_0_balanceOf, __warp_cs_7);
                        
                        let (__warp_se_26) = WS0_READ_warp_id(__warp_se_25);
                        
                        let (__warp_se_27) = WS0_INDEX_Uint256_to_Uint256(__warp_se_26, __warp_cs_6);
                        
                        let (__warp_se_28) = WS1_READ_Uint256(__warp_se_27);
                        
                        let (__warp_se_29) = warp_add256(__warp_se_28, __warp_17_amount);
                        
                        WS_WRITE0(__warp_se_24, __warp_se_29);
                        
                            
                            let (__warp_se_30) = warp_add_unsafe256(__warp_18_i, Uint256(low=1, high=0));
                            
                            let __warp_18_i = __warp_se_30;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar __warp_18_i = __warp_18_i;
                    tempvar __warp_13_ids_dstruct = __warp_13_ids_dstruct;
                    tempvar __warp_16_id = __warp_16_id;
                    tempvar __warp_17_amount = __warp_17_amount;
                    tempvar __warp_14_amounts_dstruct = __warp_14_amounts_dstruct;
                    tempvar __warp_11_from = __warp_11_from;
                    tempvar __warp_12_to = __warp_12_to;
                }else{
                
                    
                    let __warp_18_i = __warp_18_i;
                    
                    let __warp_13_ids_dstruct = __warp_13_ids_dstruct;
                    
                    let __warp_16_id = __warp_16_id;
                    
                    let __warp_17_amount = __warp_17_amount;
                    
                    let __warp_14_amounts_dstruct = __warp_14_amounts_dstruct;
                    
                    let __warp_11_from = __warp_11_from;
                    
                    let __warp_12_to = __warp_12_to;
                    
                    
                    
                    return (__warp_18_i, __warp_13_ids_dstruct, __warp_16_id, __warp_17_amount, __warp_14_amounts_dstruct, __warp_11_from, __warp_12_to);
                }
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar __warp_18_i = __warp_18_i;
                tempvar __warp_13_ids_dstruct = __warp_13_ids_dstruct;
                tempvar __warp_16_id = __warp_16_id;
                tempvar __warp_17_amount = __warp_17_amount;
                tempvar __warp_14_amounts_dstruct = __warp_14_amounts_dstruct;
                tempvar __warp_11_from = __warp_11_from;
                tempvar __warp_12_to = __warp_12_to;
        
        let (__warp_18_i, __warp_td_7, __warp_16_id, __warp_17_amount, __warp_td_8, __warp_11_from, __warp_12_to) = __warp_while0(__warp_18_i, __warp_13_ids_dstruct, __warp_16_id, __warp_17_amount, __warp_14_amounts_dstruct, __warp_11_from, __warp_12_to);
        
        let __warp_13_ids_dstruct = __warp_td_7;
        
        let __warp_14_amounts_dstruct = __warp_td_8;
        
        
        
        return (__warp_18_i, __warp_13_ids_dstruct, __warp_16_id, __warp_17_amount, __warp_14_amounts_dstruct, __warp_11_from, __warp_12_to);

    }


    func __warp_conditional_safeTransferFrom_f242432a_1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_6_from : felt)-> (__warp_rc_0 : felt, __warp_6_from : felt){
    alloc_locals;


        
        let (__warp_se_36) = get_caller_address();
        
        let (__warp_se_37) = warp_eq(__warp_se_36, __warp_6_from);
        
        if (__warp_se_37 != 0){
        
            
            let __warp_rc_0 = 1;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_6_from = __warp_6_from;
            
            
            
            return (__warp_rc_0, __warp_6_from);
        }else{
        
            
            let (__warp_se_38) = WS1_INDEX_felt_to_warp_id(__warp_1_isApprovedForAll, __warp_6_from);
            
            let (__warp_se_39) = WS0_READ_warp_id(__warp_se_38);
            
            let (__warp_se_40) = get_caller_address();
            
            let (__warp_se_41) = WS2_INDEX_felt_to_felt(__warp_se_39, __warp_se_40);
            
            let (__warp_se_42) = WS2_READ_felt(__warp_se_41);
            
            let __warp_rc_0 = __warp_se_42;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_6_from = __warp_6_from;
            
            
            
            return (__warp_rc_0, __warp_6_from);
        }

    }


    func __warp_conditional_safeTransferFrom_f242432a_3{syscall_ptr : felt*, range_check_ptr : felt}(__warp_7_to : felt, __warp_6_from : felt, __warp_8_id : Uint256, __warp_9_amount : Uint256, __warp_10_data_dstruct : cd_dynarray_felt)-> (__warp_rc_2 : felt, __warp_7_to : felt, __warp_6_from : felt, __warp_8_id : Uint256, __warp_9_amount : Uint256, __warp_10_data_dstruct : cd_dynarray_felt){
    alloc_locals;


        
        if (1 != 0){
        
            
            let (__warp_se_43) = warp_neq(__warp_7_to, 0);
            
            let __warp_rc_2 = __warp_se_43;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_7_to = __warp_7_to;
            
            let __warp_6_from = __warp_6_from;
            
            let __warp_8_id = __warp_8_id;
            
            let __warp_9_amount = __warp_9_amount;
            
            let __warp_10_data_dstruct = __warp_10_data_dstruct;
            
            
            
            return (__warp_rc_2, __warp_7_to, __warp_6_from, __warp_8_id, __warp_9_amount, __warp_10_data_dstruct);
        }else{
        
            
            let (__warp_se_44) = get_caller_address();
            
            let (__warp_pse_0) = ERC1155TokenReceiver_warped_interface.onERC1155Received_f23a6e61(__warp_7_to, __warp_se_44, __warp_6_from, __warp_8_id, __warp_9_amount, __warp_10_data_dstruct.len, __warp_10_data_dstruct.ptr);
            
            let (__warp_se_45) = warp_eq(__warp_pse_0, ERC1155TokenReceiver.onERC1155Received_f23a6e61.selector);
            
            let __warp_rc_2 = __warp_se_45;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_7_to = __warp_7_to;
            
            let __warp_6_from = __warp_6_from;
            
            let __warp_8_id = __warp_8_id;
            
            let __warp_9_amount = __warp_9_amount;
            
            let __warp_10_data_dstruct = __warp_10_data_dstruct;
            
            
            
            return (__warp_rc_2, __warp_7_to, __warp_6_from, __warp_8_id, __warp_9_amount, __warp_10_data_dstruct);
        }

    }


    func __warp_conditional_safeBatchTransferFrom_2eb2c2d6_5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_11_from : felt)-> (__warp_rc_4 : felt, __warp_11_from : felt){
    alloc_locals;


        
        let (__warp_se_63) = get_caller_address();
        
        let (__warp_se_64) = warp_eq(__warp_se_63, __warp_11_from);
        
        if (__warp_se_64 != 0){
        
            
            let __warp_rc_4 = 1;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_11_from = __warp_11_from;
            
            
            
            return (__warp_rc_4, __warp_11_from);
        }else{
        
            
            let (__warp_se_65) = WS1_INDEX_felt_to_warp_id(__warp_1_isApprovedForAll, __warp_11_from);
            
            let (__warp_se_66) = WS0_READ_warp_id(__warp_se_65);
            
            let (__warp_se_67) = get_caller_address();
            
            let (__warp_se_68) = WS2_INDEX_felt_to_felt(__warp_se_66, __warp_se_67);
            
            let (__warp_se_69) = WS2_READ_felt(__warp_se_68);
            
            let __warp_rc_4 = __warp_se_69;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_11_from = __warp_11_from;
            
            
            
            return (__warp_rc_4, __warp_11_from);
        }

    }


    func __warp_conditional_safeBatchTransferFrom_2eb2c2d6_7{syscall_ptr : felt*, range_check_ptr : felt}(__warp_12_to : felt, __warp_11_from : felt, __warp_13_ids_dstruct : cd_dynarray_Uint256, __warp_14_amounts_dstruct : cd_dynarray_Uint256, __warp_15_data_dstruct : cd_dynarray_felt)-> (__warp_rc_6 : felt, __warp_12_to : felt, __warp_11_from : felt, __warp_13_ids_dstruct : cd_dynarray_Uint256, __warp_14_amounts_dstruct : cd_dynarray_Uint256, __warp_15_data_dstruct : cd_dynarray_felt){
    alloc_locals;


        
        if (1 != 0){
        
            
            let (__warp_se_70) = warp_neq(__warp_12_to, 0);
            
            let __warp_rc_6 = __warp_se_70;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_12_to = __warp_12_to;
            
            let __warp_11_from = __warp_11_from;
            
            let __warp_13_ids_dstruct = __warp_13_ids_dstruct;
            
            let __warp_14_amounts_dstruct = __warp_14_amounts_dstruct;
            
            let __warp_15_data_dstruct = __warp_15_data_dstruct;
            
            
            
            return (__warp_rc_6, __warp_12_to, __warp_11_from, __warp_13_ids_dstruct, __warp_14_amounts_dstruct, __warp_15_data_dstruct);
        }else{
        
            
            let (__warp_se_71) = get_caller_address();
            
            let (__warp_pse_1) = ERC1155TokenReceiver_warped_interface.onERC1155BatchReceived_bc197c81(__warp_12_to, __warp_se_71, __warp_11_from, __warp_13_ids_dstruct.len, __warp_13_ids_dstruct.ptr, __warp_14_amounts_dstruct.len, __warp_14_amounts_dstruct.ptr, __warp_15_data_dstruct.len, __warp_15_data_dstruct.ptr);
            
            let (__warp_se_72) = warp_eq(__warp_pse_1, ERC1155TokenReceiver.onERC1155BatchReceived_bc197c81.selector);
            
            let __warp_rc_6 = __warp_se_72;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_12_to = __warp_12_to;
            
            let __warp_11_from = __warp_11_from;
            
            let __warp_13_ids_dstruct = __warp_13_ids_dstruct;
            
            let __warp_14_amounts_dstruct = __warp_14_amounts_dstruct;
            
            let __warp_15_data_dstruct = __warp_15_data_dstruct;
            
            
            
            return (__warp_rc_6, __warp_12_to, __warp_11_from, __warp_13_ids_dstruct, __warp_14_amounts_dstruct, __warp_15_data_dstruct);
        }

    }


    func __warp_conditional___warp_conditional_supportsInterface_01ffc9a7_9_11(__warp_23_interfaceId : felt)-> (__warp_rc_10 : felt, __warp_23_interfaceId : felt){
    alloc_locals;


        
        let (__warp_se_85) = warp_eq(__warp_23_interfaceId, 33540519);
        
        if (__warp_se_85 != 0){
        
            
            let __warp_rc_10 = 1;
            
            let __warp_rc_10 = __warp_rc_10;
            
            let __warp_23_interfaceId = __warp_23_interfaceId;
            
            
            
            return (__warp_rc_10, __warp_23_interfaceId);
        }else{
        
            
            let (__warp_se_86) = warp_eq(__warp_23_interfaceId, 3652614694);
            
            let __warp_rc_10 = __warp_se_86;
            
            let __warp_rc_10 = __warp_rc_10;
            
            let __warp_23_interfaceId = __warp_23_interfaceId;
            
            
            
            return (__warp_rc_10, __warp_23_interfaceId);
        }

    }


    func __warp_conditional_supportsInterface_01ffc9a7_9(__warp_23_interfaceId : felt)-> (__warp_rc_8 : felt, __warp_23_interfaceId : felt){
    alloc_locals;


        
        let __warp_rc_10 = 0;
        
            
            let (__warp_tv_27, __warp_tv_28) = __warp_conditional___warp_conditional_supportsInterface_01ffc9a7_9_11(__warp_23_interfaceId);
            
            let __warp_23_interfaceId = __warp_tv_28;
            
            let __warp_rc_10 = __warp_tv_27;
        
        if (__warp_rc_10 != 0){
        
            
            let __warp_rc_8 = 1;
            
            let __warp_rc_8 = __warp_rc_8;
            
            let __warp_23_interfaceId = __warp_23_interfaceId;
            
            
            
            return (__warp_rc_8, __warp_23_interfaceId);
        }else{
        
            
            let (__warp_se_87) = warp_eq(__warp_23_interfaceId, 243872796);
            
            let __warp_rc_8 = __warp_se_87;
            
            let __warp_rc_8 = __warp_rc_8;
            
            let __warp_23_interfaceId = __warp_23_interfaceId;
            
            
            
            return (__warp_rc_8, __warp_23_interfaceId);
        }

    }

}


    @external
    func setApprovalForAll_a22cb465{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_4_operator : felt, __warp_5_approved : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_bool(__warp_5_approved);
        
        warp_external_input_check_address(__warp_4_operator);
        
        let (__warp_se_31) = get_caller_address();
        
        let (__warp_se_32) = WS1_INDEX_felt_to_warp_id(ERC1155.__warp_1_isApprovedForAll, __warp_se_31);
        
        let (__warp_se_33) = WS0_READ_warp_id(__warp_se_32);
        
        let (__warp_se_34) = WS2_INDEX_felt_to_felt(__warp_se_33, __warp_4_operator);
        
        WS_WRITE1(__warp_se_34, __warp_5_approved);
        
        let (__warp_se_35) = get_caller_address();
        
        __warp_emit_ApprovalForAll_17307eab39ab6107e8899845ad3d59bd9653f200f220920489ca2b5937696c31(__warp_se_35, __warp_4_operator, __warp_5_approved);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func safeTransferFrom_f242432a{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_6_from : felt, __warp_7_to : felt, __warp_8_id : Uint256, __warp_9_amount : Uint256, __warp_10_data_len : felt, __warp_10_data : felt*)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        extern_input_check0(__warp_10_data_len, __warp_10_data);
        
        warp_external_input_check_int256(__warp_9_amount);
        
        warp_external_input_check_int256(__warp_8_id);
        
        warp_external_input_check_address(__warp_7_to);
        
        warp_external_input_check_address(__warp_6_from);
        
        local __warp_10_data_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_10_data_len, __warp_10_data);
        
        let __warp_rc_0 = 0;
        
            
            let (__warp_tv_0, __warp_tv_1) = ERC1155.__warp_conditional_safeTransferFrom_f242432a_1(__warp_6_from);
            
            let __warp_6_from = __warp_tv_1;
            
            let __warp_rc_0 = __warp_tv_0;
        
        with_attr error_message("NOT_AUTHORIZED"){
            assert __warp_rc_0 = 1;
        }
        
        let __warp_cs_8 = __warp_8_id;
        
        let __warp_cs_9 = __warp_6_from;
        
        let (__warp_se_46) = WS1_INDEX_felt_to_warp_id(ERC1155.__warp_0_balanceOf, __warp_cs_9);
        
        let (__warp_se_47) = WS0_READ_warp_id(__warp_se_46);
        
        let (__warp_se_48) = WS0_INDEX_Uint256_to_Uint256(__warp_se_47, __warp_cs_8);
        
        let (__warp_se_49) = WS1_INDEX_felt_to_warp_id(ERC1155.__warp_0_balanceOf, __warp_cs_9);
        
        let (__warp_se_50) = WS0_READ_warp_id(__warp_se_49);
        
        let (__warp_se_51) = WS0_INDEX_Uint256_to_Uint256(__warp_se_50, __warp_cs_8);
        
        let (__warp_se_52) = WS1_READ_Uint256(__warp_se_51);
        
        let (__warp_se_53) = warp_sub256(__warp_se_52, __warp_9_amount);
        
        WS_WRITE0(__warp_se_48, __warp_se_53);
        
        let __warp_cs_10 = __warp_8_id;
        
        let __warp_cs_11 = __warp_7_to;
        
        let (__warp_se_54) = WS1_INDEX_felt_to_warp_id(ERC1155.__warp_0_balanceOf, __warp_cs_11);
        
        let (__warp_se_55) = WS0_READ_warp_id(__warp_se_54);
        
        let (__warp_se_56) = WS0_INDEX_Uint256_to_Uint256(__warp_se_55, __warp_cs_10);
        
        let (__warp_se_57) = WS1_INDEX_felt_to_warp_id(ERC1155.__warp_0_balanceOf, __warp_cs_11);
        
        let (__warp_se_58) = WS0_READ_warp_id(__warp_se_57);
        
        let (__warp_se_59) = WS0_INDEX_Uint256_to_Uint256(__warp_se_58, __warp_cs_10);
        
        let (__warp_se_60) = WS1_READ_Uint256(__warp_se_59);
        
        let (__warp_se_61) = warp_add256(__warp_se_60, __warp_9_amount);
        
        WS_WRITE0(__warp_se_56, __warp_se_61);
        
        let (__warp_se_62) = get_caller_address();
        
        __warp_emit_TransferSingle_c3d58168c5ae7397731d063d5bbf3d657854427343f4c083240f7aacaa2d0f62(__warp_se_62, __warp_6_from, __warp_7_to, __warp_8_id, __warp_9_amount);
        
        let __warp_rc_2 = 0;
        
            
            let (__warp_tv_2, __warp_tv_3, __warp_tv_4, __warp_tv_5, __warp_tv_6, __warp_td_9) = ERC1155.__warp_conditional_safeTransferFrom_f242432a_3(__warp_7_to, __warp_6_from, __warp_8_id, __warp_9_amount, __warp_10_data_dstruct);
            
            let __warp_tv_7 = __warp_td_9;
            
            let __warp_9_amount = __warp_tv_6;
            
            let __warp_8_id = __warp_tv_5;
            
            let __warp_6_from = __warp_tv_4;
            
            let __warp_7_to = __warp_tv_3;
            
            let __warp_rc_2 = __warp_tv_2;
        
        with_attr error_message("UNSAFE_RECIPIENT"){
            assert __warp_rc_2 = 1;
        }
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func safeBatchTransferFrom_2eb2c2d6{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_11_from : felt, __warp_12_to : felt, __warp_13_ids_len : felt, __warp_13_ids : Uint256*, __warp_14_amounts_len : felt, __warp_14_amounts : Uint256*, __warp_15_data_len : felt, __warp_15_data : felt*)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        extern_input_check0(__warp_15_data_len, __warp_15_data);
        
        extern_input_check1(__warp_14_amounts_len, __warp_14_amounts);
        
        extern_input_check1(__warp_13_ids_len, __warp_13_ids);
        
        warp_external_input_check_address(__warp_12_to);
        
        warp_external_input_check_address(__warp_11_from);
        
        local __warp_15_data_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_15_data_len, __warp_15_data);
        
        local __warp_14_amounts_dstruct : cd_dynarray_Uint256 = cd_dynarray_Uint256(__warp_14_amounts_len, __warp_14_amounts);
        
        local __warp_13_ids_dstruct : cd_dynarray_Uint256 = cd_dynarray_Uint256(__warp_13_ids_len, __warp_13_ids);
        
        let (__warp_se_73) = felt_to_uint256(__warp_13_ids_dstruct.len);
        
        let (__warp_se_74) = felt_to_uint256(__warp_14_amounts_dstruct.len);
        
        let (__warp_se_75) = warp_eq256(__warp_se_73, __warp_se_74);
        
        with_attr error_message("LENGTH_MISMATCH"){
            assert __warp_se_75 = 1;
        }
        
        let __warp_rc_4 = 0;
        
            
            let (__warp_tv_8, __warp_tv_9) = ERC1155.__warp_conditional_safeBatchTransferFrom_2eb2c2d6_5(__warp_11_from);
            
            let __warp_11_from = __warp_tv_9;
            
            let __warp_rc_4 = __warp_tv_8;
        
        with_attr error_message("NOT_AUTHORIZED"){
            assert __warp_rc_4 = 1;
        }
        
        let __warp_16_id = Uint256(low=0, high=0);
        
        let __warp_17_amount = Uint256(low=0, high=0);
        
            
            let __warp_18_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_10, __warp_td_10, __warp_tv_12, __warp_tv_13, __warp_td_11, __warp_tv_15, __warp_tv_16) = ERC1155.__warp_while0(__warp_18_i, __warp_13_ids_dstruct, __warp_16_id, __warp_17_amount, __warp_14_amounts_dstruct, __warp_11_from, __warp_12_to);
                
                let __warp_tv_11 = __warp_td_10;
                
                let __warp_tv_14 = __warp_td_11;
                
                let __warp_12_to = __warp_tv_16;
                
                let __warp_11_from = __warp_tv_15;
                
                let __warp_17_amount = __warp_tv_13;
                
                let __warp_16_id = __warp_tv_12;
                
                let __warp_18_i = __warp_tv_10;
        
        let (__warp_se_76) = get_caller_address();
        
        let (__warp_se_77) = cd_to_memory0(__warp_13_ids_dstruct);
        
        let (__warp_se_78) = cd_to_memory0(__warp_14_amounts_dstruct);
        
        __warp_emit_TransferBatch_4a39dc06d4c0dbc64b70af90fd698a233a518aa5d07e595d983b8c0526c8f7fb(__warp_se_76, __warp_11_from, __warp_12_to, __warp_se_77, __warp_se_78);
        
        let __warp_rc_6 = 0;
        
            
            let (__warp_tv_17, __warp_tv_18, __warp_tv_19, __warp_td_12, __warp_td_13, __warp_td_14) = ERC1155.__warp_conditional_safeBatchTransferFrom_2eb2c2d6_7(__warp_12_to, __warp_11_from, __warp_13_ids_dstruct, __warp_14_amounts_dstruct, __warp_15_data_dstruct);
            
            let __warp_tv_20 = __warp_td_12;
            
            let __warp_tv_21 = __warp_td_13;
            
            let __warp_tv_22 = __warp_td_14;
            
            let __warp_11_from = __warp_tv_19;
            
            let __warp_12_to = __warp_tv_18;
            
            let __warp_rc_6 = __warp_tv_17;
        
        with_attr error_message("UNSAFE_RECIPIENT"){
            assert __warp_rc_6 = 1;
        }
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func balanceOfBatch_4e1273f4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_19_owners_len : felt, __warp_19_owners : felt*, __warp_20_ids_len : felt, __warp_20_ids : Uint256*)-> (__warp_21_balances_len : felt, __warp_21_balances : Uint256*){
    alloc_locals;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        extern_input_check1(__warp_20_ids_len, __warp_20_ids);
        
        extern_input_check2(__warp_19_owners_len, __warp_19_owners);
        
        let (__warp_21_balances) = wm_new(Uint256(low=0, high=0), Uint256(low=2, high=0));
        
        local __warp_20_ids_dstruct : cd_dynarray_Uint256 = cd_dynarray_Uint256(__warp_20_ids_len, __warp_20_ids);
        
        local __warp_19_owners_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_19_owners_len, __warp_19_owners);
        
        let (__warp_se_79) = felt_to_uint256(__warp_19_owners_dstruct.len);
        
        let (__warp_se_80) = felt_to_uint256(__warp_20_ids_dstruct.len);
        
        let (__warp_se_81) = warp_eq256(__warp_se_79, __warp_se_80);
        
        with_attr error_message("LENGTH_MISMATCH"){
            assert __warp_se_81 = 1;
        }
        
        let (__warp_se_82) = felt_to_uint256(__warp_19_owners_dstruct.len);
        
        let (__warp_se_83) = wm_new(__warp_se_82, Uint256(low=2, high=0));
        
        let __warp_21_balances = __warp_se_83;
        
            
                
                let __warp_22_i = Uint256(low=0, high=0);
                
                    
                    let (__warp_tv_23, __warp_td_15, __warp_td_16, __warp_td_17) = ERC1155.__warp_while1(__warp_22_i, __warp_19_owners_dstruct, __warp_21_balances, __warp_20_ids_dstruct);
                    
                    let __warp_tv_24 = __warp_td_15;
                    
                    let __warp_tv_25 = __warp_td_16;
                    
                    let __warp_tv_26 = __warp_td_17;
                    
                    let __warp_21_balances = __warp_tv_25;
                    
                    let __warp_22_i = __warp_tv_23;
        
        let (__warp_se_84) = wm_to_calldata0(__warp_21_balances);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return (__warp_se_84.len, __warp_se_84.ptr,);
    }
    }


    @view
    func supportsInterface_01ffc9a7{syscall_ptr : felt*, range_check_ptr : felt}(__warp_23_interfaceId : felt)-> (__warp_24 : felt){
    alloc_locals;


        
        warp_external_input_check_int32(__warp_23_interfaceId);
        
        let __warp_rc_8 = 0;
        
            
            let (__warp_tv_29, __warp_tv_30) = ERC1155.__warp_conditional_supportsInterface_01ffc9a7_9(__warp_23_interfaceId);
            
            let __warp_23_interfaceId = __warp_tv_30;
            
            let __warp_rc_8 = __warp_tv_29;
        
        
        
        return (__warp_rc_8,);

    }


    @view
    func balanceOf_00fdd58e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_43__i0 : felt, __warp_44__i1 : Uint256)-> (__warp_45 : Uint256){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_44__i1);
        
        warp_external_input_check_address(__warp_43__i0);
        
        let (__warp_se_88) = WS1_INDEX_felt_to_warp_id(ERC1155.__warp_0_balanceOf, __warp_43__i0);
        
        let (__warp_se_89) = WS0_READ_warp_id(__warp_se_88);
        
        let (__warp_se_90) = WS0_INDEX_Uint256_to_Uint256(__warp_se_89, __warp_44__i1);
        
        let (__warp_se_91) = WS1_READ_Uint256(__warp_se_90);
        
        
        
        return (__warp_se_91,);

    }


    @view
    func isApprovedForAll_e985e9c5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_46__i0 : felt, __warp_47__i1 : felt)-> (__warp_48 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_47__i1);
        
        warp_external_input_check_address(__warp_46__i0);
        
        let (__warp_se_92) = WS1_INDEX_felt_to_warp_id(ERC1155.__warp_1_isApprovedForAll, __warp_46__i0);
        
        let (__warp_se_93) = WS0_READ_warp_id(__warp_se_92);
        
        let (__warp_se_94) = WS2_INDEX_felt_to_felt(__warp_se_93, __warp_47__i1);
        
        let (__warp_se_95) = WS2_READ_felt(__warp_se_94);
        
        
        
        return (__warp_se_95,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(2);
    WARP_NAMEGEN.write(2);


        
        
        
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


// Contract Def ERC1155TokenReceiver@interface


@contract_interface
namespace ERC1155TokenReceiver_warped_interface{
func onERC1155Received_f23a6e61(__warp_0 : felt, __warp_1 : felt, __warp_2 : Uint256, __warp_3 : Uint256, __warp_4_len : felt, __warp_4 : felt*)-> (__warp_5 : felt){
}
func onERC1155BatchReceived_bc197c81(__warp_6 : felt, __warp_7 : felt, __warp_8_len : felt, __warp_8 : Uint256*, __warp_9_len : felt, __warp_9 : Uint256*, __warp_10_len : felt, __warp_10 : felt*)-> (__warp_11 : felt){
}
}