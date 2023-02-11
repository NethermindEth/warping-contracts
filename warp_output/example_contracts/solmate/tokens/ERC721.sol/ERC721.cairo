%lang starknet


from warplib.memory import wm_alloc, wm_write_256, wm_read_felt, wm_read_256, wm_dyn_array_length, wm_new, wm_to_felt_array
from starkware.cairo.common.uint256 import Uint256, uint256_sub, uint256_add, uint256_lt, uint256_eq
from starkware.cairo.common.dict import dict_write, dict_read
from starkware.cairo.common.alloc import alloc
from warplib.maths.utils import narrow_safe, felt_to_uint256
from warplib.maths.int_conversions import warp_uint256
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int8, warp_external_input_check_int32
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_bool import warp_external_input_check_bool
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array_spl
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from warplib.keccak import felt_array_concat, pack_bytes_felt
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from warplib.maths.neq import warp_neq
from starkware.cairo.common.dict_access import DictAccess
from warplib.maths.eq import warp_eq
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.sub_unsafe import warp_sub_unsafe256
from warplib.maths.add_unsafe import warp_add_unsafe256


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

func WM0_d_arr{range_check_ptr, warp_memory: DictAccess*}() -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x2, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x0, 0x0));
    return (start,);
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

func wm_to_storage0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(storage_name: felt, mem_loc : felt, length: Uint256) -> (){
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
    return wm_to_storage0_elem(storage_name, mem_loc, index);
    }else{
    let (copy) = dict_read{dict_ptr=warp_memory}(mem_loc);
    WARP_STORAGE.write(storage_loc, copy);
    return wm_to_storage0_elem(storage_name, mem_loc, index);
    }
}
func wm_to_storage0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(loc : felt, mem_loc : felt) -> (loc : felt){
    alloc_locals;
    let (length) = WARP_DARRAY0_felt_LENGTH.read(loc);
    let (mem_length) = wm_dyn_array_length(mem_loc);
    WARP_DARRAY0_felt_LENGTH.write(loc, mem_length);
    let (narrowedLength) = narrow_safe(mem_length);
    wm_to_storage0_elem(loc, mem_loc + 2 + 1 * narrowedLength, mem_length);
    let (lesser) = uint256_lt(mem_length, length);
    if (lesser == 1){
       WS0_DYNAMIC_ARRAY_DELETE_elem(loc, mem_length, length);
       return (loc,);
    }else{
       return (loc,);
    }
}

func WS0_DYNAMIC_ARRAY_DELETE_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt, index : Uint256, length : Uint256){
     alloc_locals;
     let (stop) = uint256_eq(index, length);
     if (stop == 1){
        return ();
     }
     let (elem_loc) = WARP_DARRAY0_felt.read(loc, index);
    WS1_DELETE(elem_loc);
     let (next_index, _) = uint256_add(index, Uint256(0x1, 0x0));
     return WS0_DYNAMIC_ARRAY_DELETE_elem(loc, next_index, length);
}
func WS0_DYNAMIC_ARRAY_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt){
   alloc_locals;
   let (length) = WARP_DARRAY0_felt_LENGTH.read(loc);
   WARP_DARRAY0_felt_LENGTH.write(loc, Uint256(0x0, 0x0));
   return WS0_DYNAMIC_ARRAY_DELETE_elem(loc, Uint256(0x0, 0x0), length);
}

func WS1_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt){
    WARP_STORAGE.write(loc, 0);
    return ();
}

func WS0_READ_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = readId(loc);
    return (read0,);
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

func abi_encode3{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt) -> (result_ptr : felt){
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
   let (mem_encode: felt) = abi_encode1(param2);
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
   let (mem_encode: felt) = abi_encode3(param2);
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
   let (mem_encode: felt) = abi_encode1(param2);
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

@storage_var
func WARP_DARRAY0_felt(name: felt, index: Uint256) -> (resLoc : felt){
}
@storage_var
func WARP_DARRAY0_felt_LENGTH(name: felt) -> (index: Uint256){
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

@storage_var
func WARP_MAPPING1(name: felt, index: felt) -> (resLoc : felt){
}
func WS1_INDEX_felt_to_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING1.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 2);
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

@storage_var
func WARP_MAPPING3(name: felt, index: felt) -> (resLoc : felt){
}
func WS3_INDEX_felt_to_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING3.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_MAPPING3.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}


// Contract Def ERC721

// @notice Modern, minimalist, and gas efficient ERC-721 implementation.
// @author Solmate (https://github.com/transmissions11/solmate/blob/main/src/tokens/ERC721.sol)


// @event
// func Transfer(__warp_6_from : felt, to : felt, id : Uint256){
// }


// @event
// func Approval(owner : felt, spender : felt, id : Uint256){
// }


// @event
// func ApprovalForAll(owner : felt, operator : felt, approved : felt){
// }

namespace ERC721{

    // Dynamic variables - Arrays and Maps

    const __warp_0_name = 1;

    const __warp_1_symbol = 2;

    const __warp_2__ownerOf = 3;

    const __warp_3__balanceOf = 4;

    const __warp_4_getApproved = 5;

    const __warp_5_isApprovedForAll = 6;

    // Static variables


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(__warp_11__name : felt, __warp_12__symbol : felt)-> (){
    alloc_locals;


        
        wm_to_storage0(__warp_0_name, __warp_11__name);
        
        wm_to_storage0(__warp_1_symbol, __warp_12__symbol);
        
        
        
        return ();

    }


    func __warp_conditional_approve_095ea7b3_1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_15_owner : felt)-> (__warp_rc_0 : felt, __warp_15_owner : felt){
    alloc_locals;


        
        let (__warp_se_5) = get_caller_address();
        
        let (__warp_se_6) = warp_eq(__warp_se_5, __warp_15_owner);
        
        if (__warp_se_6 != 0){
        
            
            let __warp_rc_0 = 1;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_15_owner = __warp_15_owner;
            
            
            
            return (__warp_rc_0, __warp_15_owner);
        }else{
        
            
            let (__warp_se_7) = WS3_INDEX_felt_to_warp_id(__warp_5_isApprovedForAll, __warp_15_owner);
            
            let (__warp_se_8) = WS0_READ_warp_id(__warp_se_7);
            
            let (__warp_se_9) = get_caller_address();
            
            let (__warp_se_10) = WS2_INDEX_felt_to_felt(__warp_se_8, __warp_se_9);
            
            let (__warp_se_11) = WS1_READ_felt(__warp_se_10);
            
            let __warp_rc_0 = __warp_se_11;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_15_owner = __warp_15_owner;
            
            
            
            return (__warp_rc_0, __warp_15_owner);
        }

    }


    func __warp_conditional___warp_conditional_transferFrom_23b872dd_internal_3_5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_18_from : felt)-> (__warp_rc_4 : felt, __warp_18_from : felt){
    alloc_locals;


        
        let (__warp_se_19) = get_caller_address();
        
        let (__warp_se_20) = warp_eq(__warp_se_19, __warp_18_from);
        
        if (__warp_se_20 != 0){
        
            
            let __warp_rc_4 = 1;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_18_from = __warp_18_from;
            
            
            
            return (__warp_rc_4, __warp_18_from);
        }else{
        
            
            let (__warp_se_21) = WS3_INDEX_felt_to_warp_id(__warp_5_isApprovedForAll, __warp_18_from);
            
            let (__warp_se_22) = WS0_READ_warp_id(__warp_se_21);
            
            let (__warp_se_23) = get_caller_address();
            
            let (__warp_se_24) = WS2_INDEX_felt_to_felt(__warp_se_22, __warp_se_23);
            
            let (__warp_se_25) = WS1_READ_felt(__warp_se_24);
            
            let __warp_rc_4 = __warp_se_25;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_18_from = __warp_18_from;
            
            
            
            return (__warp_rc_4, __warp_18_from);
        }

    }


    func __warp_conditional_transferFrom_23b872dd_internal_3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_18_from : felt, __warp_20_id : Uint256)-> (__warp_rc_2 : felt, __warp_18_from : felt, __warp_20_id : Uint256){
    alloc_locals;


        
        let __warp_rc_4 = 0;
        
            
            let (__warp_tv_2, __warp_tv_3) = __warp_conditional___warp_conditional_transferFrom_23b872dd_internal_3_5(__warp_18_from);
            
            let __warp_18_from = __warp_tv_3;
            
            let __warp_rc_4 = __warp_tv_2;
        
        if (__warp_rc_4 != 0){
        
            
            let __warp_rc_2 = 1;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_18_from = __warp_18_from;
            
            let __warp_20_id = __warp_20_id;
            
            
            
            return (__warp_rc_2, __warp_18_from, __warp_20_id);
        }else{
        
            
            let (__warp_se_26) = get_caller_address();
            
            let (__warp_se_27) = WS0_INDEX_Uint256_to_felt(__warp_4_getApproved, __warp_20_id);
            
            let (__warp_se_28) = WS1_READ_felt(__warp_se_27);
            
            let (__warp_se_29) = warp_eq(__warp_se_26, __warp_se_28);
            
            let __warp_rc_2 = __warp_se_29;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_18_from = __warp_18_from;
            
            let __warp_20_id = __warp_20_id;
            
            
            
            return (__warp_rc_2, __warp_18_from, __warp_20_id);
        }

    }


    func transferFrom_23b872dd_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_18_from : felt, __warp_19_to : felt, __warp_20_id : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_30) = WS0_INDEX_Uint256_to_felt(__warp_2__ownerOf, __warp_20_id);
        
        let (__warp_se_31) = WS1_READ_felt(__warp_se_30);
        
        let (__warp_se_32) = warp_eq(__warp_18_from, __warp_se_31);
        
        with_attr error_message("WRONG_FROM"){
            assert __warp_se_32 = 1;
        }
        
        let (__warp_se_33) = warp_neq(__warp_19_to, 0);
        
        with_attr error_message("INVALID_RECIPIENT"){
            assert __warp_se_33 = 1;
        }
        
        let __warp_rc_2 = 0;
        
            
            let (__warp_tv_4, __warp_tv_5, __warp_tv_6) = __warp_conditional_transferFrom_23b872dd_internal_3(__warp_18_from, __warp_20_id);
            
            let __warp_20_id = __warp_tv_6;
            
            let __warp_18_from = __warp_tv_5;
            
            let __warp_rc_2 = __warp_tv_4;
        
        with_attr error_message("NOT_AUTHORIZED"){
            assert __warp_rc_2 = 1;
        }
        
            
            let __warp_cs_0 = __warp_18_from;
            
            let (__warp_se_34) = WS1_INDEX_felt_to_Uint256(__warp_3__balanceOf, __warp_cs_0);
            
            let (__warp_se_35) = WS2_READ_Uint256(__warp_se_34);
            
            let (__warp_pse_1) = warp_sub_unsafe256(__warp_se_35, Uint256(low=1, high=0));
            
            let (__warp_se_36) = WS1_INDEX_felt_to_Uint256(__warp_3__balanceOf, __warp_cs_0);
            
            WS_WRITE1(__warp_se_36, __warp_pse_1);
            
            warp_add_unsafe256(__warp_pse_1, Uint256(low=1, high=0));
            
            let __warp_cs_1 = __warp_19_to;
            
            let (__warp_se_37) = WS1_INDEX_felt_to_Uint256(__warp_3__balanceOf, __warp_cs_1);
            
            let (__warp_se_38) = WS2_READ_Uint256(__warp_se_37);
            
            let (__warp_pse_2) = warp_add_unsafe256(__warp_se_38, Uint256(low=1, high=0));
            
            let (__warp_se_39) = WS1_INDEX_felt_to_Uint256(__warp_3__balanceOf, __warp_cs_1);
            
            WS_WRITE1(__warp_se_39, __warp_pse_2);
            
            warp_sub_unsafe256(__warp_pse_2, Uint256(low=1, high=0));
        
        let (__warp_se_40) = WS0_INDEX_Uint256_to_felt(__warp_2__ownerOf, __warp_20_id);
        
        WS_WRITE0(__warp_se_40, __warp_19_to);
        
        let (__warp_se_41) = WS0_INDEX_Uint256_to_felt(__warp_4_getApproved, __warp_20_id);
        
        WS_WRITE0(__warp_se_41, 0);
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(__warp_18_from, __warp_19_to, __warp_20_id);
        
        
        
        return ();

    }


    func __warp_conditional___warp_conditional_supportsInterface_01ffc9a7_7_9(__warp_28_interfaceId : felt)-> (__warp_rc_8 : felt, __warp_28_interfaceId : felt){
    alloc_locals;


        
        let (__warp_se_48) = warp_eq(__warp_28_interfaceId, 33540519);
        
        if (__warp_se_48 != 0){
        
            
            let __warp_rc_8 = 1;
            
            let __warp_rc_8 = __warp_rc_8;
            
            let __warp_28_interfaceId = __warp_28_interfaceId;
            
            
            
            return (__warp_rc_8, __warp_28_interfaceId);
        }else{
        
            
            let (__warp_se_49) = warp_eq(__warp_28_interfaceId, 2158778573);
            
            let __warp_rc_8 = __warp_se_49;
            
            let __warp_rc_8 = __warp_rc_8;
            
            let __warp_28_interfaceId = __warp_28_interfaceId;
            
            
            
            return (__warp_rc_8, __warp_28_interfaceId);
        }

    }


    func __warp_conditional_supportsInterface_01ffc9a7_7(__warp_28_interfaceId : felt)-> (__warp_rc_6 : felt, __warp_28_interfaceId : felt){
    alloc_locals;


        
        let __warp_rc_8 = 0;
        
            
            let (__warp_tv_7, __warp_tv_8) = __warp_conditional___warp_conditional_supportsInterface_01ffc9a7_7_9(__warp_28_interfaceId);
            
            let __warp_28_interfaceId = __warp_tv_8;
            
            let __warp_rc_8 = __warp_tv_7;
        
        if (__warp_rc_8 != 0){
        
            
            let __warp_rc_6 = 1;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_28_interfaceId = __warp_28_interfaceId;
            
            
            
            return (__warp_rc_6, __warp_28_interfaceId);
        }else{
        
            
            let (__warp_se_50) = warp_eq(__warp_28_interfaceId, 1532892063);
            
            let __warp_rc_6 = __warp_se_50;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_28_interfaceId = __warp_28_interfaceId;
            
            
            
            return (__warp_rc_6, __warp_28_interfaceId);
        }

    }

}


    @view
    func ownerOf_6352211e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_7_id : Uint256)-> (__warp_8_owner : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_7_id);
        
        let __warp_8_owner = 0;
        
        let (__warp_se_0) = WS0_INDEX_Uint256_to_felt(ERC721.__warp_2__ownerOf, __warp_7_id);
        
        let (__warp_pse_0) = WS1_READ_felt(__warp_se_0);
        
        let __warp_8_owner = __warp_pse_0;
        
        let (__warp_se_1) = warp_neq(__warp_pse_0, 0);
        
        with_attr error_message("NOT_MINTED"){
            assert __warp_se_1 = 1;
        }
        
        
        
        return (__warp_8_owner,);

    }


    @view
    func balanceOf_70a08231{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_9_owner : felt)-> (__warp_10 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_9_owner);
        
        let (__warp_se_2) = warp_neq(__warp_9_owner, 0);
        
        with_attr error_message("ZERO_ADDRESS"){
            assert __warp_se_2 = 1;
        }
        
        let (__warp_se_3) = WS1_INDEX_felt_to_Uint256(ERC721.__warp_3__balanceOf, __warp_9_owner);
        
        let (__warp_se_4) = WS2_READ_Uint256(__warp_se_3);
        
        
        
        return (__warp_se_4,);

    }


    @external
    func approve_095ea7b3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_13_spender : felt, __warp_14_id : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_14_id);
        
        warp_external_input_check_address(__warp_13_spender);
        
        let (__warp_se_12) = WS0_INDEX_Uint256_to_felt(ERC721.__warp_2__ownerOf, __warp_14_id);
        
        let (__warp_15_owner) = WS1_READ_felt(__warp_se_12);
        
        let __warp_rc_0 = 0;
        
            
            let (__warp_tv_0, __warp_tv_1) = ERC721.__warp_conditional_approve_095ea7b3_1(__warp_15_owner);
            
            let __warp_15_owner = __warp_tv_1;
            
            let __warp_rc_0 = __warp_tv_0;
        
        with_attr error_message("NOT_AUTHORIZED"){
            assert __warp_rc_0 = 1;
        }
        
        let (__warp_se_13) = WS0_INDEX_Uint256_to_felt(ERC721.__warp_4_getApproved, __warp_14_id);
        
        WS_WRITE0(__warp_se_13, __warp_13_spender);
        
        __warp_emit_Approval_8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925(__warp_15_owner, __warp_13_spender, __warp_14_id);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func setApprovalForAll_a22cb465{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_16_operator : felt, __warp_17_approved : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_bool(__warp_17_approved);
        
        warp_external_input_check_address(__warp_16_operator);
        
        let (__warp_se_14) = get_caller_address();
        
        let (__warp_se_15) = WS3_INDEX_felt_to_warp_id(ERC721.__warp_5_isApprovedForAll, __warp_se_14);
        
        let (__warp_se_16) = WS0_READ_warp_id(__warp_se_15);
        
        let (__warp_se_17) = WS2_INDEX_felt_to_felt(__warp_se_16, __warp_16_operator);
        
        WS_WRITE0(__warp_se_17, __warp_17_approved);
        
        let (__warp_se_18) = get_caller_address();
        
        __warp_emit_ApprovalForAll_17307eab39ab6107e8899845ad3d59bd9653f200f220920489ca2b5937696c31(__warp_se_18, __warp_16_operator, __warp_17_approved);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func safeTransferFrom_42842e0e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_21_from : felt, __warp_22_to : felt, __warp_23_id : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_23_id);
        
        warp_external_input_check_address(__warp_22_to);
        
        warp_external_input_check_address(__warp_21_from);
        
        ERC721.transferFrom_23b872dd_internal(__warp_21_from, __warp_22_to, __warp_23_id);
        
        let (__warp_se_42) = get_caller_address();
        
        let (__warp_se_43) = WM0_d_arr();
        
        let (__warp_se_44) = wm_to_calldata0(__warp_se_43);
        
        let (__warp_pse_3) = ERC721TokenReceiver_warped_interface.onERC721Received_150b7a02(__warp_22_to, __warp_se_42, __warp_21_from, __warp_23_id, __warp_se_44.len, __warp_se_44.ptr);
        
        let (__warp_se_45) = warp_eq(__warp_pse_3, ERC721TokenReceiver.onERC721Received_150b7a02.selector);
        
        with_attr error_message("UNSAFE_RECIPIENT"){
            assert __warp_se_45 = 1;
        }
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func safeTransferFrom_b88d4fde{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_24_from : felt, __warp_25_to : felt, __warp_26_id : Uint256, __warp_27_data_len : felt, __warp_27_data : felt*)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        extern_input_check0(__warp_27_data_len, __warp_27_data);
        
        warp_external_input_check_int256(__warp_26_id);
        
        warp_external_input_check_address(__warp_25_to);
        
        warp_external_input_check_address(__warp_24_from);
        
        local __warp_27_data_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_27_data_len, __warp_27_data);
        
        ERC721.transferFrom_23b872dd_internal(__warp_24_from, __warp_25_to, __warp_26_id);
        
        let (__warp_se_46) = get_caller_address();
        
        let (__warp_pse_4) = ERC721TokenReceiver_warped_interface.onERC721Received_150b7a02(__warp_25_to, __warp_se_46, __warp_24_from, __warp_26_id, __warp_27_data_dstruct.len, __warp_27_data_dstruct.ptr);
        
        let (__warp_se_47) = warp_eq(__warp_pse_4, ERC721TokenReceiver.onERC721Received_150b7a02.selector);
        
        with_attr error_message("UNSAFE_RECIPIENT"){
            assert __warp_se_47 = 1;
        }
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func supportsInterface_01ffc9a7{syscall_ptr : felt*, range_check_ptr : felt}(__warp_28_interfaceId : felt)-> (__warp_29 : felt){
    alloc_locals;


        
        warp_external_input_check_int32(__warp_28_interfaceId);
        
        let __warp_rc_6 = 0;
        
            
            let (__warp_tv_9, __warp_tv_10) = ERC721.__warp_conditional_supportsInterface_01ffc9a7_7(__warp_28_interfaceId);
            
            let __warp_28_interfaceId = __warp_tv_10;
            
            let __warp_rc_6 = __warp_tv_9;
        
        
        
        return (__warp_rc_6,);

    }


    @view
    func name_06fdde03{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_39_len : felt, __warp_39 : felt*){
    alloc_locals;


        
        let (__warp_se_51) = ws_dynamic_array_to_calldata0(ERC721.__warp_0_name);
        
        
        
        return (__warp_se_51.len, __warp_se_51.ptr,);

    }


    @view
    func symbol_95d89b41{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_40_len : felt, __warp_40 : felt*){
    alloc_locals;


        
        let (__warp_se_52) = ws_dynamic_array_to_calldata0(ERC721.__warp_1_symbol);
        
        
        
        return (__warp_se_52.len, __warp_se_52.ptr,);

    }


    @view
    func getApproved_081812fc{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_41__i0 : Uint256)-> (__warp_42 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_41__i0);
        
        let (__warp_se_53) = WS0_INDEX_Uint256_to_felt(ERC721.__warp_4_getApproved, __warp_41__i0);
        
        let (__warp_se_54) = WS1_READ_felt(__warp_se_53);
        
        
        
        return (__warp_se_54,);

    }


    @view
    func isApprovedForAll_e985e9c5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_43__i0 : felt, __warp_44__i1 : felt)-> (__warp_45 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_44__i1);
        
        warp_external_input_check_address(__warp_43__i0);
        
        let (__warp_se_55) = WS3_INDEX_felt_to_warp_id(ERC721.__warp_5_isApprovedForAll, __warp_43__i0);
        
        let (__warp_se_56) = WS0_READ_warp_id(__warp_se_55);
        
        let (__warp_se_57) = WS2_INDEX_felt_to_felt(__warp_se_56, __warp_44__i1);
        
        let (__warp_se_58) = WS1_READ_felt(__warp_se_57);
        
        
        
        return (__warp_se_58,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_11__name_len : felt, __warp_11__name : felt*, __warp_12__symbol_len : felt, __warp_12__symbol : felt*){
    alloc_locals;
    WARP_USED_STORAGE.write(6);
    WARP_NAMEGEN.write(6);
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        extern_input_check1(__warp_12__symbol_len, __warp_12__symbol);
        
        extern_input_check1(__warp_11__name_len, __warp_11__name);
        
        local __warp_12__symbol_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_12__symbol_len, __warp_12__symbol);
        
        let (__warp_12__symbol_mem) = cd_to_memory0(__warp_12__symbol_dstruct);
        
        local __warp_11__name_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_11__name_len, __warp_11__name);
        
        let (__warp_11__name_mem) = cd_to_memory0(__warp_11__name_dstruct);
        
        ERC721.__warp_constructor_0(__warp_11__name_mem, __warp_12__symbol_mem);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return ();
    }
    }


    @external
    func transferFrom_23b872dd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_18_from : felt, __warp_19_to : felt, __warp_20_id : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_20_id);
        
        warp_external_input_check_address(__warp_19_to);
        
        warp_external_input_check_address(__warp_18_from);
        
        ERC721.transferFrom_23b872dd_internal(__warp_18_from, __warp_19_to, __warp_20_id);
        
        let __warp_uv0 = ();
        
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


// Contract Def ERC721TokenReceiver@interface


@contract_interface
namespace ERC721TokenReceiver_warped_interface{
func onERC721Received_150b7a02(__warp_0 : felt, __warp_1 : felt, __warp_2 : Uint256, __warp_3_len : felt, __warp_3 : felt*)-> (__warp_4 : felt){
}
}