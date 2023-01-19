%lang starknet


from warplib.memory import wm_read_felt, wm_alloc, wm_read_256, wm_read_id, wm_dyn_array_length, wm_new, wm_index_dyn, wm_to_felt_array
from starkware.cairo.common.dict import dict_write, dict_read
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.uint256 import Uint256, uint256_sub, uint256_add, uint256_lt, uint256_eq
from starkware.cairo.common.alloc import alloc
from warplib.maths.utils import narrow_safe, felt_to_uint256
from warplib.maths.int_conversions import warp_uint256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int8
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, bytes_to_felt_dynamic_array, fixed_bytes256_to_felt_dynamic_array_spl
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from warplib.keccak import felt_array_concat, pack_bytes_felt
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from warplib.maths.lt import warp_lt256
from warplib.maths.neq import warp_neq
from warplib.maths.add import warp_add256
from warplib.maths.sub import warp_sub256
from warplib.maths.ge import warp_ge256
from warplib.maths.gt import warp_gt256
from warplib.maths.le import warp_le256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak


struct Transaction_a4ad9f9e{
    to : felt,
    value : Uint256,
    data : felt,
    executed : felt,
    numConfirmations : Uint256,
}


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

func WM0_struct_Transaction_a4ad9f9e{range_check_ptr, warp_memory: DictAccess*}(member_to: felt, member_value: Uint256, member_data: felt, member_executed: felt, member_numConfirmations: Uint256) -> (res:felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x7, 0x0));
dict_write{dict_ptr=warp_memory}(start, member_to);
dict_write{dict_ptr=warp_memory}(start + 1, member_value.low);
dict_write{dict_ptr=warp_memory}(start + 2, member_value.high);
dict_write{dict_ptr=warp_memory}(start + 3, member_data);
dict_write{dict_ptr=warp_memory}(start + 4, member_executed);
dict_write{dict_ptr=warp_memory}(start + 5, member_numConfirmations.low);
dict_write{dict_ptr=warp_memory}(start + 6, member_numConfirmations.high);
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

func wm_to_storage0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(loc : felt, mem_loc: felt) -> (loc: felt){
    alloc_locals;
let (elem_mem_loc_0) = dict_read{dict_ptr=warp_memory}(mem_loc);
WARP_STORAGE.write(loc, elem_mem_loc_0);
let (elem_mem_loc_1) = dict_read{dict_ptr=warp_memory}(mem_loc + 1);
WARP_STORAGE.write(loc + 1, elem_mem_loc_1);
let (elem_mem_loc_2) = dict_read{dict_ptr=warp_memory}(mem_loc + 2);
WARP_STORAGE.write(loc + 2, elem_mem_loc_2);
let (elem_mem_loc_3) = wm_read_id(mem_loc + 3, Uint256(0x2, 0x0));
let (storage_dyn_array_loc) = readId(loc + 3);
wm_to_storage1(storage_dyn_array_loc, elem_mem_loc_3);
let (elem_mem_loc_4) = dict_read{dict_ptr=warp_memory}(mem_loc + 4);
WARP_STORAGE.write(loc + 4, elem_mem_loc_4);
let (elem_mem_loc_5) = dict_read{dict_ptr=warp_memory}(mem_loc + 5);
WARP_STORAGE.write(loc + 5, elem_mem_loc_5);
let (elem_mem_loc_6) = dict_read{dict_ptr=warp_memory}(mem_loc + 6);
WARP_STORAGE.write(loc + 6, elem_mem_loc_6);
    return (loc,);
}

func wm_to_storage1_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(storage_name: felt, mem_loc : felt, length: Uint256) -> (){
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
    return wm_to_storage1_elem(storage_name, mem_loc, index);
    }else{
    let (copy) = dict_read{dict_ptr=warp_memory}(mem_loc);
    WARP_STORAGE.write(storage_loc, copy);
    return wm_to_storage1_elem(storage_name, mem_loc, index);
    }
}
func wm_to_storage1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(loc : felt, mem_loc : felt) -> (loc : felt){
    alloc_locals;
    let (length) = WARP_DARRAY0_felt_LENGTH.read(loc);
    let (mem_length) = wm_dyn_array_length(mem_loc);
    WARP_DARRAY0_felt_LENGTH.write(loc, mem_length);
    let (narrowedLength) = narrow_safe(mem_length);
    wm_to_storage1_elem(loc, mem_loc + 2 + 1 * narrowedLength, mem_length);
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

func WARP_DARRAY1_Transaction_a4ad9f9e_IDX{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(ref: felt, index: Uint256) -> (res: felt){
    alloc_locals;
    let (length) = WARP_DARRAY1_Transaction_a4ad9f9e_LENGTH.read(ref);
    let (inRange) = uint256_lt(index, length);
    assert inRange = 1;
    let (existing) = WARP_DARRAY1_Transaction_a4ad9f9e.read(ref, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 7);
        WARP_DARRAY1_Transaction_a4ad9f9e.write(ref, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}

func WARP_DARRAY0_felt_IDX{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(ref: felt, index: Uint256) -> (res: felt){
    alloc_locals;
    let (length) = WARP_DARRAY0_felt_LENGTH.read(ref);
    let (inRange) = uint256_lt(index, length);
    assert inRange = 1;
    let (existing) = WARP_DARRAY0_felt.read(ref, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_DARRAY0_felt.write(ref, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}

func WARP_DARRAY0_felt_PUSHV0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr: BitwiseBuiltin*}(loc: felt, value: felt) -> (){
    alloc_locals;
    let (len) = WARP_DARRAY0_felt_LENGTH.read(loc);
    let (newLen, carry) = uint256_add(len, Uint256(1,0));
    assert carry = 0;
    WARP_DARRAY0_felt_LENGTH.write(loc, newLen);
    let (existing) = WARP_DARRAY0_felt.read(loc, len);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_DARRAY0_felt.write(loc, len, used);
WS_WRITE0(used, value);
    }else{
WS_WRITE0(existing, value);
    }
    return ();
}

func WARP_DARRAY1_Transaction_a4ad9f9e_PUSHV1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory: DictAccess*}(loc: felt, value: felt) -> (){
    alloc_locals;
    let (len) = WARP_DARRAY1_Transaction_a4ad9f9e_LENGTH.read(loc);
    let (newLen, carry) = uint256_add(len, Uint256(1,0));
    assert carry = 0;
    WARP_DARRAY1_Transaction_a4ad9f9e_LENGTH.write(loc, newLen);
    let (existing) = WARP_DARRAY1_Transaction_a4ad9f9e.read(loc, len);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 7);
        WARP_DARRAY1_Transaction_a4ad9f9e.write(loc, len, used);
wm_to_storage0(used, value);
    }else{
wm_to_storage0(existing, value);
    }
    return ();
}

func WSM0_Transaction_a4ad9f9e_executed(loc: felt) -> (memberLoc: felt){
    return (loc + 4,);
}

func WSM1_Transaction_a4ad9f9e_numConfirmations(loc: felt) -> (memberLoc: felt){
    return (loc + 5,);
}

func WSM2_Transaction_a4ad9f9e_to(loc: felt) -> (memberLoc: felt){
    return (loc,);
}

func WSM3_Transaction_a4ad9f9e_value(loc: felt) -> (memberLoc: felt){
    return (loc + 1,);
}

func WSM4_Transaction_a4ad9f9e_data(loc: felt) -> (memberLoc: felt){
    return (loc + 3,);
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

func ws_to_memory0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(storage_name: felt, mem_start: felt, length: Uint256) -> (){
    alloc_locals;
    if (length.low == 0 and length.high == 0){
        return ();
    }
    let (index) = uint256_sub(length, Uint256(1,0));
    let (mem_loc) = wm_index_dyn(mem_start, index, Uint256(0x1, 0x0));
    let (element_storage_loc) = WARP_DARRAY0_felt.read(storage_name, index);
   let (copy) = WARP_STORAGE.read(element_storage_loc);
   dict_write{dict_ptr=warp_memory}(mem_loc, copy);
    return ws_to_memory0_elem(storage_name, mem_start, index);
}
func ws_to_memory0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(loc : felt) -> (mem_loc : felt){
    alloc_locals;
    let (length: Uint256) = WARP_DARRAY0_felt_LENGTH.read(loc);
    let (mem_start) = wm_new(length, Uint256(0x1, 0x0));
    ws_to_memory0_elem(loc, mem_start, length);
    return (mem_start,);
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
warp_external_input_check_address(ptr[0]);
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

func abi_encode2{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(param0 : felt) -> (result_ptr : felt){
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

func _emit_RevokeConfirmation_f0dca620{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x5f9d4dcdc33dd68b53516dec4585feff8234d4a2c017c7189018ab81f20f39);// keccak of event signature: RevokeConfirmation(address,uint256)
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
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_ExecuteTransaction_5445f318{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x165cc0dc4a9be1e0755559a4ff6c008a4dca238ddf9fde9fab5795aead269db);// keccak of event signature: ExecuteTransaction(address,uint256)
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
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_ConfirmTransaction_5cbe105e{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x275e20ef159a41c0db13eb4d797ccc33ddb92b083743381bf9946e490446580);// keccak of event signature: ConfirmTransaction(address,uint256)
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
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_SubmitTransaction_d5a05bf7{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : Uint256, param2 : felt, param3 : Uint256, param4 : felt){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x24d5d70f20add4e992870b2e7f5c7acddb52dcb6854a549ef704e2cd42fcec7);// keccak of event signature: SubmitTransaction(address,uint256,address,uint256,bytes)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode1(param1);
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
   let (mem_encode: felt) = abi_encode1(param3);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode2(param4);
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
func WARP_DARRAY1_Transaction_a4ad9f9e(name: felt, index: Uint256) -> (resLoc : felt){
}
@storage_var
func WARP_DARRAY1_Transaction_a4ad9f9e_LENGTH(name: felt) -> (index: Uint256){
}

@storage_var
func WARP_MAPPING0(name: felt, index: felt) -> (resLoc : felt){
}
func WS0_INDEX_felt_to_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
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
func WARP_MAPPING1(name: felt, index: Uint256) -> (resLoc : felt){
}
func WS1_INDEX_Uint256_to_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: Uint256) -> (res: felt){
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


// Contract Def MultiSigWallet


// @event
// func Deposit(sender : felt, amount : Uint256, balance : Uint256){
// }


// @event
// func SubmitTransaction(owner : felt, txIndex : Uint256, to : felt, value : Uint256, data : felt){
// }


// @event
// func ConfirmTransaction(owner : felt, txIndex : Uint256){
// }


// @event
// func RevokeConfirmation(owner : felt, txIndex : Uint256){
// }


// @event
// func ExecuteTransaction(owner : felt, txIndex : Uint256){
// }

namespace MultiSigWallet{

    // Dynamic variables - Arrays and Maps

    const __warp_0_owners = 1;

    const __warp_1_isOwner = 2;

    const __warp_3_isConfirmed = 3;

    const __warp_4_transactions = 4;

    // Static variables

    const __warp_2_numConfirmationsRequired = 2;


    func __warp_while0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_10_i : Uint256, __warp_8__owners : felt)-> (__warp_10_i : Uint256, __warp_8__owners : felt){
    alloc_locals;


        
            
            let (__warp_se_0) = wm_dyn_array_length(__warp_8__owners);
            
            let (__warp_se_1) = warp_lt256(__warp_10_i, __warp_se_0);
            
            if (__warp_se_1 != 0){
            
                
                    
                        
                        let (__warp_se_2) = wm_index_dyn(__warp_8__owners, __warp_10_i, Uint256(low=1, high=0));
                        
                        let (__warp_11_owner) = wm_read_felt(__warp_se_2);
                        
                        let (__warp_se_3) = warp_neq(__warp_11_owner, 0);
                        
                        with_attr error_message("invalid owner"){
                            assert __warp_se_3 = 1;
                        }
                        
                        let (__warp_se_4) = WS0_INDEX_felt_to_felt(__warp_1_isOwner, __warp_11_owner);
                        
                        let (__warp_se_5) = WS1_READ_felt(__warp_se_4);
                        
                        with_attr error_message("owner not unique"){
                            assert 1 - __warp_se_5 = 1;
                        }
                        
                        let (__warp_se_6) = WS0_INDEX_felt_to_felt(__warp_1_isOwner, __warp_11_owner);
                        
                        WS_WRITE0(__warp_se_6, 1);
                        
                        WARP_DARRAY0_felt_PUSHV0(__warp_0_owners, __warp_11_owner);
                    
                    let (__warp_pse_0) = warp_add256(__warp_10_i, Uint256(low=1, high=0));
                    
                    let __warp_10_i = __warp_pse_0;
                    
                    warp_sub256(__warp_pse_0, Uint256(low=1, high=0));
                
                let (__warp_10_i, __warp_td_0) = __warp_while0_if_part1(__warp_10_i, __warp_8__owners);
                
                let __warp_8__owners = __warp_td_0;
                
                
                
                return (__warp_10_i, __warp_8__owners);
            }else{
            
                
                    
                    let __warp_10_i = __warp_10_i;
                    
                    let __warp_8__owners = __warp_8__owners;
                    
                    
                    
                    return (__warp_10_i, __warp_8__owners);
            }

    }


    func __warp_while0_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_10_i : Uint256, __warp_8__owners : felt)-> (__warp_10_i : Uint256, __warp_8__owners : felt){
    alloc_locals;


        
        
        
        let (__warp_10_i, __warp_td_2) = __warp_while0(__warp_10_i, __warp_8__owners);
        
        let __warp_8__owners = __warp_td_2;
        
        
        
        return (__warp_10_i, __warp_8__owners);

    }


    func __warp_modifier_onlyOwner_revokeConfirmation_20ea8d86_39{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_5__txIndex36 : Uint256, __warp_parameter___warp_parameter___warp_6__txIndex3337 : Uint256, __warp_parameter___warp_parameter___warp_parameter___warp_20__txIndex313438 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_7) = get_caller_address();
        
        let (__warp_se_8) = WS0_INDEX_felt_to_felt(__warp_1_isOwner, __warp_se_7);
        
        let (__warp_se_9) = WS1_READ_felt(__warp_se_8);
        
        with_attr error_message("not owner"){
            assert __warp_se_9 = 1;
        }
        
        __warp_modifier_txExists_revokeConfirmation_20ea8d86_35(__warp_parameter___warp_5__txIndex36, __warp_parameter___warp_parameter___warp_6__txIndex3337, __warp_parameter___warp_parameter___warp_parameter___warp_20__txIndex313438);
        
        
        
        return ();

    }


    func __warp_modifier_txExists_revokeConfirmation_20ea8d86_35{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_5__txIndex : Uint256, __warp_parameter___warp_6__txIndex33 : Uint256, __warp_parameter___warp_parameter___warp_20__txIndex3134 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_10) = WARP_DARRAY1_Transaction_a4ad9f9e_LENGTH.read(__warp_4_transactions);
        
        let (__warp_se_11) = warp_lt256(__warp_5__txIndex, __warp_se_10);
        
        with_attr error_message("tx does not exist"){
            assert __warp_se_11 = 1;
        }
        
        __warp_modifier_notExecuted_revokeConfirmation_20ea8d86_32(__warp_parameter___warp_6__txIndex33, __warp_parameter___warp_parameter___warp_20__txIndex3134);
        
        
        
        return ();

    }


    func __warp_modifier_notExecuted_revokeConfirmation_20ea8d86_32{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_6__txIndex : Uint256, __warp_parameter___warp_20__txIndex31 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_12) = WARP_DARRAY1_Transaction_a4ad9f9e_IDX(__warp_4_transactions, __warp_6__txIndex);
        
        let (__warp_se_13) = WSM0_Transaction_a4ad9f9e_executed(__warp_se_12);
        
        let (__warp_se_14) = WS1_READ_felt(__warp_se_13);
        
        with_attr error_message("tx already executed"){
            assert 1 - __warp_se_14 = 1;
        }
        
        __warp_original_function_revokeConfirmation_20ea8d86_30(__warp_parameter___warp_20__txIndex31);
        
        
        
        return ();

    }


    func __warp_original_function_revokeConfirmation_20ea8d86_30{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_20__txIndex : Uint256)-> (){
    alloc_locals;


        
        let (__warp_21_transaction) = WARP_DARRAY1_Transaction_a4ad9f9e_IDX(__warp_4_transactions, __warp_20__txIndex);
        
        let (__warp_se_15) = WS1_INDEX_Uint256_to_warp_id(__warp_3_isConfirmed, __warp_20__txIndex);
        
        let (__warp_se_16) = WS0_READ_warp_id(__warp_se_15);
        
        let (__warp_se_17) = get_caller_address();
        
        let (__warp_se_18) = WS0_INDEX_felt_to_felt(__warp_se_16, __warp_se_17);
        
        let (__warp_se_19) = WS1_READ_felt(__warp_se_18);
        
        with_attr error_message("tx not confirmed"){
            assert __warp_se_19 = 1;
        }
        
        let (__warp_se_20) = WSM1_Transaction_a4ad9f9e_numConfirmations(__warp_21_transaction);
        
        let (__warp_se_21) = WSM1_Transaction_a4ad9f9e_numConfirmations(__warp_21_transaction);
        
        let (__warp_se_22) = WS2_READ_Uint256(__warp_se_21);
        
        let (__warp_se_23) = warp_sub256(__warp_se_22, Uint256(low=1, high=0));
        
        WS_WRITE1(__warp_se_20, __warp_se_23);
        
        let (__warp_se_24) = WS1_INDEX_Uint256_to_warp_id(__warp_3_isConfirmed, __warp_20__txIndex);
        
        let (__warp_se_25) = WS0_READ_warp_id(__warp_se_24);
        
        let (__warp_se_26) = get_caller_address();
        
        let (__warp_se_27) = WS0_INDEX_felt_to_felt(__warp_se_25, __warp_se_26);
        
        WS_WRITE0(__warp_se_27, 0);
        
        let (__warp_se_28) = get_caller_address();
        
        _emit_RevokeConfirmation_f0dca620(__warp_se_28, __warp_20__txIndex);
        
        
        
        return ();

    }


    func __warp_modifier_onlyOwner_executeTransaction_ee22610b_29{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_5__txIndex26 : Uint256, __warp_parameter___warp_parameter___warp_6__txIndex2327 : Uint256, __warp_parameter___warp_parameter___warp_parameter___warp_18__txIndex212428 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_29) = get_caller_address();
        
        let (__warp_se_30) = WS0_INDEX_felt_to_felt(__warp_1_isOwner, __warp_se_29);
        
        let (__warp_se_31) = WS1_READ_felt(__warp_se_30);
        
        with_attr error_message("not owner"){
            assert __warp_se_31 = 1;
        }
        
        __warp_modifier_txExists_executeTransaction_ee22610b_25(__warp_parameter___warp_5__txIndex26, __warp_parameter___warp_parameter___warp_6__txIndex2327, __warp_parameter___warp_parameter___warp_parameter___warp_18__txIndex212428);
        
        
        
        return ();

    }


    func __warp_modifier_txExists_executeTransaction_ee22610b_25{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_5__txIndex : Uint256, __warp_parameter___warp_6__txIndex23 : Uint256, __warp_parameter___warp_parameter___warp_18__txIndex2124 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_32) = WARP_DARRAY1_Transaction_a4ad9f9e_LENGTH.read(__warp_4_transactions);
        
        let (__warp_se_33) = warp_lt256(__warp_5__txIndex, __warp_se_32);
        
        with_attr error_message("tx does not exist"){
            assert __warp_se_33 = 1;
        }
        
        __warp_modifier_notExecuted_executeTransaction_ee22610b_22(__warp_parameter___warp_6__txIndex23, __warp_parameter___warp_parameter___warp_18__txIndex2124);
        
        
        
        return ();

    }


    func __warp_modifier_notExecuted_executeTransaction_ee22610b_22{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_6__txIndex : Uint256, __warp_parameter___warp_18__txIndex21 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_34) = WARP_DARRAY1_Transaction_a4ad9f9e_IDX(__warp_4_transactions, __warp_6__txIndex);
        
        let (__warp_se_35) = WSM0_Transaction_a4ad9f9e_executed(__warp_se_34);
        
        let (__warp_se_36) = WS1_READ_felt(__warp_se_35);
        
        with_attr error_message("tx already executed"){
            assert 1 - __warp_se_36 = 1;
        }
        
        __warp_original_function_executeTransaction_ee22610b_20(__warp_parameter___warp_18__txIndex21);
        
        
        
        return ();

    }


    func __warp_original_function_executeTransaction_ee22610b_20{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_18__txIndex : Uint256)-> (){
    alloc_locals;


        
        let (__warp_19_transaction) = WARP_DARRAY1_Transaction_a4ad9f9e_IDX(__warp_4_transactions, __warp_18__txIndex);
        
        let (__warp_se_37) = WSM1_Transaction_a4ad9f9e_numConfirmations(__warp_19_transaction);
        
        let (__warp_se_38) = WS2_READ_Uint256(__warp_se_37);
        
        let (__warp_se_39) = WS2_READ_Uint256(__warp_2_numConfirmationsRequired);
        
        let (__warp_se_40) = warp_ge256(__warp_se_38, __warp_se_39);
        
        with_attr error_message("cannot execute tx"){
            assert __warp_se_40 = 1;
        }
        
        let (__warp_se_41) = WSM0_Transaction_a4ad9f9e_executed(__warp_19_transaction);
        
        WS_WRITE0(__warp_se_41, 1);
        
        with_attr error_message("tx failed"){
            assert 1 = 1;
        }
        
        let (__warp_se_42) = get_caller_address();
        
        _emit_ExecuteTransaction_5445f318(__warp_se_42, __warp_18__txIndex);
        
        
        
        return ();

    }


    func __warp_modifier_onlyOwner_confirmTransaction_c01a8c84_19{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_5__txIndex15 : Uint256, __warp_parameter___warp_parameter___warp_6__txIndex1116 : Uint256, __warp_parameter___warp_parameter___warp_parameter___warp_7__txIndex81217 : Uint256, __warp_parameter___warp_parameter___warp_parameter___warp_parameter___warp_16__txIndex691318 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_43) = get_caller_address();
        
        let (__warp_se_44) = WS0_INDEX_felt_to_felt(__warp_1_isOwner, __warp_se_43);
        
        let (__warp_se_45) = WS1_READ_felt(__warp_se_44);
        
        with_attr error_message("not owner"){
            assert __warp_se_45 = 1;
        }
        
        __warp_modifier_txExists_confirmTransaction_c01a8c84_14(__warp_parameter___warp_5__txIndex15, __warp_parameter___warp_parameter___warp_6__txIndex1116, __warp_parameter___warp_parameter___warp_parameter___warp_7__txIndex81217, __warp_parameter___warp_parameter___warp_parameter___warp_parameter___warp_16__txIndex691318);
        
        
        
        return ();

    }


    func __warp_modifier_txExists_confirmTransaction_c01a8c84_14{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_5__txIndex : Uint256, __warp_parameter___warp_6__txIndex11 : Uint256, __warp_parameter___warp_parameter___warp_7__txIndex812 : Uint256, __warp_parameter___warp_parameter___warp_parameter___warp_16__txIndex6913 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_46) = WARP_DARRAY1_Transaction_a4ad9f9e_LENGTH.read(__warp_4_transactions);
        
        let (__warp_se_47) = warp_lt256(__warp_5__txIndex, __warp_se_46);
        
        with_attr error_message("tx does not exist"){
            assert __warp_se_47 = 1;
        }
        
        __warp_modifier_notExecuted_confirmTransaction_c01a8c84_10(__warp_parameter___warp_6__txIndex11, __warp_parameter___warp_parameter___warp_7__txIndex812, __warp_parameter___warp_parameter___warp_parameter___warp_16__txIndex6913);
        
        
        
        return ();

    }


    func __warp_modifier_notExecuted_confirmTransaction_c01a8c84_10{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_6__txIndex : Uint256, __warp_parameter___warp_7__txIndex8 : Uint256, __warp_parameter___warp_parameter___warp_16__txIndex69 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_48) = WARP_DARRAY1_Transaction_a4ad9f9e_IDX(__warp_4_transactions, __warp_6__txIndex);
        
        let (__warp_se_49) = WSM0_Transaction_a4ad9f9e_executed(__warp_se_48);
        
        let (__warp_se_50) = WS1_READ_felt(__warp_se_49);
        
        with_attr error_message("tx already executed"){
            assert 1 - __warp_se_50 = 1;
        }
        
        __warp_modifier_notConfirmed_confirmTransaction_c01a8c84_7(__warp_parameter___warp_7__txIndex8, __warp_parameter___warp_parameter___warp_16__txIndex69);
        
        
        
        return ();

    }


    func __warp_modifier_notConfirmed_confirmTransaction_c01a8c84_7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_7__txIndex : Uint256, __warp_parameter___warp_16__txIndex6 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_51) = WS1_INDEX_Uint256_to_warp_id(__warp_3_isConfirmed, __warp_7__txIndex);
        
        let (__warp_se_52) = WS0_READ_warp_id(__warp_se_51);
        
        let (__warp_se_53) = get_caller_address();
        
        let (__warp_se_54) = WS0_INDEX_felt_to_felt(__warp_se_52, __warp_se_53);
        
        let (__warp_se_55) = WS1_READ_felt(__warp_se_54);
        
        with_attr error_message("tx already confirmed"){
            assert 1 - __warp_se_55 = 1;
        }
        
        __warp_original_function_confirmTransaction_c01a8c84_5(__warp_parameter___warp_16__txIndex6);
        
        
        
        return ();

    }


    func __warp_original_function_confirmTransaction_c01a8c84_5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_16__txIndex : Uint256)-> (){
    alloc_locals;


        
        let (__warp_17_transaction) = WARP_DARRAY1_Transaction_a4ad9f9e_IDX(__warp_4_transactions, __warp_16__txIndex);
        
        let (__warp_se_56) = WSM1_Transaction_a4ad9f9e_numConfirmations(__warp_17_transaction);
        
        let (__warp_se_57) = WSM1_Transaction_a4ad9f9e_numConfirmations(__warp_17_transaction);
        
        let (__warp_se_58) = WS2_READ_Uint256(__warp_se_57);
        
        let (__warp_se_59) = warp_add256(__warp_se_58, Uint256(low=1, high=0));
        
        WS_WRITE1(__warp_se_56, __warp_se_59);
        
        let (__warp_se_60) = WS1_INDEX_Uint256_to_warp_id(__warp_3_isConfirmed, __warp_16__txIndex);
        
        let (__warp_se_61) = WS0_READ_warp_id(__warp_se_60);
        
        let (__warp_se_62) = get_caller_address();
        
        let (__warp_se_63) = WS0_INDEX_felt_to_felt(__warp_se_61, __warp_se_62);
        
        WS_WRITE0(__warp_se_63, 1);
        
        let (__warp_se_64) = get_caller_address();
        
        _emit_ConfirmTransaction_5cbe105e(__warp_se_64, __warp_16__txIndex);
        
        
        
        return ();

    }


    func __warp_modifier_onlyOwner_submitTransaction_c6427474_4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_12__to1 : felt, __warp_parameter___warp_13__value2 : Uint256, __warp_parameter___warp_14__data3 : felt)-> (){
    alloc_locals;


        
        let (__warp_se_65) = get_caller_address();
        
        let (__warp_se_66) = WS0_INDEX_felt_to_felt(__warp_1_isOwner, __warp_se_65);
        
        let (__warp_se_67) = WS1_READ_felt(__warp_se_66);
        
        with_attr error_message("not owner"){
            assert __warp_se_67 = 1;
        }
        
        __warp_original_function_submitTransaction_c6427474_0(__warp_parameter___warp_12__to1, __warp_parameter___warp_13__value2, __warp_parameter___warp_14__data3);
        
        
        
        return ();

    }


    func __warp_original_function_submitTransaction_c6427474_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_12__to : felt, __warp_13__value : Uint256, __warp_14__data : felt)-> (){
    alloc_locals;


        
        let (__warp_15_txIndex) = WARP_DARRAY1_Transaction_a4ad9f9e_LENGTH.read(__warp_4_transactions);
        
        let (__warp_se_68) = WM0_struct_Transaction_a4ad9f9e(__warp_12__to, __warp_13__value, __warp_14__data, 0, Uint256(low=0, high=0));
        
        WARP_DARRAY1_Transaction_a4ad9f9e_PUSHV1(__warp_4_transactions, __warp_se_68);
        
        let (__warp_se_69) = get_caller_address();
        
        _emit_SubmitTransaction_d5a05bf7(__warp_se_69, __warp_15_txIndex, __warp_12__to, __warp_13__value, __warp_14__data);
        
        
        
        return ();

    }


    func __warp_conditional___warp_constructor_0_1{range_check_ptr : felt, warp_memory : DictAccess*}(__warp_9__numConfirmationsRequired : Uint256, __warp_8__owners : felt)-> (__warp_rc_0 : felt, __warp_9__numConfirmationsRequired : Uint256, __warp_8__owners : felt){
    alloc_locals;


        
        let (__warp_se_70) = warp_gt256(__warp_9__numConfirmationsRequired, Uint256(low=0, high=0));
        
        if (__warp_se_70 != 0){
        
            
            let (__warp_se_71) = wm_dyn_array_length(__warp_8__owners);
            
            let (__warp_se_72) = warp_le256(__warp_9__numConfirmationsRequired, __warp_se_71);
            
            let __warp_rc_0 = __warp_se_72;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_9__numConfirmationsRequired = __warp_9__numConfirmationsRequired;
            
            let __warp_8__owners = __warp_8__owners;
            
            
            
            return (__warp_rc_0, __warp_9__numConfirmationsRequired, __warp_8__owners);
        }else{
        
            
            let __warp_rc_0 = 0;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_9__numConfirmationsRequired = __warp_9__numConfirmationsRequired;
            
            let __warp_8__owners = __warp_8__owners;
            
            
            
            return (__warp_rc_0, __warp_9__numConfirmationsRequired, __warp_8__owners);
        }

    }


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_8__owners : felt, __warp_9__numConfirmationsRequired : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_73) = wm_dyn_array_length(__warp_8__owners);
        
        let (__warp_se_74) = warp_gt256(__warp_se_73, Uint256(low=0, high=0));
        
        with_attr error_message("owners required"){
            assert __warp_se_74 = 1;
        }
        
        let __warp_rc_0 = 0;
        
            
            let (__warp_tv_0, __warp_tv_1, __warp_td_3) = __warp_conditional___warp_constructor_0_1(__warp_9__numConfirmationsRequired, __warp_8__owners);
            
            let __warp_tv_2 = __warp_td_3;
            
            let __warp_8__owners = __warp_tv_2;
            
            let __warp_9__numConfirmationsRequired = __warp_tv_1;
            
            let __warp_rc_0 = __warp_tv_0;
        
        with_attr error_message("invalid number of required confirmations"){
            assert __warp_rc_0 = 1;
        }
        
            
            let __warp_10_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_3, __warp_td_4) = __warp_while0(__warp_10_i, __warp_8__owners);
                
                let __warp_tv_4 = __warp_td_4;
                
                let __warp_8__owners = __warp_tv_4;
                
                let __warp_10_i = __warp_tv_3;
        
        WS_WRITE1(__warp_2_numConfirmationsRequired, __warp_9__numConfirmationsRequired);
        
        
        
        return ();

    }

}


    @external
    func submitTransaction_c6427474{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_12__to : felt, __warp_13__value : Uint256, __warp_14__data_len : felt, __warp_14__data : felt*)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        extern_input_check0(__warp_14__data_len, __warp_14__data);
        
        warp_external_input_check_int256(__warp_13__value);
        
        warp_external_input_check_address(__warp_12__to);
        
        local __warp_14__data_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_14__data_len, __warp_14__data);
        
        let (__warp_14__data_mem) = cd_to_memory0(__warp_14__data_dstruct);
        
        MultiSigWallet.__warp_modifier_onlyOwner_submitTransaction_c6427474_4(__warp_12__to, __warp_13__value, __warp_14__data_mem);
        
        let __warp_uv0 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func confirmTransaction_c01a8c84{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_16__txIndex : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_16__txIndex);
        
        MultiSigWallet.__warp_modifier_onlyOwner_confirmTransaction_c01a8c84_19(__warp_16__txIndex, __warp_16__txIndex, __warp_16__txIndex, __warp_16__txIndex);
        
        let __warp_uv1 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func executeTransaction_ee22610b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_18__txIndex : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_18__txIndex);
        
        MultiSigWallet.__warp_modifier_onlyOwner_executeTransaction_ee22610b_29(__warp_18__txIndex, __warp_18__txIndex, __warp_18__txIndex);
        
        let __warp_uv2 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func revokeConfirmation_20ea8d86{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_20__txIndex : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_20__txIndex);
        
        MultiSigWallet.__warp_modifier_onlyOwner_revokeConfirmation_20ea8d86_39(__warp_20__txIndex, __warp_20__txIndex, __warp_20__txIndex);
        
        let __warp_uv3 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func getOwners_a0e67e2b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_22_len : felt, __warp_22 : felt*){
    alloc_locals;


        
        let (__warp_se_75) = ws_dynamic_array_to_calldata0(MultiSigWallet.__warp_0_owners);
        
        
        
        return (__warp_se_75.len, __warp_se_75.ptr,);

    }


    @view
    func getTransactionCount_2e7700f0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_23 : Uint256){
    alloc_locals;


        
        let (__warp_se_76) = WARP_DARRAY1_Transaction_a4ad9f9e_LENGTH.read(MultiSigWallet.__warp_4_transactions);
        
        
        
        return (__warp_se_76,);

    }


    @view
    func getTransaction_33ea3dc8{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_24__txIndex : Uint256)-> (to : felt, value : Uint256, data_len : felt, data : felt*, executed : felt, numConfirmations : Uint256){
    alloc_locals;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        warp_external_input_check_int256(__warp_24__txIndex);
        
        let (__warp_25_transaction) = WARP_DARRAY1_Transaction_a4ad9f9e_IDX(MultiSigWallet.__warp_4_transactions, __warp_24__txIndex);
        
        let (__warp_se_77) = WSM2_Transaction_a4ad9f9e_to(__warp_25_transaction);
        
        let (to) = WS1_READ_felt(__warp_se_77);
        
        let (__warp_se_78) = WSM3_Transaction_a4ad9f9e_value(__warp_25_transaction);
        
        let (value) = WS2_READ_Uint256(__warp_se_78);
        
        let (__warp_se_79) = WSM4_Transaction_a4ad9f9e_data(__warp_25_transaction);
        
        let (__warp_se_80) = WS0_READ_warp_id(__warp_se_79);
        
        let (data) = ws_to_memory0(__warp_se_80);
        
        let (__warp_se_81) = WSM0_Transaction_a4ad9f9e_executed(__warp_25_transaction);
        
        let (executed) = WS1_READ_felt(__warp_se_81);
        
        let (__warp_se_82) = WSM1_Transaction_a4ad9f9e_numConfirmations(__warp_25_transaction);
        
        let (numConfirmations) = WS2_READ_Uint256(__warp_se_82);
        
        let (__warp_se_83) = wm_to_calldata0(data);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return (to, value, __warp_se_83.len, __warp_se_83.ptr, executed, numConfirmations);
    }
    }


    @view
    func owners_025e7c27{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_26__i0 : Uint256)-> (__warp_27 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_26__i0);
        
        let (__warp_se_84) = WARP_DARRAY0_felt_IDX(MultiSigWallet.__warp_0_owners, __warp_26__i0);
        
        let (__warp_se_85) = WS1_READ_felt(__warp_se_84);
        
        
        
        return (__warp_se_85,);

    }


    @view
    func isOwner_2f54bf6e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_28__i0 : felt)-> (__warp_29 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_28__i0);
        
        let (__warp_se_86) = WS0_INDEX_felt_to_felt(MultiSigWallet.__warp_1_isOwner, __warp_28__i0);
        
        let (__warp_se_87) = WS1_READ_felt(__warp_se_86);
        
        
        
        return (__warp_se_87,);

    }


    @view
    func numConfirmationsRequired_d0549b85{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_30 : Uint256){
    alloc_locals;


        
        let (__warp_se_88) = WS2_READ_Uint256(MultiSigWallet.__warp_2_numConfirmationsRequired);
        
        
        
        return (__warp_se_88,);

    }


    @view
    func isConfirmed_80f59a65{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_31__i0 : Uint256, __warp_32__i1 : felt)-> (__warp_33 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_32__i1);
        
        warp_external_input_check_int256(__warp_31__i0);
        
        let (__warp_se_89) = WS1_INDEX_Uint256_to_warp_id(MultiSigWallet.__warp_3_isConfirmed, __warp_31__i0);
        
        let (__warp_se_90) = WS0_READ_warp_id(__warp_se_89);
        
        let (__warp_se_91) = WS0_INDEX_felt_to_felt(__warp_se_90, __warp_32__i1);
        
        let (__warp_se_92) = WS1_READ_felt(__warp_se_91);
        
        
        
        return (__warp_se_92,);

    }


    @view
    func transactions_9ace38c2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_34__i0 : Uint256)-> (__warp_35 : felt, __warp_36 : Uint256, __warp_37_len : felt, __warp_37 : felt*, __warp_38 : felt, __warp_39 : Uint256){
    alloc_locals;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        warp_external_input_check_int256(__warp_34__i0);
        
        let (__warp_40__temp0) = WARP_DARRAY1_Transaction_a4ad9f9e_IDX(MultiSigWallet.__warp_4_transactions, __warp_34__i0);
        
        let (__warp_se_93) = WSM2_Transaction_a4ad9f9e_to(__warp_40__temp0);
        
        let (__warp_35) = WS1_READ_felt(__warp_se_93);
        
        let (__warp_se_94) = WSM3_Transaction_a4ad9f9e_value(__warp_40__temp0);
        
        let (__warp_36) = WS2_READ_Uint256(__warp_se_94);
        
        let (__warp_se_95) = WSM4_Transaction_a4ad9f9e_data(__warp_40__temp0);
        
        let (__warp_se_96) = WS0_READ_warp_id(__warp_se_95);
        
        let (__warp_37) = ws_to_memory0(__warp_se_96);
        
        let (__warp_se_97) = WSM0_Transaction_a4ad9f9e_executed(__warp_40__temp0);
        
        let (__warp_38) = WS1_READ_felt(__warp_se_97);
        
        let (__warp_se_98) = WSM1_Transaction_a4ad9f9e_numConfirmations(__warp_40__temp0);
        
        let (__warp_39) = WS2_READ_Uint256(__warp_se_98);
        
        let (__warp_se_99) = wm_to_calldata0(__warp_37);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return (__warp_35, __warp_36, __warp_se_99.len, __warp_se_99.ptr, __warp_38, __warp_39);
    }
    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_8__owners_len : felt, __warp_8__owners : felt*, __warp_9__numConfirmationsRequired : Uint256){
    alloc_locals;
    WARP_USED_STORAGE.write(6);
    WARP_NAMEGEN.write(4);
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        warp_external_input_check_int256(__warp_9__numConfirmationsRequired);
        
        extern_input_check1(__warp_8__owners_len, __warp_8__owners);
        
        local __warp_8__owners_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_8__owners_len, __warp_8__owners);
        
        let (__warp_8__owners_mem) = cd_to_memory1(__warp_8__owners_dstruct);
        
        MultiSigWallet.__warp_constructor_0(__warp_8__owners_mem, __warp_9__numConfirmationsRequired);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
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