%lang starknet


from warplib.maths.external_input_check_ints import warp_external_input_check_int32, warp_external_input_check_int256, warp_external_input_check_int8
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_bool import warp_external_input_check_bool
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array_spl
from warplib.maths.utils import felt_to_uint256
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from warplib.memory import wm_new, wm_to_felt_array
from warplib.keccak import felt_array_concat, pack_bytes_felt
from starkware.starknet.common.syscalls import emit_event, get_caller_address
from warplib.maths.eq import warp_eq
from warplib.maths.neq import warp_neq
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.sub import warp_sub256
from warplib.maths.add import warp_add256


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

func _emit_ApprovalForAll_17307eab{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : felt){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0xeb58175e31a087c0e37c92ec15a53ee985cf575dac1e737702c3a26592e847);// keccak of event signature: ApprovalForAll(address,address,bool)
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

func _emit_Approval_8c5be1e5{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x93c69e112b32c8eaf6fbc376d5c21ba9e86c148fc97ada2a1f426267845230);// keccak of event signature: Approval(address,address,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode0(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode2(param2);
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

func _emit_Transfer_ddf252ad{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x11e6ec91df3d153aa9bc9e4911cbfb251102e0ac5942e0dbf16443f5122846d);// keccak of event signature: Transfer(address,address,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode0(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   let (mem_encode: felt) = abi_encode2(param2);
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


// @event
// func Transfer(__warp_4_from : felt, to : felt, id : Uint256){
// }


// @event
// func Approval(owner : felt, spender : felt, id : Uint256){
// }


// @event
// func ApprovalForAll(owner : felt, operator : felt, approved : felt){
// }

namespace ERC721{

    // Dynamic variables - Arrays and Maps

    const __warp_0__ownerOf = 1;

    const __warp_1__balanceOf = 2;

    const __warp_2__approvals = 3;

    const __warp_3_isApprovedForAll = 4;

    // Static variables


    func __warp_conditional_supportsInterface_01ffc9a7_1(__warp_5_interfaceId : felt)-> (__warp_rc_0 : felt, __warp_5_interfaceId : felt){
    alloc_locals;


        
        let (__warp_se_0) = warp_eq(__warp_5_interfaceId, 2158778573);
        
        if (__warp_se_0 != 0){
        
            
            let __warp_rc_0 = 1;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_5_interfaceId = __warp_5_interfaceId;
            
            
            
            return (__warp_rc_0, __warp_5_interfaceId);
        }else{
        
            
            let (__warp_se_1) = warp_eq(__warp_5_interfaceId, 33540519);
            
            let __warp_rc_0 = __warp_se_1;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_5_interfaceId = __warp_5_interfaceId;
            
            
            
            return (__warp_rc_0, __warp_5_interfaceId);
        }

    }


    func __warp_conditional_approve_095ea7b3_3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_15_owner : felt)-> (__warp_rc_2 : felt, __warp_15_owner : felt){
    alloc_locals;


        
        let (__warp_se_13) = get_caller_address();
        
        let (__warp_se_14) = warp_eq(__warp_se_13, __warp_15_owner);
        
        if (__warp_se_14 != 0){
        
            
            let __warp_rc_2 = 1;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_15_owner = __warp_15_owner;
            
            
            
            return (__warp_rc_2, __warp_15_owner);
        }else{
        
            
            let (__warp_se_15) = WS3_INDEX_felt_to_warp_id(__warp_3_isApprovedForAll, __warp_15_owner);
            
            let (__warp_se_16) = WS0_READ_warp_id(__warp_se_15);
            
            let (__warp_se_17) = get_caller_address();
            
            let (__warp_se_18) = WS2_INDEX_felt_to_felt(__warp_se_16, __warp_se_17);
            
            let (__warp_se_19) = WS1_READ_felt(__warp_se_18);
            
            let __warp_rc_2 = __warp_se_19;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_15_owner = __warp_15_owner;
            
            
            
            return (__warp_rc_2, __warp_15_owner);
        }

    }


    func __warp_conditional___warp_conditional__isApprovedOrOwner_f7e66828_5_7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_19_spender : felt, __warp_18_owner : felt)-> (__warp_rc_6 : felt, __warp_19_spender : felt, __warp_18_owner : felt){
    alloc_locals;


        
        let (__warp_se_27) = warp_eq(__warp_19_spender, __warp_18_owner);
        
        if (__warp_se_27 != 0){
        
            
            let __warp_rc_6 = 1;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_19_spender = __warp_19_spender;
            
            let __warp_18_owner = __warp_18_owner;
            
            
            
            return (__warp_rc_6, __warp_19_spender, __warp_18_owner);
        }else{
        
            
            let (__warp_se_28) = WS3_INDEX_felt_to_warp_id(__warp_3_isApprovedForAll, __warp_18_owner);
            
            let (__warp_se_29) = WS0_READ_warp_id(__warp_se_28);
            
            let (__warp_se_30) = WS2_INDEX_felt_to_felt(__warp_se_29, __warp_19_spender);
            
            let (__warp_se_31) = WS1_READ_felt(__warp_se_30);
            
            let __warp_rc_6 = __warp_se_31;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_19_spender = __warp_19_spender;
            
            let __warp_18_owner = __warp_18_owner;
            
            
            
            return (__warp_rc_6, __warp_19_spender, __warp_18_owner);
        }

    }


    func __warp_conditional__isApprovedOrOwner_f7e66828_5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_19_spender : felt, __warp_18_owner : felt, __warp_20_id : Uint256)-> (__warp_rc_4 : felt, __warp_19_spender : felt, __warp_18_owner : felt, __warp_20_id : Uint256){
    alloc_locals;


        
        let __warp_rc_6 = 0;
        
            
            let (__warp_tv_4, __warp_tv_5, __warp_tv_6) = __warp_conditional___warp_conditional__isApprovedOrOwner_f7e66828_5_7(__warp_19_spender, __warp_18_owner);
            
            let __warp_18_owner = __warp_tv_6;
            
            let __warp_19_spender = __warp_tv_5;
            
            let __warp_rc_6 = __warp_tv_4;
        
        if (__warp_rc_6 != 0){
        
            
            let __warp_rc_4 = 1;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_19_spender = __warp_19_spender;
            
            let __warp_18_owner = __warp_18_owner;
            
            let __warp_20_id = __warp_20_id;
            
            
            
            return (__warp_rc_4, __warp_19_spender, __warp_18_owner, __warp_20_id);
        }else{
        
            
            let (__warp_se_32) = WS0_INDEX_Uint256_to_felt(__warp_2__approvals, __warp_20_id);
            
            let (__warp_se_33) = WS1_READ_felt(__warp_se_32);
            
            let (__warp_se_34) = warp_eq(__warp_19_spender, __warp_se_33);
            
            let __warp_rc_4 = __warp_se_34;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_19_spender = __warp_19_spender;
            
            let __warp_18_owner = __warp_18_owner;
            
            let __warp_20_id = __warp_20_id;
            
            
            
            return (__warp_rc_4, __warp_19_spender, __warp_18_owner, __warp_20_id);
        }

    }


    func _isApprovedOrOwner_f7e66828{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_18_owner : felt, __warp_19_spender : felt, __warp_20_id : Uint256)-> (__warp_21 : felt){
    alloc_locals;


        
        let __warp_rc_4 = 0;
        
            
            let (__warp_tv_7, __warp_tv_8, __warp_tv_9, __warp_tv_10) = __warp_conditional__isApprovedOrOwner_f7e66828_5(__warp_19_spender, __warp_18_owner, __warp_20_id);
            
            let __warp_20_id = __warp_tv_10;
            
            let __warp_18_owner = __warp_tv_9;
            
            let __warp_19_spender = __warp_tv_8;
            
            let __warp_rc_4 = __warp_tv_7;
        
        
        
        return (__warp_rc_4,);

    }


    func transferFrom_23b872dd_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_22_from : felt, __warp_23_to : felt, __warp_24_id : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_35) = WS0_INDEX_Uint256_to_felt(__warp_0__ownerOf, __warp_24_id);
        
        let (__warp_se_36) = WS1_READ_felt(__warp_se_35);
        
        let (__warp_se_37) = warp_eq(__warp_22_from, __warp_se_36);
        
        with_attr error_message("from != owner"){
            assert __warp_se_37 = 1;
        }
        
        let (__warp_se_38) = warp_neq(__warp_23_to, 0);
        
        with_attr error_message("transfer to zero address"){
            assert __warp_se_38 = 1;
        }
        
        let (__warp_se_39) = get_caller_address();
        
        let (__warp_pse_0) = _isApprovedOrOwner_f7e66828(__warp_22_from, __warp_se_39, __warp_24_id);
        
        with_attr error_message("not authorized"){
            assert __warp_pse_0 = 1;
        }
        
        let __warp_cs_0 = __warp_22_from;
        
        let (__warp_se_40) = WS1_INDEX_felt_to_Uint256(__warp_1__balanceOf, __warp_cs_0);
        
        let (__warp_se_41) = WS2_READ_Uint256(__warp_se_40);
        
        let (__warp_pse_1) = warp_sub256(__warp_se_41, Uint256(low=1, high=0));
        
        let (__warp_se_42) = WS1_INDEX_felt_to_Uint256(__warp_1__balanceOf, __warp_cs_0);
        
        WS_WRITE1(__warp_se_42, __warp_pse_1);
        
        warp_add256(__warp_pse_1, Uint256(low=1, high=0));
        
        let __warp_cs_1 = __warp_23_to;
        
        let (__warp_se_43) = WS1_INDEX_felt_to_Uint256(__warp_1__balanceOf, __warp_cs_1);
        
        let (__warp_se_44) = WS2_READ_Uint256(__warp_se_43);
        
        let (__warp_pse_2) = warp_add256(__warp_se_44, Uint256(low=1, high=0));
        
        let (__warp_se_45) = WS1_INDEX_felt_to_Uint256(__warp_1__balanceOf, __warp_cs_1);
        
        WS_WRITE1(__warp_se_45, __warp_pse_2);
        
        warp_sub256(__warp_pse_2, Uint256(low=1, high=0));
        
        let (__warp_se_46) = WS0_INDEX_Uint256_to_felt(__warp_0__ownerOf, __warp_24_id);
        
        WS_WRITE0(__warp_se_46, __warp_23_to);
        
        let (__warp_se_47) = WS0_INDEX_Uint256_to_felt(__warp_2__approvals, __warp_24_id);
        
        WS_WRITE0(__warp_se_47, 0);
        
        _emit_Transfer_ddf252ad(__warp_22_from, __warp_23_to, __warp_24_id);
        
        
        
        return ();

    }

}


    @view
    func supportsInterface_01ffc9a7{syscall_ptr : felt*, range_check_ptr : felt}(__warp_5_interfaceId : felt)-> (__warp_6 : felt){
    alloc_locals;


        
        warp_external_input_check_int32(__warp_5_interfaceId);
        
        let __warp_rc_0 = 0;
        
            
            let (__warp_tv_0, __warp_tv_1) = ERC721.__warp_conditional_supportsInterface_01ffc9a7_1(__warp_5_interfaceId);
            
            let __warp_5_interfaceId = __warp_tv_1;
            
            let __warp_rc_0 = __warp_tv_0;
        
        
        
        return (__warp_rc_0,);

    }


    @view
    func ownerOf_6352211e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_7_id : Uint256)-> (__warp_8_owner : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_7_id);
        
        let __warp_8_owner = 0;
        
        let (__warp_se_2) = WS0_INDEX_Uint256_to_felt(ERC721.__warp_0__ownerOf, __warp_7_id);
        
        let (__warp_se_3) = WS1_READ_felt(__warp_se_2);
        
        let __warp_8_owner = __warp_se_3;
        
        let (__warp_se_4) = warp_neq(__warp_8_owner, 0);
        
        with_attr error_message("token doesn't exist"){
            assert __warp_se_4 = 1;
        }
        
        
        
        return (__warp_8_owner,);

    }


    @view
    func balanceOf_70a08231{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_9_owner : felt)-> (__warp_10 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_9_owner);
        
        let (__warp_se_5) = warp_neq(__warp_9_owner, 0);
        
        with_attr error_message("owner = zero address"){
            assert __warp_se_5 = 1;
        }
        
        let (__warp_se_6) = WS1_INDEX_felt_to_Uint256(ERC721.__warp_1__balanceOf, __warp_9_owner);
        
        let (__warp_se_7) = WS2_READ_Uint256(__warp_se_6);
        
        
        
        return (__warp_se_7,);

    }


    @external
    func setApprovalForAll_a22cb465{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_11_operator : felt, __warp_12_approved : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_bool(__warp_12_approved);
        
        warp_external_input_check_address(__warp_11_operator);
        
        let (__warp_se_8) = get_caller_address();
        
        let (__warp_se_9) = WS3_INDEX_felt_to_warp_id(ERC721.__warp_3_isApprovedForAll, __warp_se_8);
        
        let (__warp_se_10) = WS0_READ_warp_id(__warp_se_9);
        
        let (__warp_se_11) = WS2_INDEX_felt_to_felt(__warp_se_10, __warp_11_operator);
        
        WS_WRITE0(__warp_se_11, __warp_12_approved);
        
        let (__warp_se_12) = get_caller_address();
        
        _emit_ApprovalForAll_17307eab(__warp_se_12, __warp_11_operator, __warp_12_approved);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
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
        
        let (__warp_se_20) = WS0_INDEX_Uint256_to_felt(ERC721.__warp_0__ownerOf, __warp_14_id);
        
        let (__warp_15_owner) = WS1_READ_felt(__warp_se_20);
        
        let __warp_rc_2 = 0;
        
            
            let (__warp_tv_2, __warp_tv_3) = ERC721.__warp_conditional_approve_095ea7b3_3(__warp_15_owner);
            
            let __warp_15_owner = __warp_tv_3;
            
            let __warp_rc_2 = __warp_tv_2;
        
        with_attr error_message("not authorized"){
            assert __warp_rc_2 = 1;
        }
        
        let (__warp_se_21) = WS0_INDEX_Uint256_to_felt(ERC721.__warp_2__approvals, __warp_14_id);
        
        WS_WRITE0(__warp_se_21, __warp_13_spender);
        
        _emit_Approval_8c5be1e5(__warp_15_owner, __warp_13_spender, __warp_14_id);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func getApproved_081812fc{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_16_id : Uint256)-> (__warp_17 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_16_id);
        
        let (__warp_se_22) = WS0_INDEX_Uint256_to_felt(ERC721.__warp_0__ownerOf, __warp_16_id);
        
        let (__warp_se_23) = WS1_READ_felt(__warp_se_22);
        
        let (__warp_se_24) = warp_neq(__warp_se_23, 0);
        
        with_attr error_message("token doesn't exist"){
            assert __warp_se_24 = 1;
        }
        
        let (__warp_se_25) = WS0_INDEX_Uint256_to_felt(ERC721.__warp_2__approvals, __warp_16_id);
        
        let (__warp_se_26) = WS1_READ_felt(__warp_se_25);
        
        
        
        return (__warp_se_26,);

    }


    @external
    func safeTransferFrom_42842e0e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_25_from : felt, __warp_26_to : felt, __warp_27_id : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_27_id);
        
        warp_external_input_check_address(__warp_26_to);
        
        warp_external_input_check_address(__warp_25_from);
        
        ERC721.transferFrom_23b872dd_internal(__warp_25_from, __warp_26_to, __warp_27_id);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func safeTransferFrom_b88d4fde{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_28_from : felt, __warp_29_to : felt, __warp_30_id : Uint256, data_len : felt, data : felt*)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        extern_input_check0(data_len, data);
        
        warp_external_input_check_int256(__warp_30_id);
        
        warp_external_input_check_address(__warp_29_to);
        
        warp_external_input_check_address(__warp_28_from);
        
        ERC721.transferFrom_23b872dd_internal(__warp_28_from, __warp_29_to, __warp_30_id);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func isApprovedForAll_e985e9c5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_35__i0 : felt, __warp_36__i1 : felt)-> (__warp_37 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_36__i1);
        
        warp_external_input_check_address(__warp_35__i0);
        
        let (__warp_se_48) = WS3_INDEX_felt_to_warp_id(ERC721.__warp_3_isApprovedForAll, __warp_35__i0);
        
        let (__warp_se_49) = WS0_READ_warp_id(__warp_se_48);
        
        let (__warp_se_50) = WS2_INDEX_felt_to_felt(__warp_se_49, __warp_36__i1);
        
        let (__warp_se_51) = WS1_READ_felt(__warp_se_50);
        
        
        
        return (__warp_se_51,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(4);
    WARP_NAMEGEN.write(4);


        
        
        
        return ();

    }


    @external
    func transferFrom_23b872dd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_22_from : felt, __warp_23_to : felt, __warp_24_id : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_24_id);
        
        warp_external_input_check_address(__warp_23_to);
        
        warp_external_input_check_address(__warp_22_from);
        
        ERC721.transferFrom_23b872dd_internal(__warp_22_from, __warp_23_to, __warp_24_id);
        
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