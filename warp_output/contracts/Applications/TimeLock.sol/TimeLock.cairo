%lang starknet


from warplib.memory import wm_read_felt, wm_read_256, wm_new, wm_index_dyn, wm_dyn_array_length, wm_to_felt_array
from starkware.cairo.common.uint256 import uint256_sub, uint256_add, Uint256
from starkware.cairo.common.alloc import alloc
from warplib.maths.utils import narrow_safe, felt_to_uint256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int8
from starkware.cairo.common.dict import dict_write
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, bytes_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes_to_felt_dynamic_array, fixed_bytes256_to_felt_dynamic_array_spl
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from warplib.keccak import felt_array_concat, pack_bytes_felt, warp_keccak
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from starkware.cairo.common.dict_access import DictAccess
from warplib.maths.neq import warp_neq
from warplib.block_methods import warp_block_timestamp
from warplib.maths.lt import warp_lt256
from warplib.maths.add import warp_add256
from warplib.maths.gt import warp_gt256
from warplib.maths.bytes_conversions import warp_bytes_narrow_256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

func wm_to_calldata0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(mem_loc: felt) -> (retData: cd_dynarray_felt){
    alloc_locals;
    let (len_256) = wm_read_256(mem_loc);
    let (ptr : felt*) = alloc();
    let (len_felt) = narrow_safe(len_256);
    wm_to_calldata1(len_felt, ptr, mem_loc + 2);
    return (cd_dynarray_felt(len=len_felt, ptr=ptr),);
}


func wm_to_calldata1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(len: felt, ptr: felt*, mem_loc: felt) -> (){
    alloc_locals;
    if (len == 0){
         return ();
    }
let (mem_read0) = wm_read_felt(mem_loc);
assert ptr[0] = mem_read0;
    wm_to_calldata1(len=len - 1, ptr=ptr + 1, mem_loc=mem_loc + 1);
    return ();
}

func WS0_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}

func WS_WRITE1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
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

func extern_input_check1{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
warp_external_input_check_int8(ptr[0]);
   extern_input_check1(len = len - 1, ptr = ptr + 1);
    return ();
}

func cd_to_memory0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata: felt*, mem_start: felt, length: felt){
    alloc_locals;
    if (length == 0){
        return ();
    }
dict_write{dict_ptr=warp_memory}(mem_start, calldata[0]);
    return cd_to_memory0_elem(calldata + 1, mem_start + 1, length - 1);
}
func cd_to_memory0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata : cd_dynarray_felt) -> (mem_loc: felt){
    alloc_locals;
    let (len256) = felt_to_uint256(calldata.len);
    let (mem_start) = wm_new(len256, Uint256(0x1, 0x0));
    cd_to_memory0_elem(calldata.ptr, mem_start + 2, calldata.len);
    return (mem_start,);
}

func cd_to_memory1_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata: felt*, mem_start: felt, length: felt){
    alloc_locals;
    if (length == 0){
        return ();
    }
dict_write{dict_ptr=warp_memory}(mem_start, calldata[0]);
    return cd_to_memory1_elem(calldata + 1, mem_start + 1, length - 1);
}
func cd_to_memory1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata : cd_dynarray_felt) -> (mem_loc: felt){
    alloc_locals;
    let (len256) = felt_to_uint256(calldata.len);
    let (mem_start) = wm_new(len256, Uint256(0x1, 0x0));
    cd_to_memory1_elem(calldata.ptr, mem_start + 2, calldata.len);
    return (mem_start,);
}

func abi_encode0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt, param1 : Uint256, param2 : felt, param3 : felt, param4 : Uint256) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 160;
  let (bytes_array : felt*) = alloc();
let (param0256) = felt_to_uint256(param0);
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param0256);
let bytes_index = bytes_index + 32;
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param1);
let bytes_index = bytes_index + 32;
let (bytes_index, bytes_offset) = bytes_to_felt_dynamic_array(
  bytes_index,
  bytes_offset,
  bytes_array,
  0,
  param2
);
let (bytes_index, bytes_offset) = bytes_to_felt_dynamic_array(
  bytes_index,
  bytes_offset,
  bytes_array,
  0,
  param3
);
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param4);
let bytes_index = bytes_index + 32;
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}

func abi_encode1{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : Uint256) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 32;
  let (bytes_array : felt*) = alloc();
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param0);
let bytes_index = bytes_index + 32;
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}

func abi_encode2{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt) -> (result_ptr : felt){
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

func abi_encode3{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : Uint256) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 32;
  let (bytes_array : felt*) = alloc();
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param0);
let bytes_index = bytes_index + 32;
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}

func abi_encode4{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 32;
  let (bytes_array : felt*) = alloc();
let (bytes_index, bytes_offset) = bytes_to_felt_dynamic_array(
  bytes_index,
  bytes_offset,
  bytes_array,
  0,
  param0
);
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}

func abi_encode5{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 32;
  let (bytes_array : felt*) = alloc();
let (bytes_index, bytes_offset) = bytes_to_felt_dynamic_array(
  bytes_index,
  bytes_offset,
  bytes_array,
  0,
  param0
);
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
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

func abi_encode_packed0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt, param1 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let (bytes_array : felt*) = alloc();
fixed_bytes_to_felt_dynamic_array(bytes_index,bytes_array,0,param0,4);
let bytes_index = bytes_index +  4;
let (length256) = wm_dyn_array_length(param1);
let (length) = narrow_safe(length256);
let (bytes_index) = abi_encode_packed_inline_array0(bytes_index, bytes_array, 0, length, param1);
  let (max_length256) = felt_to_uint256(bytes_index);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_index);
  return (mem_ptr,);
}

func _emit_Cancel_e8d9861d{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0xfa2c8e2a5ed83c180bdf8e1df16db0e32dd98f7d8e9914dcded6378abdfa20);// keccak of event signature: Cancel(bytes32)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_Execute_d1d5c3c8{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : felt, param2 : Uint256, param3 : felt, param4 : felt, param5 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x1aab35783f67274349f46d4f87145848b348440a453de6730edd4a0b3e16914);// keccak of event signature: Execute(bytes32,address,uint256,string,bytes,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode2(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode3(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode4(param3);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode5(param4);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode3(param5);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_Queue_3c22f471{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : felt, param2 : Uint256, param3 : felt, param4 : felt, param5 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x1242eb26ed8df39343a5610c373e90c9224d9eebbecba1a5e7ddd3b82a5bbbf);// keccak of event signature: Queue(bytes32,address,uint256,string,bytes,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode2(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode3(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode4(param3);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode5(param4);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode3(param5);
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
func WS0_INDEX_Uint256_to_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: Uint256) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING0.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_MAPPING0.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}


// Contract Def TimeLock


// @event
// func Queue(txId : Uint256, target : felt, value : Uint256, __warp_2_func : felt, data : felt, timestamp : Uint256){
// }


// @event
// func Execute(txId : Uint256, target : felt, value : Uint256, __warp_3_func : felt, data : felt, timestamp : Uint256){
// }


// @event
// func Cancel(txId : Uint256){
// }

namespace TimeLock{

    // Dynamic variables - Arrays and Maps

    const __warp_1_queued = 1;

    // Static variables

    const MIN_DELAY = 0;

    const MAX_DELAY = 2;

    const GRACE_PERIOD = 4;

    const __warp_0_owner = 6;


    func __warp_modifier_onlyOwner_cancel_c4d252f5_20{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_24__txId19 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_0) = get_caller_address();
        
        let (__warp_se_1) = WS0_READ_felt(__warp_0_owner);
        
        let (__warp_se_2) = warp_neq(__warp_se_0, __warp_se_1);
        
        if (__warp_se_2 != 0){
        
            
                
                with_attr error_message("NotOwnerError"){
                    assert 0 = 1;
                }
            
            __warp_modifier_onlyOwner_cancel_c4d252f5_20_if_part1(__warp_parameter___warp_24__txId19);
            
            let __warp_uv1 = ();
            
            
            
            return ();
        }else{
        
            
            __warp_modifier_onlyOwner_cancel_c4d252f5_20_if_part1(__warp_parameter___warp_24__txId19);
            
            let __warp_uv2 = ();
            
            
            
            return ();
        }

    }


    func __warp_modifier_onlyOwner_cancel_c4d252f5_20_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_24__txId19 : Uint256)-> (){
    alloc_locals;


        
        __warp_original_function_cancel_c4d252f5_18(__warp_parameter___warp_24__txId19);
        
        
        
        return ();

    }


    func __warp_original_function_cancel_c4d252f5_18{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_24__txId : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_3) = WS0_INDEX_Uint256_to_felt(__warp_1_queued, __warp_24__txId);
        
        let (__warp_se_4) = WS0_READ_felt(__warp_se_3);
        
        if (1 - __warp_se_4 != 0){
        
            
                
                with_attr error_message("NotQueuedError"){
                    assert 0 = 1;
                }
            
            __warp_original_function_cancel_c4d252f5_18_if_part1(__warp_24__txId);
            
            let __warp_uv3 = ();
            
            
            
            return ();
        }else{
        
            
            __warp_original_function_cancel_c4d252f5_18_if_part1(__warp_24__txId);
            
            let __warp_uv4 = ();
            
            
            
            return ();
        }

    }


    func __warp_original_function_cancel_c4d252f5_18_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_24__txId : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_5) = WS0_INDEX_Uint256_to_felt(__warp_1_queued, __warp_24__txId);
        
        WS_WRITE0(__warp_se_5, 0);
        
        _emit_Cancel_e8d9861d(__warp_24__txId);
        
        
        
        return ();

    }


    func __warp_modifier_onlyOwner_execute_b0f8b142_17{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_16__target10 : felt, __warp_parameter___warp_17__value11 : Uint256, __warp_parameter___warp_18__func12 : cd_dynarray_felt, __warp_parameter___warp_19__data13 : cd_dynarray_felt, __warp_parameter___warp_20__timestamp14 : Uint256, __warp_parameter___warp_21_m_capture15 : felt)-> (__warp_ret_parameter___warp_2116 : felt){
    alloc_locals;


        
        let (__warp_ret_parameter___warp_2116) = wm_new(Uint256(low=0, high=0), Uint256(low=1, high=0));
        
        let (__warp_se_6) = get_caller_address();
        
        let (__warp_se_7) = WS0_READ_felt(__warp_0_owner);
        
        let (__warp_se_8) = warp_neq(__warp_se_6, __warp_se_7);
        
        if (__warp_se_8 != 0){
        
            
                
                with_attr error_message("NotOwnerError"){
                    assert 0 = 1;
                }
            
            let (__warp_pse_0) = __warp_modifier_onlyOwner_execute_b0f8b142_17_if_part1(__warp_ret_parameter___warp_2116, __warp_parameter___warp_16__target10, __warp_parameter___warp_17__value11, __warp_parameter___warp_18__func12, __warp_parameter___warp_19__data13, __warp_parameter___warp_20__timestamp14, __warp_parameter___warp_21_m_capture15);
            
            
            
            return (__warp_pse_0,);
        }else{
        
            
            let (__warp_pse_1) = __warp_modifier_onlyOwner_execute_b0f8b142_17_if_part1(__warp_ret_parameter___warp_2116, __warp_parameter___warp_16__target10, __warp_parameter___warp_17__value11, __warp_parameter___warp_18__func12, __warp_parameter___warp_19__data13, __warp_parameter___warp_20__timestamp14, __warp_parameter___warp_21_m_capture15);
            
            
            
            return (__warp_pse_1,);
        }

    }


    func __warp_modifier_onlyOwner_execute_b0f8b142_17_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_ret_parameter___warp_2116 : felt, __warp_parameter___warp_16__target10 : felt, __warp_parameter___warp_17__value11 : Uint256, __warp_parameter___warp_18__func12 : cd_dynarray_felt, __warp_parameter___warp_19__data13 : cd_dynarray_felt, __warp_parameter___warp_20__timestamp14 : Uint256, __warp_parameter___warp_21_m_capture15 : felt)-> (__warp_ret_parameter___warp_2116 : felt){
    alloc_locals;


        
        let (__warp_pse_2) = __warp_original_function_execute_b0f8b142_9(__warp_parameter___warp_16__target10, __warp_parameter___warp_17__value11, __warp_parameter___warp_18__func12, __warp_parameter___warp_19__data13, __warp_parameter___warp_20__timestamp14, __warp_parameter___warp_21_m_capture15);
        
        let __warp_ret_parameter___warp_2116 = __warp_pse_2;
        
        
        
        return (__warp_ret_parameter___warp_2116,);

    }


    func __warp_original_function_execute_b0f8b142_9{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_16__target : felt, __warp_17__value : Uint256, __warp_18__func : cd_dynarray_felt, __warp_19__data : cd_dynarray_felt, __warp_20__timestamp : Uint256, __warp_21_m_capture : felt)-> (__warp_21 : felt){
    alloc_locals;


        
        let (__warp_21) = wm_new(Uint256(low=0, high=0), Uint256(low=1, high=0));
        
        let __warp_21 = __warp_21_m_capture;
        
        let (__warp_22_txId) = getTxId_8a1ce0b6_internal(__warp_16__target, __warp_17__value, __warp_18__func, __warp_19__data, __warp_20__timestamp);
        
        let (__warp_se_9) = WS0_INDEX_Uint256_to_felt(__warp_1_queued, __warp_22_txId);
        
        let (__warp_se_10) = WS0_READ_felt(__warp_se_9);
        
        if (1 - __warp_se_10 != 0){
        
            
                
                with_attr error_message("NotQueuedError"){
                    assert 0 = 1;
                }
            
            let (__warp_pse_3) = __warp_original_function_execute_b0f8b142_9_if_part1(__warp_20__timestamp, __warp_22_txId, __warp_18__func, __warp_19__data, __warp_16__target, __warp_17__value, __warp_21);
            
            
            
            return (__warp_pse_3,);
        }else{
        
            
            let (__warp_pse_4) = __warp_original_function_execute_b0f8b142_9_if_part1(__warp_20__timestamp, __warp_22_txId, __warp_18__func, __warp_19__data, __warp_16__target, __warp_17__value, __warp_21);
            
            
            
            return (__warp_pse_4,);
        }

    }


    func __warp_original_function_execute_b0f8b142_9_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_20__timestamp : Uint256, __warp_22_txId : Uint256, __warp_18__func : cd_dynarray_felt, __warp_19__data : cd_dynarray_felt, __warp_16__target : felt, __warp_17__value : Uint256, __warp_21 : felt)-> (__warp_21 : felt){
    alloc_locals;


        
        let (__warp_se_11) = warp_block_timestamp();
        
        let (__warp_se_12) = warp_lt256(__warp_se_11, __warp_20__timestamp);
        
        if (__warp_se_12 != 0){
        
            
                
                with_attr error_message("TimestampNotPassedError"){
                    assert 0 = 1;
                }
            
            let (__warp_pse_5) = __warp_original_function_execute_b0f8b142_9_if_part1_if_part1(__warp_20__timestamp, __warp_22_txId, __warp_18__func, __warp_19__data, __warp_16__target, __warp_17__value, __warp_21);
            
            
            
            return (__warp_pse_5,);
        }else{
        
            
            let (__warp_pse_6) = __warp_original_function_execute_b0f8b142_9_if_part1_if_part1(__warp_20__timestamp, __warp_22_txId, __warp_18__func, __warp_19__data, __warp_16__target, __warp_17__value, __warp_21);
            
            
            
            return (__warp_pse_6,);
        }

    }


    func __warp_original_function_execute_b0f8b142_9_if_part1_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_20__timestamp : Uint256, __warp_22_txId : Uint256, __warp_18__func : cd_dynarray_felt, __warp_19__data : cd_dynarray_felt, __warp_16__target : felt, __warp_17__value : Uint256, __warp_21 : felt)-> (__warp_21 : felt){
    alloc_locals;


        
        let (__warp_se_13) = warp_block_timestamp();
        
        let (__warp_se_14) = warp_add256(__warp_20__timestamp, Uint256(low=1000, high=0));
        
        let (__warp_se_15) = warp_gt256(__warp_se_13, __warp_se_14);
        
        if (__warp_se_15 != 0){
        
            
                
                with_attr error_message("TimestampExpiredError"){
                    assert 0 = 1;
                }
            
            let (__warp_pse_7) = __warp_original_function_execute_b0f8b142_9_if_part1_if_part1_if_part1(__warp_22_txId, __warp_18__func, __warp_19__data, __warp_16__target, __warp_17__value, __warp_20__timestamp, __warp_21);
            
            
            
            return (__warp_pse_7,);
        }else{
        
            
            let (__warp_pse_8) = __warp_original_function_execute_b0f8b142_9_if_part1_if_part1_if_part1(__warp_22_txId, __warp_18__func, __warp_19__data, __warp_16__target, __warp_17__value, __warp_20__timestamp, __warp_21);
            
            
            
            return (__warp_pse_8,);
        }

    }


    func __warp_original_function_execute_b0f8b142_9_if_part1_if_part1_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_22_txId : Uint256, __warp_18__func : cd_dynarray_felt, __warp_19__data : cd_dynarray_felt, __warp_16__target : felt, __warp_17__value : Uint256, __warp_20__timestamp : Uint256, __warp_21 : felt)-> (__warp_21 : felt){
    alloc_locals;


        
        let (__warp_se_16) = WS0_INDEX_Uint256_to_felt(__warp_1_queued, __warp_22_txId);
        
        WS_WRITE0(__warp_se_16, 0);
        
        let (__warp_23_data) = wm_new(Uint256(low=0, high=0), Uint256(low=1, high=0));
        
        let (__warp_se_17) = felt_to_uint256(__warp_18__func.len);
        
        let (__warp_se_18) = warp_gt256(__warp_se_17, Uint256(low=0, high=0));
        
        if (__warp_se_18 != 0){
        
            
                
                let (__warp_se_19) = cd_to_memory0(__warp_18__func);
                
                let (__warp_se_20) = warp_keccak(__warp_se_19);
                
                let (__warp_se_21) = warp_bytes_narrow_256(__warp_se_20, 224);
                
                let (__warp_se_22) = cd_to_memory0(__warp_19__data);
                
                let (__warp_se_23) = abi_encode_packed0(__warp_se_21, __warp_se_22);
                
                let __warp_23_data = __warp_se_23;
            
            let (__warp_pse_9) = __warp_original_function_execute_b0f8b142_9_if_part1_if_part1_if_part1_if_part1(__warp_22_txId, __warp_16__target, __warp_17__value, __warp_18__func, __warp_19__data, __warp_20__timestamp, __warp_21);
            
            
            
            return (__warp_pse_9,);
        }else{
        
            
                
                let (__warp_se_24) = cd_to_memory0(__warp_19__data);
                
                let __warp_23_data = __warp_se_24;
            
            let (__warp_pse_10) = __warp_original_function_execute_b0f8b142_9_if_part1_if_part1_if_part1_if_part1(__warp_22_txId, __warp_16__target, __warp_17__value, __warp_18__func, __warp_19__data, __warp_20__timestamp, __warp_21);
            
            
            
            return (__warp_pse_10,);
        }

    }


    func __warp_original_function_execute_b0f8b142_9_if_part1_if_part1_if_part1_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_22_txId : Uint256, __warp_16__target : felt, __warp_17__value : Uint256, __warp_18__func : cd_dynarray_felt, __warp_19__data : cd_dynarray_felt, __warp_20__timestamp : Uint256, __warp_21 : felt)-> (__warp_21 : felt){
    alloc_locals;


        
        let (__warp_se_25) = cd_to_memory1(__warp_18__func);
        
        let (__warp_se_26) = cd_to_memory0(__warp_19__data);
        
        _emit_Execute_d1d5c3c8(__warp_22_txId, __warp_16__target, __warp_17__value, __warp_se_25, __warp_se_26, __warp_20__timestamp);
        
        
        
        return (__warp_21,);

    }


    func __warp_modifier_onlyOwner_queue_4b9915a5_8{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_10__target1 : felt, __warp_parameter___warp_11__value2 : Uint256, __warp_parameter___warp_12__func3 : cd_dynarray_felt, __warp_parameter___warp_13__data4 : cd_dynarray_felt, __warp_parameter___warp_14__timestamp5 : Uint256, __warp_parameter___warp_15_txId_m_capture6 : Uint256)-> (__warp_ret_parameter___warp_15_txId7 : Uint256){
    alloc_locals;


        
        let __warp_ret_parameter___warp_15_txId7 = Uint256(low=0, high=0);
        
        let (__warp_se_27) = get_caller_address();
        
        let (__warp_se_28) = WS0_READ_felt(__warp_0_owner);
        
        let (__warp_se_29) = warp_neq(__warp_se_27, __warp_se_28);
        
        if (__warp_se_29 != 0){
        
            
                
                with_attr error_message("NotOwnerError"){
                    assert 0 = 1;
                }
            
            let (__warp_pse_11) = __warp_modifier_onlyOwner_queue_4b9915a5_8_if_part1(__warp_ret_parameter___warp_15_txId7, __warp_parameter___warp_10__target1, __warp_parameter___warp_11__value2, __warp_parameter___warp_12__func3, __warp_parameter___warp_13__data4, __warp_parameter___warp_14__timestamp5, __warp_parameter___warp_15_txId_m_capture6);
            
            
            
            return (__warp_pse_11,);
        }else{
        
            
            let (__warp_pse_12) = __warp_modifier_onlyOwner_queue_4b9915a5_8_if_part1(__warp_ret_parameter___warp_15_txId7, __warp_parameter___warp_10__target1, __warp_parameter___warp_11__value2, __warp_parameter___warp_12__func3, __warp_parameter___warp_13__data4, __warp_parameter___warp_14__timestamp5, __warp_parameter___warp_15_txId_m_capture6);
            
            
            
            return (__warp_pse_12,);
        }

    }


    func __warp_modifier_onlyOwner_queue_4b9915a5_8_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_ret_parameter___warp_15_txId7 : Uint256, __warp_parameter___warp_10__target1 : felt, __warp_parameter___warp_11__value2 : Uint256, __warp_parameter___warp_12__func3 : cd_dynarray_felt, __warp_parameter___warp_13__data4 : cd_dynarray_felt, __warp_parameter___warp_14__timestamp5 : Uint256, __warp_parameter___warp_15_txId_m_capture6 : Uint256)-> (__warp_ret_parameter___warp_15_txId7 : Uint256){
    alloc_locals;


        
        let (__warp_pse_13) = __warp_original_function_queue_4b9915a5_0(__warp_parameter___warp_10__target1, __warp_parameter___warp_11__value2, __warp_parameter___warp_12__func3, __warp_parameter___warp_13__data4, __warp_parameter___warp_14__timestamp5, __warp_parameter___warp_15_txId_m_capture6);
        
        let __warp_ret_parameter___warp_15_txId7 = __warp_pse_13;
        
        
        
        return (__warp_ret_parameter___warp_15_txId7,);

    }

    //  @param _target Address of contract or account to call
    // @param _value Amount of ETH to send
    // @param _func Function signature, for example "foo(address,uint256)"
    // @param _data ABI encoded data send.
    // @param _timestamp Timestamp after which the transaction can be executed.
    func __warp_original_function_queue_4b9915a5_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_10__target : felt, __warp_11__value : Uint256, __warp_12__func : cd_dynarray_felt, __warp_13__data : cd_dynarray_felt, __warp_14__timestamp : Uint256, __warp_15_txId_m_capture : Uint256)-> (__warp_15_txId : Uint256){
    alloc_locals;


        
        let __warp_15_txId = Uint256(low=0, high=0);
        
        let __warp_15_txId = __warp_15_txId_m_capture;
        
        let (__warp_pse_14) = getTxId_8a1ce0b6_internal(__warp_10__target, __warp_11__value, __warp_12__func, __warp_13__data, __warp_14__timestamp);
        
        let __warp_15_txId = __warp_pse_14;
        
        let (__warp_se_30) = WS0_INDEX_Uint256_to_felt(__warp_1_queued, __warp_15_txId);
        
        let (__warp_se_31) = WS0_READ_felt(__warp_se_30);
        
        if (__warp_se_31 != 0){
        
            
                
                with_attr error_message("AlreadyQueuedError"){
                    assert 0 = 1;
                }
            
            let (__warp_pse_15) = __warp_original_function_queue_4b9915a5_0_if_part1(__warp_14__timestamp, __warp_15_txId, __warp_10__target, __warp_11__value, __warp_12__func, __warp_13__data);
            
            
            
            return (__warp_pse_15,);
        }else{
        
            
            let (__warp_pse_16) = __warp_original_function_queue_4b9915a5_0_if_part1(__warp_14__timestamp, __warp_15_txId, __warp_10__target, __warp_11__value, __warp_12__func, __warp_13__data);
            
            
            
            return (__warp_pse_16,);
        }

    }


    func __warp_conditional___warp_original_function_queue_4b9915a5_0_if_part1_1{syscall_ptr : felt*, range_check_ptr : felt}(__warp_14__timestamp : Uint256)-> (__warp_rc_0 : felt, __warp_14__timestamp : Uint256){
    alloc_locals;


        
        let (__warp_se_32) = warp_block_timestamp();
        
        let (__warp_se_33) = warp_add256(__warp_se_32, Uint256(low=10, high=0));
        
        let (__warp_se_34) = warp_lt256(__warp_14__timestamp, __warp_se_33);
        
        if (__warp_se_34 != 0){
        
            
            let __warp_rc_0 = 1;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_14__timestamp = __warp_14__timestamp;
            
            
            
            return (__warp_rc_0, __warp_14__timestamp);
        }else{
        
            
            let (__warp_se_35) = warp_block_timestamp();
            
            let (__warp_se_36) = warp_add256(__warp_se_35, Uint256(low=1000, high=0));
            
            let (__warp_se_37) = warp_gt256(__warp_14__timestamp, __warp_se_36);
            
            let __warp_rc_0 = __warp_se_37;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_14__timestamp = __warp_14__timestamp;
            
            
            
            return (__warp_rc_0, __warp_14__timestamp);
        }

    }


    func __warp_original_function_queue_4b9915a5_0_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_14__timestamp : Uint256, __warp_15_txId : Uint256, __warp_10__target : felt, __warp_11__value : Uint256, __warp_12__func : cd_dynarray_felt, __warp_13__data : cd_dynarray_felt)-> (__warp_15_txId : Uint256){
    alloc_locals;


        
        let __warp_rc_0 = 0;
        
            
            let (__warp_tv_0, __warp_tv_1) = __warp_conditional___warp_original_function_queue_4b9915a5_0_if_part1_1(__warp_14__timestamp);
            
            let __warp_14__timestamp = __warp_tv_1;
            
            let __warp_rc_0 = __warp_tv_0;
        
        if (__warp_rc_0 != 0){
        
            
                
                with_attr error_message("TimestampNotInRangeError"){
                    assert 0 = 1;
                }
            
            let (__warp_pse_17) = __warp_original_function_queue_4b9915a5_0_if_part1_if_part1(__warp_15_txId, __warp_10__target, __warp_11__value, __warp_12__func, __warp_13__data, __warp_14__timestamp);
            
            
            
            return (__warp_pse_17,);
        }else{
        
            
            let (__warp_pse_18) = __warp_original_function_queue_4b9915a5_0_if_part1_if_part1(__warp_15_txId, __warp_10__target, __warp_11__value, __warp_12__func, __warp_13__data, __warp_14__timestamp);
            
            
            
            return (__warp_pse_18,);
        }

    }


    func __warp_original_function_queue_4b9915a5_0_if_part1_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_15_txId : Uint256, __warp_10__target : felt, __warp_11__value : Uint256, __warp_12__func : cd_dynarray_felt, __warp_13__data : cd_dynarray_felt, __warp_14__timestamp : Uint256)-> (__warp_15_txId : Uint256){
    alloc_locals;


        
        let (__warp_se_38) = WS0_INDEX_Uint256_to_felt(__warp_1_queued, __warp_15_txId);
        
        WS_WRITE0(__warp_se_38, 1);
        
        let (__warp_se_39) = cd_to_memory1(__warp_12__func);
        
        let (__warp_se_40) = cd_to_memory0(__warp_13__data);
        
        _emit_Queue_3c22f471(__warp_15_txId, __warp_10__target, __warp_11__value, __warp_se_39, __warp_se_40, __warp_14__timestamp);
        
        
        
        return (__warp_15_txId,);

    }


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        let (__warp_se_41) = get_caller_address();
        
        WS_WRITE0(__warp_0_owner, __warp_se_41);
        
        
        
        return ();

    }


    func getTxId_8a1ce0b6_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_4__target : felt, __warp_5__value : Uint256, __warp_6__func : cd_dynarray_felt, __warp_7__data : cd_dynarray_felt, __warp_8__timestamp : Uint256)-> (__warp_9 : Uint256){
    alloc_locals;


        
        let (__warp_se_42) = cd_to_memory1(__warp_6__func);
        
        let (__warp_se_43) = cd_to_memory0(__warp_7__data);
        
        let (__warp_se_44) = abi_encode0(__warp_4__target, __warp_5__value, __warp_se_42, __warp_se_43, __warp_8__timestamp);
        
        let (__warp_se_45) = warp_keccak(__warp_se_44);
        
        
        
        return (__warp_se_45,);

    }


    func __warp_init_TimeLock{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE1(MIN_DELAY, Uint256(low=10, high=0));
        
        WS_WRITE1(MAX_DELAY, Uint256(low=1000, high=0));
        
        WS_WRITE1(GRACE_PERIOD, Uint256(low=1000, high=0));
        
        
        
        return ();

    }

}

    //  @param _target Address of contract or account to call
    // @param _value Amount of ETH to send
    // @param _func Function signature, for example "foo(address,uint256)"
    // @param _data ABI encoded data send.
    // @param _timestamp Timestamp after which the transaction can be executed.
    @external
    func queue_4b9915a5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_10__target : felt, __warp_11__value : Uint256, __warp_12__func_len : felt, __warp_12__func : felt*, __warp_13__data_len : felt, __warp_13__data : felt*, __warp_14__timestamp : Uint256)-> (__warp_15_txId : Uint256){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_14__timestamp);
        
        extern_input_check1(__warp_13__data_len, __warp_13__data);
        
        extern_input_check0(__warp_12__func_len, __warp_12__func);
        
        warp_external_input_check_int256(__warp_11__value);
        
        warp_external_input_check_address(__warp_10__target);
        
        let __warp_15_txId = Uint256(low=0, high=0);
        
        local __warp_13__data_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_13__data_len, __warp_13__data);
        
        local __warp_12__func_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_12__func_len, __warp_12__func);
        
        let (__warp_pse_19) = TimeLock.__warp_modifier_onlyOwner_queue_4b9915a5_8(__warp_10__target, __warp_11__value, __warp_12__func_dstruct, __warp_13__data_dstruct, __warp_14__timestamp, __warp_15_txId);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (__warp_pse_19,);
    }
    }


    @external
    func execute_b0f8b142{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_16__target : felt, __warp_17__value : Uint256, __warp_18__func_len : felt, __warp_18__func : felt*, __warp_19__data_len : felt, __warp_19__data : felt*, __warp_20__timestamp : Uint256)-> (__warp_21_len : felt, __warp_21 : felt*){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_20__timestamp);
        
        extern_input_check1(__warp_19__data_len, __warp_19__data);
        
        extern_input_check0(__warp_18__func_len, __warp_18__func);
        
        warp_external_input_check_int256(__warp_17__value);
        
        warp_external_input_check_address(__warp_16__target);
        
        let (__warp_21) = wm_new(Uint256(low=0, high=0), Uint256(low=1, high=0));
        
        local __warp_19__data_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_19__data_len, __warp_19__data);
        
        local __warp_18__func_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_18__func_len, __warp_18__func);
        
        let (__warp_pse_20) = TimeLock.__warp_modifier_onlyOwner_execute_b0f8b142_17(__warp_16__target, __warp_17__value, __warp_18__func_dstruct, __warp_19__data_dstruct, __warp_20__timestamp, __warp_21);
        
        let (__warp_se_46) = wm_to_calldata0(__warp_pse_20);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (__warp_se_46.len, __warp_se_46.ptr,);
    }
    }


    @external
    func cancel_c4d252f5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_24__txId : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_24__txId);
        
        TimeLock.__warp_modifier_onlyOwner_cancel_c4d252f5_20(__warp_24__txId);
        
        let __warp_uv0 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func MIN_DELAY_9f81aed7{syscall_ptr : felt*, range_check_ptr : felt}()-> (__warp_25 : Uint256){
    alloc_locals;


        
        
        
        return (Uint256(low=10, high=0),);

    }


    @view
    func MAX_DELAY_4125ff90{syscall_ptr : felt*, range_check_ptr : felt}()-> (__warp_26 : Uint256){
    alloc_locals;


        
        
        
        return (Uint256(low=1000, high=0),);

    }


    @view
    func GRACE_PERIOD_c1a287e2{syscall_ptr : felt*, range_check_ptr : felt}()-> (__warp_27 : Uint256){
    alloc_locals;


        
        
        
        return (Uint256(low=1000, high=0),);

    }


    @view
    func owner_8da5cb5b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_28 : felt){
    alloc_locals;


        
        let (__warp_se_47) = WS0_READ_felt(TimeLock.__warp_0_owner);
        
        
        
        return (__warp_se_47,);

    }


    @view
    func queued_228250c9{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_29__i0 : Uint256)-> (__warp_30 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_29__i0);
        
        let (__warp_se_48) = WS0_INDEX_Uint256_to_felt(TimeLock.__warp_1_queued, __warp_29__i0);
        
        let (__warp_se_49) = WS0_READ_felt(__warp_se_48);
        
        
        
        return (__warp_se_49,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(8);
    WARP_NAMEGEN.write(1);


        
        TimeLock.__warp_init_TimeLock();
        
        TimeLock.__warp_constructor_0();
        
        
        
        return ();

    }


    @view
    func getTxId_8a1ce0b6{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_4__target : felt, __warp_5__value : Uint256, __warp_6__func_len : felt, __warp_6__func : felt*, __warp_7__data_len : felt, __warp_7__data : felt*, __warp_8__timestamp : Uint256)-> (__warp_9 : Uint256){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_8__timestamp);
        
        extern_input_check1(__warp_7__data_len, __warp_7__data);
        
        extern_input_check0(__warp_6__func_len, __warp_6__func);
        
        warp_external_input_check_int256(__warp_5__value);
        
        warp_external_input_check_address(__warp_4__target);
        
        local __warp_7__data_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_7__data_len, __warp_7__data);
        
        local __warp_6__func_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_6__func_len, __warp_6__func);
        
        let (__warp_pse_21) = TimeLock.getTxId_8a1ce0b6_internal(__warp_4__target, __warp_5__value, __warp_6__func_dstruct, __warp_7__data_dstruct, __warp_8__timestamp);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (__warp_pse_21,);
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