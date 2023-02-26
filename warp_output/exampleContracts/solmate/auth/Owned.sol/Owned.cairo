%lang starknet


from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array_spl
from warplib.maths.utils import felt_to_uint256
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from warplib.memory import wm_new, wm_to_felt_array
from warplib.keccak import felt_array_concat, pack_bytes_felt
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from starkware.cairo.common.dict_access import DictAccess
from warplib.maths.eq import warp_eq
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak


func WS0_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
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

func abi_encode1{bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}() -> (result_ptr : felt){
  alloc_locals;
  let bytes_index : felt = 0;
  let bytes_offset : felt = 0;
  let (bytes_array : felt*) = alloc();
  let (max_length256) = felt_to_uint256(bytes_offset);
  let (mem_ptr) = wm_new(max_length256, Uint256(0x1, 0x0));
  felt_array_to_warp_memory_array(0, bytes_array, 0, mem_ptr, bytes_offset);
  return (mem_ptr,);
}

func __warp_emit_OwnershipTransferred_8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x19497f9722a3daafe3b4186f6b6457e0, 0x8be0079c531659141344cd1fd0a4f284);// keccak of event signature: OwnershipTransferred(address,address)
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
   let (mem_encode: felt) = abi_encode1();
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}


// Contract Def Owned

// @notice Simple single owner authorization mixin.
// @author Solmate (https://github.com/transmissions11/solmate/blob/main/src/auth/Owned.sol)


// @event
// func OwnershipTransferred(user : felt, newOwner : felt){
// }

namespace Owned{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const __warp_0_owner = 0;


    func __warp_modifier_onlyOwner_transferOwnership_f2fde38b_2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_2_newOwner1 : felt)-> (){
    alloc_locals;


        
        let (__warp_se_0) = get_caller_address();
        
        let (__warp_se_1) = WS0_READ_felt(__warp_0_owner);
        
        let (__warp_se_2) = warp_eq(__warp_se_0, __warp_se_1);
        
        with_attr error_message("UNAUTHORIZED"){
            assert __warp_se_2 = 1;
        }
        
        __warp_original_function_transferOwnership_f2fde38b_0(__warp_parameter___warp_2_newOwner1);
        
        
        
        return ();

    }


    func __warp_original_function_transferOwnership_f2fde38b_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_2_newOwner : felt)-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_owner, __warp_2_newOwner);
        
        let (__warp_se_3) = get_caller_address();
        
        __warp_emit_OwnershipTransferred_8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0(__warp_se_3, __warp_2_newOwner);
        
        
        
        return ();

    }


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_1__owner : felt)-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_owner, __warp_1__owner);
        
        __warp_emit_OwnershipTransferred_8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0(0, __warp_1__owner);
        
        
        
        return ();

    }

}


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
        
        Owned.__warp_modifier_onlyOwner_transferOwnership_f2fde38b_2(__warp_2_newOwner);
        
        let __warp_uv0 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func owner_8da5cb5b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_3 : felt){
    alloc_locals;


        
        let (__warp_se_4) = WS0_READ_felt(Owned.__warp_0_owner);
        
        
        
        return (__warp_se_4,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_1__owner : felt){
    alloc_locals;
    WARP_USED_STORAGE.write(1);

    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_address(__warp_1__owner);
        
        Owned.__warp_constructor_0(__warp_1__owner);
        
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