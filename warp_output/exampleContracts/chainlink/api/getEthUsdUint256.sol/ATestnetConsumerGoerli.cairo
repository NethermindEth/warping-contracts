%lang starknet


from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from starkware.cairo.common.default_dict import default_dict_finalize, default_dict_new
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.uint256 import Uint256
from starkware.starknet.common.syscalls import emit_event, get_caller_address, get_contract_address
from warplib.dynamic_arrays_util import bytes_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes_to_felt_dynamic_array, fixed_bytes256_to_felt_dynamic_array, fixed_bytes256_to_felt_dynamic_array_spl
from warplib.keccak import felt_array_concat, pack_bytes_felt, warp_keccak
from warplib.maths.add import warp_add256
from warplib.maths.bitwise_or import warp_bitwise_or
from warplib.maths.div import warp_div256
from warplib.maths.eq import warp_eq
from warplib.maths.exp_unsafe import warp_exp_wide_unsafe256
from warplib.maths.exp import warp_exp_wide256
from warplib.maths.external_input_check_bool import warp_external_input_check_bool
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from warplib.maths.ge_signed import warp_ge_signed256
from warplib.maths.ge import warp_ge256
from warplib.maths.gt_signed import warp_gt_signed256
from warplib.maths.gt import warp_gt256
from warplib.maths.int_conversions import warp_int256_to_int64, warp_int64_to_int8, warp_uint256
from warplib.maths.le import warp_le, warp_le256
from warplib.maths.lt_signed import warp_lt_signed256
from warplib.maths.mod import warp_mod256
from warplib.maths.mul import warp_mul256
from warplib.maths.neq import warp_neq256
from warplib.maths.shl import warp_shl8
from warplib.maths.sub_unsafe import warp_sub_unsafe256
from warplib.maths.sub import warp_sub256
from warplib.maths.utils import felt_to_uint256, narrow_safe
from warplib.memory import wm_alloc, wm_dyn_array_length, wm_new, wm_read_256, wm_read_felt, wm_read_id, wm_to_felt_array, wm_write_256, wm_write_felt


struct buffer_7f2b9d9f{
    buf : felt,
    capacity : Uint256,
}


struct Request_3c7ee36d{
    id : Uint256,
    callbackAddress : felt,
    callbackFunctionId : felt,
    nonce : Uint256,
    buf : buffer_7f2b9d9f,
}


@storage_var
func WARP_MAPPING0(name: felt, index: Uint256) -> (resLoc : felt){
}


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}


func __warp_emit_ChainlinkFulfilled_7cc135e0cebb02c3480ae5d74d377283180a2601f8f644edf7987b009316c63a{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x180a2601f8f644edf7987b009316c63a, 0x7cc135e0cebb02c3480ae5d74d377283);// keccak of event signature: ChainlinkFulfilled(bytes32)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode2();
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}


func __warp_emit_ChainlinkRequested_b5e6e01e79f91267dc17b4e6314d5d4d03593d2ceee0fbb452b750bd70ea5af9{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x3593d2ceee0fbb452b750bd70ea5af9, 0xb5e6e01e79f91267dc17b4e6314d5d4d);// keccak of event signature: ChainlinkRequested(bytes32)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode2();
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}


func __warp_emit_RequestEthereumPriceFulfilled_794eb9e29f6750ede99e05248d997a9ab9fa23c4a7eaff8afa729080eb7c6428{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0xb9fa23c4a7eaff8afa729080eb7c6428, 0x794eb9e29f6750ede99e05248d997a9a);// keccak of event signature: RequestEthereumPriceFulfilled(bytes32,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param0);
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
   let (mem_encode: felt) = abi_encode2();
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}


func abi_encode_packed0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt, param1 : Uint256) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let (bytes_array : felt*) = alloc();
let (param0256) = felt_to_uint256(param0);
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param0256);
let bytes_index = bytes_index +  32;
fixed_bytes256_to_felt_dynamic_array(bytes_index,bytes_array,0,param1);
let bytes_index = bytes_index +  32;
  let (max_length256) = felt_to_uint256(bytes_index);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_index);
  return (mem_ptr,);
}


func abi_encode_with_selector0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(selector : felt, param0 : felt, param1 : Uint256, param2 : Uint256, param3 : felt, param4 : felt, param5 : Uint256, param6 : Uint256, param7 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 260;
  let (bytes_array : felt*) = alloc();
fixed_bytes_to_felt_dynamic_array(bytes_index, bytes_array, 0, selector, 4);
let bytes_index = bytes_index + 4;
let (param0256) = felt_to_uint256(param0);
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param0256);
let bytes_index = bytes_index + 32;
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param1);
let bytes_index = bytes_index + 32;
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param2);
let bytes_index = bytes_index + 32;
let (param3256) = felt_to_uint256(param3);
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param3256);
let bytes_index = bytes_index + 32;
let (param4256) = felt_to_uint256(param4);
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param4256);
let bytes_index = bytes_index + 32;
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param5);
let bytes_index = bytes_index + 32;
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param6);
let bytes_index = bytes_index + 32;
let (bytes_index, bytes_offset) = bytes_to_felt_dynamic_array(
  bytes_index,
  bytes_offset,
  bytes_array,
  4,
  param7
);
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}


func abi_encode0{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : Uint256) -> (result_ptr : felt){
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


func abi_encode2{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}() -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 0;
  let (bytes_array : felt*) = alloc();
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}


func wm_buffer_7f2b9d9f_buf(loc: felt) -> (memberLoc: felt){
    return (loc,);
}


func wm_buffer_7f2b9d9f_capacity(loc: felt) -> (memberLoc: felt){
    return (loc + 1,);
}


func wm_Request_3c7ee36d_buf(loc: felt) -> (memberLoc: felt){
    return (loc + 6,);
}


func wm_Request_3c7ee36d_callbackAddress(loc: felt) -> (memberLoc: felt){
    return (loc + 2,);
}


func wm_Request_3c7ee36d_callbackFunctionId(loc: felt) -> (memberLoc: felt){
    return (loc + 3,);
}


func wm_Request_3c7ee36d_id(loc: felt) -> (memberLoc: felt){
    return (loc,);
}


func wm_to_calldata_dynamic_array_reader0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(len: felt, ptr: felt*, mem_loc: felt) -> (){
    alloc_locals;
    if (len == 0){
         return ();
    }
let (mem_read0) = wm_read_felt(mem_loc);
assert ptr[0] = mem_read0;
    wm_to_calldata_dynamic_array_reader0(len=len - 1, ptr=ptr + 1, mem_loc=mem_loc + 1);
    return ();
}
func wm_to_calldata_dynamic_array0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(mem_loc: felt) -> (retData: cd_dynarray_felt){
    alloc_locals;
    let (len_256) = wm_read_256(mem_loc);
    let (ptr : felt*) = alloc();
    let (len_felt) = narrow_safe(len_256);
    wm_to_calldata_dynamic_array_reader0(len_felt, ptr, mem_loc + 2);
    return (cd_dynarray_felt(len=len_felt, ptr=ptr),);
}


func wm0_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x5, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x3, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
    return (start,);
}


func WM0_struct_buffer_7f2b9d9f{range_check_ptr, warp_memory: DictAccess*}(member_buf: felt, member_capacity: Uint256) -> (res:felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x3, 0x0));
dict_write{dict_ptr=warp_memory}(start, member_buf);
dict_write{dict_ptr=warp_memory}(start + 1, member_capacity.low);
dict_write{dict_ptr=warp_memory}(start + 2, member_capacity.high);
    return (start,);
}


func wm1_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt, e8: felt, e9: felt, e10: felt, e11: felt, e12: felt, e13: felt, e14: felt, e15: felt, e16: felt, e17: felt, e18: felt, e19: felt, e20: felt, e21: felt, e22: felt, e23: felt, e24: felt, e25: felt, e26: felt, e27: felt, e28: felt, e29: felt, e30: felt, e31: felt, e32: felt, e33: felt, e34: felt, e35: felt, e36: felt, e37: felt, e38: felt, e39: felt, e40: felt, e41: felt, e42: felt, e43: felt, e44: felt, e45: felt, e46: felt, e47: felt, e48: felt, e49: felt, e50: felt, e51: felt, e52: felt, e53: felt, e54: felt, e55: felt, e56: felt, e57: felt, e58: felt, e59: felt, e60: felt, e61: felt, e62: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x41, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x3f, 0x0));
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
dict_write{dict_ptr=warp_memory}(start + 16, e14);
dict_write{dict_ptr=warp_memory}(start + 17, e15);
dict_write{dict_ptr=warp_memory}(start + 18, e16);
dict_write{dict_ptr=warp_memory}(start + 19, e17);
dict_write{dict_ptr=warp_memory}(start + 20, e18);
dict_write{dict_ptr=warp_memory}(start + 21, e19);
dict_write{dict_ptr=warp_memory}(start + 22, e20);
dict_write{dict_ptr=warp_memory}(start + 23, e21);
dict_write{dict_ptr=warp_memory}(start + 24, e22);
dict_write{dict_ptr=warp_memory}(start + 25, e23);
dict_write{dict_ptr=warp_memory}(start + 26, e24);
dict_write{dict_ptr=warp_memory}(start + 27, e25);
dict_write{dict_ptr=warp_memory}(start + 28, e26);
dict_write{dict_ptr=warp_memory}(start + 29, e27);
dict_write{dict_ptr=warp_memory}(start + 30, e28);
dict_write{dict_ptr=warp_memory}(start + 31, e29);
dict_write{dict_ptr=warp_memory}(start + 32, e30);
dict_write{dict_ptr=warp_memory}(start + 33, e31);
dict_write{dict_ptr=warp_memory}(start + 34, e32);
dict_write{dict_ptr=warp_memory}(start + 35, e33);
dict_write{dict_ptr=warp_memory}(start + 36, e34);
dict_write{dict_ptr=warp_memory}(start + 37, e35);
dict_write{dict_ptr=warp_memory}(start + 38, e36);
dict_write{dict_ptr=warp_memory}(start + 39, e37);
dict_write{dict_ptr=warp_memory}(start + 40, e38);
dict_write{dict_ptr=warp_memory}(start + 41, e39);
dict_write{dict_ptr=warp_memory}(start + 42, e40);
dict_write{dict_ptr=warp_memory}(start + 43, e41);
dict_write{dict_ptr=warp_memory}(start + 44, e42);
dict_write{dict_ptr=warp_memory}(start + 45, e43);
dict_write{dict_ptr=warp_memory}(start + 46, e44);
dict_write{dict_ptr=warp_memory}(start + 47, e45);
dict_write{dict_ptr=warp_memory}(start + 48, e46);
dict_write{dict_ptr=warp_memory}(start + 49, e47);
dict_write{dict_ptr=warp_memory}(start + 50, e48);
dict_write{dict_ptr=warp_memory}(start + 51, e49);
dict_write{dict_ptr=warp_memory}(start + 52, e50);
dict_write{dict_ptr=warp_memory}(start + 53, e51);
dict_write{dict_ptr=warp_memory}(start + 54, e52);
dict_write{dict_ptr=warp_memory}(start + 55, e53);
dict_write{dict_ptr=warp_memory}(start + 56, e54);
dict_write{dict_ptr=warp_memory}(start + 57, e55);
dict_write{dict_ptr=warp_memory}(start + 58, e56);
dict_write{dict_ptr=warp_memory}(start + 59, e57);
dict_write{dict_ptr=warp_memory}(start + 60, e58);
dict_write{dict_ptr=warp_memory}(start + 61, e59);
dict_write{dict_ptr=warp_memory}(start + 62, e60);
dict_write{dict_ptr=warp_memory}(start + 63, e61);
dict_write{dict_ptr=warp_memory}(start + 64, e62);
    return (start,);
}


func WM1_struct_Request_3c7ee36d{range_check_ptr, warp_memory: DictAccess*}(member_id: Uint256, member_callbackAddress: felt, member_callbackFunctionId: felt, member_nonce: Uint256, member_buf: felt) -> (res:felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x7, 0x0));
dict_write{dict_ptr=warp_memory}(start, member_id.low);
dict_write{dict_ptr=warp_memory}(start + 1, member_id.high);
dict_write{dict_ptr=warp_memory}(start + 2, member_callbackAddress);
dict_write{dict_ptr=warp_memory}(start + 3, member_callbackFunctionId);
dict_write{dict_ptr=warp_memory}(start + 4, member_nonce.low);
dict_write{dict_ptr=warp_memory}(start + 5, member_nonce.high);
dict_write{dict_ptr=warp_memory}(start + 6, member_buf);
    return (start,);
}


func wm2_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x6, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x4, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
    return (start,);
}


func wm3_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x7, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x5, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
    return (start,);
}


func wm4_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x8, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x6, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
dict_write{dict_ptr=warp_memory}(start + 7, e5);
    return (start,);
}


func WS_INDEX_Uint256_to_felt0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: Uint256) -> (res: felt){
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


func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}


func WS_WRITE1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}


func WS_WRITE3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}


func WS_WRITE4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}


func WS0_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}


func WS1_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}


func WS3_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}


// Contract Def ATestnetConsumerGoerli


// @event
// func ChainlinkCancelled(id : Uint256){
// }


// @event
// func ChainlinkFulfilled(id : Uint256){
// }


// @event
// func ChainlinkRequested(id : Uint256){
// }


// @event
// func RequestEthereumPriceFulfilled(requestId : Uint256, price : Uint256){
// }

namespace ATestnetConsumerGoerli{

    // Dynamic variables - Arrays and Maps

    const __warp_5_s_pendingRequests = 1;

    // Static variables

    const __warp_0_oracleGoerli = 0;

    const __warp_1_ORACLE_PAYMENT = 1;

    const __warp_2_currentPrice = 3;

    const defaultBufferSize = 5;

    const LINK_DIVISIBILITY = 7;

    const AMOUNT_OVERRIDE = 9;

    const __warp_0_SENDER_OVERRIDE = 11;

    const ORACLE_ARGS_VERSION = 12;

    const OPERATOR_ARGS_VERSION = 14;

    const ENS_TOKEN_SUBNAME = 16;

    const ENS_ORACLE_SUBNAME = 18;

    const __warp_1_LINK_TOKEN_POINTER = 20;

    const s_ens = 21;

    const s_ensNode = 22;

    const __warp_2_s_link = 24;

    const __warp_3_s_oracle = 25;

    const __warp_4_s_requestCount = 26;


    func __warp_while7{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_17_len : Uint256, __warp_19_dest : Uint256, __warp_20_src : Uint256)-> (__warp_17_len : Uint256, __warp_19_dest : Uint256, __warp_20_src : Uint256){
    alloc_locals;


        
            
            let (__warp_se_0) = warp_ge256(__warp_17_len, Uint256(low=32, high=0));
            
                
                if (__warp_se_0 != 0){
                
                    
                        
                        let (__warp_se_1) = warp_add256(__warp_19_dest, Uint256(low=32, high=0));
                        
                        let __warp_19_dest = __warp_se_1;
                        
                        let (__warp_se_2) = warp_add256(__warp_20_src, Uint256(low=32, high=0));
                        
                        let __warp_20_src = __warp_se_2;
                    
                    let (__warp_se_3) = warp_sub256(__warp_17_len, Uint256(low=32, high=0));
                    
                    let __warp_17_len = __warp_se_3;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_17_len = __warp_17_len;
                    tempvar __warp_19_dest = __warp_19_dest;
                    tempvar __warp_20_src = __warp_20_src;
                }else{
                
                    
                    let __warp_17_len = __warp_17_len;
                    
                    let __warp_19_dest = __warp_19_dest;
                    
                    let __warp_20_src = __warp_20_src;
                    
                    
                    
                    return (__warp_17_len, __warp_19_dest, __warp_20_src);
                }
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_17_len = __warp_17_len;
                tempvar __warp_19_dest = __warp_19_dest;
                tempvar __warp_20_src = __warp_20_src;
        
        let (__warp_17_len, __warp_19_dest, __warp_20_src) = __warp_while7(__warp_17_len, __warp_19_dest, __warp_20_src);
        
        
        
        return (__warp_17_len, __warp_19_dest, __warp_20_src);

    }


    func __warp_modifier_recordChainlinkFulfillment_fulfillEthereumPrice_92cdaaf3_3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_49_requestId : Uint256, __warp_parameter___warp_4__requestId1 : Uint256, __warp_parameter___warp_5__price2 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_4) = get_caller_address();
        
        let (__warp_se_5) = WS_INDEX_Uint256_to_felt0(__warp_5_s_pendingRequests, __warp_49_requestId);
        
        let (__warp_se_6) = WS0_READ_felt(__warp_se_5);
        
        let (__warp_se_7) = warp_eq(__warp_se_4, __warp_se_6);
        
        with_attr error_message("Source must be the oracle of the request"){
            assert __warp_se_7 = 1;
        }
        
        let (__warp_se_8) = WS_INDEX_Uint256_to_felt0(__warp_5_s_pendingRequests, __warp_49_requestId);
        
        WS_WRITE0(__warp_se_8, 0);
        
        __warp_emit_ChainlinkFulfilled_7cc135e0cebb02c3480ae5d74d377283180a2601f8f644edf7987b009316c63a(__warp_49_requestId);
        
        __warp_original_function_fulfillEthereumPrice_92cdaaf3_0(__warp_parameter___warp_4__requestId1, __warp_parameter___warp_5__price2);
        
        
        
        return ();

    }


    func __warp_original_function_fulfillEthereumPrice_92cdaaf3_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_4__requestId : Uint256, __warp_5__price : Uint256)-> (){
    alloc_locals;


        
        __warp_emit_RequestEthereumPriceFulfilled_794eb9e29f6750ede99e05248d997a9ab9fa23c4a7eaff8afa729080eb7c6428(__warp_4__requestId, __warp_5__price);
        
        WS_WRITE1(__warp_2_currentPrice, __warp_5__price);
        
        
        
        return ();

    }


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        setChainlinkToken_31d0e3f5(287871216000913445118239045323704632495854913275);
        
        
        
        return ();

    }


    func __warp_init_ATestnetConsumerGoerli{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_oracleGoerli, 1167334379890507398689134499916745803670302550711);
        
        let (__warp_se_20) = warp_mul256(Uint256(low=1, high=0), Uint256(low=1000000000000000000, high=0));
        
        let (__warp_se_21) = warp_div256(__warp_se_20, Uint256(low=10, high=0));
        
        WS_WRITE1(__warp_1_ORACLE_PAYMENT, __warp_se_21);
        
        
        
        return ();

    }

    //  @notice Creates a request that can hold additional parameters
    // @param specId The Job Specification ID that the request will be created for
    // @param callbackAddr address to operate the callback on
    // @param callbackFunctionSignature function signature to use for the callback
    // @return A Chainlink Request struct in memory
    func buildChainlinkRequest_56db6353{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_6_specId : Uint256, __warp_7_callbackAddr : felt, __warp_8_callbackFunctionSignature : felt)-> (__warp_9 : felt){
    alloc_locals;


        
        let (__warp_se_22) = wm_new(Uint256(low=0, high=0), Uint256(low=1, high=0));
        
        let (__warp_se_23) = WM0_struct_buffer_7f2b9d9f(__warp_se_22, Uint256(low=0, high=0));
        
        let (__warp_10_req) = WM1_struct_Request_3c7ee36d(Uint256(low=0, high=0), 0, 0x0, Uint256(low=0, high=0), __warp_se_23);
        
        let (__warp_pse_1) = initialize_147825af(__warp_10_req, __warp_6_specId, __warp_7_callbackAddr, __warp_8_callbackFunctionSignature);
        
        
        
        return (__warp_pse_1,);

    }

    //  @notice Creates a Chainlink request to the specified oracle address
    // @dev Generates and stores a request ID, increments the local nonce, and uses `transferAndCall` to
    // send LINK which creates a request on the target oracle contract.
    // Emits ChainlinkRequested event.
    // @param oracleAddress The address of the oracle for the request
    // @param req The initialized Chainlink Request
    // @param payment The amount of LINK to send for the request
    // @return requestId The request ID
    func sendChainlinkRequestTo_9bca5ccd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_18_oracleAddress : felt, __warp_19_req : felt, __warp_20_payment : Uint256)-> (requestId : Uint256){
    alloc_locals;


        
        let (__warp_21_nonce) = WS1_READ_Uint256(__warp_4_s_requestCount);
        
        let (__warp_se_24) = warp_add256(__warp_21_nonce, Uint256(low=1, high=0));
        
        WS_WRITE1(__warp_4_s_requestCount, __warp_se_24);
        
        let (__warp_se_25) = WS0_READ_felt(__warp_0_SENDER_OVERRIDE);
        
        let (__warp_se_26) = wm_Request_3c7ee36d_id(__warp_19_req);
        
        let (__warp_se_27) = wm_read_256(__warp_se_26);
        
        let (__warp_se_28) = get_contract_address();
        
        let (__warp_se_29) = wm_Request_3c7ee36d_callbackFunctionId(__warp_19_req);
        
        let (__warp_se_30) = wm_read_felt(__warp_se_29);
        
        let (__warp_se_31) = wm_Request_3c7ee36d_buf(__warp_19_req);
        
        let (__warp_se_32) = wm_read_id(__warp_se_31, Uint256(low=3, high=0));
        
        let (__warp_se_33) = wm_buffer_7f2b9d9f_buf(__warp_se_32);
        
        let (__warp_se_34) = wm_read_id(__warp_se_33, Uint256(low=2, high=0));
        
        let (__warp_22_encodedRequest) = abi_encode_with_selector0(ChainlinkRequestInterface.oracleRequest_40429946.selector, __warp_se_25, Uint256(low=0, high=0), __warp_se_27, __warp_se_28, __warp_se_30, __warp_21_nonce, Uint256(low=1, high=0), __warp_se_34);
        
        let (__warp_pse_4) = _rawRequest_af64137f(__warp_18_oracleAddress, __warp_21_nonce, __warp_20_payment, __warp_22_encodedRequest);
        
        
        
        return (__warp_pse_4,);

    }

    //  @notice Make a request to an oracle
    // @param oracleAddress The address of the oracle for the request
    // @param nonce used to generate the request ID
    // @param payment The amount of LINK to send for the request
    // @param encodedRequest data encoded for request type specific format
    // @return requestId The request ID
    func _rawRequest_af64137f{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_31_oracleAddress : felt, __warp_32_nonce : Uint256, __warp_33_payment : Uint256, __warp_34_encodedRequest : felt)-> (__warp_35_requestId : Uint256){
    alloc_locals;


        
        let __warp_35_requestId = Uint256(low=0, high=0);
        
        let (__warp_se_35) = get_contract_address();
        
        let (__warp_se_36) = abi_encode_packed0(__warp_se_35, __warp_32_nonce);
        
        let (__warp_se_37) = warp_keccak(__warp_se_36);
        
        let __warp_35_requestId = __warp_se_37;
        
        let (__warp_se_38) = WS_INDEX_Uint256_to_felt0(__warp_5_s_pendingRequests, __warp_35_requestId);
        
        WS_WRITE0(__warp_se_38, __warp_31_oracleAddress);
        
        __warp_emit_ChainlinkRequested_b5e6e01e79f91267dc17b4e6314d5d4d03593d2ceee0fbb452b750bd70ea5af9(__warp_35_requestId);
        
        let (__warp_se_39) = WS3_READ_felt(__warp_2_s_link);
        
        let (__warp_se_40) = wm_to_calldata_dynamic_array0(__warp_34_encodedRequest);
        
        let (__warp_pse_7) = LinkTokenInterface_warped_interface.transferAndCall_4000aea0(__warp_se_39, __warp_31_oracleAddress, __warp_33_payment, __warp_se_40.len, __warp_se_40.ptr);
        
        warp_external_input_check_bool(__warp_pse_7);
        
        with_attr error_message("unable to transferAndCall to oracle"){
            assert __warp_pse_7 = 1;
        }
        
        
        
        return (__warp_35_requestId,);

    }

    //  @notice Sets the LINK token address
    // @param linkAddress The address of the LINK token contract
    func setChainlinkToken_31d0e3f5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_43_linkAddress : felt)-> (){
    alloc_locals;


        
        WS_WRITE3(__warp_2_s_link, __warp_43_linkAddress);
        
        
        
        return ();

    }


    func __warp_init_ChainlinkClient{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        WS_WRITE1(LINK_DIVISIBILITY, Uint256(low=1000000000000000000, high=0));
        
        WS_WRITE1(AMOUNT_OVERRIDE, Uint256(low=0, high=0));
        
        WS_WRITE0(__warp_0_SENDER_OVERRIDE, 0);
        
        WS_WRITE1(ORACLE_ARGS_VERSION, Uint256(low=1, high=0));
        
        WS_WRITE1(OPERATOR_ARGS_VERSION, Uint256(low=2, high=0));
        
        let (__warp_se_41) = wm2_dynamic_array(108, 105, 110, 107);
        
        let (__warp_se_42) = warp_keccak(__warp_se_41);
        
        WS_WRITE4(ENS_TOKEN_SUBNAME, __warp_se_42);
        
        let (__warp_se_43) = wm4_dynamic_array(111, 114, 97, 99, 108, 101);
        
        let (__warp_se_44) = warp_keccak(__warp_se_43);
        
        WS_WRITE4(ENS_ORACLE_SUBNAME, __warp_se_44);
        
        WS_WRITE0(__warp_1_LINK_TOKEN_POINTER, 1145273314170518648509224704101911030091525899633);
        
        WS_WRITE1(__warp_4_s_requestCount, Uint256(low=1, high=0));
        
        
        
        return ();

    }

    //  @notice Initializes a Chainlink request
    // @dev Sets the ID, callback address, and callback function signature on the request
    // @param self The uninitialized request
    // @param jobId The Job Specification ID
    // @param callbackAddr The callback address
    // @param callbackFunc The callback function signature
    // @return The initialized request
    func initialize_147825af{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_0_self : felt, __warp_1_jobId : Uint256, __warp_2_callbackAddr : felt, __warp_3_callbackFunc : felt)-> (__warp_4 : felt){
    alloc_locals;


        
        let (__warp_se_45) = wm_Request_3c7ee36d_buf(__warp_0_self);
        
        let (__warp_se_46) = wm_read_id(__warp_se_45, Uint256(low=3, high=0));
        
        init_48239d2c(__warp_se_46, Uint256(low=256, high=0));
        
        let (__warp_se_47) = wm_Request_3c7ee36d_id(__warp_0_self);
        
        wm_write_256(__warp_se_47, __warp_1_jobId);
        
        let (__warp_se_48) = wm_Request_3c7ee36d_callbackAddress(__warp_0_self);
        
        wm_write_felt(__warp_se_48, __warp_2_callbackAddr);
        
        let (__warp_se_49) = wm_Request_3c7ee36d_callbackFunctionId(__warp_0_self);
        
        wm_write_felt(__warp_se_49, __warp_3_callbackFunc);
        
        
        
        return (__warp_0_self,);

    }

    //  @notice Adds a string value to the request with a given key name
    // @param self The initialized request
    // @param key The name of the key
    // @param value The string value to add
    func add_6a265b1a{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_7_self : felt, __warp_8_key : felt, __warp_9_value : felt)-> (){
    alloc_locals;


        
        let (__warp_se_50) = wm_Request_3c7ee36d_buf(__warp_7_self);
        
        let (__warp_se_51) = wm_read_id(__warp_se_50, Uint256(low=3, high=0));
        
        encodeString_d994655b(__warp_se_51, __warp_8_key);
        
        let (__warp_se_52) = wm_Request_3c7ee36d_buf(__warp_7_self);
        
        let (__warp_se_53) = wm_read_id(__warp_se_52, Uint256(low=3, high=0));
        
        encodeString_d994655b(__warp_se_53, __warp_9_value);
        
        
        
        return ();

    }

    //  @notice Adds a int256 value to the request with a given key name
    // @param self The initialized request
    // @param key The name of the key
    // @param value The int256 value to add
    func addInt_f2aeaaaf{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_13_self : felt, __warp_14_key : felt, __warp_15_value : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_54) = wm_Request_3c7ee36d_buf(__warp_13_self);
        
        let (__warp_se_55) = wm_read_id(__warp_se_54, Uint256(low=3, high=0));
        
        encodeString_d994655b(__warp_se_55, __warp_14_key);
        
        let (__warp_se_56) = wm_Request_3c7ee36d_buf(__warp_13_self);
        
        let (__warp_se_57) = wm_read_id(__warp_se_56, Uint256(low=3, high=0));
        
        encodeInt_3803cb34(__warp_se_57, __warp_15_value);
        
        
        
        return ();

    }


    func __warp_init_Chainlink{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE1(defaultBufferSize, Uint256(low=256, high=0));
        
        
        
        return ();

    }

    //  @dev Initializes a buffer with an initial capacity.
    // @param buf The buffer to initialize.
    // @param capacity The number of bytes of space to allocate the buffer.
    // @return The buffer, for chaining.
    func init_48239d2c{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_0_buf : felt, __warp_1_capacity : Uint256)-> (__warp_2 : felt){
    alloc_locals;


        
        let (__warp_se_58) = warp_mod256(__warp_1_capacity, Uint256(low=32, high=0));
        
        let (__warp_se_59) = warp_neq256(__warp_se_58, Uint256(low=0, high=0));
        
            
            if (__warp_se_59 != 0){
            
                
                let (__warp_se_60) = warp_mod256(__warp_1_capacity, Uint256(low=32, high=0));
                
                let (__warp_se_61) = warp_sub256(Uint256(low=32, high=0), __warp_se_60);
                
                let (__warp_se_62) = warp_add256(__warp_1_capacity, __warp_se_61);
                
                let __warp_1_capacity = __warp_se_62;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar __warp_0_buf = __warp_0_buf;
                tempvar __warp_1_capacity = __warp_1_capacity;
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar __warp_0_buf = __warp_0_buf;
                tempvar __warp_1_capacity = __warp_1_capacity;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar __warp_0_buf = __warp_0_buf;
            tempvar __warp_1_capacity = __warp_1_capacity;
        
        let (__warp_se_63) = wm_buffer_7f2b9d9f_capacity(__warp_0_buf);
        
        wm_write_256(__warp_se_63, __warp_1_capacity);
        
        
        
        
        
        return (__warp_0_buf,);

    }


    func resize_1df1a454{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_6_buf : felt, __warp_7_capacity : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_64) = wm_buffer_7f2b9d9f_buf(__warp_6_buf);
        
        let (__warp_8_oldbuf) = wm_read_id(__warp_se_64, Uint256(low=2, high=0));
        
        init_48239d2c(__warp_6_buf, __warp_7_capacity);
        
        append_0b89dcd8(__warp_6_buf, __warp_8_oldbuf);
        
        
        
        return ();

    }


    func max_6d5433e6{range_check_ptr : felt}(__warp_9_a : Uint256, __warp_10_b : Uint256)-> (__warp_11 : Uint256){
    alloc_locals;


        
        let (__warp_se_65) = warp_gt256(__warp_9_a, __warp_10_b);
        
            
            if (__warp_se_65 != 0){
            
                
                
                
                return (__warp_9_a,);
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar __warp_10_b = __warp_10_b;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar __warp_10_b = __warp_10_b;
        
        
        
        return (__warp_10_b,);

    }

    //  @dev Writes a byte string to a buffer. Resizes if doing so would exceed
    //      the capacity of the buffer.
    // @param buf The buffer to append to.
    // @param off The start offset to write to.
    // @param data The data to append.
    // @param len The number of bytes to copy.
    // @return The original buffer, for chaining.
    func write_f57b867b{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_14_buf : felt, __warp_15_off : Uint256, __warp_16_data : felt, __warp_17_len : Uint256)-> (__warp_18 : felt){
    alloc_locals;


        
        let (__warp_se_66) = wm_dyn_array_length(__warp_16_data);
        
        let (__warp_se_67) = warp_le256(__warp_17_len, __warp_se_66);
        
        assert __warp_se_67 = 1;
        
        let (__warp_se_68) = warp_add256(__warp_15_off, __warp_17_len);
        
        let (__warp_se_69) = wm_buffer_7f2b9d9f_capacity(__warp_14_buf);
        
        let (__warp_se_70) = wm_read_256(__warp_se_69);
        
        let (__warp_se_71) = warp_gt256(__warp_se_68, __warp_se_70);
        
            
            if (__warp_se_71 != 0){
            
                
                let (__warp_se_72) = wm_buffer_7f2b9d9f_capacity(__warp_14_buf);
                
                let (__warp_se_73) = wm_read_256(__warp_se_72);
                
                let (__warp_se_74) = warp_add256(__warp_17_len, __warp_15_off);
                
                let (__warp_pse_9) = max_6d5433e6(__warp_se_73, __warp_se_74);
                
                let (__warp_se_75) = warp_mul256(__warp_pse_9, Uint256(low=2, high=0));
                
                resize_1df1a454(__warp_14_buf, __warp_se_75);
                tempvar warp_memory = warp_memory;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_14_buf = __warp_14_buf;
                tempvar __warp_17_len = __warp_17_len;
            }else{
            
                tempvar warp_memory = warp_memory;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_14_buf = __warp_14_buf;
                tempvar __warp_17_len = __warp_17_len;
            }
            tempvar warp_memory = warp_memory;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar __warp_14_buf = __warp_14_buf;
            tempvar __warp_17_len = __warp_17_len;
        
        let __warp_19_dest = Uint256(low=0, high=0);
        
        let __warp_20_src = Uint256(low=0, high=0);
        
        
        
            
                
                let (__warp_tv_3, __warp_tv_4, __warp_tv_5) = __warp_while7(__warp_17_len, __warp_19_dest, __warp_20_src);
                
                let __warp_20_src = __warp_tv_5;
                
                let __warp_19_dest = __warp_tv_4;
                
                let __warp_17_len = __warp_tv_3;
        
            
            let (__warp_se_76) = warp_sub_unsafe256(Uint256(low=32, high=0), __warp_17_len);
            
            let (__warp_se_77) = warp_exp_wide_unsafe256(Uint256(low=256, high=0), __warp_se_76);
            
            let (mask) = warp_sub_unsafe256(__warp_se_77, Uint256(low=1, high=0));
        
        
        
        return (__warp_14_buf,);

    }

    //  @dev Appends a byte string to a buffer. Resizes if doing so would exceed
    //      the capacity of the buffer.
    // @param buf The buffer to append to.
    // @param data The data to append.
    // @return The original buffer, for chaining.
    func append_0b89dcd8{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_25_buf : felt, __warp_26_data : felt)-> (__warp_27 : felt){
    alloc_locals;


        
        let (__warp_se_78) = wm_buffer_7f2b9d9f_buf(__warp_25_buf);
        
        let (__warp_se_79) = wm_read_id(__warp_se_78, Uint256(low=2, high=0));
        
        let (__warp_se_80) = wm_dyn_array_length(__warp_se_79);
        
        let (__warp_se_81) = wm_dyn_array_length(__warp_26_data);
        
        let (__warp_pse_11) = write_f57b867b(__warp_25_buf, __warp_se_80, __warp_26_data, __warp_se_81);
        
        
        
        return (__warp_pse_11,);

    }

    //  @dev Writes a byte to the buffer. Resizes if doing so would exceed the
    //      capacity of the buffer.
    // @param buf The buffer to append to.
    // @param off The offset to write the byte at.
    // @param data The data to append.
    // @return The original buffer, for chaining.
    func writeUint8_7fbdcb4a{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_28_buf : felt, __warp_29_off : Uint256, data : felt)-> (__warp_30 : felt){
    alloc_locals;


        
        let (__warp_se_82) = wm_buffer_7f2b9d9f_capacity(__warp_28_buf);
        
        let (__warp_se_83) = wm_read_256(__warp_se_82);
        
        let (__warp_se_84) = warp_ge256(__warp_29_off, __warp_se_83);
        
            
            if (__warp_se_84 != 0){
            
                
                let (__warp_se_85) = wm_buffer_7f2b9d9f_capacity(__warp_28_buf);
                
                let (__warp_se_86) = wm_read_256(__warp_se_85);
                
                let (__warp_se_87) = warp_mul256(__warp_se_86, Uint256(low=2, high=0));
                
                resize_1df1a454(__warp_28_buf, __warp_se_87);
                tempvar warp_memory = warp_memory;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_28_buf = __warp_28_buf;
            }else{
            
                tempvar warp_memory = warp_memory;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_28_buf = __warp_28_buf;
            }
            tempvar warp_memory = warp_memory;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar __warp_28_buf = __warp_28_buf;
        
        
        
        return (__warp_28_buf,);

    }

    //  @dev Appends a byte to the buffer. Resizes if doing so would exceed the
    //      capacity of the buffer.
    // @param buf The buffer to append to.
    // @param data The data to append.
    // @return The original buffer, for chaining.
    func appendUint8_bebc2ce5{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_31_buf : felt, __warp_32_data : felt)-> (__warp_33 : felt){
    alloc_locals;


        
        let (__warp_se_88) = wm_buffer_7f2b9d9f_buf(__warp_31_buf);
        
        let (__warp_se_89) = wm_read_id(__warp_se_88, Uint256(low=2, high=0));
        
        let (__warp_se_90) = wm_dyn_array_length(__warp_se_89);
        
        let (__warp_pse_12) = writeUint8_7fbdcb4a(__warp_31_buf, __warp_se_90, __warp_32_data);
        
        
        
        return (__warp_pse_12,);

    }

    //  @dev Writes an integer to the buffer. Resizes if doing so would exceed
    //      the capacity of the buffer.
    // @param buf The buffer to append to.
    // @param off The offset to write at.
    // @param data The data to append.
    // @param len The number of bytes to write (right-aligned).
    // @return The original buffer, for chaining.
    func writeInt_62273ea5{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_49_buf : felt, __warp_50_off : Uint256, data : Uint256, __warp_51_len : Uint256)-> (__warp_52 : felt){
    alloc_locals;


        
        let (__warp_se_91) = warp_add256(__warp_51_len, __warp_50_off);
        
        let (__warp_se_92) = wm_buffer_7f2b9d9f_capacity(__warp_49_buf);
        
        let (__warp_se_93) = wm_read_256(__warp_se_92);
        
        let (__warp_se_94) = warp_gt256(__warp_se_91, __warp_se_93);
        
            
            if (__warp_se_94 != 0){
            
                
                let (__warp_se_95) = warp_add256(__warp_51_len, __warp_50_off);
                
                let (__warp_se_96) = warp_mul256(__warp_se_95, Uint256(low=2, high=0));
                
                resize_1df1a454(__warp_49_buf, __warp_se_96);
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_49_buf = __warp_49_buf;
                tempvar __warp_51_len = __warp_51_len;
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_49_buf = __warp_49_buf;
                tempvar __warp_51_len = __warp_51_len;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar warp_memory = warp_memory;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar __warp_49_buf = __warp_49_buf;
            tempvar __warp_51_len = __warp_51_len;
        
        let (__warp_se_97) = warp_exp_wide256(Uint256(low=256, high=0), __warp_51_len);
        
        let (mask) = warp_sub256(__warp_se_97, Uint256(low=1, high=0));
        
        
        
        return (__warp_49_buf,);

    }

    //  @dev Appends a byte to the end of the buffer. Resizes if doing so would
    // exceed the capacity of the buffer.
    // @param buf The buffer to append to.
    // @param data The data to append.
    // @return The original buffer.
    func appendInt_f137d670{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_53_buf : felt, __warp_54_data : Uint256, __warp_55_len : Uint256)-> (__warp_56 : felt){
    alloc_locals;


        
        let (__warp_se_98) = wm_buffer_7f2b9d9f_buf(__warp_53_buf);
        
        let (__warp_se_99) = wm_read_id(__warp_se_98, Uint256(low=2, high=0));
        
        let (__warp_se_100) = wm_dyn_array_length(__warp_se_99);
        
        let (__warp_pse_16) = writeInt_62273ea5(__warp_53_buf, __warp_se_100, __warp_54_data, __warp_55_len);
        
        
        
        return (__warp_pse_16,);

    }


    func encodeFixedNumeric_1e15446d{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_0_buf : felt, __warp_1_major : felt, __warp_2_value : felt)-> (){
    alloc_locals;


        
        let (__warp_se_101) = warp_le(__warp_2_value, 23);
        
            
            if (__warp_se_101 != 0){
            
                
                let (__warp_se_102) = warp_shl8(__warp_1_major, 5);
                
                let (__warp_se_103) = warp_bitwise_or(__warp_se_102, __warp_2_value);
                
                let (__warp_se_104) = warp_int64_to_int8(__warp_se_103);
                
                appendUint8_bebc2ce5(__warp_0_buf, __warp_se_104);
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
            }else{
            
                
                let (__warp_se_105) = warp_le(__warp_2_value, 255);
                
                    
                    if (__warp_se_105 != 0){
                    
                        
                        let (__warp_se_106) = warp_shl8(__warp_1_major, 5);
                        
                        let (__warp_se_107) = warp_bitwise_or(__warp_se_106, 24);
                        
                        appendUint8_bebc2ce5(__warp_0_buf, __warp_se_107);
                        
                        let (__warp_se_108) = warp_uint256(__warp_2_value);
                        
                        appendInt_f137d670(__warp_0_buf, __warp_se_108, Uint256(low=1, high=0));
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                    }else{
                    
                        
                        let (__warp_se_109) = warp_le(__warp_2_value, 65535);
                        
                            
                            if (__warp_se_109 != 0){
                            
                                
                                let (__warp_se_110) = warp_shl8(__warp_1_major, 5);
                                
                                let (__warp_se_111) = warp_bitwise_or(__warp_se_110, 25);
                                
                                appendUint8_bebc2ce5(__warp_0_buf, __warp_se_111);
                                
                                let (__warp_se_112) = warp_uint256(__warp_2_value);
                                
                                appendInt_f137d670(__warp_0_buf, __warp_se_112, Uint256(low=2, high=0));
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar warp_memory = warp_memory;
                            }else{
                            
                                
                                let (__warp_se_113) = warp_le(__warp_2_value, 4294967295);
                                
                                    
                                    if (__warp_se_113 != 0){
                                    
                                        
                                        let (__warp_se_114) = warp_shl8(__warp_1_major, 5);
                                        
                                        let (__warp_se_115) = warp_bitwise_or(__warp_se_114, 26);
                                        
                                        appendUint8_bebc2ce5(__warp_0_buf, __warp_se_115);
                                        
                                        let (__warp_se_116) = warp_uint256(__warp_2_value);
                                        
                                        appendInt_f137d670(__warp_0_buf, __warp_se_116, Uint256(low=4, high=0));
                                        tempvar range_check_ptr = range_check_ptr;
                                        tempvar bitwise_ptr = bitwise_ptr;
                                        tempvar warp_memory = warp_memory;
                                    }else{
                                    
                                        
                                        let (__warp_se_117) = warp_shl8(__warp_1_major, 5);
                                        
                                        let (__warp_se_118) = warp_bitwise_or(__warp_se_117, 27);
                                        
                                        appendUint8_bebc2ce5(__warp_0_buf, __warp_se_118);
                                        
                                        let (__warp_se_119) = warp_uint256(__warp_2_value);
                                        
                                        appendInt_f137d670(__warp_0_buf, __warp_se_119, Uint256(low=8, high=0));
                                        tempvar range_check_ptr = range_check_ptr;
                                        tempvar bitwise_ptr = bitwise_ptr;
                                        tempvar warp_memory = warp_memory;
                                    }
                                    tempvar range_check_ptr = range_check_ptr;
                                    tempvar bitwise_ptr = bitwise_ptr;
                                    tempvar warp_memory = warp_memory;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar warp_memory = warp_memory;
                            }
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar warp_memory = warp_memory;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                    }
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
        
        
        
        return ();

    }


    func encodeInt_3803cb34{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_7_buf : felt, __warp_8_value : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_120) = warp_lt_signed256(__warp_8_value, Uint256(low=340282366920938463444927863358058659840, high=340282366920938463463374607431768211455));
        
            
            if (__warp_se_120 != 0){
            
                
                encodeSignedBigNum_9aeeba15(__warp_7_buf, __warp_8_value);
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
            }else{
            
                
                let (__warp_se_121) = warp_gt_signed256(__warp_8_value, Uint256(low=18446744073709551615, high=0));
                
                    
                    if (__warp_se_121 != 0){
                    
                        
                        encodeBigNum_34a05063(__warp_7_buf, __warp_8_value);
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                    }else{
                    
                        
                        let (__warp_se_122) = warp_ge_signed256(__warp_8_value, Uint256(low=0, high=0));
                        
                            
                            if (__warp_se_122 != 0){
                            
                                
                                let (__warp_se_123) = warp_int256_to_int64(__warp_8_value);
                                
                                encodeFixedNumeric_1e15446d(__warp_7_buf, 0, __warp_se_123);
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar warp_memory = warp_memory;
                            }else{
                            
                                
                                let (__warp_se_124) = warp_sub256(Uint256(low=340282366920938463463374607431768211455, high=340282366920938463463374607431768211455), __warp_8_value);
                                
                                let (__warp_se_125) = warp_int256_to_int64(__warp_se_124);
                                
                                encodeFixedNumeric_1e15446d(__warp_7_buf, 1, __warp_se_125);
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar warp_memory = warp_memory;
                            }
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar warp_memory = warp_memory;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                    }
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
        
        
        
        return ();

    }


    func encodeBytes_2df9cccd{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_9_buf : felt, __warp_10_value : felt)-> (){
    alloc_locals;


        
        let (__warp_se_126) = wm_dyn_array_length(__warp_10_value);
        
        let (__warp_se_127) = warp_int256_to_int64(__warp_se_126);
        
        encodeFixedNumeric_1e15446d(__warp_9_buf, 2, __warp_se_127);
        
        append_0b89dcd8(__warp_9_buf, __warp_10_value);
        
        
        
        return ();

    }


    func encodeBigNum_34a05063{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_11_buf : felt, __warp_12_value : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_128) = warp_shl8(6, 5);
        
        let (__warp_se_129) = warp_bitwise_or(__warp_se_128, 2);
        
        appendUint8_bebc2ce5(__warp_11_buf, __warp_se_129);
        
        let (__warp_se_130) = abi_encode0(__warp_12_value);
        
        encodeBytes_2df9cccd(__warp_11_buf, __warp_se_130);
        
        
        
        return ();

    }


    func encodeSignedBigNum_9aeeba15{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_13_buf : felt, __warp_14_input : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_131) = warp_shl8(6, 5);
        
        let (__warp_se_132) = warp_bitwise_or(__warp_se_131, 3);
        
        appendUint8_bebc2ce5(__warp_13_buf, __warp_se_132);
        
        let (__warp_se_133) = warp_sub256(Uint256(low=340282366920938463463374607431768211455, high=340282366920938463463374607431768211455), __warp_14_input);
        
        let (__warp_se_134) = abi_encode0(__warp_se_133);
        
        encodeBytes_2df9cccd(__warp_13_buf, __warp_se_134);
        
        
        
        return ();

    }


    func encodeString_d994655b{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_15_buf : felt, __warp_16_value : felt)-> (){
    alloc_locals;


        
        let (__warp_se_135) = wm_dyn_array_length(__warp_16_value);
        
        let (__warp_se_136) = warp_int256_to_int64(__warp_se_135);
        
        encodeFixedNumeric_1e15446d(__warp_15_buf, 3, __warp_se_136);
        
        append_0b89dcd8(__warp_15_buf, __warp_16_value);
        
        
        
        return ();

    }

}


    @external
    func requestEthereumPrice_d7f29c63{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        let (__warp_se_9) = get_contract_address();
        
        let (__warp_se_10) = get_contract_address();
        
        let (__warp_3_req) = ATestnetConsumerGoerli.buildChainlinkRequest_56db6353(Uint256(low=130557123987727948396541986100394419554, high=132098384927958332977776193301854631223), __warp_se_9, __warp_se_10.fulfillEthereumPrice_92cdaaf3.selector);
        
        let (__warp_se_11) = wm0_dynamic_array(103, 101, 116);
        
        let (__warp_se_12) = wm1_dynamic_array(104, 116, 116, 112, 115, 58, 47, 47, 109, 105, 110, 45, 97, 112, 105, 46, 99, 114, 121, 112, 116, 111, 99, 111, 109, 112, 97, 114, 101, 46, 99, 111, 109, 47, 100, 97, 116, 97, 47, 112, 114, 105, 99, 101, 63, 102, 115, 121, 109, 61, 69, 84, 72, 38, 116, 115, 121, 109, 115, 61, 85, 83, 68);
        
        ATestnetConsumerGoerli.add_6a265b1a(__warp_3_req, __warp_se_11, __warp_se_12);
        
        let (__warp_se_13) = wm2_dynamic_array(112, 97, 116, 104);
        
        let (__warp_se_14) = wm0_dynamic_array(85, 83, 68);
        
        ATestnetConsumerGoerli.add_6a265b1a(__warp_3_req, __warp_se_13, __warp_se_14);
        
        let (__warp_se_15) = wm3_dynamic_array(116, 105, 109, 101, 115);
        
        ATestnetConsumerGoerli.addInt_f2aeaaaf(__warp_3_req, __warp_se_15, Uint256(low=100, high=0));
        
        let (__warp_se_16) = WS0_READ_felt(ATestnetConsumerGoerli.__warp_0_oracleGoerli);
        
        let (__warp_se_17) = WS1_READ_Uint256(ATestnetConsumerGoerli.__warp_1_ORACLE_PAYMENT);
        
        ATestnetConsumerGoerli.sendChainlinkRequestTo_9bca5ccd(__warp_se_16, __warp_3_req, __warp_se_17);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func fulfillEthereumPrice_92cdaaf3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_4__requestId : Uint256, __warp_5__price : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_5__price);
        
        warp_external_input_check_int256(__warp_4__requestId);
        
        ATestnetConsumerGoerli.__warp_modifier_recordChainlinkFulfillment_fulfillEthereumPrice_92cdaaf3_3(__warp_4__requestId, __warp_4__requestId, __warp_5__price);
        
        let __warp_uv0 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func ORACLE_PAYMENT_a1fd4b34{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_6 : Uint256){
    alloc_locals;


        
        let (__warp_se_18) = WS1_READ_Uint256(ATestnetConsumerGoerli.__warp_1_ORACLE_PAYMENT);
        
        
        
        return (__warp_se_18,);

    }


    @view
    func currentPrice_9d1b464a{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_7 : Uint256){
    alloc_locals;


        
        let (__warp_se_19) = WS1_READ_Uint256(ATestnetConsumerGoerli.__warp_2_currentPrice);
        
        
        
        return (__warp_se_19,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(){
    alloc_locals;
    WARP_USED_STORAGE.write(29);
    WARP_NAMEGEN.write(1);
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        ATestnetConsumerGoerli.__warp_init_Chainlink();
        
        ATestnetConsumerGoerli.__warp_init_ChainlinkClient();
        
        ATestnetConsumerGoerli.__warp_init_ATestnetConsumerGoerli();
        
        ATestnetConsumerGoerli.__warp_constructor_0();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
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


// Contract Def OperatorInterface@interface


@contract_interface
namespace OperatorInterface_warped_interface{
func operatorRequest_3c6d41b9(sender : felt, payment : Uint256, specId : Uint256, callbackFunctionId : felt, nonce : Uint256, dataVersion : Uint256, data_len : felt, data : felt*)-> (){
}
func fulfillOracleRequest2_6ae0bc76(requestId : Uint256, payment : Uint256, callbackAddress : felt, callbackFunctionId : felt, expiration : Uint256, data_len : felt, data : felt*)-> (__warp_0 : felt){
}
func ownerTransferAndCall_902fc370(to : felt, value : Uint256, data_len : felt, data : felt*)-> (success : felt){
}
func distributeFunds_6bd59ec0(receivers_len : felt, receivers : felt*, amounts_len : felt, amounts : Uint256*)-> (){
}
func getAuthorizedSenders_2408afaa()-> (__warp_1_len : felt, __warp_1 : felt*){
}
func setAuthorizedSenders_ee56997b(senders_len : felt, senders : felt*)-> (){
}
func getForwarder_a0042526()-> (__warp_2 : felt){
}
func oracleRequest_40429946(sender : felt, requestPrice : Uint256, serviceAgreementID : Uint256, callbackAddress : felt, callbackFunctionId : felt, nonce : Uint256, dataVersion : Uint256, data_len : felt, data : felt*)-> (){
}
func cancelOracleRequest_6ee4d553(requestId : Uint256, payment : Uint256, callbackFunctionId : felt, expiration : Uint256)-> (){
}
func fulfillOracleRequest_4ab0d190(requestId : Uint256, payment : Uint256, callbackAddress : felt, callbackFunctionId : felt, expiration : Uint256, data : Uint256)-> (__warp_0 : felt){
}
func isAuthorizedSender_fa00763a(node : felt)-> (__warp_1 : felt){
}
func withdraw_f3fef3a3(recipient : felt, amount : Uint256)-> (){
}
func withdrawable_50188301()-> (__warp_2 : Uint256){
}
}


// Contract Def LinkTokenInterface@interface


@contract_interface
namespace LinkTokenInterface_warped_interface{
func allowance_dd62ed3e(owner : felt, spender : felt)-> (remaining : Uint256){
}
func approve_095ea7b3(spender : felt, value : Uint256)-> (success : felt){
}
func balanceOf_70a08231(owner : felt)-> (balance : Uint256){
}
func decimals_313ce567()-> (decimalPlaces : felt){
}
func decreaseApproval_66188463(spender : felt, addedValue : Uint256)-> (success : felt){
}
func increaseApproval_d73dd623(spender : felt, subtractedValue : Uint256)-> (){
}
func name_06fdde03()-> (tokenName_len : felt, tokenName : felt*){
}
func symbol_95d89b41()-> (tokenSymbol_len : felt, tokenSymbol : felt*){
}
func totalSupply_18160ddd()-> (totalTokensIssued : Uint256){
}
func transfer_a9059cbb(to : felt, value : Uint256)-> (success : felt){
}
func transferAndCall_4000aea0(to : felt, value : Uint256, data_len : felt, data : felt*)-> (success : felt){
}
func transferFrom_23b872dd(__warp_0_from : felt, to : felt, value : Uint256)-> (success : felt){
}
}


// Contract Def ENSInterface@interface


@contract_interface
namespace ENSInterface_warped_interface{
func setSubnodeOwner_06ab5923(node : Uint256, label : Uint256, owner : felt)-> (){
}
func setResolver_1896f70a(node : Uint256, resolver : felt)-> (){
}
func setOwner_5b0fc9c3(node : Uint256, owner : felt)-> (){
}
func setTTL_14ab9038(node : Uint256, ttl : felt)-> (){
}
func owner_02571be3(node : Uint256)-> (__warp_0 : felt){
}
func resolver_0178b8bf(node : Uint256)-> (__warp_1 : felt){
}
func ttl_16a25cbd(node : Uint256)-> (__warp_2 : felt){
}
}


// Contract Def ATestnetConsumerGoerli@interface


@contract_interface
namespace ATestnetConsumerGoerli_warped_interface_1{
func __warp_modifier_recordChainlinkFulfillment_fulfillEthereumPrice_92cdaaf3_14(__warp_49_requestId : Uint256, __warp_parameter___warp_4__requestId12 : Uint256, __warp_parameter___warp_5__price13 : Uint256)-> (){
}
func __warp_original_function_fulfillEthereumPrice_92cdaaf3_11(__warp_4__requestId : Uint256, __warp_5__price : Uint256)-> (){
}
func requestEthereumPrice_d7f29c63()-> (){
}
func fulfillEthereumPrice_92cdaaf3(__warp_4__requestId : Uint256, __warp_5__price : Uint256)-> (){
}
func ORACLE_PAYMENT_a1fd4b34()-> (__warp_6 : Uint256){
}
func currentPrice_9d1b464a()-> (__warp_7 : Uint256){
}
}


// Contract Def ChainlinkRequestInterface@interface


@contract_interface
namespace ChainlinkRequestInterface_warped_interface{
func oracleRequest_40429946(sender : felt, requestPrice : Uint256, serviceAgreementID : Uint256, callbackAddress : felt, callbackFunctionId : felt, nonce : Uint256, dataVersion : Uint256, data_len : felt, data : felt*)-> (){
}
func cancelOracleRequest_6ee4d553(requestId : Uint256, payment : Uint256, callbackFunctionId : felt, expiration : Uint256)-> (){
}
}


// Contract Def PointerInterface@interface


@contract_interface
namespace PointerInterface_warped_interface{
func getAddress_38cc4831()-> (__warp_0 : felt){
}
}