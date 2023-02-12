%lang starknet


from warplib.memory import wm_alloc, wm_write_256, wm_dyn_array_length, wm_new, wm_to_felt_array
from starkware.cairo.common.uint256 import Uint256, uint256_sub, uint256_lt, uint256_eq, uint256_add
from starkware.cairo.common.dict import dict_write, dict_read
from warplib.maths.utils import narrow_safe, felt_to_uint256
from warplib.maths.int_conversions import warp_uint256
from starkware.cairo.common.alloc import alloc
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array_spl
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from warplib.keccak import felt_array_concat, pack_bytes_felt
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.sub import warp_sub256
from warplib.maths.add_unsafe import warp_add_unsafe256
from warplib.maths.neq import warp_neq256


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

func WM0_d_arr{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt, e8: felt, e9: felt, e10: felt, e11: felt, e12: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0xf, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0xd, 0x0));
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
    return (start,);
}

func WM1_d_arr{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x6, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x4, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
    return (start,);
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
   let (elem) = WS2_READ_felt(elem_loc);
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


// Contract Def WETH

// @notice Minimalist and modern Wrapped Ether implementation.
// @author Solmate (https://github.com/transmissions11/solmate/blob/main/src/tokens/WETH.sol)
// @author Inspired by WETH9 (https://github.com/dapphub/ds-weth/blob/master/src/weth9.sol)


// @event
// func Approval(owner : felt, spender : felt, amount : Uint256){
// }


// @event
// func Transfer(__warp_6_from : felt, to : felt, amount : Uint256){
// }

namespace WETH{

    // Dynamic variables - Arrays and Maps

    const __warp_0_name = 1;

    const __warp_1_symbol = 2;

    const __warp_4_balanceOf = 3;

    const __warp_5_allowance = 4;

    // Static variables

    const __warp_2_decimals = 2;

    const __warp_3_totalSupply = 3;


    func __warp_constructor_3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(__warp_7__name : felt, __warp_8__symbol : felt, __warp_9__decimals : felt)-> (){
    alloc_locals;


        
        wm_to_storage0(__warp_0_name, __warp_7__name);
        
        wm_to_storage0(__warp_1_symbol, __warp_8__symbol);
        
        WS_WRITE0(__warp_2_decimals, __warp_9__decimals);
        
        
        
        return ();

    }

}


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(7);
    WARP_NAMEGEN.write(4);
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        let (__warp_constructor_parameter_0) = WM0_d_arr(87, 114, 97, 112, 112, 101, 100, 32, 69, 116, 104, 101, 114);
        
        let (__warp_constructor_parameter_1) = WM1_d_arr(87, 69, 84, 72);
        
        let __warp_constructor_parameter_2 = 18;
        
        WETH.__warp_constructor_3(__warp_constructor_parameter_0, __warp_constructor_parameter_1, __warp_constructor_parameter_2);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return ();
    }
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
        
        let (__warp_se_0) = get_caller_address();
        
        let (__warp_se_1) = WS1_INDEX_felt_to_warp_id(WETH.__warp_5_allowance, __warp_se_0);
        
        let (__warp_se_2) = WS0_READ_warp_id(__warp_se_1);
        
        let (__warp_se_3) = WS0_INDEX_felt_to_Uint256(__warp_se_2, __warp_10_spender);
        
        WS_WRITE1(__warp_se_3, __warp_11_amount);
        
        let (__warp_se_4) = get_caller_address();
        
        __warp_emit_Approval_8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925(__warp_se_4, __warp_10_spender, __warp_11_amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
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
        
        let (__warp_cs_0) = get_caller_address();
        
        let (__warp_se_5) = WS0_INDEX_felt_to_Uint256(WETH.__warp_4_balanceOf, __warp_cs_0);
        
        let (__warp_se_6) = WS0_INDEX_felt_to_Uint256(WETH.__warp_4_balanceOf, __warp_cs_0);
        
        let (__warp_se_7) = WS1_READ_Uint256(__warp_se_6);
        
        let (__warp_se_8) = warp_sub256(__warp_se_7, __warp_14_amount);
        
        WS_WRITE1(__warp_se_5, __warp_se_8);
        
            
            let __warp_cs_1 = __warp_13_to;
            
            let (__warp_se_9) = WS0_INDEX_felt_to_Uint256(WETH.__warp_4_balanceOf, __warp_cs_1);
            
            let (__warp_se_10) = WS0_INDEX_felt_to_Uint256(WETH.__warp_4_balanceOf, __warp_cs_1);
            
            let (__warp_se_11) = WS1_READ_Uint256(__warp_se_10);
            
            let (__warp_se_12) = warp_add_unsafe256(__warp_se_11, __warp_14_amount);
            
            WS_WRITE1(__warp_se_9, __warp_se_12);
        
        let (__warp_se_13) = get_caller_address();
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(__warp_se_13, __warp_13_to, __warp_14_amount);
        
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
        
        let (__warp_se_14) = WS1_INDEX_felt_to_warp_id(WETH.__warp_5_allowance, __warp_16_from);
        
        let (__warp_se_15) = WS0_READ_warp_id(__warp_se_14);
        
        let (__warp_se_16) = get_caller_address();
        
        let (__warp_se_17) = WS0_INDEX_felt_to_Uint256(__warp_se_15, __warp_se_16);
        
        let (__warp_20_allowed) = WS1_READ_Uint256(__warp_se_17);
        
        let (__warp_se_18) = warp_neq256(__warp_20_allowed, Uint256(low=340282366920938463463374607431768211455, high=340282366920938463463374607431768211455));
        
            
            if (__warp_se_18 != 0){
            
                
                let (__warp_se_19) = WS1_INDEX_felt_to_warp_id(WETH.__warp_5_allowance, __warp_16_from);
                
                let (__warp_se_20) = WS0_READ_warp_id(__warp_se_19);
                
                let (__warp_se_21) = get_caller_address();
                
                let (__warp_se_22) = WS0_INDEX_felt_to_Uint256(__warp_se_20, __warp_se_21);
                
                let (__warp_se_23) = warp_sub256(__warp_20_allowed, __warp_18_amount);
                
                WS_WRITE1(__warp_se_22, __warp_se_23);
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
        
        let (__warp_se_24) = WS0_INDEX_felt_to_Uint256(WETH.__warp_4_balanceOf, __warp_cs_2);
        
        let (__warp_se_25) = WS0_INDEX_felt_to_Uint256(WETH.__warp_4_balanceOf, __warp_cs_2);
        
        let (__warp_se_26) = WS1_READ_Uint256(__warp_se_25);
        
        let (__warp_se_27) = warp_sub256(__warp_se_26, __warp_18_amount);
        
        WS_WRITE1(__warp_se_24, __warp_se_27);
        
            
            let __warp_cs_3 = __warp_17_to;
            
            let (__warp_se_28) = WS0_INDEX_felt_to_Uint256(WETH.__warp_4_balanceOf, __warp_cs_3);
            
            let (__warp_se_29) = WS0_INDEX_felt_to_Uint256(WETH.__warp_4_balanceOf, __warp_cs_3);
            
            let (__warp_se_30) = WS1_READ_Uint256(__warp_se_29);
            
            let (__warp_se_31) = warp_add_unsafe256(__warp_se_30, __warp_18_amount);
            
            WS_WRITE1(__warp_se_28, __warp_se_31);
        
        __warp_emit_Transfer_ddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef(__warp_16_from, __warp_17_to, __warp_18_amount);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return (1,);
    }
    }


    @view
    func name_06fdde03{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_25_len : felt, __warp_25 : felt*){
    alloc_locals;


        
        let (__warp_se_32) = ws_dynamic_array_to_calldata0(WETH.__warp_0_name);
        
        
        
        return (__warp_se_32.len, __warp_se_32.ptr,);

    }


    @view
    func symbol_95d89b41{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_26_len : felt, __warp_26 : felt*){
    alloc_locals;


        
        let (__warp_se_33) = ws_dynamic_array_to_calldata0(WETH.__warp_1_symbol);
        
        
        
        return (__warp_se_33.len, __warp_se_33.ptr,);

    }


    @view
    func decimals_313ce567{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_27 : felt){
    alloc_locals;


        
        let (__warp_se_34) = WS2_READ_felt(WETH.__warp_2_decimals);
        
        
        
        return (__warp_se_34,);

    }


    @view
    func totalSupply_18160ddd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_28 : Uint256){
    alloc_locals;


        
        let (__warp_se_35) = WS1_READ_Uint256(WETH.__warp_3_totalSupply);
        
        
        
        return (__warp_se_35,);

    }


    @view
    func balanceOf_70a08231{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_29__i0 : felt)-> (__warp_30 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_29__i0);
        
        let (__warp_se_36) = WS0_INDEX_felt_to_Uint256(WETH.__warp_4_balanceOf, __warp_29__i0);
        
        let (__warp_se_37) = WS1_READ_Uint256(__warp_se_36);
        
        
        
        return (__warp_se_37,);

    }


    @view
    func allowance_dd62ed3e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_31__i0 : felt, __warp_32__i1 : felt)-> (__warp_33 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_32__i1);
        
        warp_external_input_check_address(__warp_31__i0);
        
        let (__warp_se_38) = WS1_INDEX_felt_to_warp_id(WETH.__warp_5_allowance, __warp_31__i0);
        
        let (__warp_se_39) = WS0_READ_warp_id(__warp_se_38);
        
        let (__warp_se_40) = WS0_INDEX_felt_to_Uint256(__warp_se_39, __warp_32__i1);
        
        let (__warp_se_41) = WS1_READ_Uint256(__warp_se_40);
        
        
        
        return (__warp_se_41,);

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


// Contract Def ERC20@interface


@contract_interface
namespace ERC20_warped_interface{
func approve_095ea7b3(__warp_10_spender : felt, __warp_11_amount : Uint256)-> (__warp_12 : felt){
}
func transfer_a9059cbb(__warp_13_to : felt, __warp_14_amount : Uint256)-> (__warp_15 : felt){
}
func transferFrom_23b872dd(__warp_16_from : felt, __warp_17_to : felt, __warp_18_amount : Uint256)-> (__warp_19 : felt){
}
func name_06fdde03()-> (__warp_25_len : felt, __warp_25 : felt*){
}
func symbol_95d89b41()-> (__warp_26_len : felt, __warp_26 : felt*){
}
func decimals_313ce567()-> (__warp_27 : felt){
}
func totalSupply_18160ddd()-> (__warp_28 : Uint256){
}
func balanceOf_70a08231(__warp_29__i0 : felt)-> (__warp_30 : Uint256){
}
func allowance_dd62ed3e(__warp_31__i0 : felt, __warp_32__i1 : felt)-> (__warp_33 : Uint256){
}
}