%lang starknet


from starkware.cairo.common.dict import dict_read, dict_write
from starkware.cairo.common.uint256 import uint256_sub, uint256_lt, Uint256, uint256_eq, uint256_add
from warplib.memory import wm_dyn_array_length, wm_new, wm_to_felt_array
from warplib.maths.utils import narrow_safe, felt_to_uint256
from warplib.maths.int_conversions import warp_uint256
from starkware.cairo.common.alloc import alloc
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int8
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array_spl
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from warplib.keccak import felt_array_concat, pack_bytes_felt
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from starkware.cairo.common.dict_access import DictAccess
from warplib.maths.eq import warp_eq, warp_eq256
from warplib.maths.neq import warp_neq, warp_neq256
from warplib.maths.gt import warp_gt256
from warplib.maths.div import warp_div256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.le import warp_le256
from warplib.maths.ge import warp_ge256
from warplib.maths.lt import warp_lt256
from warplib.maths.sub import warp_sub256
from warplib.maths.bitwise_not import warp_bitwise_not128
from warplib.maths.add import warp_add256
from warplib.maths.mul import warp_mul256


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
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

func __warp_emit_TotalSupplyUpdatedHighres_41645eb819d3011b13f97696a8109d14bfcddfaca7d063ec0564d62a3e257235{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : Uint256, param1 : Uint256, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0xbfcddfaca7d063ec0564d62a3e257235, 0x41645eb819d3011b13f97696a8109d14);// keccak of event signature: TotalSupplyUpdatedHighres(uint256,uint256,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode0(param1);
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

func __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x952ba7f163c4a11628f55a4df523b3ef, 0xddf252ad1be2c89b69c2b068fc378daa);// keccak of event signature: Transfer(address,address,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param0);
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

func __warp_emit_Approval_8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0xdd0314c0f7b2291e5b200ac8c7c3b925, 0x8c5be1e5ebec7d5bd14f71427d1e84f3);// keccak of event signature: Approval(address,address,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param0);
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

func __warp_emit_OwnershipTransferred_8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x19497f9722a3daafe3b4186f6b6457e0, 0x8be0079c531659141344cd1fd0a4f284);// keccak of event signature: OwnershipTransferred(address,address)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode1(param0);
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

@storage_var
func WARP_DARRAY0_felt(name: felt, index: Uint256) -> (resLoc : felt){
}
@storage_var
func WARP_DARRAY0_felt_LENGTH(name: felt) -> (index: Uint256){
}

@storage_var
func WARP_MAPPING0(name: felt, index: felt) -> (resLoc : felt){
}
func WS0_INDEX_felt_to_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
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


// Contract Def OUSD

//  NOTE that this is an ERC20 token but the invariant that the sum of
// balanceOf(x) for all x is not >= totalSupply(). This is a consequence of the
// rebasing design. Any integrations with OUSD should be aware.

//  @dev Emitted when the allowance of a `spender` for an `owner` is set by
// a call to {approve}. `value` is the new allowance.
// @event
// func Approval(owner : felt, spender : felt, value : Uint256){
// }

//  @dev Emitted when `value` tokens are moved from one account (`from`) to
// another (`to`).
// Note that `value` may be zero.
// @event
// func Transfer(__warp_0_from : felt, to : felt, value : Uint256){
// }


// @event
// func OwnershipTransferred(previousOwner : felt, newOwner : felt){
// }


// @event
// func TotalSupplyUpdatedHighres(totalSupply : Uint256, rebasingCredits : Uint256, rebasingCreditsPerToken : Uint256){
// }

namespace OUSD{

    // Dynamic variables - Arrays and Maps

    const __warp_2__allowances = 1;

    const __warp_4__creditBalances = 2;

    const __warp_8_nonRebasingCreditsPerToken = 3;

    const __warp_9_rebaseState = 4;

    const __warp_10_isUpgraded = 5;

    const __warp_0__balances = 6;

    const __warp_1__allowances = 7;

    const __warp_4__name = 8;

    const __warp_5__symbol = 9;

    // Static variables

    const __warp_0_MAX_SUPPLY = 0;

    const __warp_1__totalSupply = 2;

    const __warp_3_vaultAddress = 5;

    const __warp_5__rebasingCredits = 7;

    const __warp_6__rebasingCreditsPerToken = 9;

    const __warp_7_nonRebasingSupply = 11;

    const RESOLUTION_INCREASE = 16;

    const FULL_SCALE = 18;

    const __warp_0_initialized = 20;

    const __warp_1_initializing = 21;

    const ______gap = 22;

    const __warp_2__totalSupply = 124;

    const __warp_3__decimals = 126;

    const __warp_0__owner = 129;


    func __warp_modifier_onlyOwner_transferOwnership_f2fde38b_15{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_2_newOwner14 : felt)-> (){
    alloc_locals;


        
        let (__warp_pse_0) = owner_8da5cb5b_internal();
        
        let (__warp_pse_1) = _msgSender_119df25f();
        
        let (__warp_se_0) = warp_eq(__warp_pse_0, __warp_pse_1);
        
        with_attr error_message("Ownable: caller is not the owner"){
            assert __warp_se_0 = 1;
        }
        
        __warp_original_function_transferOwnership_f2fde38b_13(__warp_parameter___warp_2_newOwner14);
        
        
        
        return ();

    }

    //  @dev Transfers ownership of the contract to a new account (`newOwner`).
    // Can only be called by the current owner.
    func __warp_original_function_transferOwnership_f2fde38b_13{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_2_newOwner : felt)-> (){
    alloc_locals;


        
        let (__warp_se_1) = warp_neq(__warp_2_newOwner, 0);
        
        with_attr error_message("Ownable: new owner is the zero address"){
            assert __warp_se_1 = 1;
        }
        
        _transferOwnership_d29d44ee(__warp_2_newOwner);
        
        
        
        return ();

    }


    func __warp_modifier_onlyOwner_renounceOwnership_715018a6_12{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_pse_2) = owner_8da5cb5b_internal();
        
        let (__warp_pse_3) = _msgSender_119df25f();
        
        let (__warp_se_2) = warp_eq(__warp_pse_2, __warp_pse_3);
        
        with_attr error_message("Ownable: caller is not the owner"){
            assert __warp_se_2 = 1;
        }
        
        __warp_original_function_renounceOwnership_715018a6_11();
        
        
        
        return ();

    }

    //  @dev Leaves the contract without owner. It will not be possible to call
    // `onlyOwner` functions anymore. Can only be called by the current owner.
    // NOTE: Renouncing ownership will leave the contract without an owner,
    // thereby removing any functionality that is only available to the owner.
    func __warp_original_function_renounceOwnership_715018a6_11{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        _transferOwnership_d29d44ee(0);
        
        
        
        return ();

    }


    func __warp_modifier_onlyVault_changeSupply_39a7919f_10{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_75__newTotalSupply9 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_3) = WS1_READ_felt(__warp_3_vaultAddress);
        
        let (__warp_se_4) = get_caller_address();
        
        let (__warp_se_5) = warp_eq(__warp_se_3, __warp_se_4);
        
        with_attr error_message("Caller is not the Vault"){
            assert __warp_se_5 = 1;
        }
        
        __warp_original_function_changeSupply_39a7919f_8(__warp_parameter___warp_75__newTotalSupply9);
        
        
        
        return ();

    }


    func __warp_conditional___warp_original_function_changeSupply_39a7919f_8_1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_75__newTotalSupply : Uint256)-> (__warp_rc_0 : Uint256, __warp_75__newTotalSupply : Uint256){
    alloc_locals;


        
        let (__warp_se_6) = WS2_READ_Uint256(__warp_0_MAX_SUPPLY);
        
        let (__warp_se_7) = warp_gt256(__warp_75__newTotalSupply, __warp_se_6);
        
        if (__warp_se_7 != 0){
        
            
            let (__warp_se_8) = WS2_READ_Uint256(__warp_0_MAX_SUPPLY);
            
            let __warp_rc_0 = __warp_se_8;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_75__newTotalSupply = __warp_75__newTotalSupply;
            
            
            
            return (__warp_rc_0, __warp_75__newTotalSupply);
        }else{
        
            
            let __warp_rc_0 = __warp_75__newTotalSupply;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_75__newTotalSupply = __warp_75__newTotalSupply;
            
            
            
            return (__warp_rc_0, __warp_75__newTotalSupply);
        }

    }

    //  @dev Modify the supply without minting new tokens. This uses a change in
    //      the exchange rate between "credits" and OUSD tokens to change balances.
    // @param _newTotalSupply New total supply of OUSD.
    func __warp_original_function_changeSupply_39a7919f_8{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_75__newTotalSupply : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_9) = WS2_READ_Uint256(__warp_1__totalSupply);
        
        let (__warp_se_10) = warp_gt256(__warp_se_9, Uint256(low=0, high=0));
        
        with_attr error_message("Cannot increase 0 supply"){
            assert __warp_se_10 = 1;
        }
        
        let (__warp_se_11) = WS2_READ_Uint256(__warp_1__totalSupply);
        
        let (__warp_se_12) = warp_eq256(__warp_se_11, __warp_75__newTotalSupply);
        
            
            if (__warp_se_12 != 0){
            
                
                let (__warp_se_13) = WS2_READ_Uint256(__warp_1__totalSupply);
                
                let (__warp_se_14) = WS2_READ_Uint256(__warp_5__rebasingCredits);
                
                let (__warp_se_15) = WS2_READ_Uint256(__warp_6__rebasingCreditsPerToken);
                
                __warp_emit_TotalSupplyUpdatedHighres_41645eb819d3011b13f97696a8109d14bfcddfaca7d063ec0564d62a3e257235(__warp_se_13, __warp_se_14, __warp_se_15);
                
                
                
                return ();
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_75__newTotalSupply = __warp_75__newTotalSupply;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_75__newTotalSupply = __warp_75__newTotalSupply;
        
        let __warp_rc_0 = Uint256(low=0, high=0);
        
            
            let (__warp_tv_0, __warp_tv_1) = __warp_conditional___warp_original_function_changeSupply_39a7919f_8_1(__warp_75__newTotalSupply);
            
            let __warp_75__newTotalSupply = __warp_tv_1;
            
            let __warp_rc_0 = __warp_tv_0;
        
        WS_WRITE0(__warp_1__totalSupply, __warp_rc_0);
        
        let (__warp_se_16) = WS2_READ_Uint256(__warp_1__totalSupply);
        
        let (__warp_se_17) = WS2_READ_Uint256(__warp_7_nonRebasingSupply);
        
        let (__warp_pse_4) = sub_b67d77c5(__warp_se_16, __warp_se_17);
        
        let (__warp_se_18) = WS2_READ_Uint256(__warp_5__rebasingCredits);
        
        let (__warp_pse_5) = divPrecisely_0b6ab2f0(__warp_se_18, __warp_pse_4);
        
        WS_WRITE0(__warp_6__rebasingCreditsPerToken, __warp_pse_5);
        
        let (__warp_se_19) = WS2_READ_Uint256(__warp_6__rebasingCreditsPerToken);
        
        let (__warp_se_20) = warp_gt256(__warp_se_19, Uint256(low=0, high=0));
        
        with_attr error_message("Invalid change in supply"){
            assert __warp_se_20 = 1;
        }
        
        let (__warp_se_21) = WS2_READ_Uint256(__warp_5__rebasingCredits);
        
        let (__warp_se_22) = WS2_READ_Uint256(__warp_6__rebasingCreditsPerToken);
        
        let (__warp_pse_6) = divPrecisely_0b6ab2f0(__warp_se_21, __warp_se_22);
        
        let (__warp_se_23) = WS2_READ_Uint256(__warp_7_nonRebasingSupply);
        
        let (__warp_pse_7) = add_771602f7(__warp_pse_6, __warp_se_23);
        
        WS_WRITE0(__warp_1__totalSupply, __warp_pse_7);
        
        let (__warp_se_24) = WS2_READ_Uint256(__warp_1__totalSupply);
        
        let (__warp_se_25) = WS2_READ_Uint256(__warp_5__rebasingCredits);
        
        let (__warp_se_26) = WS2_READ_Uint256(__warp_6__rebasingCreditsPerToken);
        
        __warp_emit_TotalSupplyUpdatedHighres_41645eb819d3011b13f97696a8109d14bfcddfaca7d063ec0564d62a3e257235(__warp_se_24, __warp_se_25, __warp_se_26);
        
        
        
        return ();

    }


    func __warp_modifier_onlyVault_burn_9dc29fac_7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_62_account5 : felt, __warp_parameter___warp_63_amount6 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_27) = WS1_READ_felt(__warp_3_vaultAddress);
        
        let (__warp_se_28) = get_caller_address();
        
        let (__warp_se_29) = warp_eq(__warp_se_27, __warp_se_28);
        
        with_attr error_message("Caller is not the Vault"){
            assert __warp_se_29 = 1;
        }
        
        __warp_original_function_burn_9dc29fac_4(__warp_parameter___warp_62_account5, __warp_parameter___warp_63_amount6);
        
        
        
        return ();

    }

    //  @dev Burns tokens, decreasing totalSupply.
    func __warp_original_function_burn_9dc29fac_4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_62_account : felt, __warp_63_amount : Uint256)-> (){
    alloc_locals;


        
        _burn_6161eb18(__warp_62_account, __warp_63_amount);
        
        
        
        return ();

    }


    func __warp_modifier_onlyVault_mint_40c10f19_3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_56__account1 : felt, __warp_parameter___warp_57__amount2 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_30) = WS1_READ_felt(__warp_3_vaultAddress);
        
        let (__warp_se_31) = get_caller_address();
        
        let (__warp_se_32) = warp_eq(__warp_se_30, __warp_se_31);
        
        with_attr error_message("Caller is not the Vault"){
            assert __warp_se_32 = 1;
        }
        
        __warp_original_function_mint_40c10f19_0(__warp_parameter___warp_56__account1, __warp_parameter___warp_57__amount2);
        
        
        
        return ();

    }

    //  @dev Mints new tokens, increasing totalSupply.
    func __warp_original_function_mint_40c10f19_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_56__account : felt, __warp_57__amount : Uint256)-> (){
    alloc_locals;


        
        _mint_4e6ec247(__warp_56__account, __warp_57__amount);
        
        
        
        return ();

    }


    func __warp_constructor_5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_11__nameArg : felt, __warp_12__symbolArg : felt, __warp_13__vaultAddress : felt)-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_6__rebasingCreditsPerToken, Uint256(low=1000000000000000000, high=0));
        
        WS_WRITE1(__warp_3_vaultAddress, __warp_13__vaultAddress);
        
        
        
        return ();

    }

    //  @dev Gets the balance of the specified address.
    // @param _account Address to query the balance of.
    // @return A uint256 representing the amount of base units owned by the
    //         specified address.
    func balanceOf_70a08231_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_19__account : felt)-> (__warp_20 : Uint256){
    alloc_locals;


        
        let (__warp_se_40) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_19__account);
        
        let (__warp_se_41) = WS2_READ_Uint256(__warp_se_40);
        
        let (__warp_se_42) = warp_eq256(__warp_se_41, Uint256(low=0, high=0));
        
            
            if (__warp_se_42 != 0){
            
                
                
                
                return (Uint256(low=0, high=0),);
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar __warp_19__account = __warp_19__account;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar __warp_19__account = __warp_19__account;
        
        let (__warp_pse_8) = _creditsPerToken_130e9bc1(__warp_19__account);
        
        let (__warp_se_43) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_19__account);
        
        let (__warp_se_44) = WS2_READ_Uint256(__warp_se_43);
        
        let (__warp_pse_9) = divPrecisely_0b6ab2f0(__warp_se_44, __warp_pse_8);
        
        
        
        return (__warp_pse_9,);

    }


    func __warp_conditional__executeTransfer_33a738c9_3(__warp_39_isNonRebasingTo : felt, __warp_40_isNonRebasingFrom : felt)-> (__warp_rc_2 : felt, __warp_39_isNonRebasingTo : felt, __warp_40_isNonRebasingFrom : felt){
    alloc_locals;


        
        if (__warp_39_isNonRebasingTo != 0){
        
            
            let __warp_rc_2 = 1 - __warp_40_isNonRebasingFrom;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_39_isNonRebasingTo = __warp_39_isNonRebasingTo;
            
            let __warp_40_isNonRebasingFrom = __warp_40_isNonRebasingFrom;
            
            
            
            return (__warp_rc_2, __warp_39_isNonRebasingTo, __warp_40_isNonRebasingFrom);
        }else{
        
            
            let __warp_rc_2 = 0;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_39_isNonRebasingTo = __warp_39_isNonRebasingTo;
            
            let __warp_40_isNonRebasingFrom = __warp_40_isNonRebasingFrom;
            
            
            
            return (__warp_rc_2, __warp_39_isNonRebasingTo, __warp_40_isNonRebasingFrom);
        }

    }


    func __warp_conditional__executeTransfer_33a738c9_5(__warp_39_isNonRebasingTo : felt, __warp_40_isNonRebasingFrom : felt)-> (__warp_rc_4 : felt, __warp_39_isNonRebasingTo : felt, __warp_40_isNonRebasingFrom : felt){
    alloc_locals;


        
        if (1 - __warp_39_isNonRebasingTo != 0){
        
            
            let __warp_rc_4 = __warp_40_isNonRebasingFrom;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_39_isNonRebasingTo = __warp_39_isNonRebasingTo;
            
            let __warp_40_isNonRebasingFrom = __warp_40_isNonRebasingFrom;
            
            
            
            return (__warp_rc_4, __warp_39_isNonRebasingTo, __warp_40_isNonRebasingFrom);
        }else{
        
            
            let __warp_rc_4 = 0;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_39_isNonRebasingTo = __warp_39_isNonRebasingTo;
            
            let __warp_40_isNonRebasingFrom = __warp_40_isNonRebasingFrom;
            
            
            
            return (__warp_rc_4, __warp_39_isNonRebasingTo, __warp_40_isNonRebasingFrom);
        }

    }

    //  @dev Update the count of non rebasing credits in response to a transfer
    // @param _from The address you want to send tokens from.
    // @param _to The address you want to transfer to.
    // @param _value Amount of OUSD to transfer
    func _executeTransfer_33a738c9{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_36__from : felt, __warp_37__to : felt, __warp_38__value : Uint256)-> (){
    alloc_locals;


        
        let (__warp_39_isNonRebasingTo) = _isNonRebasingAccount_6184aaf5(__warp_37__to);
        
        let (__warp_40_isNonRebasingFrom) = _isNonRebasingAccount_6184aaf5(__warp_36__from);
        
        let (__warp_pse_14) = _creditsPerToken_130e9bc1(__warp_37__to);
        
        let (__warp_41_creditsCredited) = mulTruncate_8f8a618a(__warp_38__value, __warp_pse_14);
        
        let (__warp_pse_15) = _creditsPerToken_130e9bc1(__warp_36__from);
        
        let (__warp_42_creditsDeducted) = mulTruncate_8f8a618a(__warp_38__value, __warp_pse_15);
        
        let (__warp_se_68) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_36__from);
        
        let (__warp_se_69) = WS2_READ_Uint256(__warp_se_68);
        
        let (__warp_pse_16) = sub_b67d77c5(__warp_se_69, __warp_42_creditsDeducted);
        
        let (__warp_se_70) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_36__from);
        
        WS_WRITE0(__warp_se_70, __warp_pse_16);
        
        let (__warp_se_71) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_37__to);
        
        let (__warp_se_72) = WS2_READ_Uint256(__warp_se_71);
        
        let (__warp_pse_17) = add_771602f7(__warp_se_72, __warp_41_creditsCredited);
        
        let (__warp_se_73) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_37__to);
        
        WS_WRITE0(__warp_se_73, __warp_pse_17);
        
        let __warp_rc_2 = 0;
        
            
            let (__warp_tv_2, __warp_tv_3, __warp_tv_4) = __warp_conditional__executeTransfer_33a738c9_3(__warp_39_isNonRebasingTo, __warp_40_isNonRebasingFrom);
            
            let __warp_40_isNonRebasingFrom = __warp_tv_4;
            
            let __warp_39_isNonRebasingTo = __warp_tv_3;
            
            let __warp_rc_2 = __warp_tv_2;
        
            
            if (__warp_rc_2 != 0){
            
                
                let (__warp_se_74) = WS2_READ_Uint256(__warp_7_nonRebasingSupply);
                
                let (__warp_pse_18) = add_771602f7(__warp_se_74, __warp_38__value);
                
                WS_WRITE0(__warp_7_nonRebasingSupply, __warp_pse_18);
                
                let (__warp_se_75) = WS2_READ_Uint256(__warp_5__rebasingCredits);
                
                let (__warp_pse_19) = sub_b67d77c5(__warp_se_75, __warp_42_creditsDeducted);
                
                WS_WRITE0(__warp_5__rebasingCredits, __warp_pse_19);
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
            }else{
            
                
                let __warp_rc_4 = 0;
                
                    
                    let (__warp_tv_5, __warp_tv_6, __warp_tv_7) = __warp_conditional__executeTransfer_33a738c9_5(__warp_39_isNonRebasingTo, __warp_40_isNonRebasingFrom);
                    
                    let __warp_40_isNonRebasingFrom = __warp_tv_7;
                    
                    let __warp_39_isNonRebasingTo = __warp_tv_6;
                    
                    let __warp_rc_4 = __warp_tv_5;
                
                    
                    if (__warp_rc_4 != 0){
                    
                        
                        let (__warp_se_76) = WS2_READ_Uint256(__warp_7_nonRebasingSupply);
                        
                        let (__warp_pse_20) = sub_b67d77c5(__warp_se_76, __warp_38__value);
                        
                        WS_WRITE0(__warp_7_nonRebasingSupply, __warp_pse_20);
                        
                        let (__warp_se_77) = WS2_READ_Uint256(__warp_5__rebasingCredits);
                        
                        let (__warp_pse_21) = add_771602f7(__warp_se_77, __warp_41_creditsCredited);
                        
                        WS_WRITE0(__warp_5__rebasingCredits, __warp_pse_21);
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar pedersen_ptr = pedersen_ptr;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                    }else{
                    
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar pedersen_ptr = pedersen_ptr;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                    }
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
        
        
        
        return ();

    }

    //  @dev Function to check the amount of tokens that _owner has allowed to
    //      `_spender`.
    // @param _owner The address which owns the funds.
    // @param _spender The address which will spend the funds.
    // @return The number of tokens still available for the _spender.
    func allowance_dd62ed3e_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_43__owner : felt, __warp_44__spender : felt)-> (__warp_45 : Uint256){
    alloc_locals;


        
        let (__warp_se_78) = WS1_INDEX_felt_to_warp_id(__warp_2__allowances, __warp_43__owner);
        
        let (__warp_se_79) = WS0_READ_warp_id(__warp_se_78);
        
        let (__warp_se_80) = WS0_INDEX_felt_to_Uint256(__warp_se_79, __warp_44__spender);
        
        let (__warp_se_81) = WS2_READ_Uint256(__warp_se_80);
        
        
        
        return (__warp_se_81,);

    }

    //  @dev Creates `_amount` tokens and assigns them to `_account`, increasing
    // the total supply.
    // Emits a {Transfer} event with `from` set to the zero address.
    // Requirements
    // - `to` cannot be the zero address.
    func _mint_4e6ec247{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_58__account : felt, __warp_59__amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_121) = warp_neq(__warp_58__account, 0);
        
        with_attr error_message("Mint to the zero address"){
            assert __warp_se_121 = 1;
        }
        
        let (__warp_60_isNonRebasingAccount) = _isNonRebasingAccount_6184aaf5(__warp_58__account);
        
        let (__warp_pse_24) = _creditsPerToken_130e9bc1(__warp_58__account);
        
        let (__warp_61_creditAmount) = mulTruncate_8f8a618a(__warp_59__amount, __warp_pse_24);
        
        let (__warp_se_122) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_58__account);
        
        let (__warp_se_123) = WS2_READ_Uint256(__warp_se_122);
        
        let (__warp_pse_25) = add_771602f7(__warp_se_123, __warp_61_creditAmount);
        
        let (__warp_se_124) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_58__account);
        
        WS_WRITE0(__warp_se_124, __warp_pse_25);
        
            
            if (__warp_60_isNonRebasingAccount != 0){
            
                
                let (__warp_se_125) = WS2_READ_Uint256(__warp_7_nonRebasingSupply);
                
                let (__warp_pse_26) = add_771602f7(__warp_se_125, __warp_59__amount);
                
                WS_WRITE0(__warp_7_nonRebasingSupply, __warp_pse_26);
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_58__account = __warp_58__account;
                tempvar __warp_59__amount = __warp_59__amount;
            }else{
            
                
                let (__warp_se_126) = WS2_READ_Uint256(__warp_5__rebasingCredits);
                
                let (__warp_pse_27) = add_771602f7(__warp_se_126, __warp_61_creditAmount);
                
                WS_WRITE0(__warp_5__rebasingCredits, __warp_pse_27);
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_58__account = __warp_58__account;
                tempvar __warp_59__amount = __warp_59__amount;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_58__account = __warp_58__account;
            tempvar __warp_59__amount = __warp_59__amount;
        
        let (__warp_se_127) = WS2_READ_Uint256(__warp_1__totalSupply);
        
        let (__warp_pse_28) = add_771602f7(__warp_se_127, __warp_59__amount);
        
        WS_WRITE0(__warp_1__totalSupply, __warp_pse_28);
        
        let (__warp_se_128) = WS2_READ_Uint256(__warp_1__totalSupply);
        
        let (__warp_se_129) = WS2_READ_Uint256(__warp_0_MAX_SUPPLY);
        
        let (__warp_se_130) = warp_lt256(__warp_se_128, __warp_se_129);
        
        with_attr error_message("Max supply"){
            assert __warp_se_130 = 1;
        }
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(0, __warp_58__account, __warp_59__amount);
        
        
        
        return ();

    }


    func __warp_conditional__burn_6161eb18_7{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_68_currentCredits : Uint256, __warp_67_creditAmount : Uint256)-> (__warp_rc_6 : felt, __warp_68_currentCredits : Uint256, __warp_67_creditAmount : Uint256){
    alloc_locals;


        
        let (__warp_se_131) = warp_eq256(__warp_68_currentCredits, __warp_67_creditAmount);
        
        if (__warp_se_131 != 0){
        
            
            let __warp_rc_6 = 1;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_68_currentCredits = __warp_68_currentCredits;
            
            let __warp_67_creditAmount = __warp_67_creditAmount;
            
            
            
            return (__warp_rc_6, __warp_68_currentCredits, __warp_67_creditAmount);
        }else{
        
            
            let (__warp_se_132) = warp_sub256(__warp_68_currentCredits, Uint256(low=1, high=0));
            
            let (__warp_se_133) = warp_eq256(__warp_se_132, __warp_67_creditAmount);
            
            let __warp_rc_6 = __warp_se_133;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_68_currentCredits = __warp_68_currentCredits;
            
            let __warp_67_creditAmount = __warp_67_creditAmount;
            
            
            
            return (__warp_rc_6, __warp_68_currentCredits, __warp_67_creditAmount);
        }

    }

    //  @dev Destroys `_amount` tokens from `_account`, reducing the
    // total supply.
    // Emits a {Transfer} event with `to` set to the zero address.
    // Requirements
    // - `_account` cannot be the zero address.
    // - `_account` must have at least `_amount` tokens.
    func _burn_6161eb18{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_64__account : felt, __warp_65__amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_134) = warp_neq(__warp_64__account, 0);
        
        with_attr error_message("Burn from the zero address"){
            assert __warp_se_134 = 1;
        }
        
        let (__warp_se_135) = warp_eq256(__warp_65__amount, Uint256(low=0, high=0));
        
            
            if (__warp_se_135 != 0){
            
                
                
                
                return ();
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_64__account = __warp_64__account;
                tempvar __warp_65__amount = __warp_65__amount;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_64__account = __warp_64__account;
            tempvar __warp_65__amount = __warp_65__amount;
        
        let (__warp_66_isNonRebasingAccount) = _isNonRebasingAccount_6184aaf5(__warp_64__account);
        
        let (__warp_pse_29) = _creditsPerToken_130e9bc1(__warp_64__account);
        
        let (__warp_67_creditAmount) = mulTruncate_8f8a618a(__warp_65__amount, __warp_pse_29);
        
        let (__warp_se_136) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_64__account);
        
        let (__warp_68_currentCredits) = WS2_READ_Uint256(__warp_se_136);
        
        let __warp_rc_6 = 0;
        
            
            let (__warp_tv_8, __warp_tv_9, __warp_tv_10) = __warp_conditional__burn_6161eb18_7(__warp_68_currentCredits, __warp_67_creditAmount);
            
            let __warp_67_creditAmount = __warp_tv_10;
            
            let __warp_68_currentCredits = __warp_tv_9;
            
            let __warp_rc_6 = __warp_tv_8;
        
            
            if (__warp_rc_6 != 0){
            
                
                let (__warp_se_137) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_64__account);
                
                WS_WRITE0(__warp_se_137, Uint256(low=0, high=0));
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_64__account = __warp_64__account;
                tempvar __warp_65__amount = __warp_65__amount;
                tempvar __warp_66_isNonRebasingAccount = __warp_66_isNonRebasingAccount;
                tempvar __warp_67_creditAmount = __warp_67_creditAmount;
            }else{
            
                
                let (__warp_se_138) = warp_gt256(__warp_68_currentCredits, __warp_67_creditAmount);
                
                    
                    if (__warp_se_138 != 0){
                    
                        
                        let (__warp_se_139) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_64__account);
                        
                        let (__warp_se_140) = WS2_READ_Uint256(__warp_se_139);
                        
                        let (__warp_pse_30) = sub_b67d77c5(__warp_se_140, __warp_67_creditAmount);
                        
                        let (__warp_se_141) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_64__account);
                        
                        WS_WRITE0(__warp_se_141, __warp_pse_30);
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar pedersen_ptr = pedersen_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar keccak_ptr = keccak_ptr;
                        tempvar __warp_64__account = __warp_64__account;
                        tempvar __warp_65__amount = __warp_65__amount;
                        tempvar __warp_66_isNonRebasingAccount = __warp_66_isNonRebasingAccount;
                        tempvar __warp_67_creditAmount = __warp_67_creditAmount;
                    }else{
                    
                        
                        with_attr error_message("Remove exceeds balance"){
                            assert 0 = 1;
                        }
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar pedersen_ptr = pedersen_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar keccak_ptr = keccak_ptr;
                        tempvar __warp_64__account = __warp_64__account;
                        tempvar __warp_65__amount = __warp_65__amount;
                        tempvar __warp_66_isNonRebasingAccount = __warp_66_isNonRebasingAccount;
                        tempvar __warp_67_creditAmount = __warp_67_creditAmount;
                    }
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar keccak_ptr = keccak_ptr;
                    tempvar __warp_64__account = __warp_64__account;
                    tempvar __warp_65__amount = __warp_65__amount;
                    tempvar __warp_66_isNonRebasingAccount = __warp_66_isNonRebasingAccount;
                    tempvar __warp_67_creditAmount = __warp_67_creditAmount;
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_64__account = __warp_64__account;
                tempvar __warp_65__amount = __warp_65__amount;
                tempvar __warp_66_isNonRebasingAccount = __warp_66_isNonRebasingAccount;
                tempvar __warp_67_creditAmount = __warp_67_creditAmount;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_64__account = __warp_64__account;
            tempvar __warp_65__amount = __warp_65__amount;
            tempvar __warp_66_isNonRebasingAccount = __warp_66_isNonRebasingAccount;
            tempvar __warp_67_creditAmount = __warp_67_creditAmount;
        
            
            if (__warp_66_isNonRebasingAccount != 0){
            
                
                let (__warp_se_142) = WS2_READ_Uint256(__warp_7_nonRebasingSupply);
                
                let (__warp_pse_31) = sub_b67d77c5(__warp_se_142, __warp_65__amount);
                
                WS_WRITE0(__warp_7_nonRebasingSupply, __warp_pse_31);
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_64__account = __warp_64__account;
                tempvar __warp_65__amount = __warp_65__amount;
            }else{
            
                
                let (__warp_se_143) = WS2_READ_Uint256(__warp_5__rebasingCredits);
                
                let (__warp_pse_32) = sub_b67d77c5(__warp_se_143, __warp_67_creditAmount);
                
                WS_WRITE0(__warp_5__rebasingCredits, __warp_pse_32);
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_64__account = __warp_64__account;
                tempvar __warp_65__amount = __warp_65__amount;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_64__account = __warp_64__account;
            tempvar __warp_65__amount = __warp_65__amount;
        
        let (__warp_se_144) = WS2_READ_Uint256(__warp_1__totalSupply);
        
        let (__warp_pse_33) = sub_b67d77c5(__warp_se_144, __warp_65__amount);
        
        WS_WRITE0(__warp_1__totalSupply, __warp_pse_33);
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(__warp_64__account, 0, __warp_65__amount);
        
        
        
        return ();

    }

    //  @dev Get the credits per token for an account. Returns a fixed amount
    //      if the account is non-rebasing.
    // @param _account Address of the account.
    func _creditsPerToken_130e9bc1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_69__account : felt)-> (__warp_70 : Uint256){
    alloc_locals;


        
        let (__warp_se_145) = WS0_INDEX_felt_to_Uint256(__warp_8_nonRebasingCreditsPerToken, __warp_69__account);
        
        let (__warp_se_146) = WS2_READ_Uint256(__warp_se_145);
        
        let (__warp_se_147) = warp_neq256(__warp_se_146, Uint256(low=0, high=0));
        
        if (__warp_se_147 != 0){
        
            
            let (__warp_se_148) = WS0_INDEX_felt_to_Uint256(__warp_8_nonRebasingCreditsPerToken, __warp_69__account);
            
            let (__warp_se_149) = WS2_READ_Uint256(__warp_se_148);
            
            
            
            return (__warp_se_149,);
        }else{
        
            
            let (__warp_se_150) = WS2_READ_Uint256(__warp_6__rebasingCreditsPerToken);
            
            
            
            return (__warp_se_150,);
        }

    }

    //  @dev Is an account using rebasing accounting or non-rebasing accounting?
    //      Also, ensure contracts are non-rebasing if they have not opted in.
    // @param _account Address of the account.
    func _isNonRebasingAccount_6184aaf5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_71__account : felt)-> (__warp_72 : felt){
    alloc_locals;


        
        let (__warp_se_151) = WS2_INDEX_felt_to_felt(__warp_9_rebaseState, __warp_71__account);
        
        let (__warp_se_152) = WS1_READ_felt(__warp_se_151);
        
        let (__warp_se_153) = warp_eq(__warp_se_152, 0);
        
            
            if (__warp_se_153 != 0){
            
                
                _ensureRebasingMigration_c52534a2(__warp_71__account);
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_71__account = __warp_71__account;
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_71__account = __warp_71__account;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar __warp_71__account = __warp_71__account;
        
        let (__warp_se_154) = WS0_INDEX_felt_to_Uint256(__warp_8_nonRebasingCreditsPerToken, __warp_71__account);
        
        let (__warp_se_155) = WS2_READ_Uint256(__warp_se_154);
        
        let (__warp_se_156) = warp_gt256(__warp_se_155, Uint256(low=0, high=0));
        
        
        
        return (__warp_se_156,);

    }

    //  @dev Ensures internal account for rebasing and non-rebasing credits and
    //      supply is updated following deployment of frozen yield change.
    func _ensureRebasingMigration_c52534a2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_73__account : felt)-> (){
    alloc_locals;


        
        let (__warp_se_157) = WS0_INDEX_felt_to_Uint256(__warp_8_nonRebasingCreditsPerToken, __warp_73__account);
        
        let (__warp_se_158) = WS2_READ_Uint256(__warp_se_157);
        
        let (__warp_se_159) = warp_eq256(__warp_se_158, Uint256(low=0, high=0));
        
            
            if (__warp_se_159 != 0){
            
                
                let (__warp_se_160) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_73__account);
                
                let (__warp_se_161) = WS2_READ_Uint256(__warp_se_160);
                
                let (__warp_se_162) = warp_eq256(__warp_se_161, Uint256(low=0, high=0));
                
                    
                    if (__warp_se_162 != 0){
                    
                        
                        let (__warp_se_163) = WS0_INDEX_felt_to_Uint256(__warp_8_nonRebasingCreditsPerToken, __warp_73__account);
                        
                        WS_WRITE0(__warp_se_163, Uint256(low=1000000000000000000000000000, high=0));
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar pedersen_ptr = pedersen_ptr;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                    }else{
                    
                        
                        let (__warp_se_164) = WS0_INDEX_felt_to_Uint256(__warp_8_nonRebasingCreditsPerToken, __warp_73__account);
                        
                        let (__warp_se_165) = WS2_READ_Uint256(__warp_6__rebasingCreditsPerToken);
                        
                        WS_WRITE0(__warp_se_164, __warp_se_165);
                        
                        let (__warp_pse_34) = balanceOf_70a08231_internal(__warp_73__account);
                        
                        let (__warp_se_166) = WS2_READ_Uint256(__warp_7_nonRebasingSupply);
                        
                        let (__warp_pse_35) = add_771602f7(__warp_se_166, __warp_pse_34);
                        
                        WS_WRITE0(__warp_7_nonRebasingSupply, __warp_pse_35);
                        
                        let (__warp_se_167) = WS2_READ_Uint256(__warp_5__rebasingCredits);
                        
                        let (__warp_se_168) = WS0_INDEX_felt_to_Uint256(__warp_4__creditBalances, __warp_73__account);
                        
                        let (__warp_se_169) = WS2_READ_Uint256(__warp_se_168);
                        
                        let (__warp_pse_36) = sub_b67d77c5(__warp_se_167, __warp_se_169);
                        
                        WS_WRITE0(__warp_5__rebasingCredits, __warp_pse_36);
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar pedersen_ptr = pedersen_ptr;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                    }
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
        
        
        
        return ();

    }


    func __warp_init_OUSD{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;


        
        let (__warp_se_209) = warp_bitwise_not128(0);
        
        let (__warp_se_210) = warp_uint256(__warp_se_209);
        
        WS_WRITE0(__warp_0_MAX_SUPPLY, __warp_se_210);
        
        WS_WRITE1(__warp_3_vaultAddress, 0);
        
        WS_WRITE0(RESOLUTION_INCREASE, Uint256(low=1000000000, high=0));
        
        
        
        return ();

    }

    //  @dev Sets the values for {name} and {symbol}.
    // The default value of {decimals} is 18. To select a different value for
    // {decimals} you should overload it.
    // All two of these values are immutable: they can only be set once during
    // construction.
    func __warp_constructor_3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(__warp_6_name_ : felt, __warp_7_symbol_ : felt, __warp_8_decimals_ : felt)-> (){
    alloc_locals;


        
        wm_to_storage0(__warp_4__name, __warp_6_name_);
        
        wm_to_storage0(__warp_5__symbol, __warp_7_symbol_);
        
        WS_WRITE1(__warp_3__decimals, __warp_8_decimals_);
        
        
        
        return ();

    }

    //  @dev Initializes the contract setting the deployer as the initial owner.
    func __warp_constructor_4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_pse_47) = _msgSender_119df25f();
        
        _transferOwnership_d29d44ee(__warp_pse_47);
        
        
        
        return ();

    }

    //  @dev Returns the address of the current owner.
    func owner_8da5cb5b_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_1 : felt){
    alloc_locals;


        
        let (__warp_se_211) = WS1_READ_felt(__warp_0__owner);
        
        
        
        return (__warp_se_211,);

    }

    //  @dev Transfers ownership of the contract to a new account (`newOwner`).
    // Internal function without access restriction.
    func _transferOwnership_d29d44ee{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_3_newOwner : felt)-> (){
    alloc_locals;


        
        let (__warp_4_oldOwner) = WS1_READ_felt(__warp_0__owner);
        
        WS_WRITE1(__warp_0__owner, __warp_3_newOwner);
        
        __warp_emit_OwnershipTransferred_8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0(__warp_4_oldOwner, __warp_3_newOwner);
        
        
        
        return ();

    }


    func _msgSender_119df25f{syscall_ptr : felt*}()-> (__warp_0 : felt){
    alloc_locals;


        
        let (__warp_se_215) = get_caller_address();
        
        
        
        return (__warp_se_215,);

    }

    //  @dev Multiplies two precise units, and then truncates by the full scale
    // @param x Left hand input to multiplication
    // @param y Right hand input to multiplication
    // @return Result after multiplying the two inputs and then dividing by the shared
    //         scale unit
    func mulTruncate_8f8a618a{range_check_ptr : felt}(__warp_4_x : Uint256, __warp_5_y : Uint256)-> (__warp_6 : Uint256){
    alloc_locals;


        
        let (__warp_pse_51) = mulTruncateScale_7473708e(__warp_4_x, __warp_5_y, Uint256(low=1000000000000000000, high=0));
        
        
        
        return (__warp_pse_51,);

    }

    //  @dev Multiplies two precise units, and then truncates by the given scale. For example,
    // when calculating 90% of 10e18, (10e18 * 9e17) / 1e18 = (9e36) / 1e18 = 9e18
    // @param x Left hand input to multiplication
    // @param y Right hand input to multiplication
    // @param scale Scale unit
    // @return Result after multiplying the two inputs and then dividing by the shared
    //         scale unit
    func mulTruncateScale_7473708e{range_check_ptr : felt}(__warp_7_x : Uint256, __warp_8_y : Uint256, __warp_9_scale : Uint256)-> (__warp_10 : Uint256){
    alloc_locals;


        
        let (__warp_11_z) = mul_c8a4ac9c(__warp_7_x, __warp_8_y);
        
        let (__warp_pse_52) = div_a391c15b(__warp_11_z, __warp_9_scale);
        
        
        
        return (__warp_pse_52,);

    }

    //  @dev Precisely divides two units, by first scaling the left hand operand. Useful
    //      for finding percentage weightings, i.e. 8e18/10e18 = 80% (or 8e17)
    // @param x Left hand input to division
    // @param y Right hand input to division
    // @return Result after multiplying the left operand by the scale, and
    //         executing the division on the right hand input.
    func divPrecisely_0b6ab2f0{range_check_ptr : felt}(__warp_17_x : Uint256, __warp_18_y : Uint256)-> (__warp_19 : Uint256){
    alloc_locals;


        
        let (__warp_20_z) = mul_c8a4ac9c(__warp_17_x, Uint256(low=1000000000000000000, high=0));
        
        let (__warp_pse_55) = div_a391c15b(__warp_20_z, __warp_18_y);
        
        
        
        return (__warp_pse_55,);

    }


    func __warp_init_StableMath{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(FULL_SCALE, Uint256(low=1000000000000000000, high=0));
        
        
        
        return ();

    }

    //  @dev Returns the addition of two unsigned integers, reverting on
    // overflow.
    // Counterpart to Solidity's `+` operator.
    // Requirements:
    // - Addition cannot overflow.
    func add_771602f7{range_check_ptr : felt}(__warp_22_a : Uint256, __warp_23_b : Uint256)-> (__warp_24 : Uint256){
    alloc_locals;


        
        let (__warp_se_216) = warp_add256(__warp_22_a, __warp_23_b);
        
        
        
        return (__warp_se_216,);

    }

    //  @dev Returns the subtraction of two unsigned integers, reverting on
    // overflow (when the result is negative).
    // Counterpart to Solidity's `-` operator.
    // Requirements:
    // - Subtraction cannot overflow.
    func sub_b67d77c5{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_25_a : Uint256, __warp_26_b : Uint256)-> (__warp_27 : Uint256){
    alloc_locals;


        
        let (__warp_se_217) = warp_sub256(__warp_25_a, __warp_26_b);
        
        
        
        return (__warp_se_217,);

    }

    //  @dev Returns the multiplication of two unsigned integers, reverting on
    // overflow.
    // Counterpart to Solidity's `*` operator.
    // Requirements:
    // - Multiplication cannot overflow.
    func mul_c8a4ac9c{range_check_ptr : felt}(__warp_28_a : Uint256, __warp_29_b : Uint256)-> (__warp_30 : Uint256){
    alloc_locals;


        
        let (__warp_se_218) = warp_mul256(__warp_28_a, __warp_29_b);
        
        
        
        return (__warp_se_218,);

    }

    //  @dev Returns the integer division of two unsigned integers, reverting on
    // division by zero. The result is rounded towards zero.
    // Counterpart to Solidity's `/` operator.
    // Requirements:
    // - The divisor cannot be zero.
    func div_a391c15b{range_check_ptr : felt}(__warp_31_a : Uint256, __warp_32_b : Uint256)-> (__warp_33 : Uint256){
    alloc_locals;


        
        let (__warp_se_219) = warp_div256(__warp_31_a, __warp_32_b);
        
        
        
        return (__warp_se_219,);

    }

}

    //  @return The total supply of OUSD.
    @view
    func totalSupply_18160ddd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_14 : Uint256){
    alloc_locals;


        
        let (__warp_se_33) = WS2_READ_Uint256(OUSD.__warp_1__totalSupply);
        
        
        
        return (__warp_se_33,);

    }

    //  @return Low resolution rebasingCreditsPerToken
    @view
    func rebasingCreditsPerToken_6691cb3d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_15 : Uint256){
    alloc_locals;


        
        let (__warp_se_34) = WS2_READ_Uint256(OUSD.__warp_6__rebasingCreditsPerToken);
        
        let (__warp_se_35) = warp_div256(__warp_se_34, Uint256(low=1000000000, high=0));
        
        
        
        return (__warp_se_35,);

    }

    //  @return Low resolution total number of rebasing credits
    @view
    func rebasingCredits_077f22b7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_16 : Uint256){
    alloc_locals;


        
        let (__warp_se_36) = WS2_READ_Uint256(OUSD.__warp_5__rebasingCredits);
        
        let (__warp_se_37) = warp_div256(__warp_se_36, Uint256(low=1000000000, high=0));
        
        
        
        return (__warp_se_37,);

    }

    //  @return High resolution rebasingCreditsPerToken
    @view
    func rebasingCreditsPerTokenHighres_7a46a9c5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_17 : Uint256){
    alloc_locals;


        
        let (__warp_se_38) = WS2_READ_Uint256(OUSD.__warp_6__rebasingCreditsPerToken);
        
        
        
        return (__warp_se_38,);

    }

    //  @return High resolution total number of rebasing credits
    @view
    func rebasingCreditsHighres_7d0d66ff{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_18 : Uint256){
    alloc_locals;


        
        let (__warp_se_39) = WS2_READ_Uint256(OUSD.__warp_5__rebasingCredits);
        
        
        
        return (__warp_se_39,);

    }

    //  @dev Gets the credits balance of the specified address.
    // @dev Backwards compatible with old low res credits per token.
    // @param _account The address to query the balance of.
    // @return (uint256, uint256) Credit balance and credits per token of the
    //         address
    @view
    func creditsBalanceOf_f9854bfc{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_21__account : felt)-> (__warp_22 : Uint256, __warp_23 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_21__account);
        
        let (__warp_24_cpt) = OUSD._creditsPerToken_130e9bc1(__warp_21__account);
        
        let (__warp_se_45) = warp_eq256(__warp_24_cpt, Uint256(low=1000000000000000000000000000, high=0));
        
        if (__warp_se_45 != 0){
        
            
            let (__warp_se_46) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_4__creditBalances, __warp_21__account);
            
            let (__warp_22) = WS2_READ_Uint256(__warp_se_46);
            
            let __warp_23 = __warp_24_cpt;
            
            
            
            return (__warp_22, __warp_23);
        }else{
        
            
            let (__warp_se_47) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_4__creditBalances, __warp_21__account);
            
            let (__warp_se_48) = WS2_READ_Uint256(__warp_se_47);
            
            let (__warp_22) = warp_div256(__warp_se_48, Uint256(low=1000000000, high=0));
            
            let (__warp_23) = warp_div256(__warp_24_cpt, Uint256(low=1000000000, high=0));
            
            
            
            return (__warp_22, __warp_23);
        }

    }

    //  @dev Gets the credits balance of the specified address.
    // @param _account The address to query the balance of.
    // @return (uint256, uint256, bool) Credit balance, credits per token of the
    //         address, and isUpgraded
    @view
    func creditsBalanceOfHighres_e5c4fffe{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_25__account : felt)-> (__warp_26 : Uint256, __warp_27 : Uint256, __warp_28 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_25__account);
        
        let (__warp_pse_10) = OUSD._creditsPerToken_130e9bc1(__warp_25__account);
        
        let (__warp_se_49) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_4__creditBalances, __warp_25__account);
        
        let (__warp_26) = WS2_READ_Uint256(__warp_se_49);
        
        let __warp_27 = __warp_pse_10;
        
        let (__warp_se_50) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_10_isUpgraded, __warp_25__account);
        
        let (__warp_se_51) = WS2_READ_Uint256(__warp_se_50);
        
        let (__warp_28) = warp_eq256(__warp_se_51, Uint256(low=1, high=0));
        
        
        
        return (__warp_26, __warp_27, __warp_28);

    }

    //  @dev Transfer tokens to a specified address.
    // @param _to the address to transfer to.
    // @param _value the amount to be transferred.
    // @return true on success.
    @external
    func transfer_a9059cbb{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_29__to : felt, __warp_30__value : Uint256)-> (__warp_31 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_30__value);
        
        warp_external_input_check_address(__warp_29__to);
        
        let (__warp_se_52) = warp_neq(__warp_29__to, 0);
        
        with_attr error_message("Transfer to zero address"){
            assert __warp_se_52 = 1;
        }
        
        let (__warp_se_53) = get_caller_address();
        
        let (__warp_pse_11) = OUSD.balanceOf_70a08231_internal(__warp_se_53);
        
        let (__warp_se_54) = warp_le256(__warp_30__value, __warp_pse_11);
        
        with_attr error_message("Transfer greater than balance"){
            assert __warp_se_54 = 1;
        }
        
        let (__warp_se_55) = get_caller_address();
        
        OUSD._executeTransfer_33a738c9(__warp_se_55, __warp_29__to, __warp_30__value);
        
        let (__warp_se_56) = get_caller_address();
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(__warp_se_56, __warp_29__to, __warp_30__value);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }

    //  @dev Transfer tokens from one address to another.
    // @param _from The address you want to send tokens from.
    // @param _to The address you want to transfer to.
    // @param _value The amount of tokens to be transferred.
    @external
    func transferFrom_23b872dd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_32__from : felt, __warp_33__to : felt, __warp_34__value : Uint256)-> (__warp_35 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_34__value);
        
        warp_external_input_check_address(__warp_33__to);
        
        warp_external_input_check_address(__warp_32__from);
        
        let (__warp_se_57) = warp_neq(__warp_33__to, 0);
        
        with_attr error_message("Transfer to zero address"){
            assert __warp_se_57 = 1;
        }
        
        let (__warp_pse_12) = OUSD.balanceOf_70a08231_internal(__warp_32__from);
        
        let (__warp_se_58) = warp_le256(__warp_34__value, __warp_pse_12);
        
        with_attr error_message("Transfer greater than balance"){
            assert __warp_se_58 = 1;
        }
        
        let (__warp_se_59) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_32__from);
        
        let (__warp_se_60) = WS0_READ_warp_id(__warp_se_59);
        
        let (__warp_se_61) = get_caller_address();
        
        let (__warp_se_62) = WS0_INDEX_felt_to_Uint256(__warp_se_60, __warp_se_61);
        
        let (__warp_se_63) = WS2_READ_Uint256(__warp_se_62);
        
        let (__warp_pse_13) = OUSD.sub_b67d77c5(__warp_se_63, __warp_34__value);
        
        let (__warp_se_64) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_32__from);
        
        let (__warp_se_65) = WS0_READ_warp_id(__warp_se_64);
        
        let (__warp_se_66) = get_caller_address();
        
        let (__warp_se_67) = WS0_INDEX_felt_to_Uint256(__warp_se_65, __warp_se_66);
        
        WS_WRITE0(__warp_se_67, __warp_pse_13);
        
        OUSD._executeTransfer_33a738c9(__warp_32__from, __warp_33__to, __warp_34__value);
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(__warp_32__from, __warp_33__to, __warp_34__value);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }

    //  @dev Approve the passed address to spend the specified amount of tokens
    //      on behalf of msg.sender. This method is included for ERC20
    //      compatibility. `increaseAllowance` and `decreaseAllowance` should be
    //      used instead.
    //      Changing an allowance with this method brings the risk that someone
    //      may transfer both the old and the new allowance - if they are both
    //      greater than zero - if a transfer transaction is mined before the
    //      later approve() call is mined.
    // @param _spender The address which will spend the funds.
    // @param _value The amount of tokens to be spent.
    @external
    func approve_095ea7b3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_46__spender : felt, __warp_47__value : Uint256)-> (__warp_48 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_47__value);
        
        warp_external_input_check_address(__warp_46__spender);
        
        let (__warp_se_82) = get_caller_address();
        
        let (__warp_se_83) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_se_82);
        
        let (__warp_se_84) = WS0_READ_warp_id(__warp_se_83);
        
        let (__warp_se_85) = WS0_INDEX_felt_to_Uint256(__warp_se_84, __warp_46__spender);
        
        WS_WRITE0(__warp_se_85, __warp_47__value);
        
        let (__warp_se_86) = get_caller_address();
        
        __warp_emit_Approval_8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925(__warp_se_86, __warp_46__spender, __warp_47__value);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }

    //  @dev Increase the amount of tokens that an owner has allowed to
    //      `_spender`.
    //      This method should be used instead of approve() to avoid the double
    //      approval vulnerability described above.
    // @param _spender The address which will spend the funds.
    // @param _addedValue The amount of tokens to increase the allowance by.
    @external
    func increaseAllowance_39509351{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_49__spender : felt, __warp_50__addedValue : Uint256)-> (__warp_51 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_50__addedValue);
        
        warp_external_input_check_address(__warp_49__spender);
        
        let (__warp_se_87) = get_caller_address();
        
        let (__warp_se_88) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_se_87);
        
        let (__warp_se_89) = WS0_READ_warp_id(__warp_se_88);
        
        let (__warp_se_90) = WS0_INDEX_felt_to_Uint256(__warp_se_89, __warp_49__spender);
        
        let (__warp_se_91) = WS2_READ_Uint256(__warp_se_90);
        
        let (__warp_pse_22) = OUSD.add_771602f7(__warp_se_91, __warp_50__addedValue);
        
        let (__warp_se_92) = get_caller_address();
        
        let (__warp_se_93) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_se_92);
        
        let (__warp_se_94) = WS0_READ_warp_id(__warp_se_93);
        
        let (__warp_se_95) = WS0_INDEX_felt_to_Uint256(__warp_se_94, __warp_49__spender);
        
        WS_WRITE0(__warp_se_95, __warp_pse_22);
        
        let (__warp_se_96) = get_caller_address();
        
        let (__warp_se_97) = get_caller_address();
        
        let (__warp_se_98) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_se_97);
        
        let (__warp_se_99) = WS0_READ_warp_id(__warp_se_98);
        
        let (__warp_se_100) = WS0_INDEX_felt_to_Uint256(__warp_se_99, __warp_49__spender);
        
        let (__warp_se_101) = WS2_READ_Uint256(__warp_se_100);
        
        __warp_emit_Approval_8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925(__warp_se_96, __warp_49__spender, __warp_se_101);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }

    //  @dev Decrease the amount of tokens that an owner has allowed to
    //`_spender`.
    // @param _spender The address which will spend the funds.
    // @param _subtractedValue The amount of tokens to decrease the allowance
    //        by.
    @external
    func decreaseAllowance_a457c2d7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_52__spender : felt, __warp_53__subtractedValue : Uint256)-> (__warp_54 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_53__subtractedValue);
        
        warp_external_input_check_address(__warp_52__spender);
        
        let (__warp_se_102) = get_caller_address();
        
        let (__warp_se_103) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_se_102);
        
        let (__warp_se_104) = WS0_READ_warp_id(__warp_se_103);
        
        let (__warp_se_105) = WS0_INDEX_felt_to_Uint256(__warp_se_104, __warp_52__spender);
        
        let (__warp_55_oldValue) = WS2_READ_Uint256(__warp_se_105);
        
        let (__warp_se_106) = warp_ge256(__warp_53__subtractedValue, __warp_55_oldValue);
        
            
            if (__warp_se_106 != 0){
            
                
                let (__warp_se_107) = get_caller_address();
                
                let (__warp_se_108) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_se_107);
                
                let (__warp_se_109) = WS0_READ_warp_id(__warp_se_108);
                
                let (__warp_se_110) = WS0_INDEX_felt_to_Uint256(__warp_se_109, __warp_52__spender);
                
                WS_WRITE0(__warp_se_110, Uint256(low=0, high=0));
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_52__spender = __warp_52__spender;
            }else{
            
                
                let (__warp_pse_23) = OUSD.sub_b67d77c5(__warp_55_oldValue, __warp_53__subtractedValue);
                
                let (__warp_se_111) = get_caller_address();
                
                let (__warp_se_112) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_se_111);
                
                let (__warp_se_113) = WS0_READ_warp_id(__warp_se_112);
                
                let (__warp_se_114) = WS0_INDEX_felt_to_Uint256(__warp_se_113, __warp_52__spender);
                
                WS_WRITE0(__warp_se_114, __warp_pse_23);
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_52__spender = __warp_52__spender;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_52__spender = __warp_52__spender;
        
        let (__warp_se_115) = get_caller_address();
        
        let (__warp_se_116) = get_caller_address();
        
        let (__warp_se_117) = WS1_INDEX_felt_to_warp_id(OUSD.__warp_2__allowances, __warp_se_116);
        
        let (__warp_se_118) = WS0_READ_warp_id(__warp_se_117);
        
        let (__warp_se_119) = WS0_INDEX_felt_to_Uint256(__warp_se_118, __warp_52__spender);
        
        let (__warp_se_120) = WS2_READ_Uint256(__warp_se_119);
        
        __warp_emit_Approval_8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925(__warp_se_115, __warp_52__spender, __warp_se_120);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }

    //  @dev Mints new tokens, increasing totalSupply.
    @external
    func mint_40c10f19{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_56__account : felt, __warp_57__amount : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_57__amount);
        
        warp_external_input_check_address(__warp_56__account);
        
        OUSD.__warp_modifier_onlyVault_mint_40c10f19_3(__warp_56__account, __warp_57__amount);
        
        let __warp_uv0 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Burns tokens, decreasing totalSupply.
    @external
    func burn_9dc29fac{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_62_account : felt, __warp_63_amount : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_63_amount);
        
        warp_external_input_check_address(__warp_62_account);
        
        OUSD.__warp_modifier_onlyVault_burn_9dc29fac_7(__warp_62_account, __warp_63_amount);
        
        let __warp_uv1 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Add a contract address to the non-rebasing exception list. The
    // address's balance will be part of rebases and the account will be exposed
    // to upside and downside.
    @external
    func rebaseOptIn_f51b0fd4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;


        
        let (__warp_se_170) = get_caller_address();
        
        let (__warp_pse_37) = OUSD._isNonRebasingAccount_6184aaf5(__warp_se_170);
        
        with_attr error_message("Account has not opted out"){
            assert __warp_pse_37 = 1;
        }
        
        let (__warp_se_171) = get_caller_address();
        
        let (__warp_se_172) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_4__creditBalances, __warp_se_171);
        
        let (__warp_se_173) = WS2_READ_Uint256(__warp_se_172);
        
        let (__warp_se_174) = WS2_READ_Uint256(OUSD.__warp_6__rebasingCreditsPerToken);
        
        let (__warp_pse_38) = OUSD.mul_c8a4ac9c(__warp_se_173, __warp_se_174);
        
        let (__warp_se_175) = get_caller_address();
        
        let (__warp_pse_39) = OUSD._creditsPerToken_130e9bc1(__warp_se_175);
        
        let (__warp_74_newCreditBalance) = OUSD.div_a391c15b(__warp_pse_38, __warp_pse_39);
        
        let (__warp_se_176) = get_caller_address();
        
        let (__warp_pse_40) = OUSD.balanceOf_70a08231_internal(__warp_se_176);
        
        let (__warp_se_177) = WS2_READ_Uint256(OUSD.__warp_7_nonRebasingSupply);
        
        let (__warp_pse_41) = OUSD.sub_b67d77c5(__warp_se_177, __warp_pse_40);
        
        WS_WRITE0(OUSD.__warp_7_nonRebasingSupply, __warp_pse_41);
        
        let (__warp_se_178) = get_caller_address();
        
        let (__warp_se_179) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_4__creditBalances, __warp_se_178);
        
        WS_WRITE0(__warp_se_179, __warp_74_newCreditBalance);
        
        let (__warp_se_180) = WS2_READ_Uint256(OUSD.__warp_5__rebasingCredits);
        
        let (__warp_se_181) = get_caller_address();
        
        let (__warp_se_182) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_4__creditBalances, __warp_se_181);
        
        let (__warp_se_183) = WS2_READ_Uint256(__warp_se_182);
        
        let (__warp_pse_42) = OUSD.add_771602f7(__warp_se_180, __warp_se_183);
        
        WS_WRITE0(OUSD.__warp_5__rebasingCredits, __warp_pse_42);
        
        let (__warp_se_184) = get_caller_address();
        
        let (__warp_se_185) = WS2_INDEX_felt_to_felt(OUSD.__warp_9_rebaseState, __warp_se_184);
        
        WS_WRITE1(__warp_se_185, 2);
        
        let (__warp_se_186) = get_caller_address();
        
        let (__warp_se_187) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_8_nonRebasingCreditsPerToken, __warp_se_186);
        
        WS_WRITE0(__warp_se_187, Uint256(low=0, high=0));
        
        
        
        return ();

    }

    //  @dev Explicitly mark that an address is non-rebasing.
    @external
    func rebaseOptOut_c2376dff{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;


        
        let (__warp_se_188) = get_caller_address();
        
        let (__warp_pse_43) = OUSD._isNonRebasingAccount_6184aaf5(__warp_se_188);
        
        with_attr error_message("Account has not opted in"){
            assert 1 - __warp_pse_43 = 1;
        }
        
        let (__warp_se_189) = get_caller_address();
        
        let (__warp_pse_44) = OUSD.balanceOf_70a08231_internal(__warp_se_189);
        
        let (__warp_se_190) = WS2_READ_Uint256(OUSD.__warp_7_nonRebasingSupply);
        
        let (__warp_pse_45) = OUSD.add_771602f7(__warp_se_190, __warp_pse_44);
        
        WS_WRITE0(OUSD.__warp_7_nonRebasingSupply, __warp_pse_45);
        
        let (__warp_se_191) = get_caller_address();
        
        let (__warp_se_192) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_8_nonRebasingCreditsPerToken, __warp_se_191);
        
        let (__warp_se_193) = WS2_READ_Uint256(OUSD.__warp_6__rebasingCreditsPerToken);
        
        WS_WRITE0(__warp_se_192, __warp_se_193);
        
        let (__warp_se_194) = WS2_READ_Uint256(OUSD.__warp_5__rebasingCredits);
        
        let (__warp_se_195) = get_caller_address();
        
        let (__warp_se_196) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_4__creditBalances, __warp_se_195);
        
        let (__warp_se_197) = WS2_READ_Uint256(__warp_se_196);
        
        let (__warp_pse_46) = OUSD.sub_b67d77c5(__warp_se_194, __warp_se_197);
        
        WS_WRITE0(OUSD.__warp_5__rebasingCredits, __warp_pse_46);
        
        let (__warp_se_198) = get_caller_address();
        
        let (__warp_se_199) = WS2_INDEX_felt_to_felt(OUSD.__warp_9_rebaseState, __warp_se_198);
        
        WS_WRITE1(__warp_se_199, 1);
        
        
        
        return ();

    }

    //  @dev Modify the supply without minting new tokens. This uses a change in
    //      the exchange rate between "credits" and OUSD tokens to change balances.
    // @param _newTotalSupply New total supply of OUSD.
    @external
    func changeSupply_39a7919f{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_75__newTotalSupply : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_75__newTotalSupply);
        
        OUSD.__warp_modifier_onlyVault_changeSupply_39a7919f_10(__warp_75__newTotalSupply);
        
        let __warp_uv2 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func _totalSupply_3eaaf86b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_76 : Uint256){
    alloc_locals;


        
        let (__warp_se_200) = WS2_READ_Uint256(OUSD.__warp_1__totalSupply);
        
        
        
        return (__warp_se_200,);

    }


    @view
    func vaultAddress_430bf08a{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_77 : felt){
    alloc_locals;


        
        let (__warp_se_201) = WS1_READ_felt(OUSD.__warp_3_vaultAddress);
        
        
        
        return (__warp_se_201,);

    }


    @view
    func nonRebasingSupply_e696393a{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_78 : Uint256){
    alloc_locals;


        
        let (__warp_se_202) = WS2_READ_Uint256(OUSD.__warp_7_nonRebasingSupply);
        
        
        
        return (__warp_se_202,);

    }


    @view
    func nonRebasingCreditsPerToken_609350cd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_79__i0 : felt)-> (__warp_80 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_79__i0);
        
        let (__warp_se_203) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_8_nonRebasingCreditsPerToken, __warp_79__i0);
        
        let (__warp_se_204) = WS2_READ_Uint256(__warp_se_203);
        
        
        
        return (__warp_se_204,);

    }


    @view
    func rebaseState_456ee286{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_81__i0 : felt)-> (__warp_82 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_81__i0);
        
        let (__warp_se_205) = WS2_INDEX_felt_to_felt(OUSD.__warp_9_rebaseState, __warp_81__i0);
        
        let (__warp_se_206) = WS1_READ_felt(__warp_se_205);
        
        
        
        return (__warp_se_206,);

    }


    @view
    func isUpgraded_95ef84b9{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_83__i0 : felt)-> (__warp_84 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_83__i0);
        
        let (__warp_se_207) = WS0_INDEX_felt_to_Uint256(OUSD.__warp_10_isUpgraded, __warp_83__i0);
        
        let (__warp_se_208) = WS2_READ_Uint256(__warp_se_207);
        
        
        
        return (__warp_se_208,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_11__nameArg_len : felt, __warp_11__nameArg : felt*, __warp_12__symbolArg_len : felt, __warp_12__symbolArg : felt*, __warp_13__vaultAddress : felt){
    alloc_locals;
    WARP_USED_STORAGE.write(130);
    WARP_NAMEGEN.write(9);
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_address(__warp_13__vaultAddress);
        
        extern_input_check0(__warp_12__symbolArg_len, __warp_12__symbolArg);
        
        extern_input_check0(__warp_11__nameArg_len, __warp_11__nameArg);
        
        local __warp_12__symbolArg_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_12__symbolArg_len, __warp_12__symbolArg);
        
        let (__warp_12__symbolArg_mem) = cd_to_memory0(__warp_12__symbolArg_dstruct);
        
        local __warp_11__nameArg_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_11__nameArg_len, __warp_11__nameArg);
        
        let (__warp_11__nameArg_mem) = cd_to_memory0(__warp_11__nameArg_dstruct);
        
        let __warp_constructor_parameter_0 = __warp_11__nameArg_mem;
        
        let __warp_constructor_parameter_1 = __warp_12__symbolArg_mem;
        
        let __warp_constructor_parameter_2 = 18;
        
        OUSD.__warp_init_StableMath();
        
        OUSD.__warp_constructor_3(__warp_constructor_parameter_0, __warp_constructor_parameter_1, __warp_constructor_parameter_2);
        
        OUSD.__warp_constructor_4();
        
        OUSD.__warp_init_OUSD();
        
        OUSD.__warp_constructor_5(__warp_11__nameArg_mem, __warp_12__symbolArg_mem, __warp_13__vaultAddress);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Leaves the contract without owner. It will not be possible to call
    // `onlyOwner` functions anymore. Can only be called by the current owner.
    // NOTE: Renouncing ownership will leave the contract without an owner,
    // thereby removing any functionality that is only available to the owner.
    @external
    func renounceOwnership_715018a6{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        OUSD.__warp_modifier_onlyOwner_renounceOwnership_715018a6_12();
        
        let __warp_uv3 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Transfers ownership of the contract to a new account (`newOwner`).
    // Can only be called by the current owner.
    @external
    func transferOwnership_f2fde38b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_2_newOwner : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_address(__warp_2_newOwner);
        
        OUSD.__warp_modifier_onlyOwner_transferOwnership_f2fde38b_15(__warp_2_newOwner);
        
        let __warp_uv4 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Returns the name of the token.
    @view
    func name_06fdde03{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_9_len : felt, __warp_9 : felt*){
    alloc_locals;


        
        let (__warp_se_212) = ws_dynamic_array_to_calldata0(OUSD.__warp_4__name);
        
        
        
        return (__warp_se_212.len, __warp_se_212.ptr,);

    }

    //  @dev Returns the symbol of the token, usually a shorter version of the
    // name.
    @view
    func symbol_95d89b41{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_10_len : felt, __warp_10 : felt*){
    alloc_locals;


        
        let (__warp_se_213) = ws_dynamic_array_to_calldata0(OUSD.__warp_5__symbol);
        
        
        
        return (__warp_se_213.len, __warp_se_213.ptr,);

    }

    //  @dev Returns the number of decimals used to get its user representation.
    // For example, if `decimals` equals `2`, a balance of `505` tokens should
    // be displayed to a user as `5.05` (`505 / 10 ** 2`).
    // Tokens usually opt for a value of 18, imitating the relationship between
    // Ether and Wei. This is the value {ERC20} uses, unless this function is
    // overridden;
    // NOTE: This information is only used for _display_ purposes: it in
    // no way affects any of the arithmetic of the contract, including
    // {IERC20-balanceOf} and {IERC20-transfer}.
    @view
    func decimals_313ce567{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_11 : felt){
    alloc_locals;


        
        let (__warp_se_214) = WS1_READ_felt(OUSD.__warp_3__decimals);
        
        
        
        return (__warp_se_214,);

    }

    //  @dev Gets the balance of the specified address.
    // @param _account Address to query the balance of.
    // @return A uint256 representing the amount of base units owned by the
    //         specified address.
    @view
    func balanceOf_70a08231{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_19__account : felt)-> (__warp_20 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_19__account);
        
        let (__warp_pse_56) = OUSD.balanceOf_70a08231_internal(__warp_19__account);
        
        
        
        return (__warp_pse_56,);

    }

    //  @dev Function to check the amount of tokens that _owner has allowed to
    //      `_spender`.
    // @param _owner The address which owns the funds.
    // @param _spender The address which will spend the funds.
    // @return The number of tokens still available for the _spender.
    @view
    func allowance_dd62ed3e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_43__owner : felt, __warp_44__spender : felt)-> (__warp_45 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_44__spender);
        
        warp_external_input_check_address(__warp_43__owner);
        
        let (__warp_pse_57) = OUSD.allowance_dd62ed3e_internal(__warp_43__owner, __warp_44__spender);
        
        
        
        return (__warp_pse_57,);

    }

    //  @dev Returns the address of the current owner.
    @view
    func owner_8da5cb5b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_1 : felt){
    alloc_locals;


        
        let (__warp_pse_58) = OUSD.owner_8da5cb5b_internal();
        
        
        
        return (__warp_pse_58,);

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