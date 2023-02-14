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
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.add import warp_add256
from warplib.maths.ge import warp_ge256
from warplib.maths.sub_unsafe import warp_sub_unsafe256
from warplib.maths.neq import warp_neq, warp_neq256
from warplib.maths.add_unsafe import warp_add_unsafe256


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
   let (mem_encode: felt) = abi_encode1(param2);
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


// Contract Def ERC20

//  @dev Implementation of the {IERC20} interface.
// This implementation is agnostic to the way tokens are created. This means
// that a supply mechanism has to be added in a derived contract using {_mint}.
// For a generic mechanism see {ERC20PresetMinterPauser}.
// TIP: For a detailed writeup see our guide
// https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
// to implement supply mechanisms].
// We have followed general OpenZeppelin Contracts guidelines: functions revert
// instead returning `false` on failure. This behavior is nonetheless
// conventional and does not conflict with the expectations of ERC20
// applications.
// Additionally, an {Approval} event is emitted on calls to {transferFrom}.
// This allows applications to reconstruct the allowance for all accounts just
// by listening to said events. Other implementations of the EIP may not emit
// these events, as it isn't required by the specification.
// Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
// functions have been added to mitigate the well-known issues around setting
// allowances. See {IERC20-approve}.

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

namespace ERC20{

    // Dynamic variables - Arrays and Maps

    const __warp_0__balances = 1;

    const __warp_1__allowances = 2;

    const __warp_4__name = 3;

    const __warp_5__symbol = 4;

    // Static variables

    const __warp_2__totalSupply = 2;

    const __warp_3__decimals = 4;

    //  @dev Sets the values for {name} and {symbol}.
    // The default value of {decimals} is 18. To select a different value for
    // {decimals} you should overload it.
    // All two of these values are immutable: they can only be set once during
    // construction.
    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(__warp_6_name_ : felt, __warp_7_symbol_ : felt, __warp_8_decimals_ : felt)-> (){
    alloc_locals;


        
        wm_to_storage0(__warp_4__name, __warp_6_name_);
        
        wm_to_storage0(__warp_5__symbol, __warp_7_symbol_);
        
        WS_WRITE0(__warp_3__decimals, __warp_8_decimals_);
        
        
        
        return ();

    }

    //  @dev See {IERC20-allowance}.
    func allowance_dd62ed3e_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_19_owner : felt, __warp_20_spender : felt)-> (__warp_21 : Uint256){
    alloc_locals;


        
        let (__warp_se_6) = WS1_INDEX_felt_to_warp_id(__warp_1__allowances, __warp_19_owner);
        
        let (__warp_se_7) = WS0_READ_warp_id(__warp_se_6);
        
        let (__warp_se_8) = WS0_INDEX_felt_to_Uint256(__warp_se_7, __warp_20_spender);
        
        let (__warp_se_9) = WS2_READ_Uint256(__warp_se_8);
        
        
        
        return (__warp_se_9,);

    }

    //  @dev Moves `amount` of tokens from `from` to `to`.
    // This internal function is equivalent to {transfer}, and can be used to
    // e.g. implement automatic token fees, slashing mechanisms, etc.
    // Emits a {Transfer} event.
    // Requirements:
    // - `from` cannot be the zero address.
    // - `to` cannot be the zero address.
    // - `from` must have a balance of at least `amount`.
    func _transfer_30e0789e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_40_from : felt, __warp_41_to : felt, __warp_42_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_13) = warp_neq(__warp_40_from, 0);
        
        with_attr error_message("ERC20: transfer from the zero address"){
            assert __warp_se_13 = 1;
        }
        
        let (__warp_se_14) = warp_neq(__warp_41_to, 0);
        
        with_attr error_message("ERC20: transfer to the zero address"){
            assert __warp_se_14 = 1;
        }
        
        _beforeTokenTransfer_cad3be83(__warp_40_from, __warp_41_to, __warp_42_amount);
        
        let (__warp_se_15) = WS0_INDEX_felt_to_Uint256(__warp_0__balances, __warp_40_from);
        
        let (__warp_43_fromBalance) = WS2_READ_Uint256(__warp_se_15);
        
        let (__warp_se_16) = warp_ge256(__warp_43_fromBalance, __warp_42_amount);
        
        with_attr error_message("ERC20: transfer amount exceeds balance"){
            assert __warp_se_16 = 1;
        }
        
            
            let (__warp_se_17) = WS0_INDEX_felt_to_Uint256(__warp_0__balances, __warp_40_from);
            
            let (__warp_se_18) = warp_sub_unsafe256(__warp_43_fromBalance, __warp_42_amount);
            
            WS_WRITE1(__warp_se_17, __warp_se_18);
            
            let __warp_cs_0 = __warp_41_to;
            
            let (__warp_se_19) = WS0_INDEX_felt_to_Uint256(__warp_0__balances, __warp_cs_0);
            
            let (__warp_se_20) = WS0_INDEX_felt_to_Uint256(__warp_0__balances, __warp_cs_0);
            
            let (__warp_se_21) = WS2_READ_Uint256(__warp_se_20);
            
            let (__warp_se_22) = warp_add_unsafe256(__warp_se_21, __warp_42_amount);
            
            WS_WRITE1(__warp_se_19, __warp_se_22);
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(__warp_40_from, __warp_41_to, __warp_42_amount);
        
        _afterTokenTransfer_8f811a1c(__warp_40_from, __warp_41_to, __warp_42_amount);
        
        
        
        return ();

    }

    //  @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
    // This internal function is equivalent to `approve`, and can be used to
    // e.g. set automatic allowances for certain subsystems, etc.
    // Emits an {Approval} event.
    // Requirements:
    // - `owner` cannot be the zero address.
    // - `spender` cannot be the zero address.
    func _approve_104e81ff{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_49_owner : felt, __warp_50_spender : felt, __warp_51_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_23) = warp_neq(__warp_49_owner, 0);
        
        with_attr error_message("ERC20: approve from the zero address"){
            assert __warp_se_23 = 1;
        }
        
        let (__warp_se_24) = warp_neq(__warp_50_spender, 0);
        
        with_attr error_message("ERC20: approve to the zero address"){
            assert __warp_se_24 = 1;
        }
        
        let (__warp_se_25) = WS1_INDEX_felt_to_warp_id(__warp_1__allowances, __warp_49_owner);
        
        let (__warp_se_26) = WS0_READ_warp_id(__warp_se_25);
        
        let (__warp_se_27) = WS0_INDEX_felt_to_Uint256(__warp_se_26, __warp_50_spender);
        
        WS_WRITE1(__warp_se_27, __warp_51_amount);
        
        __warp_emit_Approval_8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925(__warp_49_owner, __warp_50_spender, __warp_51_amount);
        
        
        
        return ();

    }

    //  @dev Updates `owner` s allowance for `spender` based on spent `amount`.
    // Does not update the allowance amount in case of infinite allowance.
    // Revert if not enough allowance is available.
    // Might emit an {Approval} event.
    func _spendAllowance_1532335e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_52_owner : felt, __warp_53_spender : felt, __warp_54_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_55_currentAllowance) = allowance_dd62ed3e_internal(__warp_52_owner, __warp_53_spender);
        
        let (__warp_se_28) = warp_neq256(__warp_55_currentAllowance, Uint256(low=340282366920938463463374607431768211455, high=340282366920938463463374607431768211455));
        
            
            if (__warp_se_28 != 0){
            
                
                let (__warp_se_29) = warp_ge256(__warp_55_currentAllowance, __warp_54_amount);
                
                with_attr error_message("ERC20: insufficient allowance"){
                    assert __warp_se_29 = 1;
                }
                
                    
                    let (__warp_se_30) = warp_sub_unsafe256(__warp_55_currentAllowance, __warp_54_amount);
                    
                    _approve_104e81ff(__warp_52_owner, __warp_53_spender, __warp_se_30);
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
        
        
        
        return ();

    }

    //  @dev Hook that is called before any transfer of tokens. This includes
    // minting and burning.
    // Calling conditions:
    // - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
    // will be transferred to `to`.
    // - when `from` is zero, `amount` tokens will be minted for `to`.
    // - when `to` is zero, `amount` of ``from``'s tokens will be burned.
    // - `from` and `to` are never both zero.
    // To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
    func _beforeTokenTransfer_cad3be83(__warp_56_from : felt, to : felt, amount : Uint256)-> (){
    alloc_locals;


        
        
        
        return ();

    }

    //  @dev Hook that is called after any transfer of tokens. This includes
    // minting and burning.
    // Calling conditions:
    // - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
    // has been transferred to `to`.
    // - when `from` is zero, `amount` tokens have been minted for `to`.
    // - when `to` is zero, `amount` of ``from``'s tokens have been burned.
    // - `from` and `to` are never both zero.
    // To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
    func _afterTokenTransfer_8f811a1c(__warp_57_from : felt, to : felt, amount : Uint256)-> (){
    alloc_locals;


        
        
        
        return ();

    }


    func _msgSender_119df25f{syscall_ptr : felt*}()-> (__warp_0 : felt){
    alloc_locals;


        
        let (__warp_se_31) = get_caller_address();
        
        
        
        return (__warp_se_31,);

    }

}

    //  @dev Returns the name of the token.
    @view
    func name_06fdde03{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_9_len : felt, __warp_9 : felt*){
    alloc_locals;


        
        let (__warp_se_0) = ws_dynamic_array_to_calldata0(ERC20.__warp_4__name);
        
        
        
        return (__warp_se_0.len, __warp_se_0.ptr,);

    }

    //  @dev Returns the symbol of the token, usually a shorter version of the
    // name.
    @view
    func symbol_95d89b41{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_10_len : felt, __warp_10 : felt*){
    alloc_locals;


        
        let (__warp_se_1) = ws_dynamic_array_to_calldata0(ERC20.__warp_5__symbol);
        
        
        
        return (__warp_se_1.len, __warp_se_1.ptr,);

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


        
        let (__warp_se_2) = WS1_READ_felt(ERC20.__warp_3__decimals);
        
        
        
        return (__warp_se_2,);

    }

    //  @dev See {IERC20-totalSupply}.
    @view
    func totalSupply_18160ddd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_12 : Uint256){
    alloc_locals;


        
        let (__warp_se_3) = WS2_READ_Uint256(ERC20.__warp_2__totalSupply);
        
        
        
        return (__warp_se_3,);

    }

    //  @dev See {IERC20-balanceOf}.
    @view
    func balanceOf_70a08231{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_13_account : felt)-> (__warp_14 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_13_account);
        
        let (__warp_se_4) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_0__balances, __warp_13_account);
        
        let (__warp_se_5) = WS2_READ_Uint256(__warp_se_4);
        
        
        
        return (__warp_se_5,);

    }

    //  @dev See {IERC20-transfer}.
    // Requirements:
    // - `to` cannot be the zero address.
    // - the caller must have a balance of at least `amount`.
    @external
    func transfer_a9059cbb{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_15_to : felt, __warp_16_amount : Uint256)-> (__warp_17 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_16_amount);
        
        warp_external_input_check_address(__warp_15_to);
        
        let (__warp_18_owner) = ERC20._msgSender_119df25f();
        
        ERC20._transfer_30e0789e(__warp_18_owner, __warp_15_to, __warp_16_amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }

    //  @dev See {IERC20-approve}.
    // NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
    // `transferFrom`. This is semantically equivalent to an infinite approval.
    // Requirements:
    // - `spender` cannot be the zero address.
    @external
    func approve_095ea7b3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_22_spender : felt, __warp_23_amount : Uint256)-> (__warp_24 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_23_amount);
        
        warp_external_input_check_address(__warp_22_spender);
        
        let (__warp_25_owner) = ERC20._msgSender_119df25f();
        
        ERC20._approve_104e81ff(__warp_25_owner, __warp_22_spender, __warp_23_amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }

    //  @dev See {IERC20-transferFrom}.
    // Emits an {Approval} event indicating the updated allowance. This is not
    // required by the EIP. See the note at the beginning of {ERC20}.
    // NOTE: Does not update the allowance if the current allowance
    // is the maximum `uint256`.
    // Requirements:
    // - `from` and `to` cannot be the zero address.
    // - `from` must have a balance of at least `amount`.
    // - the caller must have allowance for ``from``'s tokens of at least
    // `amount`.
    @external
    func transferFrom_23b872dd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_26_from : felt, __warp_27_to : felt, __warp_28_amount : Uint256)-> (__warp_29 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_28_amount);
        
        warp_external_input_check_address(__warp_27_to);
        
        warp_external_input_check_address(__warp_26_from);
        
        let (__warp_30_spender) = ERC20._msgSender_119df25f();
        
        ERC20._spendAllowance_1532335e(__warp_26_from, __warp_30_spender, __warp_28_amount);
        
        ERC20._transfer_30e0789e(__warp_26_from, __warp_27_to, __warp_28_amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }

    //  @dev Atomically increases the allowance granted to `spender` by the caller.
    // This is an alternative to {approve} that can be used as a mitigation for
    // problems described in {IERC20-approve}.
    // Emits an {Approval} event indicating the updated allowance.
    // Requirements:
    // - `spender` cannot be the zero address.
    @external
    func increaseAllowance_39509351{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_31_spender : felt, __warp_32_addedValue : Uint256)-> (__warp_33 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_32_addedValue);
        
        warp_external_input_check_address(__warp_31_spender);
        
        let (__warp_34_owner) = ERC20._msgSender_119df25f();
        
        let (__warp_pse_0) = ERC20.allowance_dd62ed3e_internal(__warp_34_owner, __warp_31_spender);
        
        let (__warp_se_10) = warp_add256(__warp_pse_0, __warp_32_addedValue);
        
        ERC20._approve_104e81ff(__warp_34_owner, __warp_31_spender, __warp_se_10);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }

    //  @dev Atomically decreases the allowance granted to `spender` by the caller.
    // This is an alternative to {approve} that can be used as a mitigation for
    // problems described in {IERC20-approve}.
    // Emits an {Approval} event indicating the updated allowance.
    // Requirements:
    // - `spender` cannot be the zero address.
    // - `spender` must have allowance for the caller of at least
    // `subtractedValue`.
    @external
    func decreaseAllowance_a457c2d7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_35_spender : felt, __warp_36_subtractedValue : Uint256)-> (__warp_37 : felt){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_36_subtractedValue);
        
        warp_external_input_check_address(__warp_35_spender);
        
        let (__warp_38_owner) = ERC20._msgSender_119df25f();
        
        let (__warp_39_currentAllowance) = ERC20.allowance_dd62ed3e_internal(__warp_38_owner, __warp_35_spender);
        
        let (__warp_se_11) = warp_ge256(__warp_39_currentAllowance, __warp_36_subtractedValue);
        
        with_attr error_message("ERC20: decreased allowance below zero"){
            assert __warp_se_11 = 1;
        }
        
            
            let (__warp_se_12) = warp_sub_unsafe256(__warp_39_currentAllowance, __warp_36_subtractedValue);
            
            ERC20._approve_104e81ff(__warp_38_owner, __warp_35_spender, __warp_se_12);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_6_name__len : felt, __warp_6_name_ : felt*, __warp_7_symbol__len : felt, __warp_7_symbol_ : felt*, __warp_8_decimals_ : felt){
    alloc_locals;
    WARP_USED_STORAGE.write(7);
    WARP_NAMEGEN.write(4);
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        warp_external_input_check_int8(__warp_8_decimals_);
        
        extern_input_check0(__warp_7_symbol__len, __warp_7_symbol_);
        
        extern_input_check0(__warp_6_name__len, __warp_6_name_);
        
        local __warp_7_symbol__dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_7_symbol__len, __warp_7_symbol_);
        
        let (__warp_7_symbol__mem) = cd_to_memory0(__warp_7_symbol__dstruct);
        
        local __warp_6_name__dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_6_name__len, __warp_6_name_);
        
        let (__warp_6_name__mem) = cd_to_memory0(__warp_6_name__dstruct);
        
        ERC20.__warp_constructor_0(__warp_6_name__mem, __warp_7_symbol__mem, __warp_8_decimals_);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return ();
    }
    }

    //  @dev See {IERC20-allowance}.
    @view
    func allowance_dd62ed3e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_19_owner : felt, __warp_20_spender : felt)-> (__warp_21 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_20_spender);
        
        warp_external_input_check_address(__warp_19_owner);
        
        let (__warp_pse_1) = ERC20.allowance_dd62ed3e_internal(__warp_19_owner, __warp_20_spender);
        
        
        
        return (__warp_pse_1,);

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