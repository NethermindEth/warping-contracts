%lang starknet


from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from starkware.cairo.common.default_dict import default_dict_finalize, default_dict_new
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.dict import dict_read, dict_write
from starkware.cairo.common.uint256 import Uint256, uint256_add, uint256_eq, uint256_lt, uint256_sub
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from warplib.dynamic_arrays_util import bytes_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array, fixed_bytes256_to_felt_dynamic_array_spl
from warplib.keccak import felt_array_concat, pack_bytes_felt
from warplib.maths.add_unsafe import warp_add_unsafe256
from warplib.maths.add import warp_add256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int8
from warplib.maths.int_conversions import warp_uint256
from warplib.maths.neq import warp_neq256
from warplib.maths.sub import warp_sub256
from warplib.maths.utils import felt_to_uint256, narrow_safe
from warplib.memory import wm_alloc, wm_dyn_array_length, wm_new, wm_read_256, wm_read_felt, wm_to_felt_array, wm_write_256


@storage_var
func WARP_DARRAY0_felt(name: felt, index: Uint256) -> (res_loc : felt){
}


@storage_var
func WARP_DARRAY0_felt_LENGTH(name: felt) -> (length: Uint256){
}


@storage_var
func WARP_MAPPING0(name: felt, index: felt) -> (resLoc : felt){
}


@storage_var
func WARP_MAPPING1(name: felt, index: felt) -> (resLoc : felt){
}


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}


func __warp_emit_Approval_8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0xdd0314c0f7b2291e5b200ac8c7c3b925, 0x8c5be1e5ebec7d5bd14f71427d1e84f3);// keccak of event signature: Approval(address,address,uint256)
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
   let (mem_encode: felt) = abi_encode2(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}


func __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x952ba7f163c4a11628f55a4df523b3ef, 0xddf252ad1be2c89b69c2b068fc378daa);// keccak of event signature: Transfer(address,address,uint256)
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
   let (mem_encode: felt) = abi_encode2(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}


func __warp_emit_Transfer_e19260aff97b920c7df27010903aeb9c8d2be5d310a2c67824cf3f15396e4c16{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : Uint256, param3 : felt){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x8d2be5d310a2c67824cf3f15396e4c16, 0xe19260aff97b920c7df27010903aeb9c);// keccak of event signature: Transfer(address,address,uint256,bytes)
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
   let (mem_encode: felt) = abi_encode1(param2,param3);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
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


func abi_encode1{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : Uint256, param1 : felt) -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 64;
  let (bytes_array : felt*) = alloc();
fixed_bytes256_to_felt_dynamic_array(bytes_index, bytes_array, 0, param0);
let bytes_index = bytes_index + 32;
let (bytes_index, bytes_offset) = bytes_to_felt_dynamic_array(
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


func abi_encode2{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : Uint256) -> (result_ptr : felt){
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
    warp_external_input_check_int8(ptr[0]);
    external_input_check_dynamic_array0(len = len - 1, ptr = ptr + 1);
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


func wm_to_storage_dynamic_array0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(storage_name: felt, mem_loc : felt, length: Uint256) -> (){
    alloc_locals;
    if (length.low == 0 and length.high == 0){
        return ();
    }
    let (index) = uint256_sub(length, Uint256(1,0));
    let (storage_loc) = WARP_DARRAY0_felt.read(storage_name, index);
    let mem_loc = mem_loc - 1;
    if (storage_loc == 0){
        let (storage_loc) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(storage_loc + 1);
        WARP_DARRAY0_felt.write(storage_name, index, storage_loc);
            let (copy) = dict_read{dict_ptr=warp_memory}(mem_loc);
    WARP_STORAGE.write(storage_loc, copy);
    return wm_to_storage_dynamic_array0_elem(storage_name, mem_loc, index);
    }else{
            let (copy) = dict_read{dict_ptr=warp_memory}(mem_loc);
    WARP_STORAGE.write(storage_loc, copy);
    return wm_to_storage_dynamic_array0_elem(storage_name, mem_loc, index);
    }
}
func wm_to_storage_dynamic_array0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(loc : felt, mem_loc : felt) -> (loc : felt){
    alloc_locals;
    let (length) = WARP_DARRAY0_felt_LENGTH.read(loc);
    let (mem_length) = wm_dyn_array_length(mem_loc);
    WARP_DARRAY0_felt_LENGTH.write(loc, mem_length);
    let (narrowedLength) = narrow_safe(mem_length);
    wm_to_storage_dynamic_array0_elem(loc, mem_loc + 2 + 1 * narrowedLength, mem_length);
    let (lesser) = uint256_lt(mem_length, length);
    if (lesser == 1){
       WS0_DYNAMIC_ARRAY_DELETE_elem(loc, mem_length, length);
       return (loc,);
    }else{
       return (loc,);
    }
}


func wm0_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt, e8: felt, e9: felt, e10: felt, e11: felt, e12: felt, e13: felt, e14: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x11, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0xf, 0x0));
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
    return (start,);
}


func wm1_dynamic_array{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x6, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x4, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
    return (start,);
}


func ws_dynamic_array_to_calldata0_write{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(
   loc : felt,
   index : felt,
   len : felt,
   ptr : felt*) -> (ptr : felt*){
   alloc_locals;
   if (len == index){
       return (ptr,);
   }
   let (index_uint256) = warp_uint256(index);
   let (elem_loc) = WARP_DARRAY0_felt.read(loc, index_uint256);
   let (elem) = WS1_READ_felt(elem_loc);
   assert ptr[index] = elem;
   return ws_dynamic_array_to_calldata0_write(loc, index + 1, len, ptr);
}
func ws_dynamic_array_to_calldata0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt) -> (dyn_array_struct : cd_dynarray_felt){
   alloc_locals;
   let (len_uint256) = WARP_DARRAY0_felt_LENGTH.read(loc);
   let len = len_uint256.low + len_uint256.high*128;
   let (ptr : felt*) = alloc();
   let (ptr : felt*) = ws_dynamic_array_to_calldata0_write(loc, 0, len, ptr);
   let dyn_array_struct = cd_dynarray_felt(len, ptr);
   return (dyn_array_struct,);
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


func WS_INDEX_felt_to_warp_id1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
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


func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}


func WS_WRITE1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}


func WS0_DYNAMIC_ARRAY_DELETE_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt, index : Uint256, length : Uint256){
     alloc_locals;
     let (stop) = uint256_eq(index, length);
     if (stop == 1){
        return ();
     }
     let (elem_loc) = WARP_DARRAY0_felt.read(loc, index);
    WS1_GENERIC_DELETE(elem_loc);
     let (next_index, _) = uint256_add(index, Uint256(0x1, 0x0));
     return WS0_DYNAMIC_ARRAY_DELETE_elem(loc, next_index, length);
}
func WS0_DYNAMIC_ARRAY_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt){
   alloc_locals;
   let (length) = WARP_DARRAY0_felt_LENGTH.read(loc);
   WARP_DARRAY0_felt_LENGTH.write(loc, Uint256(0x0, 0x0));
   return WS0_DYNAMIC_ARRAY_DELETE_elem(loc, Uint256(0x0, 0x0), length);
}


func WS0_READ_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = readId(loc);
    return (read0,);
}


func WS1_GENERIC_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt){
    WARP_STORAGE.write(loc, 0);
    return ();
}


func WS1_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}


func WS2_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
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


// Contract Def LinkTokenExperimental


// @event
// func Transfer(__warp_0_from : felt, to : felt, value : Uint256, data : felt){
// }


// @event
// func Approval(owner : felt, spender : felt, amount : Uint256){
// }


// @event
// func Transfer(__warp_6_from : felt, to : felt, amount : Uint256){
// }

namespace LinkTokenExperimental{

    // Dynamic variables - Arrays and Maps

    const NAME = 1;

    const SYMBOL = 2;

    const __warp_0_name = 3;

    const __warp_1_symbol = 4;

    const __warp_4_balanceOf = 5;

    const __warp_5_allowance = 6;

    // Static variables

    const TOTAL_SUPPLY = 0;

    const __warp_2_decimals = 6;

    const __warp_3_totalSupply = 7;


    func __warp_constructor_4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_se_0) = get_caller_address();
        
        _mint_4e6ec247(__warp_se_0, Uint256(low=1000000000000000000000000000, high=0));
        
        
        
        return ();

    }


    func __warp_init_LinkTokenExperimental{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}()-> (){
    alloc_locals;


        
        WS_WRITE0(TOTAL_SUPPLY, Uint256(low=1000000000000000000000000000, high=0));
        
        let (wm_NAME) = wm0_dynamic_array(67, 104, 97, 105, 110, 76, 105, 110, 107, 32, 84, 111, 107, 101, 110);
        
        wm_to_storage_dynamic_array0(NAME, wm_NAME);
        
        let (wm_SYMBOL) = wm1_dynamic_array(76, 73, 78, 75);
        
        wm_to_storage_dynamic_array0(SYMBOL, wm_SYMBOL);
        
        
        
        return ();

    }


    func __warp_constructor_3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(__warp_7__name : felt, __warp_8__symbol : felt, __warp_9__decimals : felt)-> (){
    alloc_locals;


        
        wm_to_storage_dynamic_array0(__warp_0_name, __warp_7__name);
        
        wm_to_storage_dynamic_array0(__warp_1_symbol, __warp_8__symbol);
        
        WS_WRITE1(__warp_2_decimals, __warp_9__decimals);
        
        
        
        return ();

    }


    func contractFallback_579fc25e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(__warp_3_to : felt, __warp_4_value : Uint256, __warp_5_data : felt)-> (){
    alloc_locals;


        
        let __warp_6_receiver = __warp_3_to;
        
        let (__warp_se_2) = get_caller_address();
        
        let (__warp_se_3) = wm_to_calldata_dynamic_array0(__warp_5_data);
        
        IERC677Receiver_warped_interface.onTokenTransfer_a4c0ed36(__warp_6_receiver, __warp_se_2, __warp_4_value, __warp_se_3.len, __warp_se_3.ptr);
        
        
        
        return ();

    }


    func approve_095ea7b3_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_10_spender : felt, __warp_11_amount : Uint256)-> (__warp_12 : felt){
    alloc_locals;


        
        let (__warp_se_4) = get_caller_address();
        
        let (__warp_se_5) = WS_INDEX_felt_to_warp_id1(__warp_5_allowance, __warp_se_4);
        
        let (__warp_se_6) = WS0_READ_warp_id(__warp_se_5);
        
        let (__warp_se_7) = WS_INDEX_felt_to_Uint2560(__warp_se_6, __warp_10_spender);
        
        WS_WRITE0(__warp_se_7, __warp_11_amount);
        
        let (__warp_se_8) = get_caller_address();
        
        __warp_emit_Approval_8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925(__warp_se_8, __warp_10_spender, __warp_11_amount);
        
        
        
        return (1,);

    }


    func transfer_a9059cbb_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_13_to : felt, __warp_14_amount : Uint256)-> (__warp_15 : felt){
    alloc_locals;


        
        let (__warp_cs_0) = get_caller_address();
        
        let (__warp_se_9) = WS_INDEX_felt_to_Uint2560(__warp_4_balanceOf, __warp_cs_0);
        
        let (__warp_se_10) = WS_INDEX_felt_to_Uint2560(__warp_4_balanceOf, __warp_cs_0);
        
        let (__warp_se_11) = WS2_READ_Uint256(__warp_se_10);
        
        let (__warp_se_12) = warp_sub256(__warp_se_11, __warp_14_amount);
        
        WS_WRITE0(__warp_se_9, __warp_se_12);
        
            
            let __warp_cs_1 = __warp_13_to;
            
            let (__warp_se_13) = WS_INDEX_felt_to_Uint2560(__warp_4_balanceOf, __warp_cs_1);
            
            let (__warp_se_14) = WS_INDEX_felt_to_Uint2560(__warp_4_balanceOf, __warp_cs_1);
            
            let (__warp_se_15) = WS2_READ_Uint256(__warp_se_14);
            
            let (__warp_se_16) = warp_add_unsafe256(__warp_se_15, __warp_14_amount);
            
            WS_WRITE0(__warp_se_13, __warp_se_16);
        
        let (__warp_se_17) = get_caller_address();
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(__warp_se_17, __warp_13_to, __warp_14_amount);
        
        
        
        return (1,);

    }


    func _mint_4e6ec247{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_21_to : felt, __warp_22_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_36) = WS2_READ_Uint256(__warp_3_totalSupply);
        
        let (__warp_se_37) = warp_add256(__warp_se_36, __warp_22_amount);
        
        WS_WRITE0(__warp_3_totalSupply, __warp_se_37);
        
            
            let __warp_cs_4 = __warp_21_to;
            
            let (__warp_se_38) = WS_INDEX_felt_to_Uint2560(__warp_4_balanceOf, __warp_cs_4);
            
            let (__warp_se_39) = WS_INDEX_felt_to_Uint2560(__warp_4_balanceOf, __warp_cs_4);
            
            let (__warp_se_40) = WS2_READ_Uint256(__warp_se_39);
            
            let (__warp_se_41) = warp_add_unsafe256(__warp_se_40, __warp_22_amount);
            
            WS_WRITE0(__warp_se_38, __warp_se_41);
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(0, __warp_21_to, __warp_22_amount);
        
        
        
        return ();

    }

}


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(){
    alloc_locals;
    WARP_USED_STORAGE.write(11);
    WARP_NAMEGEN.write(6);
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        let (__warp_constructor_parameter_0) = wm0_dynamic_array(67, 104, 97, 105, 110, 76, 105, 110, 107, 32, 84, 111, 107, 101, 110);
        
        let (__warp_constructor_parameter_1) = wm1_dynamic_array(76, 73, 78, 75);
        
        let __warp_constructor_parameter_2 = 18;
        
        LinkTokenExperimental.__warp_constructor_3(__warp_constructor_parameter_0, __warp_constructor_parameter_1, __warp_constructor_parameter_2);
        
        LinkTokenExperimental.__warp_init_LinkTokenExperimental();
        
        LinkTokenExperimental.__warp_constructor_4();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev transfer token to a contract address with additional data if the recipient is a contact.
    // @param to The address to transfer to.
    // @param value The amount to be transferred.
    // @param data The extra data to be passed to the receiving contract.
    @external
    func transferAndCall_4000aea0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_to : felt, __warp_1_value : Uint256, __warp_2_data_len : felt, __warp_2_data : felt*)-> (success : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        external_input_check_dynamic_array0(__warp_2_data_len, __warp_2_data);
        
        warp_external_input_check_int256(__warp_1_value);
        
        warp_external_input_check_address(__warp_0_to);
        
        local __warp_2_data_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_2_data_len, __warp_2_data);
        
        let (__warp_2_data_mem) = cd_to_memory_dynamic_array0(__warp_2_data_dstruct);
        
        LinkTokenExperimental.transfer_a9059cbb_internal(__warp_0_to, __warp_1_value);
        
        let (__warp_se_1) = get_caller_address();
        
        __warp_emit_Transfer_e19260aff97b920c7df27010903aeb9c8d2be5d310a2c67824cf3f15396e4c16(__warp_se_1, __warp_0_to, __warp_1_value, __warp_2_data_mem);
        
        LinkTokenExperimental.contractFallback_579fc25e(__warp_0_to, __warp_1_value, __warp_2_data_mem);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }


    @external
    func transferFrom_23b872dd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_16_from : felt, __warp_17_to : felt, __warp_18_amount : Uint256)-> (__warp_19 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_18_amount);
        
        warp_external_input_check_address(__warp_17_to);
        
        warp_external_input_check_address(__warp_16_from);
        
        let (__warp_se_18) = WS_INDEX_felt_to_warp_id1(LinkTokenExperimental.__warp_5_allowance, __warp_16_from);
        
        let (__warp_se_19) = WS0_READ_warp_id(__warp_se_18);
        
        let (__warp_se_20) = get_caller_address();
        
        let (__warp_se_21) = WS_INDEX_felt_to_Uint2560(__warp_se_19, __warp_se_20);
        
        let (__warp_20_allowed) = WS2_READ_Uint256(__warp_se_21);
        
        let (__warp_se_22) = warp_neq256(__warp_20_allowed, Uint256(low=340282366920938463463374607431768211455, high=340282366920938463463374607431768211455));
        
            
            if (__warp_se_22 != 0){
            
                
                let (__warp_se_23) = WS_INDEX_felt_to_warp_id1(LinkTokenExperimental.__warp_5_allowance, __warp_16_from);
                
                let (__warp_se_24) = WS0_READ_warp_id(__warp_se_23);
                
                let (__warp_se_25) = get_caller_address();
                
                let (__warp_se_26) = WS_INDEX_felt_to_Uint2560(__warp_se_24, __warp_se_25);
                
                let (__warp_se_27) = warp_sub256(__warp_20_allowed, __warp_18_amount);
                
                WS_WRITE0(__warp_se_26, __warp_se_27);
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_16_from = __warp_16_from;
                tempvar __warp_17_to = __warp_17_to;
                tempvar __warp_18_amount = __warp_18_amount;
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_16_from = __warp_16_from;
                tempvar __warp_17_to = __warp_17_to;
                tempvar __warp_18_amount = __warp_18_amount;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_16_from = __warp_16_from;
            tempvar __warp_17_to = __warp_17_to;
            tempvar __warp_18_amount = __warp_18_amount;
        
        let __warp_cs_2 = __warp_16_from;
        
        let (__warp_se_28) = WS_INDEX_felt_to_Uint2560(LinkTokenExperimental.__warp_4_balanceOf, __warp_cs_2);
        
        let (__warp_se_29) = WS_INDEX_felt_to_Uint2560(LinkTokenExperimental.__warp_4_balanceOf, __warp_cs_2);
        
        let (__warp_se_30) = WS2_READ_Uint256(__warp_se_29);
        
        let (__warp_se_31) = warp_sub256(__warp_se_30, __warp_18_amount);
        
        WS_WRITE0(__warp_se_28, __warp_se_31);
        
            
            let __warp_cs_3 = __warp_17_to;
            
            let (__warp_se_32) = WS_INDEX_felt_to_Uint2560(LinkTokenExperimental.__warp_4_balanceOf, __warp_cs_3);
            
            let (__warp_se_33) = WS_INDEX_felt_to_Uint2560(LinkTokenExperimental.__warp_4_balanceOf, __warp_cs_3);
            
            let (__warp_se_34) = WS2_READ_Uint256(__warp_se_33);
            
            let (__warp_se_35) = warp_add_unsafe256(__warp_se_34, __warp_18_amount);
            
            WS_WRITE0(__warp_se_32, __warp_se_35);
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(__warp_16_from, __warp_17_to, __warp_18_amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }


    @view
    func name_06fdde03{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_25_len : felt, __warp_25 : felt*){
    alloc_locals;


        
        let (__warp_se_42) = ws_dynamic_array_to_calldata0(LinkTokenExperimental.__warp_0_name);
        
        
        
        return (__warp_se_42.len, __warp_se_42.ptr,);

    }


    @view
    func symbol_95d89b41{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_26_len : felt, __warp_26 : felt*){
    alloc_locals;


        
        let (__warp_se_43) = ws_dynamic_array_to_calldata0(LinkTokenExperimental.__warp_1_symbol);
        
        
        
        return (__warp_se_43.len, __warp_se_43.ptr,);

    }


    @view
    func decimals_313ce567{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_27 : felt){
    alloc_locals;


        
        let (__warp_se_44) = WS3_READ_felt(LinkTokenExperimental.__warp_2_decimals);
        
        
        
        return (__warp_se_44,);

    }


    @view
    func totalSupply_18160ddd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_28 : Uint256){
    alloc_locals;


        
        let (__warp_se_45) = WS2_READ_Uint256(LinkTokenExperimental.__warp_3_totalSupply);
        
        
        
        return (__warp_se_45,);

    }


    @view
    func balanceOf_70a08231{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_29__i0 : felt)-> (__warp_30 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_29__i0);
        
        let (__warp_se_46) = WS_INDEX_felt_to_Uint2560(LinkTokenExperimental.__warp_4_balanceOf, __warp_29__i0);
        
        let (__warp_se_47) = WS2_READ_Uint256(__warp_se_46);
        
        
        
        return (__warp_se_47,);

    }


    @view
    func allowance_dd62ed3e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_31__i0 : felt, __warp_32__i1 : felt)-> (__warp_33 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_32__i1);
        
        warp_external_input_check_address(__warp_31__i0);
        
        let (__warp_se_48) = WS_INDEX_felt_to_warp_id1(LinkTokenExperimental.__warp_5_allowance, __warp_31__i0);
        
        let (__warp_se_49) = WS0_READ_warp_id(__warp_se_48);
        
        let (__warp_se_50) = WS_INDEX_felt_to_Uint2560(__warp_se_49, __warp_32__i1);
        
        let (__warp_se_51) = WS2_READ_Uint256(__warp_se_50);
        
        
        
        return (__warp_se_51,);

    }


    @external
    func approve_095ea7b3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_10_spender : felt, __warp_11_amount : Uint256)-> (__warp_12 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_11_amount);
        
        warp_external_input_check_address(__warp_10_spender);
        
        let (__warp_pse_0) = LinkTokenExperimental.approve_095ea7b3_internal(__warp_10_spender, __warp_11_amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (__warp_pse_0,);
    }
    }


    @external
    func transfer_a9059cbb{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_13_to : felt, __warp_14_amount : Uint256)-> (__warp_15 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_14_amount);
        
        warp_external_input_check_address(__warp_13_to);
        
        let (__warp_pse_1) = LinkTokenExperimental.transfer_a9059cbb_internal(__warp_13_to, __warp_14_amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (__warp_pse_1,);
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


// Contract Def IERC677Receiver@interface


@contract_interface
namespace IERC677Receiver_warped_interface{
func onTokenTransfer_a4c0ed36(sender : felt, value : Uint256, data_len : felt, data : felt*)-> (){
}
}