%lang starknet


from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from starkware.cairo.common.default_dict import default_dict_finalize, default_dict_new
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.uint256 import Uint256
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from warplib.dynamic_arrays_util import felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array, fixed_bytes256_to_felt_dynamic_array_spl
from warplib.keccak import felt_array_concat, pack_bytes_felt
from warplib.maths.add import warp_add256
from warplib.maths.eq import warp_eq, warp_eq256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int64
from warplib.maths.mod import warp_mod256
from warplib.maths.neq import warp_neq256
from warplib.maths.sub import warp_sub256
from warplib.maths.utils import felt_to_uint256, narrow_safe
from warplib.memory import wm_alloc, wm_index_dyn, wm_index_static, wm_new, wm_read_256, wm_read_felt, wm_read_id, wm_to_felt_array, wm_write_256


@storage_var
func WARP_MAPPING0(name: felt, index: felt) -> (resLoc : felt){
}


@storage_var
func WARP_MAPPING1(name: felt, index: Uint256) -> (resLoc : felt){
}


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}


struct cd_dynarray_Uint256{
     len : felt ,
     ptr : Uint256*,
}


func __warp_emit_DiceLanded_54d97c1f7e5abad75bd421455cd4dd296852a52e1ea721f2cdb66d06fa2082a9{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x6852a52e1ea721f2cdb66d06fa2082a9, 0x54d97c1f7e5abad75bd421455cd4dd29);// keccak of event signature: DiceLanded(uint256,uint256)
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
   let (mem_encode: felt) = abi_encode2();
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}


func __warp_emit_DiceRolled_3e7fdeab84c01ce5308321caa0b460e1c4ec3c7099223d79634d9a71d99932e3{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : felt){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0xc4ec3c7099223d79634d9a71d99932e3, 0x3e7fdeab84c01ce5308321caa0b460e1);// keccak of event signature: DiceRolled(uint256,address)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode1(param1);
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


func cd_to_memory_dynamic_array0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata: Uint256*, mem_start: felt, length: felt){
    alloc_locals;
    if (length == 0){
        return ();
    }
dict_write{dict_ptr=warp_memory}(mem_start, calldata[0].low);
dict_write{dict_ptr=warp_memory}(mem_start+1, calldata[0].high);
    return cd_to_memory_dynamic_array0_elem(calldata + 2, mem_start + 2, length - 1);
}
func cd_to_memory_dynamic_array0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(calldata : cd_dynarray_Uint256) -> (mem_loc: felt){
    alloc_locals;
    let (len256) = felt_to_uint256(calldata.len);
    let (mem_start) = wm_new(len256, Uint256(0x2, 0x0));
    cd_to_memory_dynamic_array0_elem(calldata.ptr, mem_start + 2, calldata.len);
    return (mem_start,);
}


func external_input_check_dynamic_array0{range_check_ptr : felt}(len: felt, ptr : Uint256*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
    warp_external_input_check_int256(ptr[0]);
    external_input_check_dynamic_array0(len = len - 1, ptr = ptr + 2);
    return ();
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


func wm0_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt, e8: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0xb, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x9, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
dict_write{dict_ptr=warp_memory}(start + 7, e5);
dict_write{dict_ptr=warp_memory}(start + 8, e6);
dict_write{dict_ptr=warp_memory}(start + 9, e7);
dict_write{dict_ptr=warp_memory}(start + 10, e8);
    return (start,);
}


func wm1_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt) -> (loc: felt){
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


func wm2_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt) -> (loc: felt){
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


func wm3_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x9, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x7, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
dict_write{dict_ptr=warp_memory}(start + 7, e5);
dict_write{dict_ptr=warp_memory}(start + 8, e6);
    return (start,);
}


func wm4_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x6, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x4, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
    return (start,);
}


func wm5_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0xa, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x8, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
dict_write{dict_ptr=warp_memory}(start + 7, e5);
dict_write{dict_ptr=warp_memory}(start + 8, e6);
dict_write{dict_ptr=warp_memory}(start + 9, e7);
    return (start,);
}


func wm6_static_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt, e8: felt, e9: felt, e10: felt, e11: felt, e12: felt, e13: felt, e14: felt, e15: felt, e16: felt, e17: felt, e18: felt, e19: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x14, 0x0));
dict_write{dict_ptr=warp_memory}(start, e0);
dict_write{dict_ptr=warp_memory}(start + 1, e1);
dict_write{dict_ptr=warp_memory}(start + 2, e2);
dict_write{dict_ptr=warp_memory}(start + 3, e3);
dict_write{dict_ptr=warp_memory}(start + 4, e4);
dict_write{dict_ptr=warp_memory}(start + 5, e5);
dict_write{dict_ptr=warp_memory}(start + 6, e6);
dict_write{dict_ptr=warp_memory}(start + 7, e7);
dict_write{dict_ptr=warp_memory}(start + 8, e8);
dict_write{dict_ptr=warp_memory}(start + 9, e9);
dict_write{dict_ptr=warp_memory}(start + 10, e10);
dict_write{dict_ptr=warp_memory}(start + 11, e11);
dict_write{dict_ptr=warp_memory}(start + 12, e12);
dict_write{dict_ptr=warp_memory}(start + 13, e13);
dict_write{dict_ptr=warp_memory}(start + 14, e14);
dict_write{dict_ptr=warp_memory}(start + 15, e15);
dict_write{dict_ptr=warp_memory}(start + 16, e16);
dict_write{dict_ptr=warp_memory}(start + 17, e17);
dict_write{dict_ptr=warp_memory}(start + 18, e18);
dict_write{dict_ptr=warp_memory}(start + 19, e19);
    return (start,);
}


func WS_INDEX_felt_to_Uint2560{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
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


func WS_INDEX_Uint256_to_felt1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: Uint256) -> (res: felt){
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


func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}


func WS_WRITE1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}


func WS_WRITE2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
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


func WS_WRITE5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}


func WS_WRITE6{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
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


func WS2_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}


func WS3_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}


func WS4_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}


func WS5_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}


func WS6_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}


// Contract Def VRFD20

//  THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED VALUES FOR CLARITY.
// THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
// DO NOT USE THIS CODE IN PRODUCTION.


// @event
// func DiceRolled(requestId : Uint256, roller : felt){
// }


// @event
// func DiceLanded(requestId : Uint256, result : Uint256){
// }

namespace VRFD20{

    // Dynamic variables - Arrays and Maps

    const __warp_8_s_rollers = 1;

    const __warp_9_s_results = 2;

    // Static variables

    const ROLL_IN_PROGRESS = 0;

    const __warp_0_COORDINATOR = 2;

    const __warp_1_s_subscriptionId = 3;

    const __warp_2_vrfCoordinator = 4;

    const __warp_3_s_keyHash = 5;

    const __warp_4_callbackGasLimit = 7;

    const __warp_5_requestConfirmations = 8;

    const __warp_6_numWords = 9;

    const __warp_7_s_owner = 10;

    const __warp_0_vrfCoordinator = 13;


    func __warp_modifier_onlyOwner_rollDice_dd02d9e5_4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_11_roller1 : felt, __warp_parameter___warp_12_requestId_m_capture2 : Uint256)-> (__warp_ret_parameter___warp_12_requestId3 : Uint256){
    alloc_locals;


        
        let __warp_ret_parameter___warp_12_requestId3 = Uint256(low=0, high=0);
        
        let (__warp_se_0) = get_caller_address();
        
        let (__warp_se_1) = WS0_READ_felt(__warp_7_s_owner);
        
        let (__warp_se_2) = warp_eq(__warp_se_0, __warp_se_1);
        
        assert __warp_se_2 = 1;
        
        let (__warp_pse_0) = __warp_original_function_rollDice_dd02d9e5_0(__warp_parameter___warp_11_roller1, __warp_parameter___warp_12_requestId_m_capture2);
        
        let __warp_ret_parameter___warp_12_requestId3 = __warp_pse_0;
        
        
        
        return (__warp_ret_parameter___warp_12_requestId3,);

    }

    //  @notice Requests randomness
    // @dev Warning: if the VRF response is delayed, avoid calling requestRandomness repeatedly
    // as that would give miners/VRF operators latitude about which VRF response arrives first.
    // @dev You must review your implementation details with extreme care.
    // @param roller address of the roller
    func __warp_original_function_rollDice_dd02d9e5_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_11_roller : felt, __warp_12_requestId_m_capture : Uint256)-> (__warp_12_requestId : Uint256){
    alloc_locals;


        
        let __warp_12_requestId = Uint256(low=0, high=0);
        
        let __warp_12_requestId = __warp_12_requestId_m_capture;
        
        let (__warp_se_3) = WS_INDEX_felt_to_Uint2560(__warp_9_s_results, __warp_11_roller);
        
        let (__warp_se_4) = WS1_READ_Uint256(__warp_se_3);
        
        let (__warp_se_5) = warp_eq256(__warp_se_4, Uint256(low=0, high=0));
        
        with_attr error_message("Already rolled"){
            assert __warp_se_5 = 1;
        }
        
        let (__warp_se_6) = WS2_READ_felt(__warp_0_COORDINATOR);
        
        let (__warp_se_7) = WS3_READ_Uint256(__warp_3_s_keyHash);
        
        let (__warp_se_8) = WS4_READ_felt(__warp_1_s_subscriptionId);
        
        let (__warp_se_9) = WS5_READ_felt(__warp_5_requestConfirmations);
        
        let (__warp_se_10) = WS6_READ_felt(__warp_4_callbackGasLimit);
        
        let (__warp_se_11) = WS6_READ_felt(__warp_6_numWords);
        
        let (__warp_pse_1) = VRFCoordinatorV2Interface_warped_interface.requestRandomWords_5d3b1d30(__warp_se_6, __warp_se_7, __warp_se_8, __warp_se_9, __warp_se_10, __warp_se_11);
        
        warp_external_input_check_int256(__warp_pse_1);
        
        let __warp_12_requestId = __warp_pse_1;
        
        let (__warp_se_12) = WS_INDEX_Uint256_to_felt1(__warp_8_s_rollers, __warp_12_requestId);
        
        WS_WRITE0(__warp_se_12, __warp_11_roller);
        
        let (__warp_se_13) = WS_INDEX_felt_to_Uint2560(__warp_9_s_results, __warp_11_roller);
        
        WS_WRITE1(__warp_se_13, Uint256(low=42, high=0));
        
        __warp_emit_DiceRolled_3e7fdeab84c01ce5308321caa0b460e1c4ec3c7099223d79634d9a71d99932e3(__warp_12_requestId, __warp_11_roller);
        
        
        
        return (__warp_12_requestId,);

    }

    //  @notice Constructor inherits VRFConsumerBaseV2
    // @dev NETWORK: Sepolia
    // @param subscriptionId subscription id that this consumer contract can use
    func __warp_constructor_2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_10_subscriptionId : felt)-> (){
    alloc_locals;


        
        let (__warp_se_14) = WS0_READ_felt(__warp_2_vrfCoordinator);
        
        WS_WRITE2(__warp_0_COORDINATOR, __warp_se_14);
        
        let (__warp_se_15) = get_caller_address();
        
        WS_WRITE0(__warp_7_s_owner, __warp_se_15);
        
        WS_WRITE3(__warp_1_s_subscriptionId, __warp_10_subscriptionId);
        
        
        
        return ();

    }

    //  @notice Callback function used by VRF Coordinator to return the random number to this contract.
    // @dev Some action on the contract state should be taken here, like storing the result.
    // @dev WARNING: take care to avoid having multiple VRF requests in flight if their order of arrival would result
    // in contract states with different outcomes. Otherwise miners or the VRF operator would could take advantage
    // by controlling the order.
    // @dev The VRF Coordinator will only send this function verified responses, and the parent VRFConsumerBaseV2
    // contract ensures that this method only receives randomness from the designated VRFCoordinator.
    // @param requestId uint256
    // @param randomWords  uint256[] The random result returned by the oracle.
    func fulfillRandomWords_38ba4614{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_13_requestId : Uint256, __warp_14_randomWords : felt)-> (){
    alloc_locals;


        
        let (__warp_se_16) = wm_index_dyn(__warp_14_randomWords, Uint256(low=0, high=0), Uint256(low=2, high=0));
        
        let (__warp_se_17) = wm_read_256(__warp_se_16);
        
        let (__warp_se_18) = warp_mod256(__warp_se_17, Uint256(low=20, high=0));
        
        let (__warp_15_d20Value) = warp_add256(__warp_se_18, Uint256(low=1, high=0));
        
        let (__warp_se_19) = WS_INDEX_Uint256_to_felt1(__warp_8_s_rollers, __warp_13_requestId);
        
        let (__warp_se_20) = WS0_READ_felt(__warp_se_19);
        
        let (__warp_se_21) = WS_INDEX_felt_to_Uint2560(__warp_9_s_results, __warp_se_20);
        
        WS_WRITE1(__warp_se_21, __warp_15_d20Value);
        
        __warp_emit_DiceLanded_54d97c1f7e5abad75bd421455cd4dd296852a52e1ea721f2cdb66d06fa2082a9(__warp_13_requestId, __warp_15_d20Value);
        
        
        
        return ();

    }

    //  @notice Get the house name from the id
    // @param id uint256
    // @return house name string
    func getHouseName_853982b9{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_18_id : Uint256)-> (__warp_19 : felt){
    alloc_locals;


        
        let (__warp_se_31) = wm0_dynamic_array(84, 97, 114, 103, 97, 114, 121, 101, 110);
        
        let (__warp_se_32) = wm0_dynamic_array(76, 97, 110, 110, 105, 115, 116, 101, 114);
        
        let (__warp_se_33) = wm1_dynamic_array(83, 116, 97, 114, 107);
        
        let (__warp_se_34) = wm2_dynamic_array(84, 121, 114, 101, 108, 108);
        
        let (__warp_se_35) = wm0_dynamic_array(66, 97, 114, 97, 116, 104, 101, 111, 110);
        
        let (__warp_se_36) = wm3_dynamic_array(77, 97, 114, 116, 101, 108, 108);
        
        let (__warp_se_37) = wm1_dynamic_array(84, 117, 108, 108, 121);
        
        let (__warp_se_38) = wm2_dynamic_array(66, 111, 108, 116, 111, 110);
        
        let (__warp_se_39) = wm3_dynamic_array(71, 114, 101, 121, 106, 111, 121);
        
        let (__warp_se_40) = wm1_dynamic_array(65, 114, 114, 121, 110);
        
        let (__warp_se_41) = wm4_dynamic_array(70, 114, 101, 121);
        
        let (__warp_se_42) = wm3_dynamic_array(77, 111, 114, 109, 111, 110, 116);
        
        let (__warp_se_43) = wm2_dynamic_array(84, 97, 114, 108, 101, 121);
        
        let (__warp_se_44) = wm1_dynamic_array(68, 97, 121, 110, 101);
        
        let (__warp_se_45) = wm1_dynamic_array(85, 109, 98, 101, 114);
        
        let (__warp_se_46) = wm5_dynamic_array(86, 97, 108, 101, 114, 121, 111, 110);
        
        let (__warp_se_47) = wm5_dynamic_array(77, 97, 110, 100, 101, 114, 108, 121);
        
        let (__warp_se_48) = wm3_dynamic_array(67, 108, 101, 103, 97, 110, 101);
        
        let (__warp_se_49) = wm2_dynamic_array(71, 108, 111, 118, 101, 114);
        
        let (__warp_se_50) = wm5_dynamic_array(75, 97, 114, 115, 116, 97, 114, 107);
        
        let (__warp_20_houseNames) = wm6_static_array(__warp_se_31, __warp_se_32, __warp_se_33, __warp_se_34, __warp_se_35, __warp_se_36, __warp_se_37, __warp_se_38, __warp_se_39, __warp_se_40, __warp_se_41, __warp_se_42, __warp_se_43, __warp_se_44, __warp_se_45, __warp_se_46, __warp_se_47, __warp_se_48, __warp_se_49, __warp_se_50);
        
        let (__warp_se_51) = warp_sub256(__warp_18_id, Uint256(low=1, high=0));
        
        let (__warp_se_52) = wm_index_static(__warp_20_houseNames, __warp_se_51, Uint256(low=1, high=0), Uint256(low=20, high=0));
        
        let (__warp_se_53) = wm_read_id(__warp_se_52, Uint256(low=2, high=0));
        
        
        
        return (__warp_se_53,);

    }


    func __warp_init_VRFD20{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE1(ROLL_IN_PROGRESS, Uint256(low=42, high=0));
        
        WS_WRITE0(__warp_2_vrfCoordinator, 736542100814370719003330277217658782188674893349);
        
        WS_WRITE4(__warp_3_s_keyHash, Uint256(low=78738201360042078857422061107830048108, high=94781254254598860265360451337420016050));
        
        WS_WRITE5(__warp_4_callbackGasLimit, 40000);
        
        WS_WRITE6(__warp_5_requestConfirmations, 3);
        
        WS_WRITE5(__warp_6_numWords, 1);
        
        
        
        return ();

    }

    //  @param _vrfCoordinator address of VRFCoordinator contract
    func __warp_constructor_1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_1__vrfCoordinator : felt)-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_vrfCoordinator, __warp_1__vrfCoordinator);
        
        
        
        return ();

    }

}

    //  @notice Requests randomness
    // @dev Warning: if the VRF response is delayed, avoid calling requestRandomness repeatedly
    // as that would give miners/VRF operators latitude about which VRF response arrives first.
    // @dev You must review your implementation details with extreme care.
    // @param roller address of the roller
    @external
    func rollDice_dd02d9e5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_11_roller : felt)-> (__warp_12_requestId : Uint256){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_address(__warp_11_roller);
        
        let __warp_12_requestId = Uint256(low=0, high=0);
        
        let (__warp_pse_2) = VRFD20.__warp_modifier_onlyOwner_rollDice_dd02d9e5_4(__warp_11_roller, __warp_12_requestId);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (__warp_pse_2,);
    }
    }

    //  @notice Get the house assigned to the player once the address has rolled
    // @param player address
    // @return house as a string
    @view
    func house_b1cad5e3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_16_player : felt)-> (__warp_17_len : felt, __warp_17 : felt*){
    alloc_locals;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        warp_external_input_check_address(__warp_16_player);
        
        let (__warp_se_22) = WS_INDEX_felt_to_Uint2560(VRFD20.__warp_9_s_results, __warp_16_player);
        
        let (__warp_se_23) = WS1_READ_Uint256(__warp_se_22);
        
        let (__warp_se_24) = warp_neq256(__warp_se_23, Uint256(low=0, high=0));
        
        with_attr error_message("Dice not rolled"){
            assert __warp_se_24 = 1;
        }
        
        let (__warp_se_25) = WS_INDEX_felt_to_Uint2560(VRFD20.__warp_9_s_results, __warp_16_player);
        
        let (__warp_se_26) = WS1_READ_Uint256(__warp_se_25);
        
        let (__warp_se_27) = warp_neq256(__warp_se_26, Uint256(low=42, high=0));
        
        with_attr error_message("Roll in progress"){
            assert __warp_se_27 = 1;
        }
        
        let (__warp_se_28) = WS_INDEX_felt_to_Uint2560(VRFD20.__warp_9_s_results, __warp_16_player);
        
        let (__warp_se_29) = WS1_READ_Uint256(__warp_se_28);
        
        let (__warp_pse_3) = VRFD20.getHouseName_853982b9(__warp_se_29);
        
        let (__warp_se_30) = wm_to_calldata_dynamic_array0(__warp_pse_3);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return (__warp_se_30.len, __warp_se_30.ptr,);
    }
    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_10_subscriptionId : felt){
    alloc_locals;
    WARP_USED_STORAGE.write(14);
    WARP_NAMEGEN.write(2);


        
        warp_external_input_check_int64(__warp_10_subscriptionId);
        
        let (__warp_constructor_parameter_0) = WS0_READ_felt(VRFD20.__warp_2_vrfCoordinator);
        
        VRFD20.__warp_constructor_1(__warp_constructor_parameter_0);
        
        VRFD20.__warp_init_VRFD20();
        
        VRFD20.__warp_constructor_2(__warp_10_subscriptionId);
        
        
        
        return ();

    }


    @external
    func rawFulfillRandomWords_1fe543e3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_2_requestId : Uint256, __warp_3_randomWords_len : felt, __warp_3_randomWords : Uint256*)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        external_input_check_dynamic_array0(__warp_3_randomWords_len, __warp_3_randomWords);
        
        warp_external_input_check_int256(__warp_2_requestId);
        
        local __warp_3_randomWords_dstruct : cd_dynarray_Uint256 = cd_dynarray_Uint256(__warp_3_randomWords_len, __warp_3_randomWords);
        
        let (__warp_3_randomWords_mem) = cd_to_memory_dynamic_array0(__warp_3_randomWords_dstruct);
        
        let (__warp_se_54) = get_caller_address();
        
        let (__warp_se_55) = WS0_READ_felt(VRFD20.__warp_0_vrfCoordinator);
        
        let (__warp_se_56) = warp_eq(__warp_se_54, __warp_se_55);
        
        with_attr error_message("OnlyCoordinatorCanFulfill"){
            assert __warp_se_56 = 1;
        }
        
        VRFD20.fulfillRandomWords_38ba4614(__warp_2_requestId, __warp_3_randomWords_mem);
        
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


// Contract Def VRFCoordinatorV2Interface@interface


@contract_interface
namespace VRFCoordinatorV2Interface_warped_interface{
func getRequestConfig_00012291()-> (__warp_0 : felt, __warp_1 : felt, __warp_2_len : felt, __warp_2 : Uint256*){
}
func requestRandomWords_5d3b1d30(keyHash : Uint256, subId : felt, minimumRequestConfirmations : felt, callbackGasLimit : felt, numWords : felt)-> (requestId : Uint256){
}
func createSubscription_a21a23e4()-> (subId : felt){
}
func getSubscription_a47c7696(subId : felt)-> (balance : felt, reqCount : felt, owner : felt, consumers_len : felt, consumers : felt*){
}
func requestSubscriptionOwnerTransfer_04c357cb(subId : felt, newOwner : felt)-> (){
}
func acceptSubscriptionOwnerTransfer_82359740(subId : felt)-> (){
}
func addConsumer_7341c10c(subId : felt, consumer : felt)-> (){
}
func removeConsumer_9f87fad7(subId : felt, consumer : felt)-> (){
}
func cancelSubscription_d7ae1d30(subId : felt, to : felt)-> (){
}
func pendingRequestExists_e82ad7d4(subId : felt)-> (__warp_3 : felt){
}
}