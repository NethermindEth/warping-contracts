%lang starknet


from warplib.memory import wm_read_felt, wm_read_256, wm_alloc, wm_new, wm_to_felt_array
from starkware.cairo.common.dict import dict_write, dict_read
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.uint256 import Uint256
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int32
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array_spl
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from warplib.maths.utils import felt_to_uint256
from warplib.keccak import felt_array_concat, pack_bytes_felt
from starkware.starknet.common.syscalls import emit_event, get_caller_address, get_contract_address
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.int_conversions import warp_uint256
from warplib.block_methods import warp_block_timestamp
from warplib.maths.ge import warp_ge256, warp_ge
from warplib.maths.add import warp_add256
from warplib.maths.le import warp_le256
from warplib.maths.eq import warp_eq
from warplib.maths.lt import warp_lt256
from warplib.maths.sub import warp_sub256
from warplib.maths.gt import warp_gt256


struct Campaign_fbfbf307{
    creator : felt,
    goal : Uint256,
    pledged : Uint256,
    startAt : felt,
    endAt : felt,
    claimed : felt,
}


func WM0_Campaign_fbfbf307_creator(loc: felt) -> (memberLoc: felt){
    return (loc,);
}

func WM1_Campaign_fbfbf307_startAt(loc: felt) -> (memberLoc: felt){
    return (loc + 5,);
}

func WM2_Campaign_fbfbf307_endAt(loc: felt) -> (memberLoc: felt){
    return (loc + 6,);
}

func WM3_Campaign_fbfbf307_pledged(loc: felt) -> (memberLoc: felt){
    return (loc + 3,);
}

func WM4_Campaign_fbfbf307_goal(loc: felt) -> (memberLoc: felt){
    return (loc + 1,);
}

func WM0_struct_Campaign_fbfbf307{range_check_ptr, warp_memory: DictAccess*}(member_creator: felt, member_goal: Uint256, member_pledged: Uint256, member_startAt: felt, member_endAt: felt, member_claimed: felt) -> (res:felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x8, 0x0));
dict_write{dict_ptr=warp_memory}(start, member_creator);
dict_write{dict_ptr=warp_memory}(start + 1, member_goal.low);
dict_write{dict_ptr=warp_memory}(start + 2, member_goal.high);
dict_write{dict_ptr=warp_memory}(start + 3, member_pledged.low);
dict_write{dict_ptr=warp_memory}(start + 4, member_pledged.high);
dict_write{dict_ptr=warp_memory}(start + 5, member_startAt);
dict_write{dict_ptr=warp_memory}(start + 6, member_endAt);
dict_write{dict_ptr=warp_memory}(start + 7, member_claimed);
    return (start,);
}

func wm_to_storage0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(loc : felt, mem_loc: felt) -> (loc: felt){
    alloc_locals;
let (elem_mem_loc_0) = dict_read{dict_ptr=warp_memory}(mem_loc);
WARP_STORAGE.write(loc, elem_mem_loc_0);
let (elem_mem_loc_1) = dict_read{dict_ptr=warp_memory}(mem_loc + 1);
WARP_STORAGE.write(loc + 1, elem_mem_loc_1);
let (elem_mem_loc_2) = dict_read{dict_ptr=warp_memory}(mem_loc + 2);
WARP_STORAGE.write(loc + 2, elem_mem_loc_2);
let (elem_mem_loc_3) = dict_read{dict_ptr=warp_memory}(mem_loc + 3);
WARP_STORAGE.write(loc + 3, elem_mem_loc_3);
let (elem_mem_loc_4) = dict_read{dict_ptr=warp_memory}(mem_loc + 4);
WARP_STORAGE.write(loc + 4, elem_mem_loc_4);
let (elem_mem_loc_5) = dict_read{dict_ptr=warp_memory}(mem_loc + 5);
WARP_STORAGE.write(loc + 5, elem_mem_loc_5);
let (elem_mem_loc_6) = dict_read{dict_ptr=warp_memory}(mem_loc + 6);
WARP_STORAGE.write(loc + 6, elem_mem_loc_6);
let (elem_mem_loc_7) = dict_read{dict_ptr=warp_memory}(mem_loc + 7);
WARP_STORAGE.write(loc + 7, elem_mem_loc_7);
    return (loc,);
}

func WS_STRUCT_Campaign_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt){
   alloc_locals;
    WS1_DELETE(loc);
    WS2_DELETE(loc + 1);
    WS2_DELETE(loc + 3);
    WS3_DELETE(loc + 5);
    WS3_DELETE(loc + 6);
    WS4_DELETE(loc + 7);
   return ();
}

func WS1_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt){
    WARP_STORAGE.write(loc, 0);
    return ();
}

func WS2_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt){
    WARP_STORAGE.write(loc, 0);
    WARP_STORAGE.write(loc + 1, 0);
    return ();
}

func WS3_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt){
    WARP_STORAGE.write(loc, 0);
    return ();
}

func WS4_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt){
    WARP_STORAGE.write(loc, 0);
    return ();
}

func WSM0_Campaign_fbfbf307_startAt(loc: felt) -> (memberLoc: felt){
    return (loc + 5,);
}

func WSM1_Campaign_fbfbf307_endAt(loc: felt) -> (memberLoc: felt){
    return (loc + 6,);
}

func WSM2_Campaign_fbfbf307_pledged(loc: felt) -> (memberLoc: felt){
    return (loc + 3,);
}

func WSM3_Campaign_fbfbf307_creator(loc: felt) -> (memberLoc: felt){
    return (loc,);
}

func WSM4_Campaign_fbfbf307_goal(loc: felt) -> (memberLoc: felt){
    return (loc + 1,);
}

func WSM5_Campaign_fbfbf307_claimed(loc: felt) -> (memberLoc: felt){
    return (loc + 7,);
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

func ws_to_memory0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(loc : felt) -> (mem_loc: felt){
    alloc_locals;
    let (mem_start) = wm_alloc(Uint256(0x8, 0x0));
let (copy0) = WARP_STORAGE.read(loc);
dict_write{dict_ptr=warp_memory}(mem_start, copy0);
let (copy1) = WARP_STORAGE.read(loc + 1);
dict_write{dict_ptr=warp_memory}(mem_start + 1, copy1);
let (copy2) = WARP_STORAGE.read(loc + 2);
dict_write{dict_ptr=warp_memory}(mem_start + 2, copy2);
let (copy3) = WARP_STORAGE.read(loc + 3);
dict_write{dict_ptr=warp_memory}(mem_start + 3, copy3);
let (copy4) = WARP_STORAGE.read(loc + 4);
dict_write{dict_ptr=warp_memory}(mem_start + 4, copy4);
let (copy5) = WARP_STORAGE.read(loc + 5);
dict_write{dict_ptr=warp_memory}(mem_start + 5, copy5);
let (copy6) = WARP_STORAGE.read(loc + 6);
dict_write{dict_ptr=warp_memory}(mem_start + 6, copy6);
let (copy7) = WARP_STORAGE.read(loc + 7);
dict_write{dict_ptr=warp_memory}(mem_start + 7, copy7);
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

func _emit_Launch_0601cd0d{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : felt, param2 : Uint256, param3 : felt, param4 : felt){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x3720001408ad73ea210d453a94cc33c810bcb60996e927ad70d9db1d8a5d6b5);// keccak of event signature: Launch(uint256,address,uint256,uint32,uint32)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode0(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode2(param3);
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

func _emit_Cancel_8bf30e7f{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x128d62bc976b4483b5177f0c81d1d9f96878343335879fc2259c892760e7585);// keccak of event signature: Cancel(uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_Pledge_06bdb975{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x2dcb6a47500262409b9a6555329daa856082169ff22d9be76a262f3e6f9570e);// keccak of event signature: Pledge(uint256,address,uint256)
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
   let (mem_encode: felt) = abi_encode0(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_Unpledge_2eeeab89{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x38d6333768972c5778c321a10228cbd3f71d461d903ce94ffeaa0356b899444);// keccak of event signature: Unpledge(uint256,address,uint256)
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
   let (mem_encode: felt) = abi_encode0(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_Claim_7bb2b3c1{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x330af8667b0e4a3d0afe6fc7f73e89242acbc101de17d76698846a72d4534b9);// keccak of event signature: Claim(uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_Refund_21e12a7c{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x3fc585dc4e2635a07d8207ed57e685bacbf354a2a2cebaf9e28eac6dac142e8);// keccak of event signature: Refund(uint256,address,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode0(param2);
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
func WS0_INDEX_Uint256_to_Campaign_fbfbf307{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: Uint256) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING0.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 8);
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
func WARP_MAPPING2(name: felt, index: Uint256) -> (resLoc : felt){
}
func WS2_INDEX_Uint256_to_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: Uint256) -> (res: felt){
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


// Contract Def CrowdFund


// @event
// func Launch(id : Uint256, creator : felt, goal : Uint256, startAt : felt, endAt : felt){
// }


// @event
// func Cancel(id : Uint256){
// }


// @event
// func Pledge(id : Uint256, caller : felt, amount : Uint256){
// }


// @event
// func Unpledge(id : Uint256, caller : felt, amount : Uint256){
// }


// @event
// func Claim(id : Uint256){
// }


// @event
// func Refund(id : Uint256, caller : felt, amount : Uint256){
// }

namespace CrowdFund{

    // Dynamic variables - Arrays and Maps

    const __warp_2_campaigns = 1;

    const __warp_3_pledgedAmount = 2;

    // Static variables

    const __warp_0_token = 0;

    const __warp_1_count = 1;


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_4__token : felt)-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_token, __warp_4__token);
        
        
        
        return ();

    }

}


    @external
    func launch_2c63f146{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_5__goal : Uint256, __warp_6__startAt : felt, __warp_7__endAt : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int32(__warp_7__endAt);
        
        warp_external_input_check_int32(__warp_6__startAt);
        
        warp_external_input_check_int256(__warp_5__goal);
        
        let (__warp_se_0) = warp_uint256(__warp_6__startAt);
        
        let (__warp_se_1) = warp_block_timestamp();
        
        let (__warp_se_2) = warp_ge256(__warp_se_0, __warp_se_1);
        
        with_attr error_message("start at < now"){
            assert __warp_se_2 = 1;
        }
        
        let (__warp_se_3) = warp_ge(__warp_7__endAt, __warp_6__startAt);
        
        with_attr error_message("end at < start at"){
            assert __warp_se_3 = 1;
        }
        
        let (__warp_se_4) = warp_uint256(__warp_7__endAt);
        
        let (__warp_se_5) = warp_block_timestamp();
        
        let (__warp_se_6) = warp_add256(__warp_se_5, Uint256(low=7776000, high=0));
        
        let (__warp_se_7) = warp_le256(__warp_se_4, __warp_se_6);
        
        with_attr error_message("end at > max duration"){
            assert __warp_se_7 = 1;
        }
        
        let (__warp_se_8) = WS1_READ_Uint256(CrowdFund.__warp_1_count);
        
        let (__warp_se_9) = warp_add256(__warp_se_8, Uint256(low=1, high=0));
        
        WS_WRITE1(CrowdFund.__warp_1_count, __warp_se_9);
        
        let (__warp_se_10) = WS1_READ_Uint256(CrowdFund.__warp_1_count);
        
        let (__warp_se_11) = WS0_INDEX_Uint256_to_Campaign_fbfbf307(CrowdFund.__warp_2_campaigns, __warp_se_10);
        
        let (__warp_se_12) = get_caller_address();
        
        let (__warp_se_13) = WM0_struct_Campaign_fbfbf307(__warp_se_12, __warp_5__goal, Uint256(low=0, high=0), __warp_6__startAt, __warp_7__endAt, 0);
        
        wm_to_storage0(__warp_se_11, __warp_se_13);
        
        let (__warp_se_14) = WS1_READ_Uint256(CrowdFund.__warp_1_count);
        
        let (__warp_se_15) = get_caller_address();
        
        _emit_Launch_0601cd0d(__warp_se_14, __warp_se_15, __warp_5__goal, __warp_6__startAt, __warp_7__endAt);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func cancel_40e58ee5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_8__id : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_8__id);
        
        let (__warp_se_16) = WS0_INDEX_Uint256_to_Campaign_fbfbf307(CrowdFund.__warp_2_campaigns, __warp_8__id);
        
        let (__warp_9_campaign) = ws_to_memory0(__warp_se_16);
        
        let (__warp_se_17) = WM0_Campaign_fbfbf307_creator(__warp_9_campaign);
        
        let (__warp_se_18) = wm_read_felt(__warp_se_17);
        
        let (__warp_se_19) = get_caller_address();
        
        let (__warp_se_20) = warp_eq(__warp_se_18, __warp_se_19);
        
        with_attr error_message("not creator"){
            assert __warp_se_20 = 1;
        }
        
        let (__warp_se_21) = warp_block_timestamp();
        
        let (__warp_se_22) = WM1_Campaign_fbfbf307_startAt(__warp_9_campaign);
        
        let (__warp_se_23) = wm_read_felt(__warp_se_22);
        
        let (__warp_se_24) = warp_uint256(__warp_se_23);
        
        let (__warp_se_25) = warp_lt256(__warp_se_21, __warp_se_24);
        
        with_attr error_message("started"){
            assert __warp_se_25 = 1;
        }
        
        let (__warp_se_26) = WS0_INDEX_Uint256_to_Campaign_fbfbf307(CrowdFund.__warp_2_campaigns, __warp_8__id);
        
        WS_STRUCT_Campaign_DELETE(__warp_se_26);
        
        _emit_Cancel_8bf30e7f(__warp_8__id);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func pledge_fde327be{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_10__id : Uint256, __warp_11__amount : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_11__amount);
        
        warp_external_input_check_int256(__warp_10__id);
        
        let (__warp_12_campaign) = WS0_INDEX_Uint256_to_Campaign_fbfbf307(CrowdFund.__warp_2_campaigns, __warp_10__id);
        
        let (__warp_se_27) = warp_block_timestamp();
        
        let (__warp_se_28) = WSM0_Campaign_fbfbf307_startAt(__warp_12_campaign);
        
        let (__warp_se_29) = WS2_READ_felt(__warp_se_28);
        
        let (__warp_se_30) = warp_uint256(__warp_se_29);
        
        let (__warp_se_31) = warp_ge256(__warp_se_27, __warp_se_30);
        
        with_attr error_message("not started"){
            assert __warp_se_31 = 1;
        }
        
        let (__warp_se_32) = warp_block_timestamp();
        
        let (__warp_se_33) = WSM1_Campaign_fbfbf307_endAt(__warp_12_campaign);
        
        let (__warp_se_34) = WS2_READ_felt(__warp_se_33);
        
        let (__warp_se_35) = warp_uint256(__warp_se_34);
        
        let (__warp_se_36) = warp_le256(__warp_se_32, __warp_se_35);
        
        with_attr error_message("ended"){
            assert __warp_se_36 = 1;
        }
        
        let (__warp_se_37) = WSM2_Campaign_fbfbf307_pledged(__warp_12_campaign);
        
        let (__warp_se_38) = WSM2_Campaign_fbfbf307_pledged(__warp_12_campaign);
        
        let (__warp_se_39) = WS1_READ_Uint256(__warp_se_38);
        
        let (__warp_se_40) = warp_add256(__warp_se_39, __warp_11__amount);
        
        WS_WRITE1(__warp_se_37, __warp_se_40);
        
        let (__warp_cs_0) = get_caller_address();
        
        let __warp_cs_1 = __warp_10__id;
        
        let (__warp_se_41) = WS2_INDEX_Uint256_to_warp_id(CrowdFund.__warp_3_pledgedAmount, __warp_cs_1);
        
        let (__warp_se_42) = WS0_READ_warp_id(__warp_se_41);
        
        let (__warp_se_43) = WS1_INDEX_felt_to_Uint256(__warp_se_42, __warp_cs_0);
        
        let (__warp_se_44) = WS2_INDEX_Uint256_to_warp_id(CrowdFund.__warp_3_pledgedAmount, __warp_cs_1);
        
        let (__warp_se_45) = WS0_READ_warp_id(__warp_se_44);
        
        let (__warp_se_46) = WS1_INDEX_felt_to_Uint256(__warp_se_45, __warp_cs_0);
        
        let (__warp_se_47) = WS1_READ_Uint256(__warp_se_46);
        
        let (__warp_se_48) = warp_add256(__warp_se_47, __warp_11__amount);
        
        WS_WRITE1(__warp_se_43, __warp_se_48);
        
        let (__warp_se_49) = WS2_READ_felt(CrowdFund.__warp_0_token);
        
        let (__warp_se_50) = get_caller_address();
        
        let (__warp_se_51) = get_contract_address();
        
        IERC20_warped_interface.transferFrom_23b872dd(__warp_se_49, __warp_se_50, __warp_se_51, __warp_11__amount);
        
        let (__warp_se_52) = get_caller_address();
        
        _emit_Pledge_06bdb975(__warp_10__id, __warp_se_52, __warp_11__amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func unpledge_711853ab{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_13__id : Uint256, __warp_14__amount : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_14__amount);
        
        warp_external_input_check_int256(__warp_13__id);
        
        let (__warp_15_campaign) = WS0_INDEX_Uint256_to_Campaign_fbfbf307(CrowdFund.__warp_2_campaigns, __warp_13__id);
        
        let (__warp_se_53) = warp_block_timestamp();
        
        let (__warp_se_54) = WSM1_Campaign_fbfbf307_endAt(__warp_15_campaign);
        
        let (__warp_se_55) = WS2_READ_felt(__warp_se_54);
        
        let (__warp_se_56) = warp_uint256(__warp_se_55);
        
        let (__warp_se_57) = warp_le256(__warp_se_53, __warp_se_56);
        
        with_attr error_message("ended"){
            assert __warp_se_57 = 1;
        }
        
        let (__warp_se_58) = WSM2_Campaign_fbfbf307_pledged(__warp_15_campaign);
        
        let (__warp_se_59) = WSM2_Campaign_fbfbf307_pledged(__warp_15_campaign);
        
        let (__warp_se_60) = WS1_READ_Uint256(__warp_se_59);
        
        let (__warp_se_61) = warp_sub256(__warp_se_60, __warp_14__amount);
        
        WS_WRITE1(__warp_se_58, __warp_se_61);
        
        let (__warp_cs_2) = get_caller_address();
        
        let __warp_cs_3 = __warp_13__id;
        
        let (__warp_se_62) = WS2_INDEX_Uint256_to_warp_id(CrowdFund.__warp_3_pledgedAmount, __warp_cs_3);
        
        let (__warp_se_63) = WS0_READ_warp_id(__warp_se_62);
        
        let (__warp_se_64) = WS1_INDEX_felt_to_Uint256(__warp_se_63, __warp_cs_2);
        
        let (__warp_se_65) = WS2_INDEX_Uint256_to_warp_id(CrowdFund.__warp_3_pledgedAmount, __warp_cs_3);
        
        let (__warp_se_66) = WS0_READ_warp_id(__warp_se_65);
        
        let (__warp_se_67) = WS1_INDEX_felt_to_Uint256(__warp_se_66, __warp_cs_2);
        
        let (__warp_se_68) = WS1_READ_Uint256(__warp_se_67);
        
        let (__warp_se_69) = warp_sub256(__warp_se_68, __warp_14__amount);
        
        WS_WRITE1(__warp_se_64, __warp_se_69);
        
        let (__warp_se_70) = WS2_READ_felt(CrowdFund.__warp_0_token);
        
        let (__warp_se_71) = get_caller_address();
        
        IERC20_warped_interface.transfer_a9059cbb(__warp_se_70, __warp_se_71, __warp_14__amount);
        
        let (__warp_se_72) = get_caller_address();
        
        _emit_Unpledge_2eeeab89(__warp_13__id, __warp_se_72, __warp_14__amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func claim_379607f5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_16__id : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_16__id);
        
        let (__warp_17_campaign) = WS0_INDEX_Uint256_to_Campaign_fbfbf307(CrowdFund.__warp_2_campaigns, __warp_16__id);
        
        let (__warp_se_73) = WSM3_Campaign_fbfbf307_creator(__warp_17_campaign);
        
        let (__warp_se_74) = WS2_READ_felt(__warp_se_73);
        
        let (__warp_se_75) = get_caller_address();
        
        let (__warp_se_76) = warp_eq(__warp_se_74, __warp_se_75);
        
        with_attr error_message("not creator"){
            assert __warp_se_76 = 1;
        }
        
        let (__warp_se_77) = warp_block_timestamp();
        
        let (__warp_se_78) = WSM1_Campaign_fbfbf307_endAt(__warp_17_campaign);
        
        let (__warp_se_79) = WS2_READ_felt(__warp_se_78);
        
        let (__warp_se_80) = warp_uint256(__warp_se_79);
        
        let (__warp_se_81) = warp_gt256(__warp_se_77, __warp_se_80);
        
        with_attr error_message("not ended"){
            assert __warp_se_81 = 1;
        }
        
        let (__warp_se_82) = WSM2_Campaign_fbfbf307_pledged(__warp_17_campaign);
        
        let (__warp_se_83) = WS1_READ_Uint256(__warp_se_82);
        
        let (__warp_se_84) = WSM4_Campaign_fbfbf307_goal(__warp_17_campaign);
        
        let (__warp_se_85) = WS1_READ_Uint256(__warp_se_84);
        
        let (__warp_se_86) = warp_ge256(__warp_se_83, __warp_se_85);
        
        with_attr error_message("pledged < goal"){
            assert __warp_se_86 = 1;
        }
        
        let (__warp_se_87) = WSM5_Campaign_fbfbf307_claimed(__warp_17_campaign);
        
        let (__warp_se_88) = WS2_READ_felt(__warp_se_87);
        
        with_attr error_message("claimed"){
            assert 1 - __warp_se_88 = 1;
        }
        
        let (__warp_se_89) = WSM5_Campaign_fbfbf307_claimed(__warp_17_campaign);
        
        WS_WRITE0(__warp_se_89, 1);
        
        let (__warp_se_90) = WS2_READ_felt(CrowdFund.__warp_0_token);
        
        let (__warp_se_91) = WSM3_Campaign_fbfbf307_creator(__warp_17_campaign);
        
        let (__warp_se_92) = WS2_READ_felt(__warp_se_91);
        
        let (__warp_se_93) = WSM2_Campaign_fbfbf307_pledged(__warp_17_campaign);
        
        let (__warp_se_94) = WS1_READ_Uint256(__warp_se_93);
        
        IERC20_warped_interface.transfer_a9059cbb(__warp_se_90, __warp_se_92, __warp_se_94);
        
        _emit_Claim_7bb2b3c1(__warp_16__id);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func refund_278ecde1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_18__id : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_18__id);
        
        let (__warp_se_95) = WS0_INDEX_Uint256_to_Campaign_fbfbf307(CrowdFund.__warp_2_campaigns, __warp_18__id);
        
        let (__warp_19_campaign) = ws_to_memory0(__warp_se_95);
        
        let (__warp_se_96) = warp_block_timestamp();
        
        let (__warp_se_97) = WM2_Campaign_fbfbf307_endAt(__warp_19_campaign);
        
        let (__warp_se_98) = wm_read_felt(__warp_se_97);
        
        let (__warp_se_99) = warp_uint256(__warp_se_98);
        
        let (__warp_se_100) = warp_gt256(__warp_se_96, __warp_se_99);
        
        with_attr error_message("not ended"){
            assert __warp_se_100 = 1;
        }
        
        let (__warp_se_101) = WM3_Campaign_fbfbf307_pledged(__warp_19_campaign);
        
        let (__warp_se_102) = wm_read_256(__warp_se_101);
        
        let (__warp_se_103) = WM4_Campaign_fbfbf307_goal(__warp_19_campaign);
        
        let (__warp_se_104) = wm_read_256(__warp_se_103);
        
        let (__warp_se_105) = warp_lt256(__warp_se_102, __warp_se_104);
        
        with_attr error_message("pledged >= goal"){
            assert __warp_se_105 = 1;
        }
        
        let (__warp_se_106) = WS2_INDEX_Uint256_to_warp_id(CrowdFund.__warp_3_pledgedAmount, __warp_18__id);
        
        let (__warp_se_107) = WS0_READ_warp_id(__warp_se_106);
        
        let (__warp_se_108) = get_caller_address();
        
        let (__warp_se_109) = WS1_INDEX_felt_to_Uint256(__warp_se_107, __warp_se_108);
        
        let (__warp_20_bal) = WS1_READ_Uint256(__warp_se_109);
        
        let (__warp_se_110) = WS2_INDEX_Uint256_to_warp_id(CrowdFund.__warp_3_pledgedAmount, __warp_18__id);
        
        let (__warp_se_111) = WS0_READ_warp_id(__warp_se_110);
        
        let (__warp_se_112) = get_caller_address();
        
        let (__warp_se_113) = WS1_INDEX_felt_to_Uint256(__warp_se_111, __warp_se_112);
        
        WS_WRITE1(__warp_se_113, Uint256(low=0, high=0));
        
        let (__warp_se_114) = WS2_READ_felt(CrowdFund.__warp_0_token);
        
        let (__warp_se_115) = get_caller_address();
        
        IERC20_warped_interface.transfer_a9059cbb(__warp_se_114, __warp_se_115, __warp_20_bal);
        
        let (__warp_se_116) = get_caller_address();
        
        _emit_Refund_21e12a7c(__warp_18__id, __warp_se_116, __warp_20_bal);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func token_fc0c546a{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_21 : felt){
    alloc_locals;


        
        let (__warp_se_117) = WS2_READ_felt(CrowdFund.__warp_0_token);
        
        
        
        return (__warp_se_117,);

    }


    @view
    func count_06661abd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_22 : Uint256){
    alloc_locals;


        
        let (__warp_se_118) = WS1_READ_Uint256(CrowdFund.__warp_1_count);
        
        
        
        return (__warp_se_118,);

    }


    @view
    func campaigns_141961bc{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_23__i0 : Uint256)-> (__warp_24 : felt, __warp_25 : Uint256, __warp_26 : Uint256, __warp_27 : felt, __warp_28 : felt, __warp_29 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_23__i0);
        
        let (__warp_30__temp0) = WS0_INDEX_Uint256_to_Campaign_fbfbf307(CrowdFund.__warp_2_campaigns, __warp_23__i0);
        
        let (__warp_se_119) = WSM3_Campaign_fbfbf307_creator(__warp_30__temp0);
        
        let (__warp_24) = WS2_READ_felt(__warp_se_119);
        
        let (__warp_se_120) = WSM4_Campaign_fbfbf307_goal(__warp_30__temp0);
        
        let (__warp_25) = WS1_READ_Uint256(__warp_se_120);
        
        let (__warp_se_121) = WSM2_Campaign_fbfbf307_pledged(__warp_30__temp0);
        
        let (__warp_26) = WS1_READ_Uint256(__warp_se_121);
        
        let (__warp_se_122) = WSM0_Campaign_fbfbf307_startAt(__warp_30__temp0);
        
        let (__warp_27) = WS2_READ_felt(__warp_se_122);
        
        let (__warp_se_123) = WSM1_Campaign_fbfbf307_endAt(__warp_30__temp0);
        
        let (__warp_28) = WS2_READ_felt(__warp_se_123);
        
        let (__warp_se_124) = WSM5_Campaign_fbfbf307_claimed(__warp_30__temp0);
        
        let (__warp_29) = WS2_READ_felt(__warp_se_124);
        
        
        
        return (__warp_24, __warp_25, __warp_26, __warp_27, __warp_28, __warp_29);

    }


    @view
    func pledgedAmount_aa4fb63a{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_31__i0 : Uint256, __warp_32__i1 : felt)-> (__warp_33 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_32__i1);
        
        warp_external_input_check_int256(__warp_31__i0);
        
        let (__warp_se_125) = WS2_INDEX_Uint256_to_warp_id(CrowdFund.__warp_3_pledgedAmount, __warp_31__i0);
        
        let (__warp_se_126) = WS0_READ_warp_id(__warp_se_125);
        
        let (__warp_se_127) = WS1_INDEX_felt_to_Uint256(__warp_se_126, __warp_32__i1);
        
        let (__warp_se_128) = WS1_READ_Uint256(__warp_se_127);
        
        
        
        return (__warp_se_128,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_4__token : felt){
    alloc_locals;
    WARP_USED_STORAGE.write(5);
    WARP_NAMEGEN.write(2);


        
        warp_external_input_check_address(__warp_4__token);
        
        CrowdFund.__warp_constructor_0(__warp_4__token);
        
        
        
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


// Contract Def IERC20@interface


@contract_interface
namespace IERC20_warped_interface{
func transfer_a9059cbb(__warp_0 : felt, __warp_1 : Uint256)-> (__warp_2 : felt){
}
func transferFrom_23b872dd(__warp_3 : felt, __warp_4 : felt, __warp_5 : Uint256)-> (__warp_6 : felt){
}
}