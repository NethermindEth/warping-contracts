%lang starknet


from warplib.memory import wm_read_256, wm_write_256, wm_new, wm_to_felt_array, wm_index_dyn, wm_dyn_array_length
from starkware.cairo.common.uint256 import uint256_sub, uint256_add, Uint256, uint256_lt
from starkware.cairo.common.alloc import alloc
from warplib.maths.utils import narrow_safe, felt_to_uint256
from warplib.maths.int_conversions import warp_uint256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.dict import dict_write
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array_spl
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from warplib.keccak import felt_array_concat, pack_bytes_felt
from starkware.starknet.common.syscalls import emit_event, get_contract_address, get_caller_address
from starkware.cairo.common.dict_access import DictAccess
from warplib.maths.lt import warp_lt256
from warplib.maths.add import warp_add256
from warplib.maths.sub import warp_sub256
from warplib.maths.gt import warp_gt256
from warplib.maths.neq import warp_neq
from warplib.maths.eq import warp_eq256, warp_eq
from warplib.maths.ge import warp_ge256
from warplib.maths.sub_signed import warp_sub_signed256
from warplib.maths.add_signed import warp_add_signed256
from warplib.maths.exp import warp_exp_wide256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.le import warp_le256
from warplib.maths.ge_signed import warp_ge_signed256
from warplib.maths.negate import warp_negate256
from warplib.maths.lt_signed import warp_lt_signed256
from warplib.maths.mul import warp_mul256
from warplib.maths.div import warp_div256


struct Asset_96786d17{
    isSupported : felt,
}


struct Strategy_d1c2465f{
    isSupported : felt,
    _deprecated : Uint256,
}


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

struct cd_dynarray_Uint256{
     len : felt ,
     ptr : Uint256*,
}

func wm_to_calldata0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(mem_loc: felt) -> (retData: cd_dynarray_Uint256){
    alloc_locals;
    let (len_256) = wm_read_256(mem_loc);
    let (ptr : Uint256*) = alloc();
    let (len_felt) = narrow_safe(len_256);
    wm_to_calldata1(len_felt, ptr, mem_loc + 2);
    return (cd_dynarray_Uint256(len=len_felt, ptr=ptr),);
}


func wm_to_calldata1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(len: felt, ptr: Uint256*, mem_loc: felt) -> (){
    alloc_locals;
    if (len == 0){
         return ();
    }
let (mem_read0) = wm_read_256(mem_loc);
assert ptr[0] = mem_read0;
    wm_to_calldata1(len=len - 1, ptr=ptr + 2, mem_loc=mem_loc + 2);
    return ();
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

func WSM0_Asset_96786d17_isSupported(loc: felt) -> (memberLoc: felt){
    return (loc,);
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
   let (elem) = WS0_READ_felt(elem_loc);
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

func __warp_emit_AssetAllocated_41b99659f6ba0803f444aff29e5bf6e26dd86a3219aff92119d69710a956ba8d{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : felt, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x6dd86a3219aff92119d69710a956ba8d, 0x41b99659f6ba0803f444aff29e5bf6e2);// keccak of event signature: AssetAllocated(address,address,uint256)
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
   let (mem_encode: felt) = abi_encode1(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func __warp_emit_YieldDistribution_09516ecf4a8a86e59780a9befc6dee948bc9e60a36e3be68d31ea817ee8d2c80{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : Uint256, param2 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x8bc9e60a36e3be68d31ea817ee8d2c80, 0x9516ecf4a8a86e59780a9befc6dee94);// keccak of event signature: YieldDistribution(address,uint256,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode1(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode1(param2);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func __warp_emit_Redeem_222838db2794d11532d940e8dec38ae307ed0b63cd97c233322e221f998767a6{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x7ed0b63cd97c233322e221f998767a6, 0x222838db2794d11532d940e8dec38ae3);// keccak of event signature: Redeem(address,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode1(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func __warp_emit_Mint_0f6798a560793a54c3bcfe86a93cde1e73087d944c0ea20544137d4121396885{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let topic256: Uint256 = Uint256(0x73087d944c0ea20544137d4121396885, 0xf6798a560793a54c3bcfe86a93cde1e);// keccak of event signature: Mint(address,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   let (mem_encode: felt) = abi_encode1(param1);
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
func WARP_MAPPING1(name: felt, index: felt) -> (resLoc : felt){
}
func WS1_INDEX_felt_to_Asset_96786d17{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
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


// Contract Def VaultCore


// @event
// func OwnershipTransferred(previousOwner : felt, newOwner : felt){
// }


// @event
// func NetOusdMintForStrategyThresholdChanged(_threshold : Uint256){
// }


// @event
// func TrusteeAddressChanged(_address : felt){
// }


// @event
// func TrusteeFeeBpsChanged(_basis : Uint256){
// }


// @event
// func YieldDistribution(_to : felt, _yield : Uint256, _fee : Uint256){
// }


// @event
// func MaxSupplyDiffChanged(maxSupplyDiff : Uint256){
// }


// @event
// func StrategistUpdated(_address : felt){
// }


// @event
// func RebaseThresholdUpdated(_threshold : Uint256){
// }


// @event
// func AllocateThresholdUpdated(_threshold : Uint256){
// }


// @event
// func PriceProviderUpdated(_priceProvider : felt){
// }


// @event
// func RedeemFeeUpdated(_redeemFeeBps : Uint256){
// }


// @event
// func OusdMetaStrategyUpdated(_ousdMetaStrategy : felt){
// }


// @event
// func VaultBufferUpdated(_vaultBuffer : Uint256){
// }


// @event
// func RebaseUnpaused(){
// }


// @event
// func RebasePaused(){
// }


// @event
// func CapitalUnpaused(){
// }


// @event
// func CapitalPaused(){
// }


// @event
// func Redeem(_addr : felt, _value : Uint256){
// }


// @event
// func Mint(_addr : felt, _value : Uint256){
// }


// @event
// func StrategyRemoved(_addr : felt){
// }


// @event
// func StrategyApproved(_addr : felt){
// }


// @event
// func AssetAllocated(_asset : felt, _strategy : felt, _amount : Uint256){
// }


// @event
// func AssetDefaultStrategyUpdated(_asset : felt, _strategy : felt){
// }


// @event
// func AssetSupported(_asset : felt){
// }

namespace VaultCore{

    // Dynamic variables - Arrays and Maps

    const assets = 1;

    const allAssets = 2;

    const strategies = 3;

    const allStrategies = 4;

    const __warp_8_assetDefaultStrategies = 5;

    const _deprecated_swapTokens = 6;

    // Static variables

    const MAX_INT = 0;

    const MAX_UINT = 2;

    const FULL_SCALE = 4;

    const __warp_0_initialized = 6;

    const __warp_1_initializing = 7;

    const ______gap = 8;

    const __warp_0__owner = 108;

    const __warp_0_priceProvider = 113;

    const __warp_1_rebasePaused = 114;

    const __warp_2_capitalPaused = 115;

    const __warp_3_redeemFeeBps = 116;

    const __warp_4_vaultBuffer = 118;

    const __warp_5_autoAllocateThreshold = 120;

    const __warp_6_rebaseThreshold = 122;

    const oUSD = 124;

    const _deprecated_rebaseHooksAddr = 125;

    const _deprecated_uniswapAddr = 126;

    const __warp_7_strategistAddr = 127;

    const __warp_9_maxSupplyDiff = 129;

    const __warp_10_trusteeAddress = 131;

    const __warp_11_trusteeFeeBps = 132;

    const MINT_MINIMUM_ORACLE = 135;

    const __warp_12_ousdMetaStrategy = 137;

    const __warp_13_netOusdMintedForStrategy = 138;

    const __warp_14_netOusdMintForStrategyThreshold = 140;


    func __warp_while11{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_88_i : Uint256, __warp_86_assetPrices : felt, __warp_87_oracle : felt)-> (__warp_88_i : Uint256, __warp_86_assetPrices : felt, __warp_87_oracle : felt){
    alloc_locals;


        
            
            let (__warp_se_0) = WARP_DARRAY0_felt_LENGTH.read(allAssets);
            
            let (__warp_se_1) = warp_lt256(__warp_88_i, __warp_se_0);
            
                
                if (__warp_se_1 != 0){
                
                    
                        
                        let (__warp_se_2) = WARP_DARRAY0_felt_IDX(allAssets, __warp_88_i);
                        
                        let (__warp_se_3) = WS0_READ_felt(__warp_se_2);
                        
                        let (__warp_pse_0) = IOracle_warped_interface.price_aea91078(__warp_87_oracle, __warp_se_3);
                        
                        let (__warp_pse_1) = scaleBy_bd502d8d(__warp_pse_0, Uint256(low=18, high=0), Uint256(low=8, high=0));
                        
                        let (__warp_se_4) = wm_index_dyn(__warp_86_assetPrices, __warp_88_i, Uint256(low=2, high=0));
                        
                        wm_write_256(__warp_se_4, __warp_pse_1);
                    
                    let (__warp_pse_2) = warp_add256(__warp_88_i, Uint256(low=1, high=0));
                    
                    let __warp_88_i = __warp_pse_2;
                    
                    warp_sub256(__warp_pse_2, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar __warp_88_i = __warp_88_i;
                    tempvar __warp_86_assetPrices = __warp_86_assetPrices;
                    tempvar __warp_87_oracle = __warp_87_oracle;
                }else{
                
                    
                    let __warp_88_i = __warp_88_i;
                    
                    let __warp_86_assetPrices = __warp_86_assetPrices;
                    
                    let __warp_87_oracle = __warp_87_oracle;
                    
                    
                    
                    return (__warp_88_i, __warp_86_assetPrices, __warp_87_oracle);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar __warp_88_i = __warp_88_i;
                tempvar __warp_86_assetPrices = __warp_86_assetPrices;
                tempvar __warp_87_oracle = __warp_87_oracle;
        
        let (__warp_88_i, __warp_td_0, __warp_87_oracle) = __warp_while11(__warp_88_i, __warp_86_assetPrices, __warp_87_oracle);
        
        let __warp_86_assetPrices = __warp_td_0;
        
        
        
        return (__warp_88_i, __warp_86_assetPrices, __warp_87_oracle);

    }


    func __warp_while10{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_85_i : Uint256, __warp_70_outputs : felt, __warp_74_assetBalances : felt, __warp_84_factor : Uint256, __warp_71_totalBalance : Uint256)-> (__warp_85_i : Uint256, __warp_70_outputs : felt, __warp_74_assetBalances : felt, __warp_84_factor : Uint256, __warp_71_totalBalance : Uint256){
    alloc_locals;


        
            
            let (__warp_se_5) = WARP_DARRAY0_felt_LENGTH.read(allAssets);
            
            let (__warp_se_6) = warp_lt256(__warp_85_i, __warp_se_5);
            
                
                if (__warp_se_6 != 0){
                
                    
                        
                        let (__warp_se_7) = wm_index_dyn(__warp_74_assetBalances, __warp_85_i, Uint256(low=2, high=0));
                        
                        let (__warp_se_8) = wm_read_256(__warp_se_7);
                        
                        let (__warp_pse_3) = mul_c8a4ac9c(__warp_se_8, __warp_84_factor);
                        
                        let (__warp_pse_4) = div_a391c15b(__warp_pse_3, __warp_71_totalBalance);
                        
                        let (__warp_se_9) = wm_index_dyn(__warp_70_outputs, __warp_85_i, Uint256(low=2, high=0));
                        
                        wm_write_256(__warp_se_9, __warp_pse_4);
                    
                    let (__warp_pse_5) = warp_add256(__warp_85_i, Uint256(low=1, high=0));
                    
                    let __warp_85_i = __warp_pse_5;
                    
                    warp_sub256(__warp_pse_5, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_85_i = __warp_85_i;
                    tempvar __warp_70_outputs = __warp_70_outputs;
                    tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                    tempvar __warp_84_factor = __warp_84_factor;
                    tempvar __warp_71_totalBalance = __warp_71_totalBalance;
                }else{
                
                    
                    let __warp_85_i = __warp_85_i;
                    
                    let __warp_70_outputs = __warp_70_outputs;
                    
                    let __warp_74_assetBalances = __warp_74_assetBalances;
                    
                    let __warp_84_factor = __warp_84_factor;
                    
                    let __warp_71_totalBalance = __warp_71_totalBalance;
                    
                    
                    
                    return (__warp_85_i, __warp_70_outputs, __warp_74_assetBalances, __warp_84_factor, __warp_71_totalBalance);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_85_i = __warp_85_i;
                tempvar __warp_70_outputs = __warp_70_outputs;
                tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                tempvar __warp_84_factor = __warp_84_factor;
                tempvar __warp_71_totalBalance = __warp_71_totalBalance;
        
        let (__warp_85_i, __warp_td_1, __warp_td_2, __warp_84_factor, __warp_71_totalBalance) = __warp_while10(__warp_85_i, __warp_70_outputs, __warp_74_assetBalances, __warp_84_factor, __warp_71_totalBalance);
        
        let __warp_70_outputs = __warp_td_1;
        
        let __warp_74_assetBalances = __warp_td_2;
        
        
        
        return (__warp_85_i, __warp_70_outputs, __warp_74_assetBalances, __warp_84_factor, __warp_71_totalBalance);

    }


    func __warp_while9{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_81_i : Uint256, __warp_73_assetPrices : felt, __warp_74_assetBalances : felt, __warp_75_assetDecimals : felt, __warp_71_totalBalance : Uint256, __warp_76_totalOutputRatio : Uint256)-> (__warp_81_i : Uint256, __warp_73_assetPrices : felt, __warp_74_assetBalances : felt, __warp_75_assetDecimals : felt, __warp_71_totalBalance : Uint256, __warp_76_totalOutputRatio : Uint256){
    alloc_locals;


        
            
            let (__warp_se_10) = WARP_DARRAY0_felt_LENGTH.read(allAssets);
            
            let (__warp_se_11) = warp_lt256(__warp_81_i, __warp_se_10);
            
                
                if (__warp_se_11 != 0){
                
                    
                        
                        let (__warp_se_12) = wm_index_dyn(__warp_73_assetPrices, __warp_81_i, Uint256(low=2, high=0));
                        
                        let (__warp_82_price) = wm_read_256(__warp_se_12);
                        
                        let (__warp_se_13) = warp_lt256(__warp_82_price, Uint256(low=1000000000000000000, high=0));
                        
                            
                            if (__warp_se_13 != 0){
                            
                                
                                let __warp_82_price = Uint256(low=1000000000000000000, high=0);
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar warp_memory = warp_memory;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_81_i = __warp_81_i;
                                tempvar __warp_73_assetPrices = __warp_73_assetPrices;
                                tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                                tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
                                tempvar __warp_71_totalBalance = __warp_71_totalBalance;
                                tempvar __warp_76_totalOutputRatio = __warp_76_totalOutputRatio;
                                tempvar __warp_82_price = __warp_82_price;
                            }else{
                            
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar warp_memory = warp_memory;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_81_i = __warp_81_i;
                                tempvar __warp_73_assetPrices = __warp_73_assetPrices;
                                tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                                tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
                                tempvar __warp_71_totalBalance = __warp_71_totalBalance;
                                tempvar __warp_76_totalOutputRatio = __warp_76_totalOutputRatio;
                                tempvar __warp_82_price = __warp_82_price;
                            }
                            tempvar syscall_ptr = syscall_ptr;
                            tempvar pedersen_ptr = pedersen_ptr;
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar warp_memory = warp_memory;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar __warp_81_i = __warp_81_i;
                            tempvar __warp_73_assetPrices = __warp_73_assetPrices;
                            tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                            tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
                            tempvar __warp_71_totalBalance = __warp_71_totalBalance;
                            tempvar __warp_76_totalOutputRatio = __warp_76_totalOutputRatio;
                            tempvar __warp_82_price = __warp_82_price;
                        
                        let (__warp_se_14) = wm_index_dyn(__warp_74_assetBalances, __warp_81_i, Uint256(low=2, high=0));
                        
                        let (__warp_se_15) = wm_read_256(__warp_se_14);
                        
                        let (__warp_se_16) = wm_index_dyn(__warp_75_assetDecimals, __warp_81_i, Uint256(low=2, high=0));
                        
                        let (__warp_se_17) = wm_read_256(__warp_se_16);
                        
                        let (__warp_pse_6) = scaleBy_bd502d8d(__warp_se_15, Uint256(low=18, high=0), __warp_se_17);
                        
                        let (__warp_pse_7) = mul_c8a4ac9c(__warp_pse_6, __warp_82_price);
                        
                        let (__warp_83_ratio) = div_a391c15b(__warp_pse_7, __warp_71_totalBalance);
                        
                        let (__warp_pse_8) = add_771602f7(__warp_76_totalOutputRatio, __warp_83_ratio);
                        
                        let __warp_76_totalOutputRatio = __warp_pse_8;
                    
                    let (__warp_pse_9) = warp_add256(__warp_81_i, Uint256(low=1, high=0));
                    
                    let __warp_81_i = __warp_pse_9;
                    
                    warp_sub256(__warp_pse_9, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_81_i = __warp_81_i;
                    tempvar __warp_73_assetPrices = __warp_73_assetPrices;
                    tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                    tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
                    tempvar __warp_71_totalBalance = __warp_71_totalBalance;
                    tempvar __warp_76_totalOutputRatio = __warp_76_totalOutputRatio;
                }else{
                
                    
                    let __warp_81_i = __warp_81_i;
                    
                    let __warp_73_assetPrices = __warp_73_assetPrices;
                    
                    let __warp_74_assetBalances = __warp_74_assetBalances;
                    
                    let __warp_75_assetDecimals = __warp_75_assetDecimals;
                    
                    let __warp_71_totalBalance = __warp_71_totalBalance;
                    
                    let __warp_76_totalOutputRatio = __warp_76_totalOutputRatio;
                    
                    
                    
                    return (__warp_81_i, __warp_73_assetPrices, __warp_74_assetBalances, __warp_75_assetDecimals, __warp_71_totalBalance, __warp_76_totalOutputRatio);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_81_i = __warp_81_i;
                tempvar __warp_73_assetPrices = __warp_73_assetPrices;
                tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
                tempvar __warp_71_totalBalance = __warp_71_totalBalance;
                tempvar __warp_76_totalOutputRatio = __warp_76_totalOutputRatio;
        
        let (__warp_81_i, __warp_td_3, __warp_td_4, __warp_td_5, __warp_71_totalBalance, __warp_76_totalOutputRatio) = __warp_while9(__warp_81_i, __warp_73_assetPrices, __warp_74_assetBalances, __warp_75_assetDecimals, __warp_71_totalBalance, __warp_76_totalOutputRatio);
        
        let __warp_73_assetPrices = __warp_td_3;
        
        let __warp_74_assetBalances = __warp_td_4;
        
        let __warp_75_assetDecimals = __warp_td_5;
        
        
        
        return (__warp_81_i, __warp_73_assetPrices, __warp_74_assetBalances, __warp_75_assetDecimals, __warp_71_totalBalance, __warp_76_totalOutputRatio);

    }


    func __warp_while8{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_78_i : Uint256, __warp_74_assetBalances : felt, __warp_75_assetDecimals : felt, __warp_71_totalBalance : Uint256)-> (__warp_78_i : Uint256, __warp_74_assetBalances : felt, __warp_75_assetDecimals : felt, __warp_71_totalBalance : Uint256){
    alloc_locals;


        
            
            let (__warp_se_18) = WARP_DARRAY0_felt_LENGTH.read(allAssets);
            
            let (__warp_se_19) = warp_lt256(__warp_78_i, __warp_se_18);
            
                
                if (__warp_se_19 != 0){
                
                    
                        
                        let (__warp_se_20) = WARP_DARRAY0_felt_IDX(allAssets, __warp_78_i);
                        
                        let (__warp_se_21) = WS0_READ_felt(__warp_se_20);
                        
                        let (__warp_79_balance) = _checkBalance_e27a3dc8(__warp_se_21);
                        
                        let (__warp_se_22) = WARP_DARRAY0_felt_IDX(allAssets, __warp_78_i);
                        
                        let (__warp_se_23) = WS0_READ_felt(__warp_se_22);
                        
                        let (__warp_80_decimals) = getDecimals_cf54aaa0(__warp_se_23);
                        
                        let (__warp_se_24) = wm_index_dyn(__warp_74_assetBalances, __warp_78_i, Uint256(low=2, high=0));
                        
                        wm_write_256(__warp_se_24, __warp_79_balance);
                        
                        let (__warp_se_25) = wm_index_dyn(__warp_75_assetDecimals, __warp_78_i, Uint256(low=2, high=0));
                        
                        wm_write_256(__warp_se_25, __warp_80_decimals);
                        
                        let (__warp_pse_10) = scaleBy_bd502d8d(__warp_79_balance, Uint256(low=18, high=0), __warp_80_decimals);
                        
                        let (__warp_pse_11) = add_771602f7(__warp_71_totalBalance, __warp_pse_10);
                        
                        let __warp_71_totalBalance = __warp_pse_11;
                    
                    let (__warp_pse_12) = warp_add256(__warp_78_i, Uint256(low=1, high=0));
                    
                    let __warp_78_i = __warp_pse_12;
                    
                    warp_sub256(__warp_pse_12, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar __warp_78_i = __warp_78_i;
                    tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                    tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
                    tempvar __warp_71_totalBalance = __warp_71_totalBalance;
                }else{
                
                    
                    let __warp_78_i = __warp_78_i;
                    
                    let __warp_74_assetBalances = __warp_74_assetBalances;
                    
                    let __warp_75_assetDecimals = __warp_75_assetDecimals;
                    
                    let __warp_71_totalBalance = __warp_71_totalBalance;
                    
                    
                    
                    return (__warp_78_i, __warp_74_assetBalances, __warp_75_assetDecimals, __warp_71_totalBalance);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar __warp_78_i = __warp_78_i;
                tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
                tempvar __warp_71_totalBalance = __warp_71_totalBalance;
        
        let (__warp_78_i, __warp_td_6, __warp_td_7, __warp_71_totalBalance) = __warp_while8(__warp_78_i, __warp_74_assetBalances, __warp_75_assetDecimals, __warp_71_totalBalance);
        
        let __warp_74_assetBalances = __warp_td_6;
        
        let __warp_75_assetDecimals = __warp_td_7;
        
        
        
        return (__warp_78_i, __warp_74_assetBalances, __warp_75_assetDecimals, __warp_71_totalBalance);

    }


    func __warp_while6{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_61_i : Uint256, __warp_58__asset : felt, __warp_59_balance : Uint256)-> (__warp_61_i : Uint256, __warp_58__asset : felt, __warp_59_balance : Uint256){
    alloc_locals;


        
            
            let (__warp_se_26) = WARP_DARRAY0_felt_LENGTH.read(allStrategies);
            
            let (__warp_se_27) = warp_lt256(__warp_61_i, __warp_se_26);
            
                
                if (__warp_se_27 != 0){
                
                    
                        
                        let (__warp_se_28) = WARP_DARRAY0_felt_IDX(allStrategies, __warp_61_i);
                        
                        let (__warp_62_strategy) = WS0_READ_felt(__warp_se_28);
                        
                        let (__warp_pse_17) = IStrategy_warped_interface.supportsAsset_aa388af6(__warp_62_strategy, __warp_58__asset);
                        
                            
                            if (__warp_pse_17 != 0){
                            
                                
                                let (__warp_pse_18) = IStrategy_warped_interface.checkBalance_5f515226(__warp_62_strategy, __warp_58__asset);
                                
                                let (__warp_pse_19) = add_771602f7(__warp_59_balance, __warp_pse_18);
                                
                                let __warp_59_balance = __warp_pse_19;
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_61_i = __warp_61_i;
                                tempvar __warp_58__asset = __warp_58__asset;
                                tempvar __warp_59_balance = __warp_59_balance;
                            }else{
                            
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_61_i = __warp_61_i;
                                tempvar __warp_58__asset = __warp_58__asset;
                                tempvar __warp_59_balance = __warp_59_balance;
                            }
                            tempvar syscall_ptr = syscall_ptr;
                            tempvar pedersen_ptr = pedersen_ptr;
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar __warp_61_i = __warp_61_i;
                            tempvar __warp_58__asset = __warp_58__asset;
                            tempvar __warp_59_balance = __warp_59_balance;
                    
                    let (__warp_pse_20) = warp_add256(__warp_61_i, Uint256(low=1, high=0));
                    
                    let __warp_61_i = __warp_pse_20;
                    
                    warp_sub256(__warp_pse_20, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_61_i = __warp_61_i;
                    tempvar __warp_58__asset = __warp_58__asset;
                    tempvar __warp_59_balance = __warp_59_balance;
                }else{
                
                    
                    let __warp_61_i = __warp_61_i;
                    
                    let __warp_58__asset = __warp_58__asset;
                    
                    let __warp_59_balance = __warp_59_balance;
                    
                    
                    
                    return (__warp_61_i, __warp_58__asset, __warp_59_balance);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_61_i = __warp_61_i;
                tempvar __warp_58__asset = __warp_58__asset;
                tempvar __warp_59_balance = __warp_59_balance;
        
        let (__warp_61_i, __warp_58__asset, __warp_59_balance) = __warp_while6(__warp_61_i, __warp_58__asset, __warp_59_balance);
        
        
        
        return (__warp_61_i, __warp_58__asset, __warp_59_balance);

    }


    func __warp_while5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_53_y : Uint256, __warp_52_strategy : felt, __warp_51_value : Uint256)-> (__warp_53_y : Uint256, __warp_52_strategy : felt, __warp_51_value : Uint256){
    alloc_locals;


        
            
            let (__warp_se_29) = WARP_DARRAY0_felt_LENGTH.read(allAssets);
            
            let (__warp_se_30) = warp_lt256(__warp_53_y, __warp_se_29);
            
                
                if (__warp_se_30 != 0){
                
                    
                        
                        let (__warp_se_31) = WARP_DARRAY0_felt_IDX(allAssets, __warp_53_y);
                        
                        let (__warp_se_32) = WS0_READ_felt(__warp_se_31);
                        
                        let (__warp_54_assetDecimals) = getDecimals_cf54aaa0(__warp_se_32);
                        
                        let (__warp_se_33) = WARP_DARRAY0_felt_IDX(allAssets, __warp_53_y);
                        
                        let (__warp_se_34) = WS0_READ_felt(__warp_se_33);
                        
                        let (__warp_pse_21) = IStrategy_warped_interface.supportsAsset_aa388af6(__warp_52_strategy, __warp_se_34);
                        
                            
                            if (__warp_pse_21 != 0){
                            
                                
                                let (__warp_se_35) = WARP_DARRAY0_felt_IDX(allAssets, __warp_53_y);
                                
                                let (__warp_se_36) = WS0_READ_felt(__warp_se_35);
                                
                                let (__warp_55_balance) = IStrategy_warped_interface.checkBalance_5f515226(__warp_52_strategy, __warp_se_36);
                                
                                let (__warp_se_37) = warp_gt256(__warp_55_balance, Uint256(low=0, high=0));
                                
                                    
                                    if (__warp_se_37 != 0){
                                    
                                        
                                        let (__warp_pse_22) = scaleBy_bd502d8d(__warp_55_balance, Uint256(low=18, high=0), __warp_54_assetDecimals);
                                        
                                        let (__warp_pse_23) = add_771602f7(__warp_51_value, __warp_pse_22);
                                        
                                        let __warp_51_value = __warp_pse_23;
                                        tempvar syscall_ptr = syscall_ptr;
                                        tempvar pedersen_ptr = pedersen_ptr;
                                        tempvar range_check_ptr = range_check_ptr;
                                        tempvar bitwise_ptr = bitwise_ptr;
                                        tempvar __warp_53_y = __warp_53_y;
                                        tempvar __warp_52_strategy = __warp_52_strategy;
                                        tempvar __warp_51_value = __warp_51_value;
                                    }else{
                                    
                                        tempvar syscall_ptr = syscall_ptr;
                                        tempvar pedersen_ptr = pedersen_ptr;
                                        tempvar range_check_ptr = range_check_ptr;
                                        tempvar bitwise_ptr = bitwise_ptr;
                                        tempvar __warp_53_y = __warp_53_y;
                                        tempvar __warp_52_strategy = __warp_52_strategy;
                                        tempvar __warp_51_value = __warp_51_value;
                                    }
                                    tempvar syscall_ptr = syscall_ptr;
                                    tempvar pedersen_ptr = pedersen_ptr;
                                    tempvar range_check_ptr = range_check_ptr;
                                    tempvar bitwise_ptr = bitwise_ptr;
                                    tempvar __warp_53_y = __warp_53_y;
                                    tempvar __warp_52_strategy = __warp_52_strategy;
                                    tempvar __warp_51_value = __warp_51_value;
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_53_y = __warp_53_y;
                                tempvar __warp_52_strategy = __warp_52_strategy;
                                tempvar __warp_51_value = __warp_51_value;
                            }else{
                            
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_53_y = __warp_53_y;
                                tempvar __warp_52_strategy = __warp_52_strategy;
                                tempvar __warp_51_value = __warp_51_value;
                            }
                            tempvar syscall_ptr = syscall_ptr;
                            tempvar pedersen_ptr = pedersen_ptr;
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar __warp_53_y = __warp_53_y;
                            tempvar __warp_52_strategy = __warp_52_strategy;
                            tempvar __warp_51_value = __warp_51_value;
                    
                    let (__warp_pse_24) = warp_add256(__warp_53_y, Uint256(low=1, high=0));
                    
                    let __warp_53_y = __warp_pse_24;
                    
                    warp_sub256(__warp_pse_24, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_53_y = __warp_53_y;
                    tempvar __warp_52_strategy = __warp_52_strategy;
                    tempvar __warp_51_value = __warp_51_value;
                }else{
                
                    
                    let __warp_53_y = __warp_53_y;
                    
                    let __warp_52_strategy = __warp_52_strategy;
                    
                    let __warp_51_value = __warp_51_value;
                    
                    
                    
                    return (__warp_53_y, __warp_52_strategy, __warp_51_value);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_53_y = __warp_53_y;
                tempvar __warp_52_strategy = __warp_52_strategy;
                tempvar __warp_51_value = __warp_51_value;
        
        let (__warp_53_y, __warp_52_strategy, __warp_51_value) = __warp_while5(__warp_53_y, __warp_52_strategy, __warp_51_value);
        
        
        
        return (__warp_53_y, __warp_52_strategy, __warp_51_value);

    }


    func __warp_while4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_49_i : Uint256, __warp_48_value : Uint256)-> (__warp_49_i : Uint256, __warp_48_value : Uint256){
    alloc_locals;


        
            
            let (__warp_se_38) = WARP_DARRAY0_felt_LENGTH.read(allStrategies);
            
            let (__warp_se_39) = warp_lt256(__warp_49_i, __warp_se_38);
            
                
                if (__warp_se_39 != 0){
                
                    
                        
                        let (__warp_se_40) = WARP_DARRAY0_felt_IDX(allStrategies, __warp_49_i);
                        
                        let (__warp_se_41) = WS0_READ_felt(__warp_se_40);
                        
                        let (__warp_pse_25) = _totalValueInStrategy_f633af46(__warp_se_41);
                        
                        let (__warp_pse_26) = add_771602f7(__warp_48_value, __warp_pse_25);
                        
                        let __warp_48_value = __warp_pse_26;
                    
                    let (__warp_pse_27) = warp_add256(__warp_49_i, Uint256(low=1, high=0));
                    
                    let __warp_49_i = __warp_pse_27;
                    
                    warp_sub256(__warp_pse_27, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_49_i = __warp_49_i;
                    tempvar __warp_48_value = __warp_48_value;
                }else{
                
                    
                    let __warp_49_i = __warp_49_i;
                    
                    let __warp_48_value = __warp_48_value;
                    
                    
                    
                    return (__warp_49_i, __warp_48_value);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_49_i = __warp_49_i;
                tempvar __warp_48_value = __warp_48_value;
        
        let (__warp_49_i, __warp_48_value) = __warp_while4(__warp_49_i, __warp_48_value);
        
        
        
        return (__warp_49_i, __warp_48_value);

    }


    func __warp_while3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_44_y : Uint256, __warp_43_value : Uint256)-> (__warp_44_y : Uint256, __warp_43_value : Uint256){
    alloc_locals;


        
            
            let (__warp_se_42) = WARP_DARRAY0_felt_LENGTH.read(allAssets);
            
            let (__warp_se_43) = warp_lt256(__warp_44_y, __warp_se_42);
            
                
                if (__warp_se_43 != 0){
                
                    
                        
                        let (__warp_se_44) = WARP_DARRAY0_felt_IDX(allAssets, __warp_44_y);
                        
                        let (__warp_45_asset) = WS0_READ_felt(__warp_se_44);
                        
                        let (__warp_se_45) = WARP_DARRAY0_felt_IDX(allAssets, __warp_44_y);
                        
                        let (__warp_se_46) = WS0_READ_felt(__warp_se_45);
                        
                        let (__warp_46_assetDecimals) = getDecimals_cf54aaa0(__warp_se_46);
                        
                        let (__warp_se_47) = get_contract_address();
                        
                        let (__warp_47_balance) = IERC20_warped_interface.balanceOf_70a08231(__warp_45_asset, __warp_se_47);
                        
                        let (__warp_se_48) = warp_gt256(__warp_47_balance, Uint256(low=0, high=0));
                        
                            
                            if (__warp_se_48 != 0){
                            
                                
                                let (__warp_pse_28) = scaleBy_bd502d8d(__warp_47_balance, Uint256(low=18, high=0), __warp_46_assetDecimals);
                                
                                let (__warp_pse_29) = add_771602f7(__warp_43_value, __warp_pse_28);
                                
                                let __warp_43_value = __warp_pse_29;
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_44_y = __warp_44_y;
                                tempvar __warp_43_value = __warp_43_value;
                            }else{
                            
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_44_y = __warp_44_y;
                                tempvar __warp_43_value = __warp_43_value;
                            }
                            tempvar syscall_ptr = syscall_ptr;
                            tempvar pedersen_ptr = pedersen_ptr;
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar __warp_44_y = __warp_44_y;
                            tempvar __warp_43_value = __warp_43_value;
                    
                    let (__warp_pse_30) = warp_add256(__warp_44_y, Uint256(low=1, high=0));
                    
                    let __warp_44_y = __warp_pse_30;
                    
                    warp_sub256(__warp_pse_30, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_44_y = __warp_44_y;
                    tempvar __warp_43_value = __warp_43_value;
                }else{
                
                    
                    let __warp_44_y = __warp_44_y;
                    
                    let __warp_43_value = __warp_43_value;
                    
                    
                    
                    return (__warp_44_y, __warp_43_value);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_44_y = __warp_44_y;
                tempvar __warp_43_value = __warp_43_value;
        
        let (__warp_44_y, __warp_43_value) = __warp_while3(__warp_44_y, __warp_43_value);
        
        
        
        return (__warp_44_y, __warp_43_value);

    }


    func __warp_conditional___warp_while2_1{range_check_ptr : felt}(__warp_34_depositStrategyAddr : felt, __warp_33_allocateAmount : Uint256)-> (__warp_rc_0 : felt, __warp_34_depositStrategyAddr : felt, __warp_33_allocateAmount : Uint256){
    alloc_locals;


        
        let (__warp_se_49) = warp_neq(__warp_34_depositStrategyAddr, 0);
        
        if (__warp_se_49 != 0){
        
            
            let (__warp_se_50) = warp_gt256(__warp_33_allocateAmount, Uint256(low=0, high=0));
            
            let __warp_rc_0 = __warp_se_50;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_34_depositStrategyAddr = __warp_34_depositStrategyAddr;
            
            let __warp_33_allocateAmount = __warp_33_allocateAmount;
            
            
            
            return (__warp_rc_0, __warp_34_depositStrategyAddr, __warp_33_allocateAmount);
        }else{
        
            
            let __warp_rc_0 = 0;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_34_depositStrategyAddr = __warp_34_depositStrategyAddr;
            
            let __warp_33_allocateAmount = __warp_33_allocateAmount;
            
            
            
            return (__warp_rc_0, __warp_34_depositStrategyAddr, __warp_33_allocateAmount);
        }

    }


    func __warp_while2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_30_i : Uint256, __warp_29_vaultBufferModifier : Uint256)-> (__warp_30_i : Uint256, __warp_29_vaultBufferModifier : Uint256){
    alloc_locals;


        
            
            let (__warp_se_51) = WARP_DARRAY0_felt_LENGTH.read(allAssets);
            
            let (__warp_se_52) = warp_lt256(__warp_30_i, __warp_se_51);
            
                
                if (__warp_se_52 != 0){
                
                    
                        
                        let (__warp_se_53) = WARP_DARRAY0_felt_IDX(allAssets, __warp_30_i);
                        
                        let (__warp_31_asset) = WS0_READ_felt(__warp_se_53);
                        
                        let (__warp_se_54) = get_contract_address();
                        
                        let (__warp_32_assetBalance) = IERC20_warped_interface.balanceOf_70a08231(__warp_31_asset, __warp_se_54);
                        
                        let (__warp_se_55) = warp_eq256(__warp_32_assetBalance, Uint256(low=0, high=0));
                        
                            
                            if (__warp_se_55 != 0){
                            
                                
                                let (__warp_pse_31) = warp_add256(__warp_30_i, Uint256(low=1, high=0));
                                
                                let __warp_30_i = __warp_pse_31;
                                
                                warp_sub256(__warp_pse_31, Uint256(low=1, high=0));
                                
                                let (__warp_30_i, __warp_29_vaultBufferModifier) = __warp_while2(__warp_30_i, __warp_29_vaultBufferModifier);
                                
                                
                                
                                return (__warp_30_i, __warp_29_vaultBufferModifier);
                            }else{
                            
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar warp_memory = warp_memory;
                                tempvar keccak_ptr = keccak_ptr;
                                tempvar __warp_30_i = __warp_30_i;
                                tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
                                tempvar __warp_31_asset = __warp_31_asset;
                                tempvar __warp_32_assetBalance = __warp_32_assetBalance;
                            }
                            tempvar syscall_ptr = syscall_ptr;
                            tempvar pedersen_ptr = pedersen_ptr;
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar warp_memory = warp_memory;
                            tempvar keccak_ptr = keccak_ptr;
                            tempvar __warp_30_i = __warp_30_i;
                            tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
                            tempvar __warp_31_asset = __warp_31_asset;
                            tempvar __warp_32_assetBalance = __warp_32_assetBalance;
                        
                        let (__warp_33_allocateAmount) = mulTruncate_8f8a618a(__warp_32_assetBalance, __warp_29_vaultBufferModifier);
                        
                        let (__warp_se_56) = WS0_INDEX_felt_to_felt(__warp_8_assetDefaultStrategies, __warp_31_asset);
                        
                        let (__warp_34_depositStrategyAddr) = WS0_READ_felt(__warp_se_56);
                        
                        let __warp_rc_0 = 0;
                        
                            
                            let (__warp_tv_0, __warp_tv_1, __warp_tv_2) = __warp_conditional___warp_while2_1(__warp_34_depositStrategyAddr, __warp_33_allocateAmount);
                            
                            let __warp_33_allocateAmount = __warp_tv_2;
                            
                            let __warp_34_depositStrategyAddr = __warp_tv_1;
                            
                            let __warp_rc_0 = __warp_tv_0;
                        
                            
                            if (__warp_rc_0 != 0){
                            
                                
                                let __warp_35_strategy = __warp_34_depositStrategyAddr;
                                
                                IERC20_warped_interface.transfer_a9059cbb(__warp_31_asset, __warp_35_strategy, __warp_33_allocateAmount);
                                
                                IStrategy_warped_interface.deposit_47e7ef24(__warp_35_strategy, __warp_31_asset, __warp_33_allocateAmount);
                                
                                __warp_emit_AssetAllocated_41b99659f6ba0803f444aff29e5bf6e26dd86a3219aff92119d69710a956ba8d(__warp_31_asset, __warp_34_depositStrategyAddr, __warp_33_allocateAmount);
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar warp_memory = warp_memory;
                                tempvar keccak_ptr = keccak_ptr;
                                tempvar __warp_30_i = __warp_30_i;
                                tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
                            }else{
                            
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar warp_memory = warp_memory;
                                tempvar keccak_ptr = keccak_ptr;
                                tempvar __warp_30_i = __warp_30_i;
                                tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
                            }
                            tempvar syscall_ptr = syscall_ptr;
                            tempvar pedersen_ptr = pedersen_ptr;
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar warp_memory = warp_memory;
                            tempvar keccak_ptr = keccak_ptr;
                            tempvar __warp_30_i = __warp_30_i;
                            tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
                    
                    let (__warp_pse_32) = warp_add256(__warp_30_i, Uint256(low=1, high=0));
                    
                    let __warp_30_i = __warp_pse_32;
                    
                    warp_sub256(__warp_pse_32, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar keccak_ptr = keccak_ptr;
                    tempvar __warp_30_i = __warp_30_i;
                    tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
                }else{
                
                    
                    let __warp_30_i = __warp_30_i;
                    
                    let __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
                    
                    
                    
                    return (__warp_30_i, __warp_29_vaultBufferModifier);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_30_i = __warp_30_i;
                tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
        
        let (__warp_30_i, __warp_29_vaultBufferModifier) = __warp_while2(__warp_30_i, __warp_29_vaultBufferModifier);
        
        
        
        return (__warp_30_i, __warp_29_vaultBufferModifier);

    }


    func __warp_while1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_22_i : Uint256, __warp_13_outputs : felt, __warp_21_unitTotal : Uint256)-> (__warp_22_i : Uint256, __warp_13_outputs : felt, __warp_21_unitTotal : Uint256){
    alloc_locals;


        
            
            let (__warp_se_57) = wm_dyn_array_length(__warp_13_outputs);
            
            let (__warp_se_58) = warp_lt256(__warp_22_i, __warp_se_57);
            
                
                if (__warp_se_58 != 0){
                
                    
                        
                        let (__warp_se_59) = WARP_DARRAY0_felt_IDX(allAssets, __warp_22_i);
                        
                        let (__warp_se_60) = WS0_READ_felt(__warp_se_59);
                        
                        let (__warp_23_assetDecimals) = getDecimals_cf54aaa0(__warp_se_60);
                        
                        let (__warp_se_61) = wm_index_dyn(__warp_13_outputs, __warp_22_i, Uint256(low=2, high=0));
                        
                        let (__warp_se_62) = wm_read_256(__warp_se_61);
                        
                        let (__warp_pse_33) = scaleBy_bd502d8d(__warp_se_62, Uint256(low=18, high=0), __warp_23_assetDecimals);
                        
                        let (__warp_pse_34) = add_771602f7(__warp_21_unitTotal, __warp_pse_33);
                        
                        let __warp_21_unitTotal = __warp_pse_34;
                    
                    let (__warp_pse_35) = warp_add256(__warp_22_i, Uint256(low=1, high=0));
                    
                    let __warp_22_i = __warp_pse_35;
                    
                    warp_sub256(__warp_pse_35, Uint256(low=1, high=0));
                    tempvar warp_memory = warp_memory;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_22_i = __warp_22_i;
                    tempvar __warp_13_outputs = __warp_13_outputs;
                    tempvar __warp_21_unitTotal = __warp_21_unitTotal;
                }else{
                
                    
                    let __warp_22_i = __warp_22_i;
                    
                    let __warp_13_outputs = __warp_13_outputs;
                    
                    let __warp_21_unitTotal = __warp_21_unitTotal;
                    
                    
                    
                    return (__warp_22_i, __warp_13_outputs, __warp_21_unitTotal);
                }
                tempvar warp_memory = warp_memory;
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_22_i = __warp_22_i;
                tempvar __warp_13_outputs = __warp_13_outputs;
                tempvar __warp_21_unitTotal = __warp_21_unitTotal;
        
        let (__warp_22_i, __warp_td_8, __warp_21_unitTotal) = __warp_while1(__warp_22_i, __warp_13_outputs, __warp_21_unitTotal);
        
        let __warp_13_outputs = __warp_td_8;
        
        
        
        return (__warp_22_i, __warp_13_outputs, __warp_21_unitTotal);

    }


    func __warp_while0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_17_i : Uint256, __warp_13_outputs : felt)-> (__warp_17_i : Uint256, __warp_13_outputs : felt){
    alloc_locals;


        
            
            let (__warp_se_63) = WARP_DARRAY0_felt_LENGTH.read(allAssets);
            
            let (__warp_se_64) = warp_lt256(__warp_17_i, __warp_se_63);
            
                
                if (__warp_se_64 != 0){
                
                    
                        
                        let (__warp_se_65) = wm_index_dyn(__warp_13_outputs, __warp_17_i, Uint256(low=2, high=0));
                        
                        let (__warp_se_66) = wm_read_256(__warp_se_65);
                        
                        let (__warp_se_67) = warp_eq256(__warp_se_66, Uint256(low=0, high=0));
                        
                            
                            if (__warp_se_67 != 0){
                            
                                
                                let (__warp_pse_36) = warp_add256(__warp_17_i, Uint256(low=1, high=0));
                                
                                let __warp_17_i = __warp_pse_36;
                                
                                warp_sub256(__warp_pse_36, Uint256(low=1, high=0));
                                
                                let (__warp_17_i, __warp_td_9) = __warp_while0(__warp_17_i, __warp_13_outputs);
                                
                                let __warp_13_outputs = __warp_td_9;
                                
                                
                                
                                return (__warp_17_i, __warp_13_outputs);
                            }else{
                            
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar warp_memory = warp_memory;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_17_i = __warp_17_i;
                                tempvar __warp_13_outputs = __warp_13_outputs;
                            }
                            tempvar syscall_ptr = syscall_ptr;
                            tempvar pedersen_ptr = pedersen_ptr;
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar warp_memory = warp_memory;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar __warp_17_i = __warp_17_i;
                            tempvar __warp_13_outputs = __warp_13_outputs;
                        
                        let (__warp_se_68) = WARP_DARRAY0_felt_IDX(allAssets, __warp_17_i);
                        
                        let (__warp_18_asset) = WS0_READ_felt(__warp_se_68);
                        
                        let (__warp_se_69) = get_contract_address();
                        
                        let (__warp_pse_37) = IERC20_warped_interface.balanceOf_70a08231(__warp_18_asset, __warp_se_69);
                        
                        let (__warp_se_70) = wm_index_dyn(__warp_13_outputs, __warp_17_i, Uint256(low=2, high=0));
                        
                        let (__warp_se_71) = wm_read_256(__warp_se_70);
                        
                        let (__warp_se_72) = warp_ge256(__warp_pse_37, __warp_se_71);
                        
                            
                            if (__warp_se_72 != 0){
                            
                                
                                let (__warp_se_73) = get_caller_address();
                                
                                let (__warp_se_74) = wm_index_dyn(__warp_13_outputs, __warp_17_i, Uint256(low=2, high=0));
                                
                                let (__warp_se_75) = wm_read_256(__warp_se_74);
                                
                                IERC20_warped_interface.transfer_a9059cbb(__warp_18_asset, __warp_se_73, __warp_se_75);
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar warp_memory = warp_memory;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_17_i = __warp_17_i;
                                tempvar __warp_13_outputs = __warp_13_outputs;
                            }else{
                            
                                
                                let (__warp_se_76) = WARP_DARRAY0_felt_IDX(allAssets, __warp_17_i);
                                
                                let (__warp_se_77) = WS0_READ_felt(__warp_se_76);
                                
                                let (__warp_se_78) = WS0_INDEX_felt_to_felt(__warp_8_assetDefaultStrategies, __warp_se_77);
                                
                                let (__warp_19_strategyAddr) = WS0_READ_felt(__warp_se_78);
                                
                                let (__warp_se_79) = warp_neq(__warp_19_strategyAddr, 0);
                                
                                    
                                    if (__warp_se_79 != 0){
                                    
                                        
                                        let __warp_20_strategy = __warp_19_strategyAddr;
                                        
                                        let (__warp_se_80) = get_caller_address();
                                        
                                        let (__warp_se_81) = WARP_DARRAY0_felt_IDX(allAssets, __warp_17_i);
                                        
                                        let (__warp_se_82) = WS0_READ_felt(__warp_se_81);
                                        
                                        let (__warp_se_83) = wm_index_dyn(__warp_13_outputs, __warp_17_i, Uint256(low=2, high=0));
                                        
                                        let (__warp_se_84) = wm_read_256(__warp_se_83);
                                        
                                        IStrategy_warped_interface.withdraw_d9caed12(__warp_20_strategy, __warp_se_80, __warp_se_82, __warp_se_84);
                                        tempvar syscall_ptr = syscall_ptr;
                                        tempvar pedersen_ptr = pedersen_ptr;
                                        tempvar range_check_ptr = range_check_ptr;
                                        tempvar warp_memory = warp_memory;
                                        tempvar bitwise_ptr = bitwise_ptr;
                                        tempvar __warp_17_i = __warp_17_i;
                                        tempvar __warp_13_outputs = __warp_13_outputs;
                                    }else{
                                    
                                        
                                        with_attr error_message("Liquidity error"){
                                            assert 0 = 1;
                                        }
                                        tempvar syscall_ptr = syscall_ptr;
                                        tempvar pedersen_ptr = pedersen_ptr;
                                        tempvar range_check_ptr = range_check_ptr;
                                        tempvar warp_memory = warp_memory;
                                        tempvar bitwise_ptr = bitwise_ptr;
                                        tempvar __warp_17_i = __warp_17_i;
                                        tempvar __warp_13_outputs = __warp_13_outputs;
                                    }
                                    tempvar syscall_ptr = syscall_ptr;
                                    tempvar pedersen_ptr = pedersen_ptr;
                                    tempvar range_check_ptr = range_check_ptr;
                                    tempvar warp_memory = warp_memory;
                                    tempvar bitwise_ptr = bitwise_ptr;
                                    tempvar __warp_17_i = __warp_17_i;
                                    tempvar __warp_13_outputs = __warp_13_outputs;
                                tempvar syscall_ptr = syscall_ptr;
                                tempvar pedersen_ptr = pedersen_ptr;
                                tempvar range_check_ptr = range_check_ptr;
                                tempvar warp_memory = warp_memory;
                                tempvar bitwise_ptr = bitwise_ptr;
                                tempvar __warp_17_i = __warp_17_i;
                                tempvar __warp_13_outputs = __warp_13_outputs;
                            }
                            tempvar syscall_ptr = syscall_ptr;
                            tempvar pedersen_ptr = pedersen_ptr;
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar warp_memory = warp_memory;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar __warp_17_i = __warp_17_i;
                            tempvar __warp_13_outputs = __warp_13_outputs;
                    
                    let (__warp_pse_38) = warp_add256(__warp_17_i, Uint256(low=1, high=0));
                    
                    let __warp_17_i = __warp_pse_38;
                    
                    warp_sub256(__warp_pse_38, Uint256(low=1, high=0));
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_17_i = __warp_17_i;
                    tempvar __warp_13_outputs = __warp_13_outputs;
                }else{
                
                    
                    let __warp_17_i = __warp_17_i;
                    
                    let __warp_13_outputs = __warp_13_outputs;
                    
                    
                    
                    return (__warp_17_i, __warp_13_outputs);
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_17_i = __warp_17_i;
                tempvar __warp_13_outputs = __warp_13_outputs;
        
        let (__warp_17_i, __warp_td_10) = __warp_while0(__warp_17_i, __warp_13_outputs);
        
        let __warp_13_outputs = __warp_td_10;
        
        
        
        return (__warp_17_i, __warp_13_outputs);

    }


    func __warp_modifier_onlyOwner_transferOwnership_f2fde38b_30{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_3_newOwner29 : felt)-> (){
    alloc_locals;


        
        let (__warp_pse_39) = owner_8da5cb5b_internal();
        
        let (__warp_pse_40) = _msgSender_119df25f();
        
        let (__warp_se_85) = warp_eq(__warp_pse_39, __warp_pse_40);
        
        with_attr error_message("Ownable: caller is not the owner"){
            assert __warp_se_85 = 1;
        }
        
        __warp_original_function_transferOwnership_f2fde38b_28(__warp_parameter___warp_3_newOwner29);
        
        
        
        return ();

    }

    //  @dev Transfers ownership of the contract to a new account (`newOwner`).
    // Can only be called by the current owner.
    func __warp_original_function_transferOwnership_f2fde38b_28{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_3_newOwner : felt)-> (){
    alloc_locals;


        
        let (__warp_se_86) = warp_neq(__warp_3_newOwner, 0);
        
        with_attr error_message("Ownable: new owner is the zero address"){
            assert __warp_se_86 = 1;
        }
        
        _transferOwnership_d29d44ee(__warp_3_newOwner);
        
        
        
        return ();

    }


    func __warp_modifier_onlyOwner_renounceOwnership_715018a6_27{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_pse_41) = owner_8da5cb5b_internal();
        
        let (__warp_pse_42) = _msgSender_119df25f();
        
        let (__warp_se_87) = warp_eq(__warp_pse_41, __warp_pse_42);
        
        with_attr error_message("Ownable: caller is not the owner"){
            assert __warp_se_87 = 1;
        }
        
        __warp_original_function_renounceOwnership_715018a6_26();
        
        
        
        return ();

    }

    //  @dev Leaves the contract without owner. It will not be possible to call
    // `onlyOwner` functions anymore. Can only be called by the current owner.
    // NOTE: Renouncing ownership will leave the contract without an owner,
    // thereby removing any functionality that is only available to the owner.
    func __warp_original_function_renounceOwnership_715018a6_26{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        _transferOwnership_d29d44ee(0);
        
        
        
        return ();

    }


    func __warp_modifier_whenNotRebasePaused__rebase_edb65cb4_25{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_se_88) = WS0_READ_felt(__warp_1_rebasePaused);
        
        with_attr error_message("Rebasing paused"){
            assert 1 - __warp_se_88 = 1;
        }
        
        __warp_original_function__rebase_edb65cb4_24();
        
        
        
        return ();

    }


    func __warp_conditional___warp_original_function__rebase_edb65cb4_24_3{range_check_ptr : felt}(__warp_39__trusteeAddress : felt, __warp_38_vaultValue : Uint256, __warp_37_ousdSupply : Uint256)-> (__warp_rc_2 : felt, __warp_39__trusteeAddress : felt, __warp_38_vaultValue : Uint256, __warp_37_ousdSupply : Uint256){
    alloc_locals;


        
        let (__warp_se_89) = warp_neq(__warp_39__trusteeAddress, 0);
        
        if (__warp_se_89 != 0){
        
            
            let (__warp_se_90) = warp_gt256(__warp_38_vaultValue, __warp_37_ousdSupply);
            
            let __warp_rc_2 = __warp_se_90;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_39__trusteeAddress = __warp_39__trusteeAddress;
            
            let __warp_38_vaultValue = __warp_38_vaultValue;
            
            let __warp_37_ousdSupply = __warp_37_ousdSupply;
            
            
            
            return (__warp_rc_2, __warp_39__trusteeAddress, __warp_38_vaultValue, __warp_37_ousdSupply);
        }else{
        
            
            let __warp_rc_2 = 0;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_39__trusteeAddress = __warp_39__trusteeAddress;
            
            let __warp_38_vaultValue = __warp_38_vaultValue;
            
            let __warp_37_ousdSupply = __warp_37_ousdSupply;
            
            
            
            return (__warp_rc_2, __warp_39__trusteeAddress, __warp_38_vaultValue, __warp_37_ousdSupply);
        }

    }

    //  @dev Calculate the total value of assets held by the Vault and all
    //      strategies and update the supply of OUSD, optionally sending a
    //      portion of the yield to the trustee.
    func __warp_original_function__rebase_edb65cb4_24{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_se_91) = WS0_READ_felt(oUSD);
        
        let (__warp_37_ousdSupply) = OUSD_warped_interface.totalSupply_18160ddd(__warp_se_91);
        
        let (__warp_se_92) = warp_eq256(__warp_37_ousdSupply, Uint256(low=0, high=0));
        
            
            if (__warp_se_92 != 0){
            
                
                
                
                return ();
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_37_ousdSupply = __warp_37_ousdSupply;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_37_ousdSupply = __warp_37_ousdSupply;
        
        let (__warp_38_vaultValue) = _totalValue_43038ff3();
        
        let (__warp_39__trusteeAddress) = WS0_READ_felt(__warp_10_trusteeAddress);
        
        let __warp_rc_2 = 0;
        
            
            let (__warp_tv_3, __warp_tv_4, __warp_tv_5, __warp_tv_6) = __warp_conditional___warp_original_function__rebase_edb65cb4_24_3(__warp_39__trusteeAddress, __warp_38_vaultValue, __warp_37_ousdSupply);
            
            let __warp_37_ousdSupply = __warp_tv_6;
            
            let __warp_38_vaultValue = __warp_tv_5;
            
            let __warp_39__trusteeAddress = __warp_tv_4;
            
            let __warp_rc_2 = __warp_tv_3;
        
            
            if (__warp_rc_2 != 0){
            
                
                let (__warp_40_yield) = sub_b67d77c5(__warp_38_vaultValue, __warp_37_ousdSupply);
                
                let (__warp_se_93) = WS1_READ_Uint256(__warp_11_trusteeFeeBps);
                
                let (__warp_pse_43) = mul_c8a4ac9c(__warp_40_yield, __warp_se_93);
                
                let (__warp_41_fee) = div_a391c15b(__warp_pse_43, Uint256(low=10000, high=0));
                
                let (__warp_se_94) = warp_gt256(__warp_40_yield, __warp_41_fee);
                
                with_attr error_message("Fee must not be greater than yield"){
                    assert __warp_se_94 = 1;
                }
                
                let (__warp_se_95) = warp_gt256(__warp_41_fee, Uint256(low=0, high=0));
                
                    
                    if (__warp_se_95 != 0){
                    
                        
                        let (__warp_se_96) = WS0_READ_felt(oUSD);
                        
                        OUSD_warped_interface.mint_40c10f19(__warp_se_96, __warp_39__trusteeAddress, __warp_41_fee);
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar pedersen_ptr = pedersen_ptr;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar keccak_ptr = keccak_ptr;
                        tempvar __warp_38_vaultValue = __warp_38_vaultValue;
                        tempvar __warp_37_ousdSupply = __warp_37_ousdSupply;
                        tempvar __warp_39__trusteeAddress = __warp_39__trusteeAddress;
                        tempvar __warp_40_yield = __warp_40_yield;
                        tempvar __warp_41_fee = __warp_41_fee;
                    }else{
                    
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar pedersen_ptr = pedersen_ptr;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar keccak_ptr = keccak_ptr;
                        tempvar __warp_38_vaultValue = __warp_38_vaultValue;
                        tempvar __warp_37_ousdSupply = __warp_37_ousdSupply;
                        tempvar __warp_39__trusteeAddress = __warp_39__trusteeAddress;
                        tempvar __warp_40_yield = __warp_40_yield;
                        tempvar __warp_41_fee = __warp_41_fee;
                    }
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar keccak_ptr = keccak_ptr;
                    tempvar __warp_38_vaultValue = __warp_38_vaultValue;
                    tempvar __warp_37_ousdSupply = __warp_37_ousdSupply;
                    tempvar __warp_39__trusteeAddress = __warp_39__trusteeAddress;
                    tempvar __warp_40_yield = __warp_40_yield;
                    tempvar __warp_41_fee = __warp_41_fee;
                
                __warp_emit_YieldDistribution_09516ecf4a8a86e59780a9befc6dee948bc9e60a36e3be68d31ea817ee8d2c80(__warp_39__trusteeAddress, __warp_40_yield, __warp_41_fee);
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_38_vaultValue = __warp_38_vaultValue;
                tempvar __warp_37_ousdSupply = __warp_37_ousdSupply;
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_38_vaultValue = __warp_38_vaultValue;
                tempvar __warp_37_ousdSupply = __warp_37_ousdSupply;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_38_vaultValue = __warp_38_vaultValue;
            tempvar __warp_37_ousdSupply = __warp_37_ousdSupply;
        
        let (__warp_se_97) = WS0_READ_felt(oUSD);
        
        let (__warp_pse_44) = OUSD_warped_interface.totalSupply_18160ddd(__warp_se_97);
        
        let __warp_37_ousdSupply = __warp_pse_44;
        
        let (__warp_se_98) = warp_gt256(__warp_38_vaultValue, __warp_37_ousdSupply);
        
            
            if (__warp_se_98 != 0){
            
                
                let (__warp_se_99) = WS0_READ_felt(oUSD);
                
                OUSD_warped_interface.changeSupply_39a7919f(__warp_se_99, __warp_38_vaultValue);
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


    func __warp_modifier_whenNotCapitalPaused_allocate_abaa9916_23{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_se_100) = WS0_READ_felt(__warp_2_capitalPaused);
        
        with_attr error_message("Capital paused"){
            assert 1 - __warp_se_100 = 1;
        }
        
        __warp_original_function_allocate_abaa9916_22();
        
        
        
        return ();

    }

    //  @notice Allocate unallocated funds on Vault to strategies.
    // @dev Allocate unallocated funds on Vault to strategies.*
    func __warp_original_function_allocate_abaa9916_22{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        _allocate_153c6dab();
        
        
        
        return ();

    }


    func __warp_modifier_whenNotCapitalPaused_redeemAll_7136a7a6_21{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_25__minimumUnitAmount20 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_101) = WS0_READ_felt(__warp_2_capitalPaused);
        
        with_attr error_message("Capital paused"){
            assert 1 - __warp_se_101 = 1;
        }
        
        __warp_original_function_redeemAll_7136a7a6_19(__warp_parameter___warp_25__minimumUnitAmount20);
        
        
        
        return ();

    }

    //  @notice Withdraw a supported asset and burn all OUSD.
    // @param _minimumUnitAmount Minimum stablecoin units to receive in return
    func __warp_original_function_redeemAll_7136a7a6_19{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_25__minimumUnitAmount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_102) = WS0_READ_felt(oUSD);
        
        let (__warp_se_103) = get_caller_address();
        
        let (__warp_pse_45) = OUSD_warped_interface.balanceOf_70a08231(__warp_se_102, __warp_se_103);
        
        _redeem_3db27ce0(__warp_pse_45, __warp_25__minimumUnitAmount);
        
        
        
        return ();

    }


    func __warp_modifier_whenNotCapitalPaused_burnForStrategy_6217f3ea_18{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_parameter___warp_24__amount1517 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_104) = WS0_READ_felt(__warp_2_capitalPaused);
        
        with_attr error_message("Capital paused"){
            assert 1 - __warp_se_104 = 1;
        }
        
        __warp_modifier_onlyOusdMetaStrategy_burnForStrategy_6217f3ea_16(__warp_parameter___warp_parameter___warp_24__amount1517);
        
        
        
        return ();

    }


    func __warp_modifier_onlyOusdMetaStrategy_burnForStrategy_6217f3ea_16{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_24__amount15 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_105) = get_caller_address();
        
        let (__warp_se_106) = WS0_READ_felt(__warp_12_ousdMetaStrategy);
        
        let (__warp_se_107) = warp_eq(__warp_se_105, __warp_se_106);
        
        with_attr error_message("Caller is not the OUSD meta strategy"){
            assert __warp_se_107 = 1;
        }
        
        __warp_original_function_burnForStrategy_6217f3ea_14(__warp_parameter___warp_24__amount15);
        
        
        
        return ();

    }


    func __warp_conditional___warp_original_function_burnForStrategy_6217f3ea_14_5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_24__amount : Uint256)-> (__warp_rc_4 : felt, __warp_24__amount : Uint256){
    alloc_locals;


        
        let (__warp_se_108) = WS1_READ_Uint256(__warp_6_rebaseThreshold);
        
        let (__warp_se_109) = warp_ge256(__warp_24__amount, __warp_se_108);
        
        if (__warp_se_109 != 0){
        
            
            let (__warp_se_110) = WS0_READ_felt(__warp_1_rebasePaused);
            
            let __warp_rc_4 = 1 - __warp_se_110;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_24__amount = __warp_24__amount;
            
            
            
            return (__warp_rc_4, __warp_24__amount);
        }else{
        
            
            let __warp_rc_4 = 0;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_24__amount = __warp_24__amount;
            
            
            
            return (__warp_rc_4, __warp_24__amount);
        }

    }

    //  @dev Burn OUSD for OUSD Meta Strategy
    // @param _amount Amount of OUSD to burn
    // Notice: can't use `nonReentrant` modifier since the `redeem` function could
    // require withdrawal on `ConvexOUSDMetaStrategy` and that one can call `burnForStrategy`
    // while the execution of the `redeem` has not yet completed -> causing a `nonReentrant` collision.
    // Also important to understand is that this is a limitation imposed by the test suite.
    // Production / mainnet contracts should never be configured in a way where mint/redeem functions
    // that are moving funds between the Vault and end user wallets can influence strategies
    // utilizing this function.
    func __warp_original_function_burnForStrategy_6217f3ea_14{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_24__amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_111) = warp_lt256(__warp_24__amount, Uint256(low=340282366920938463463374607431768211455, high=170141183460469231731687303715884105727));
        
        with_attr error_message("Amount too high"){
            assert __warp_se_111 = 1;
        }
        
        let (__warp_se_112) = get_caller_address();
        
        __warp_emit_Redeem_222838db2794d11532d940e8dec38ae307ed0b63cd97c233322e221f998767a6(__warp_se_112, __warp_24__amount);
        
        let (__warp_se_113) = WS1_READ_Uint256(__warp_13_netOusdMintedForStrategy);
        
        let (__warp_se_114) = warp_sub_signed256(__warp_se_113, __warp_24__amount);
        
        WS_WRITE0(__warp_13_netOusdMintedForStrategy, __warp_se_114);
        
        let (__warp_se_115) = WS1_READ_Uint256(__warp_13_netOusdMintedForStrategy);
        
        let (__warp_pse_46) = abs_1b5ac4b5(__warp_se_115);
        
        let (__warp_se_116) = WS1_READ_Uint256(__warp_14_netOusdMintForStrategyThreshold);
        
        let (__warp_se_117) = warp_lt256(__warp_pse_46, __warp_se_116);
        
        with_attr error_message("Attempting to burn too much OUSD."){
            assert __warp_se_117 = 1;
        }
        
        let (__warp_se_118) = WS0_READ_felt(oUSD);
        
        let (__warp_se_119) = get_caller_address();
        
        OUSD_warped_interface.burn_9dc29fac(__warp_se_118, __warp_se_119, __warp_24__amount);
        
        let __warp_rc_4 = 0;
        
            
            let (__warp_tv_7, __warp_tv_8) = __warp_conditional___warp_original_function_burnForStrategy_6217f3ea_14_5(__warp_24__amount);
            
            let __warp_24__amount = __warp_tv_8;
            
            let __warp_rc_4 = __warp_tv_7;
        
            
            if (__warp_rc_4 != 0){
            
                
                _rebase_edb65cb4();
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar syscall_ptr = syscall_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
        
        
        
        return ();

    }


    func __warp_modifier_whenNotCapitalPaused_redeem_7cbc2373_13{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_9__amount11 : Uint256, __warp_parameter___warp_10__minimumUnitAmount12 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_120) = WS0_READ_felt(__warp_2_capitalPaused);
        
        with_attr error_message("Capital paused"){
            assert 1 - __warp_se_120 = 1;
        }
        
        __warp_original_function_redeem_7cbc2373_10(__warp_parameter___warp_9__amount11, __warp_parameter___warp_10__minimumUnitAmount12);
        
        
        
        return ();

    }

    //  @dev Withdraw a supported asset and burn OUSD.
    // @param _amount Amount of OUSD to burn
    // @param _minimumUnitAmount Minimum stablecoin units to receive in return
    func __warp_original_function_redeem_7cbc2373_10{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_9__amount : Uint256, __warp_10__minimumUnitAmount : Uint256)-> (){
    alloc_locals;


        
        _redeem_3db27ce0(__warp_9__amount, __warp_10__minimumUnitAmount);
        
        
        
        return ();

    }


    func __warp_modifier_whenNotCapitalPaused_mintForStrategy_ab80dafb_9{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_parameter___warp_8__amount68 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_121) = WS0_READ_felt(__warp_2_capitalPaused);
        
        with_attr error_message("Capital paused"){
            assert 1 - __warp_se_121 = 1;
        }
        
        __warp_modifier_onlyOusdMetaStrategy_mintForStrategy_ab80dafb_7(__warp_parameter___warp_parameter___warp_8__amount68);
        
        
        
        return ();

    }


    func __warp_modifier_onlyOusdMetaStrategy_mintForStrategy_ab80dafb_7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_8__amount6 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_122) = get_caller_address();
        
        let (__warp_se_123) = WS0_READ_felt(__warp_12_ousdMetaStrategy);
        
        let (__warp_se_124) = warp_eq(__warp_se_122, __warp_se_123);
        
        with_attr error_message("Caller is not the OUSD meta strategy"){
            assert __warp_se_124 = 1;
        }
        
        __warp_original_function_mintForStrategy_ab80dafb_5(__warp_parameter___warp_8__amount6);
        
        
        
        return ();

    }


    func __warp_conditional___warp_original_function_mintForStrategy_ab80dafb_5_7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_8__amount : Uint256)-> (__warp_rc_6 : felt, __warp_8__amount : Uint256){
    alloc_locals;


        
        let (__warp_se_125) = WS1_READ_Uint256(__warp_6_rebaseThreshold);
        
        let (__warp_se_126) = warp_ge256(__warp_8__amount, __warp_se_125);
        
        if (__warp_se_126 != 0){
        
            
            let (__warp_se_127) = WS0_READ_felt(__warp_1_rebasePaused);
            
            let __warp_rc_6 = 1 - __warp_se_127;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_8__amount = __warp_8__amount;
            
            
            
            return (__warp_rc_6, __warp_8__amount);
        }else{
        
            
            let __warp_rc_6 = 0;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_8__amount = __warp_8__amount;
            
            
            
            return (__warp_rc_6, __warp_8__amount);
        }

    }

    //  @dev Mint OUSD for OUSD Meta Strategy
    // @param _amount Amount of the asset being deposited
    // Notice: can't use `nonReentrant` modifier since the `mint` function can
    // call `allocate`, and that can trigger `ConvexOUSDMetaStrategy` to call this function
    // while the execution of the `mint` has not yet completed -> causing a `nonReentrant` collision.
    // Also important to understand is that this is a limitation imposed by the test suite.
    // Production / mainnet contracts should never be configured in a way where mint/redeem functions
    // that are moving funds between the Vault and end user wallets can influence strategies
    // utilizing this function.
    func __warp_original_function_mintForStrategy_ab80dafb_5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_8__amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_128) = warp_lt256(__warp_8__amount, Uint256(low=340282366920938463463374607431768211455, high=170141183460469231731687303715884105727));
        
        with_attr error_message("Amount too high"){
            assert __warp_se_128 = 1;
        }
        
        let (__warp_se_129) = get_caller_address();
        
        __warp_emit_Mint_0f6798a560793a54c3bcfe86a93cde1e73087d944c0ea20544137d4121396885(__warp_se_129, __warp_8__amount);
        
        let __warp_rc_6 = 0;
        
            
            let (__warp_tv_9, __warp_tv_10) = __warp_conditional___warp_original_function_mintForStrategy_ab80dafb_5_7(__warp_8__amount);
            
            let __warp_8__amount = __warp_tv_10;
            
            let __warp_rc_6 = __warp_tv_9;
        
            
            if (__warp_rc_6 != 0){
            
                
                _rebase_edb65cb4();
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar __warp_8__amount = __warp_8__amount;
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar __warp_8__amount = __warp_8__amount;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar syscall_ptr = syscall_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar __warp_8__amount = __warp_8__amount;
        
        let (__warp_se_130) = WS1_READ_Uint256(__warp_13_netOusdMintedForStrategy);
        
        let (__warp_se_131) = warp_add_signed256(__warp_se_130, __warp_8__amount);
        
        WS_WRITE0(__warp_13_netOusdMintedForStrategy, __warp_se_131);
        
        let (__warp_se_132) = WS1_READ_Uint256(__warp_13_netOusdMintedForStrategy);
        
        let (__warp_pse_47) = abs_1b5ac4b5(__warp_se_132);
        
        let (__warp_se_133) = WS1_READ_Uint256(__warp_14_netOusdMintForStrategyThreshold);
        
        let (__warp_se_134) = warp_lt256(__warp_pse_47, __warp_se_133);
        
        with_attr error_message("Minted ousd surpassed netOusdMintForStrategyThreshold."){
            assert __warp_se_134 = 1;
        }
        
        let (__warp_se_135) = WS0_READ_felt(oUSD);
        
        let (__warp_se_136) = get_caller_address();
        
        OUSD_warped_interface.mint_40c10f19(__warp_se_135, __warp_se_136, __warp_8__amount);
        
        
        
        return ();

    }


    func __warp_modifier_whenNotCapitalPaused_mint_156e29f6_4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_0__asset1 : felt, __warp_parameter___warp_1__amount2 : Uint256, __warp_parameter___warp_2__minimumOusdAmount3 : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_137) = WS0_READ_felt(__warp_2_capitalPaused);
        
        with_attr error_message("Capital paused"){
            assert 1 - __warp_se_137 = 1;
        }
        
        __warp_original_function_mint_156e29f6_0(__warp_parameter___warp_0__asset1, __warp_parameter___warp_1__amount2, __warp_parameter___warp_2__minimumOusdAmount3);
        
        
        
        return ();

    }


    func __warp_conditional___warp_original_function_mint_156e29f6_0_9{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_5_unitAdjustedDeposit : Uint256)-> (__warp_rc_8 : felt, __warp_5_unitAdjustedDeposit : Uint256){
    alloc_locals;


        
        let (__warp_se_138) = WS1_READ_Uint256(__warp_6_rebaseThreshold);
        
        let (__warp_se_139) = warp_ge256(__warp_5_unitAdjustedDeposit, __warp_se_138);
        
        if (__warp_se_139 != 0){
        
            
            let (__warp_se_140) = WS0_READ_felt(__warp_1_rebasePaused);
            
            let __warp_rc_8 = 1 - __warp_se_140;
            
            let __warp_rc_8 = __warp_rc_8;
            
            let __warp_5_unitAdjustedDeposit = __warp_5_unitAdjustedDeposit;
            
            
            
            return (__warp_rc_8, __warp_5_unitAdjustedDeposit);
        }else{
        
            
            let __warp_rc_8 = 0;
            
            let __warp_rc_8 = __warp_rc_8;
            
            let __warp_5_unitAdjustedDeposit = __warp_5_unitAdjustedDeposit;
            
            
            
            return (__warp_rc_8, __warp_5_unitAdjustedDeposit);
        }

    }

    //  @dev Deposit a supported asset and mint OUSD.
    // @param _asset Address of the asset being deposited
    // @param _amount Amount of the asset being deposited
    // @param _minimumOusdAmount Minimum OUSD to mint
    func __warp_original_function_mint_156e29f6_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_0__asset : felt, __warp_1__amount : Uint256, __warp_2__minimumOusdAmount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_141) = WS1_INDEX_felt_to_Asset_96786d17(assets, __warp_0__asset);
        
        let (__warp_se_142) = WSM0_Asset_96786d17_isSupported(__warp_se_141);
        
        let (__warp_se_143) = WS0_READ_felt(__warp_se_142);
        
        with_attr error_message("Asset is not supported"){
            assert __warp_se_143 = 1;
        }
        
        let (__warp_se_144) = warp_gt256(__warp_1__amount, Uint256(low=0, high=0));
        
        with_attr error_message("Amount must be greater than 0"){
            assert __warp_se_144 = 1;
        }
        
        let (__warp_se_145) = WS0_READ_felt(__warp_0_priceProvider);
        
        let (__warp_3_price) = IOracle_warped_interface.price_aea91078(__warp_se_145, __warp_0__asset);
        
        let (__warp_se_146) = warp_gt256(__warp_3_price, Uint256(low=100000000, high=0));
        
            
            if (__warp_se_146 != 0){
            
                
                let __warp_3_price = Uint256(low=100000000, high=0);
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_1__amount = __warp_1__amount;
                tempvar __warp_0__asset = __warp_0__asset;
                tempvar __warp_2__minimumOusdAmount = __warp_2__minimumOusdAmount;
                tempvar __warp_3_price = __warp_3_price;
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_1__amount = __warp_1__amount;
                tempvar __warp_0__asset = __warp_0__asset;
                tempvar __warp_2__minimumOusdAmount = __warp_2__minimumOusdAmount;
                tempvar __warp_3_price = __warp_3_price;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_1__amount = __warp_1__amount;
            tempvar __warp_0__asset = __warp_0__asset;
            tempvar __warp_2__minimumOusdAmount = __warp_2__minimumOusdAmount;
            tempvar __warp_3_price = __warp_3_price;
        
        let (__warp_se_147) = warp_ge256(__warp_3_price, Uint256(low=99800000, high=0));
        
        with_attr error_message("Asset price below peg"){
            assert __warp_se_147 = 1;
        }
        
        let (__warp_4_assetDecimals) = getDecimals_cf54aaa0(__warp_0__asset);
        
        let (__warp_5_unitAdjustedDeposit) = scaleBy_bd502d8d(__warp_1__amount, Uint256(low=18, high=0), __warp_4_assetDecimals);
        
        let (__warp_pse_48) = scaleBy_bd502d8d(__warp_3_price, Uint256(low=18, high=0), Uint256(low=8, high=0));
        
        let (__warp_se_148) = warp_exp_wide256(Uint256(low=10, high=0), __warp_4_assetDecimals);
        
        let (__warp_6_priceAdjustedDeposit) = mulTruncateScale_7473708e(__warp_1__amount, __warp_pse_48, __warp_se_148);
        
        let (__warp_se_149) = warp_gt256(__warp_2__minimumOusdAmount, Uint256(low=0, high=0));
        
            
            if (__warp_se_149 != 0){
            
                
                let (__warp_se_150) = warp_ge256(__warp_6_priceAdjustedDeposit, __warp_2__minimumOusdAmount);
                
                with_attr error_message("Mint amount lower than minimum"){
                    assert __warp_se_150 = 1;
                }
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_5_unitAdjustedDeposit = __warp_5_unitAdjustedDeposit;
                tempvar __warp_1__amount = __warp_1__amount;
                tempvar __warp_0__asset = __warp_0__asset;
                tempvar __warp_6_priceAdjustedDeposit = __warp_6_priceAdjustedDeposit;
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_5_unitAdjustedDeposit = __warp_5_unitAdjustedDeposit;
                tempvar __warp_1__amount = __warp_1__amount;
                tempvar __warp_0__asset = __warp_0__asset;
                tempvar __warp_6_priceAdjustedDeposit = __warp_6_priceAdjustedDeposit;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_5_unitAdjustedDeposit = __warp_5_unitAdjustedDeposit;
            tempvar __warp_1__amount = __warp_1__amount;
            tempvar __warp_0__asset = __warp_0__asset;
            tempvar __warp_6_priceAdjustedDeposit = __warp_6_priceAdjustedDeposit;
        
        let (__warp_se_151) = get_caller_address();
        
        __warp_emit_Mint_0f6798a560793a54c3bcfe86a93cde1e73087d944c0ea20544137d4121396885(__warp_se_151, __warp_6_priceAdjustedDeposit);
        
        let __warp_rc_8 = 0;
        
            
            let (__warp_tv_11, __warp_tv_12) = __warp_conditional___warp_original_function_mint_156e29f6_0_9(__warp_5_unitAdjustedDeposit);
            
            let __warp_5_unitAdjustedDeposit = __warp_tv_12;
            
            let __warp_rc_8 = __warp_tv_11;
        
            
            if (__warp_rc_8 != 0){
            
                
                _rebase_edb65cb4();
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_5_unitAdjustedDeposit = __warp_5_unitAdjustedDeposit;
                tempvar __warp_1__amount = __warp_1__amount;
                tempvar __warp_0__asset = __warp_0__asset;
                tempvar __warp_6_priceAdjustedDeposit = __warp_6_priceAdjustedDeposit;
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_5_unitAdjustedDeposit = __warp_5_unitAdjustedDeposit;
                tempvar __warp_1__amount = __warp_1__amount;
                tempvar __warp_0__asset = __warp_0__asset;
                tempvar __warp_6_priceAdjustedDeposit = __warp_6_priceAdjustedDeposit;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_5_unitAdjustedDeposit = __warp_5_unitAdjustedDeposit;
            tempvar __warp_1__amount = __warp_1__amount;
            tempvar __warp_0__asset = __warp_0__asset;
            tempvar __warp_6_priceAdjustedDeposit = __warp_6_priceAdjustedDeposit;
        
        let (__warp_se_152) = WS0_READ_felt(oUSD);
        
        let (__warp_se_153) = get_caller_address();
        
        OUSD_warped_interface.mint_40c10f19(__warp_se_152, __warp_se_153, __warp_6_priceAdjustedDeposit);
        
        let __warp_7_asset = __warp_0__asset;
        
        let (__warp_se_154) = get_caller_address();
        
        let (__warp_se_155) = get_contract_address();
        
        IERC20_warped_interface.transferFrom_23b872dd(__warp_7_asset, __warp_se_154, __warp_se_155, __warp_1__amount);
        
        let (__warp_se_156) = WS1_READ_Uint256(__warp_5_autoAllocateThreshold);
        
        let (__warp_se_157) = warp_ge256(__warp_5_unitAdjustedDeposit, __warp_se_156);
        
            
            if (__warp_se_157 != 0){
            
                
                _allocate_153c6dab();
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


    func __warp_conditional__redeem_3db27ce0_11{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_16_diff : Uint256)-> (__warp_rc_10 : Uint256, __warp_16_diff : Uint256){
    alloc_locals;


        
        let (__warp_se_158) = warp_gt256(__warp_16_diff, Uint256(low=1000000000000000000, high=0));
        
        if (__warp_se_158 != 0){
        
            
            let (__warp_pse_49) = sub_b67d77c5(__warp_16_diff, Uint256(low=1000000000000000000, high=0));
            
            let __warp_rc_10 = __warp_pse_49;
            
            let __warp_rc_10 = __warp_rc_10;
            
            let __warp_16_diff = __warp_16_diff;
            
            
            
            return (__warp_rc_10, __warp_16_diff);
        }else{
        
            
            let (__warp_pse_50) = sub_b67d77c5(Uint256(low=1000000000000000000, high=0), __warp_16_diff);
            
            let __warp_rc_10 = __warp_pse_50;
            
            let __warp_rc_10 = __warp_rc_10;
            
            let __warp_16_diff = __warp_16_diff;
            
            
            
            return (__warp_rc_10, __warp_16_diff);
        }

    }


    func __warp_conditional__redeem_3db27ce0_13{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_11__amount : Uint256)-> (__warp_rc_12 : felt, __warp_11__amount : Uint256){
    alloc_locals;


        
        let (__warp_se_159) = WS1_READ_Uint256(__warp_6_rebaseThreshold);
        
        let (__warp_se_160) = warp_ge256(__warp_11__amount, __warp_se_159);
        
        if (__warp_se_160 != 0){
        
            
            let (__warp_se_161) = WS0_READ_felt(__warp_1_rebasePaused);
            
            let __warp_rc_12 = 1 - __warp_se_161;
            
            let __warp_rc_12 = __warp_rc_12;
            
            let __warp_11__amount = __warp_11__amount;
            
            
            
            return (__warp_rc_12, __warp_11__amount);
        }else{
        
            
            let __warp_rc_12 = 0;
            
            let __warp_rc_12 = __warp_rc_12;
            
            let __warp_11__amount = __warp_11__amount;
            
            
            
            return (__warp_rc_12, __warp_11__amount);
        }

    }

    //  @dev Withdraw a supported asset and burn OUSD.
    // @param _amount Amount of OUSD to burn
    // @param _minimumUnitAmount Minimum stablecoin units to receive in return
    func _redeem_3db27ce0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_11__amount : Uint256, __warp_12__minimumUnitAmount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_td_13, __warp_14__backingValue) = _calculateRedeemOutputs_46a857c4(__warp_11__amount);
        
        let __warp_13_outputs = __warp_td_13;
        
        let (__warp_se_162) = WS0_READ_felt(oUSD);
        
        let (__warp_15__totalSupply) = OUSD_warped_interface.totalSupply_18160ddd(__warp_se_162);
        
        let (__warp_se_163) = WS1_READ_Uint256(__warp_9_maxSupplyDiff);
        
        let (__warp_se_164) = warp_gt256(__warp_se_163, Uint256(low=0, high=0));
        
            
            if (__warp_se_164 != 0){
            
                
                let (__warp_16_diff) = divPrecisely_0b6ab2f0(__warp_15__totalSupply, __warp_14__backingValue);
                
                let __warp_rc_10 = Uint256(low=0, high=0);
                
                    
                    let (__warp_tv_13, __warp_tv_14) = __warp_conditional__redeem_3db27ce0_11(__warp_16_diff);
                    
                    let __warp_16_diff = __warp_tv_14;
                    
                    let __warp_rc_10 = __warp_tv_13;
                
                let (__warp_se_165) = WS1_READ_Uint256(__warp_9_maxSupplyDiff);
                
                let (__warp_se_166) = warp_le256(__warp_rc_10, __warp_se_165);
                
                with_attr error_message("Backing supply liquidity error"){
                    assert __warp_se_166 = 1;
                }
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_11__amount = __warp_11__amount;
                tempvar __warp_12__minimumUnitAmount = __warp_12__minimumUnitAmount;
                tempvar __warp_13_outputs = __warp_13_outputs;
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_11__amount = __warp_11__amount;
                tempvar __warp_12__minimumUnitAmount = __warp_12__minimumUnitAmount;
                tempvar __warp_13_outputs = __warp_13_outputs;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar warp_memory = warp_memory;
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_11__amount = __warp_11__amount;
            tempvar __warp_12__minimumUnitAmount = __warp_12__minimumUnitAmount;
            tempvar __warp_13_outputs = __warp_13_outputs;
        
        let (__warp_se_167) = get_caller_address();
        
        __warp_emit_Redeem_222838db2794d11532d940e8dec38ae307ed0b63cd97c233322e221f998767a6(__warp_se_167, __warp_11__amount);
        
            
            let __warp_17_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_15, __warp_td_11) = __warp_while0(__warp_17_i, __warp_13_outputs);
                
                let __warp_tv_16 = __warp_td_11;
                
                let __warp_13_outputs = __warp_tv_16;
                
                let __warp_17_i = __warp_tv_15;
        
        let (__warp_se_168) = warp_gt256(__warp_12__minimumUnitAmount, Uint256(low=0, high=0));
        
            
            if (__warp_se_168 != 0){
            
                
                let __warp_21_unitTotal = Uint256(low=0, high=0);
                
                    
                    let __warp_22_i = Uint256(low=0, high=0);
                    
                        
                        let (__warp_tv_17, __warp_td_12, __warp_tv_19) = __warp_while1(__warp_22_i, __warp_13_outputs, __warp_21_unitTotal);
                        
                        let __warp_tv_18 = __warp_td_12;
                        
                        let __warp_21_unitTotal = __warp_tv_19;
                        
                        let __warp_13_outputs = __warp_tv_18;
                        
                        let __warp_22_i = __warp_tv_17;
                
                let (__warp_se_169) = warp_ge256(__warp_21_unitTotal, __warp_12__minimumUnitAmount);
                
                with_attr error_message("Redeem amount lower than minimum"){
                    assert __warp_se_169 = 1;
                }
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_11__amount = __warp_11__amount;
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_11__amount = __warp_11__amount;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar warp_memory = warp_memory;
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_11__amount = __warp_11__amount;
        
        let (__warp_se_170) = WS0_READ_felt(oUSD);
        
        let (__warp_se_171) = get_caller_address();
        
        OUSD_warped_interface.burn_9dc29fac(__warp_se_170, __warp_se_171, __warp_11__amount);
        
        let __warp_rc_12 = 0;
        
            
            let (__warp_tv_20, __warp_tv_21) = __warp_conditional__redeem_3db27ce0_13(__warp_11__amount);
            
            let __warp_11__amount = __warp_tv_21;
            
            let __warp_rc_12 = __warp_tv_20;
        
            
            if (__warp_rc_12 != 0){
            
                
                _rebase_edb65cb4();
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar keccak_ptr = keccak_ptr;
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar keccak_ptr = keccak_ptr;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar warp_memory = warp_memory;
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar keccak_ptr = keccak_ptr;
        
        
        
        return ();

    }

    //  @notice Allocate unallocated funds on Vault to strategies.
    // @dev Allocate unallocated funds on Vault to strategies.*
    func _allocate_153c6dab{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_26_vaultValue) = _totalValueInVault_141350b8();
        
        let (__warp_se_172) = warp_eq256(__warp_26_vaultValue, Uint256(low=0, high=0));
        
            
            if (__warp_se_172 != 0){
            
                
                
                
                return ();
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_26_vaultValue = __warp_26_vaultValue;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_26_vaultValue = __warp_26_vaultValue;
        
        let (__warp_27_strategiesValue) = _totalValueInStrategies_c067c102();
        
        let (__warp_28_calculatedTotalValue) = add_771602f7(__warp_26_vaultValue, __warp_27_strategiesValue);
        
        let __warp_29_vaultBufferModifier = Uint256(low=0, high=0);
        
        let (__warp_se_173) = warp_eq256(__warp_27_strategiesValue, Uint256(low=0, high=0));
        
            
            if (__warp_se_173 != 0){
            
                
                let (__warp_se_174) = WS1_READ_Uint256(__warp_4_vaultBuffer);
                
                let (__warp_pse_51) = sub_b67d77c5(Uint256(low=1000000000000000000, high=0), __warp_se_174);
                
                let __warp_29_vaultBufferModifier = __warp_pse_51;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
            }else{
            
                
                let (__warp_se_175) = WS1_READ_Uint256(__warp_4_vaultBuffer);
                
                let (__warp_pse_52) = mul_c8a4ac9c(__warp_se_175, __warp_28_calculatedTotalValue);
                
                let (__warp_pse_53) = div_a391c15b(__warp_pse_52, __warp_26_vaultValue);
                
                let __warp_29_vaultBufferModifier = __warp_pse_53;
                
                let (__warp_se_176) = warp_gt256(Uint256(low=1000000000000000000, high=0), __warp_29_vaultBufferModifier);
                
                    
                    if (__warp_se_176 != 0){
                    
                        
                        let (__warp_pse_54) = sub_b67d77c5(Uint256(low=1000000000000000000, high=0), __warp_29_vaultBufferModifier);
                        
                        let __warp_29_vaultBufferModifier = __warp_pse_54;
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar pedersen_ptr = pedersen_ptr;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar keccak_ptr = keccak_ptr;
                        tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
                    }else{
                    
                        
                        
                        
                        return ();
                    }
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar pedersen_ptr = pedersen_ptr;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar keccak_ptr = keccak_ptr;
                    tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
        
        let (__warp_se_177) = warp_eq256(__warp_29_vaultBufferModifier, Uint256(low=0, high=0));
        
            
            if (__warp_se_177 != 0){
            
                
                
                
                return ();
            }else{
            
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar keccak_ptr = keccak_ptr;
                tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
            }
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar keccak_ptr = keccak_ptr;
            tempvar __warp_29_vaultBufferModifier = __warp_29_vaultBufferModifier;
        
            
            let __warp_30_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_22, __warp_tv_23) = __warp_while2(__warp_30_i, __warp_29_vaultBufferModifier);
                
                let __warp_29_vaultBufferModifier = __warp_tv_23;
                
                let __warp_30_i = __warp_tv_22;
        
        let (__warp_36__trusteeAddress) = WS0_READ_felt(__warp_10_trusteeAddress);
        
        let (__warp_se_178) = warp_neq(__warp_36__trusteeAddress, 0);
        
            
            if (__warp_se_178 != 0){
            
                
                let (__warp_se_179) = WS0_READ_felt(__warp_10_trusteeAddress);
                
                IBuyback_warped_interface.swap_8119c065(__warp_se_179);
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

    //  @dev Calculate the total value of assets held by the Vault and all
    //      strategies and update the supply of OUSD, optionally sending a
    //      portion of the yield to the trustee.
    func _rebase_edb65cb4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        __warp_modifier_whenNotRebasePaused__rebase_edb65cb4_25();
        
        let __warp_uv13 = ();
        
        
        
        return ();

    }

    //  @dev Internal Calculate the total value of the assets held by the
    //         vault and its strategies.
    // @return value Total value in USD (1e18)
    func _totalValue_43038ff3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (value : Uint256){
    alloc_locals;


        
        let (__warp_pse_56) = _totalValueInVault_141350b8();
        
        let (__warp_pse_57) = _totalValueInStrategies_c067c102();
        
        let (__warp_pse_58) = add_771602f7(__warp_pse_56, __warp_pse_57);
        
        
        
        return (__warp_pse_58,);

    }

    //  @dev Internal to calculate total value of all assets held in Vault.
    // @return value Total value in ETH (1e18)
    func _totalValueInVault_141350b8{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (__warp_43_value : Uint256){
    alloc_locals;


        
        let __warp_43_value = Uint256(low=0, high=0);
        
            
            let __warp_44_y = Uint256(low=0, high=0);
            
                
                let (__warp_tv_24, __warp_tv_25) = __warp_while3(__warp_44_y, __warp_43_value);
                
                let __warp_43_value = __warp_tv_25;
                
                let __warp_44_y = __warp_tv_24;
        
        
        
        return (__warp_43_value,);

    }

    //  @dev Internal to calculate total value of all assets held in Strategies.
    // @return value Total value in ETH (1e18)
    func _totalValueInStrategies_c067c102{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (__warp_48_value : Uint256){
    alloc_locals;


        
        let __warp_48_value = Uint256(low=0, high=0);
        
            
            let __warp_49_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_26, __warp_tv_27) = __warp_while4(__warp_49_i, __warp_48_value);
                
                let __warp_48_value = __warp_tv_27;
                
                let __warp_49_i = __warp_tv_26;
        
        
        
        return (__warp_48_value,);

    }

    //  @dev Internal to calculate total value of all assets held by strategy.
    // @param _strategyAddr Address of the strategy
    // @return value Total value in ETH (1e18)
    func _totalValueInStrategy_f633af46{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_50__strategyAddr : felt)-> (__warp_51_value : Uint256){
    alloc_locals;


        
        let __warp_51_value = Uint256(low=0, high=0);
        
        let __warp_52_strategy = __warp_50__strategyAddr;
        
            
            let __warp_53_y = Uint256(low=0, high=0);
            
                
                let (__warp_tv_28, __warp_tv_29, __warp_tv_30) = __warp_while5(__warp_53_y, __warp_52_strategy, __warp_51_value);
                
                let __warp_51_value = __warp_tv_30;
                
                let __warp_52_strategy = __warp_tv_29;
                
                let __warp_53_y = __warp_tv_28;
        
        
        
        return (__warp_51_value,);

    }

    //  @notice Get the balance of an asset held in Vault and all strategies.
    // @param _asset Address of asset
    // @return balance Balance of asset in decimals of asset
    func _checkBalance_e27a3dc8{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_58__asset : felt)-> (__warp_59_balance : Uint256){
    alloc_locals;


        
        let __warp_59_balance = Uint256(low=0, high=0);
        
        let __warp_60_asset = __warp_58__asset;
        
        let (__warp_se_180) = get_contract_address();
        
        let (__warp_pse_60) = IERC20_warped_interface.balanceOf_70a08231(__warp_60_asset, __warp_se_180);
        
        let __warp_59_balance = __warp_pse_60;
        
            
            let __warp_61_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_31, __warp_tv_32, __warp_tv_33) = __warp_while6(__warp_61_i, __warp_58__asset, __warp_59_balance);
                
                let __warp_59_balance = __warp_tv_33;
                
                let __warp_58__asset = __warp_tv_32;
                
                let __warp_61_i = __warp_tv_31;
        
        
        
        return (__warp_59_balance,);

    }

    //  @notice Calculate the outputs for a redeem function, i.e. the mix of
    // coins that will be returned.
    // @return outputs Array of amounts respective to the supported assets
    // @return totalBalance Total balance of Vault
    func _calculateRedeemOutputs_46a857c4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_69__amount : Uint256)-> (__warp_70_outputs : felt, __warp_71_totalBalance : Uint256){
    alloc_locals;


        
        let __warp_71_totalBalance = Uint256(low=0, high=0);
        
        let (__warp_70_outputs) = wm_new(Uint256(low=0, high=0), Uint256(low=2, high=0));
        
        let (__warp_72_assetCount) = getAssetCount_a0aead4d_internal();
        
        let (__warp_73_assetPrices) = _getAssetPrices_9fd03eb4();
        
        let (__warp_74_assetBalances) = wm_new(__warp_72_assetCount, Uint256(low=2, high=0));
        
        let (__warp_75_assetDecimals) = wm_new(__warp_72_assetCount, Uint256(low=2, high=0));
        
        let __warp_76_totalOutputRatio = Uint256(low=0, high=0);
        
        let (__warp_se_182) = wm_new(__warp_72_assetCount, Uint256(low=2, high=0));
        
        let __warp_70_outputs = __warp_se_182;
        
        let (__warp_se_183) = WS1_READ_Uint256(__warp_3_redeemFeeBps);
        
        let (__warp_se_184) = warp_gt256(__warp_se_183, Uint256(low=0, high=0));
        
            
            if (__warp_se_184 != 0){
            
                
                let (__warp_se_185) = WS1_READ_Uint256(__warp_3_redeemFeeBps);
                
                let (__warp_pse_61) = mul_c8a4ac9c(__warp_69__amount, __warp_se_185);
                
                let (__warp_77_redeemFee) = div_a391c15b(__warp_pse_61, Uint256(low=10000, high=0));
                
                let (__warp_pse_62) = sub_b67d77c5(__warp_69__amount, __warp_77_redeemFee);
                
                let __warp_69__amount = __warp_pse_62;
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_71_totalBalance = __warp_71_totalBalance;
                tempvar __warp_70_outputs = __warp_70_outputs;
                tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                tempvar __warp_69__amount = __warp_69__amount;
                tempvar __warp_76_totalOutputRatio = __warp_76_totalOutputRatio;
                tempvar __warp_73_assetPrices = __warp_73_assetPrices;
                tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar syscall_ptr = syscall_ptr;
                tempvar pedersen_ptr = pedersen_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_71_totalBalance = __warp_71_totalBalance;
                tempvar __warp_70_outputs = __warp_70_outputs;
                tempvar __warp_74_assetBalances = __warp_74_assetBalances;
                tempvar __warp_69__amount = __warp_69__amount;
                tempvar __warp_76_totalOutputRatio = __warp_76_totalOutputRatio;
                tempvar __warp_73_assetPrices = __warp_73_assetPrices;
                tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar warp_memory = warp_memory;
            tempvar syscall_ptr = syscall_ptr;
            tempvar pedersen_ptr = pedersen_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar __warp_71_totalBalance = __warp_71_totalBalance;
            tempvar __warp_70_outputs = __warp_70_outputs;
            tempvar __warp_74_assetBalances = __warp_74_assetBalances;
            tempvar __warp_69__amount = __warp_69__amount;
            tempvar __warp_76_totalOutputRatio = __warp_76_totalOutputRatio;
            tempvar __warp_73_assetPrices = __warp_73_assetPrices;
            tempvar __warp_75_assetDecimals = __warp_75_assetDecimals;
        
            
            let __warp_78_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_36, __warp_td_15, __warp_td_16, __warp_tv_39) = __warp_while8(__warp_78_i, __warp_74_assetBalances, __warp_75_assetDecimals, __warp_71_totalBalance);
                
                let __warp_tv_37 = __warp_td_15;
                
                let __warp_tv_38 = __warp_td_16;
                
                let __warp_71_totalBalance = __warp_tv_39;
                
                let __warp_75_assetDecimals = __warp_tv_38;
                
                let __warp_74_assetBalances = __warp_tv_37;
                
                let __warp_78_i = __warp_tv_36;
        
            
            let __warp_81_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_40, __warp_td_17, __warp_td_18, __warp_td_19, __warp_tv_44, __warp_tv_45) = __warp_while9(__warp_81_i, __warp_73_assetPrices, __warp_74_assetBalances, __warp_75_assetDecimals, __warp_71_totalBalance, __warp_76_totalOutputRatio);
                
                let __warp_tv_41 = __warp_td_17;
                
                let __warp_tv_42 = __warp_td_18;
                
                let __warp_tv_43 = __warp_td_19;
                
                let __warp_76_totalOutputRatio = __warp_tv_45;
                
                let __warp_71_totalBalance = __warp_tv_44;
                
                let __warp_75_assetDecimals = __warp_tv_43;
                
                let __warp_74_assetBalances = __warp_tv_42;
                
                let __warp_73_assetPrices = __warp_tv_41;
                
                let __warp_81_i = __warp_tv_40;
        
        let (__warp_84_factor) = divPrecisely_0b6ab2f0(__warp_69__amount, __warp_76_totalOutputRatio);
        
            
            let __warp_85_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_46, __warp_td_20, __warp_td_21, __warp_tv_49, __warp_tv_50) = __warp_while10(__warp_85_i, __warp_70_outputs, __warp_74_assetBalances, __warp_84_factor, __warp_71_totalBalance);
                
                let __warp_tv_47 = __warp_td_20;
                
                let __warp_tv_48 = __warp_td_21;
                
                let __warp_71_totalBalance = __warp_tv_50;
                
                let __warp_84_factor = __warp_tv_49;
                
                let __warp_74_assetBalances = __warp_tv_48;
                
                let __warp_70_outputs = __warp_tv_47;
                
                let __warp_85_i = __warp_tv_46;
        
        let __warp_70_outputs = __warp_70_outputs;
        
        let __warp_71_totalBalance = __warp_71_totalBalance;
        
        
        
        return (__warp_70_outputs, __warp_71_totalBalance);

    }

    //  @notice Get an array of the supported asset prices in USD.
    // @return assetPrices Array of asset prices in USD (1e18)
    func _getAssetPrices_9fd03eb4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}()-> (__warp_86_assetPrices : felt){
    alloc_locals;


        
        let (__warp_86_assetPrices) = wm_new(Uint256(low=0, high=0), Uint256(low=2, high=0));
        
        let (__warp_pse_63) = getAssetCount_a0aead4d_internal();
        
        let (__warp_se_186) = wm_new(__warp_pse_63, Uint256(low=2, high=0));
        
        let __warp_86_assetPrices = __warp_se_186;
        
        let (__warp_87_oracle) = WS0_READ_felt(__warp_0_priceProvider);
        
            
            let __warp_88_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_51, __warp_td_22, __warp_tv_53) = __warp_while11(__warp_88_i, __warp_86_assetPrices, __warp_87_oracle);
                
                let __warp_tv_52 = __warp_td_22;
                
                let __warp_87_oracle = __warp_tv_53;
                
                let __warp_86_assetPrices = __warp_tv_52;
                
                let __warp_88_i = __warp_tv_51;
        
        
        
        return (__warp_86_assetPrices,);

    }

    //  @dev Return the number of assets supported by the Vault.
    func getAssetCount_a0aead4d_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_89 : Uint256){
    alloc_locals;


        
        let (__warp_se_187) = WARP_DARRAY0_felt_LENGTH.read(allAssets);
        
        
        
        return (__warp_se_187,);

    }


    func __warp_conditional_abs_1b5ac4b5_15{range_check_ptr : felt}(__warp_95_x : Uint256)-> (__warp_rc_14 : Uint256, __warp_95_x : Uint256){
    alloc_locals;


        
        let (__warp_se_194) = warp_ge_signed256(__warp_95_x, Uint256(low=0, high=0));
        
        if (__warp_se_194 != 0){
        
            
            let __warp_rc_14 = __warp_95_x;
            
            let __warp_rc_14 = __warp_rc_14;
            
            let __warp_95_x = __warp_95_x;
            
            
            
            return (__warp_rc_14, __warp_95_x);
        }else{
        
            
            let (__warp_se_195) = warp_negate256(__warp_95_x);
            
            let __warp_rc_14 = __warp_se_195;
            
            let __warp_rc_14 = __warp_rc_14;
            
            let __warp_95_x = __warp_95_x;
            
            
            
            return (__warp_rc_14, __warp_95_x);
        }

    }


    func abs_1b5ac4b5{range_check_ptr : felt}(__warp_95_x : Uint256)-> (__warp_96 : Uint256){
    alloc_locals;


        
        let (__warp_se_196) = warp_lt_signed256(__warp_95_x, Uint256(low=340282366920938463463374607431768211455, high=170141183460469231731687303715884105727));
        
        with_attr error_message("Amount too high"){
            assert __warp_se_196 = 1;
        }
        
        let __warp_rc_14 = Uint256(low=0, high=0);
        
            
            let (__warp_tv_54, __warp_tv_55) = __warp_conditional_abs_1b5ac4b5_15(__warp_95_x);
            
            let __warp_95_x = __warp_tv_55;
            
            let __warp_rc_14 = __warp_tv_54;
        
        
        
        return (__warp_rc_14,);

    }


    func __warp_init_VaultCore{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(MAX_INT, Uint256(low=340282366920938463463374607431768211455, high=170141183460469231731687303715884105727));
        
        WS_WRITE0(MAX_UINT, Uint256(low=340282366920938463463374607431768211455, high=340282366920938463463374607431768211455));
        
        
        
        return ();

    }

    //  @dev Initializes the contract setting the deployer as the initial owner.
    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_pse_64) = _msgSender_119df25f();
        
        _transferOwnership_d29d44ee(__warp_pse_64);
        
        
        
        return ();

    }


    func __warp_init_VaultStorage{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE1(__warp_1_rebasePaused, 0);
        
        WS_WRITE1(__warp_2_capitalPaused, 1);
        
        WS_WRITE1(_deprecated_rebaseHooksAddr, 0);
        
        WS_WRITE1(_deprecated_uniswapAddr, 0);
        
        WS_WRITE1(__warp_7_strategistAddr, 0);
        
        WS_WRITE0(MINT_MINIMUM_ORACLE, Uint256(low=99800000, high=0));
        
        WS_WRITE1(__warp_12_ousdMetaStrategy, 0);
        
        WS_WRITE0(__warp_13_netOusdMintedForStrategy, Uint256(low=0, high=0));
        
        WS_WRITE0(__warp_14_netOusdMintForStrategyThreshold, Uint256(low=0, high=0));
        
        
        
        return ();

    }

    //  @dev Returns the address of the current owner.
    func owner_8da5cb5b_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_1 : felt){
    alloc_locals;


        
        let (__warp_se_213) = WS0_READ_felt(__warp_0__owner);
        
        
        
        return (__warp_se_213,);

    }

    //  @dev Transfers ownership of the contract to a new account (`newOwner`).
    // Internal function without access restriction.
    func _transferOwnership_d29d44ee{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_4_newOwner : felt)-> (){
    alloc_locals;


        
        let (__warp_5_oldOwner) = WS0_READ_felt(__warp_0__owner);
        
        WS_WRITE1(__warp_0__owner, __warp_4_newOwner);
        
        __warp_emit_OwnershipTransferred_8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0(__warp_5_oldOwner, __warp_4_newOwner);
        
        
        
        return ();

    }


    func _msgSender_119df25f{syscall_ptr : felt*}()-> (__warp_0 : felt){
    alloc_locals;


        
        let (__warp_se_216) = get_caller_address();
        
        
        
        return (__warp_se_216,);

    }


    func __warp_conditional_getDecimals_cf54aaa0_17{range_check_ptr : felt}(__warp_5_decimals : Uint256)-> (__warp_rc_16 : felt, __warp_5_decimals : Uint256){
    alloc_locals;


        
        let (__warp_se_217) = warp_ge256(__warp_5_decimals, Uint256(low=4, high=0));
        
        if (__warp_se_217 != 0){
        
            
            let (__warp_se_218) = warp_le256(__warp_5_decimals, Uint256(low=18, high=0));
            
            let __warp_rc_16 = __warp_se_218;
            
            let __warp_rc_16 = __warp_rc_16;
            
            let __warp_5_decimals = __warp_5_decimals;
            
            
            
            return (__warp_rc_16, __warp_5_decimals);
        }else{
        
            
            let __warp_rc_16 = 0;
            
            let __warp_rc_16 = __warp_rc_16;
            
            let __warp_5_decimals = __warp_5_decimals;
            
            
            
            return (__warp_rc_16, __warp_5_decimals);
        }

    }

    //  @notice Fetch the `decimals()` from an ERC20 token
    // @dev Grabs the `decimals()` from a contract and fails if
    //      the decimal value does not live within a certain range
    // @param _token Address of the ERC20 token
    // @return uint256 Decimals of the ERC20 token
    func getDecimals_cf54aaa0{syscall_ptr : felt*, range_check_ptr : felt}(__warp_3__token : felt)-> (__warp_4 : Uint256){
    alloc_locals;


        
        let (__warp_se_219) = IBasicToken_warped_interface.decimals_313ce567(__warp_3__token);
        
        let (__warp_5_decimals) = warp_uint256(__warp_se_219);
        
        let __warp_rc_16 = 0;
        
            
            let (__warp_tv_56, __warp_tv_57) = __warp_conditional_getDecimals_cf54aaa0_17(__warp_5_decimals);
            
            let __warp_5_decimals = __warp_tv_57;
            
            let __warp_rc_16 = __warp_tv_56;
        
        with_attr error_message("Token must have sufficient decimal places"){
            assert __warp_rc_16 = 1;
        }
        
        
        
        return (__warp_5_decimals,);

    }

    //  @dev Adjust the scale of an integer
    // @param to Decimals to scale to
    // @param from Decimals to scale from
    func scaleBy_bd502d8d{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_x : Uint256, __warp_1_to : Uint256, __warp_2_from : Uint256)-> (__warp_3 : Uint256){
    alloc_locals;


        
        let (__warp_se_220) = warp_gt256(__warp_1_to, __warp_2_from);
        
            
            if (__warp_se_220 != 0){
            
                
                let (__warp_se_221) = warp_sub256(__warp_1_to, __warp_2_from);
                
                let (__warp_se_222) = warp_exp_wide256(Uint256(low=10, high=0), __warp_se_221);
                
                let (__warp_pse_66) = mul_c8a4ac9c(__warp_0_x, __warp_se_222);
                
                let __warp_0_x = __warp_pse_66;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_0_x = __warp_0_x;
            }else{
            
                
                let (__warp_se_223) = warp_lt256(__warp_1_to, __warp_2_from);
                
                    
                    if (__warp_se_223 != 0){
                    
                        
                        let (__warp_se_224) = warp_sub256(__warp_2_from, __warp_1_to);
                        
                        let (__warp_se_225) = warp_exp_wide256(Uint256(low=10, high=0), __warp_se_224);
                        
                        let (__warp_pse_67) = div_a391c15b(__warp_0_x, __warp_se_225);
                        
                        let __warp_0_x = __warp_pse_67;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar __warp_0_x = __warp_0_x;
                    }else{
                    
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar __warp_0_x = __warp_0_x;
                    }
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_0_x = __warp_0_x;
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_0_x = __warp_0_x;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar __warp_0_x = __warp_0_x;
        
        
        
        return (__warp_0_x,);

    }

    //  @dev Multiplies two precise units, and then truncates by the full scale
    // @param x Left hand input to multiplication
    // @param y Right hand input to multiplication
    // @return Result after multiplying the two inputs and then dividing by the shared
    //         scale unit
    func mulTruncate_8f8a618a{range_check_ptr : felt}(__warp_4_x : Uint256, __warp_5_y : Uint256)-> (__warp_6 : Uint256){
    alloc_locals;


        
        let (__warp_pse_68) = mulTruncateScale_7473708e(__warp_4_x, __warp_5_y, Uint256(low=1000000000000000000, high=0));
        
        
        
        return (__warp_pse_68,);

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
        
        let (__warp_pse_69) = div_a391c15b(__warp_11_z, __warp_9_scale);
        
        
        
        return (__warp_pse_69,);

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
        
        let (__warp_pse_72) = div_a391c15b(__warp_20_z, __warp_18_y);
        
        
        
        return (__warp_pse_72,);

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


        
        let (__warp_se_226) = warp_add256(__warp_22_a, __warp_23_b);
        
        
        
        return (__warp_se_226,);

    }

    //  @dev Returns the subtraction of two unsigned integers, reverting on
    // overflow (when the result is negative).
    // Counterpart to Solidity's `-` operator.
    // Requirements:
    // - Subtraction cannot overflow.
    func sub_b67d77c5{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_25_a : Uint256, __warp_26_b : Uint256)-> (__warp_27 : Uint256){
    alloc_locals;


        
        let (__warp_se_227) = warp_sub256(__warp_25_a, __warp_26_b);
        
        
        
        return (__warp_se_227,);

    }

    //  @dev Returns the multiplication of two unsigned integers, reverting on
    // overflow.
    // Counterpart to Solidity's `*` operator.
    // Requirements:
    // - Multiplication cannot overflow.
    func mul_c8a4ac9c{range_check_ptr : felt}(__warp_28_a : Uint256, __warp_29_b : Uint256)-> (__warp_30 : Uint256){
    alloc_locals;


        
        let (__warp_se_228) = warp_mul256(__warp_28_a, __warp_29_b);
        
        
        
        return (__warp_se_228,);

    }

    //  @dev Returns the integer division of two unsigned integers, reverting on
    // division by zero. The result is rounded towards zero.
    // Counterpart to Solidity's `/` operator.
    // Requirements:
    // - The divisor cannot be zero.
    func div_a391c15b{range_check_ptr : felt}(__warp_31_a : Uint256, __warp_32_b : Uint256)-> (__warp_33 : Uint256){
    alloc_locals;


        
        let (__warp_se_229) = warp_div256(__warp_31_a, __warp_32_b);
        
        
        
        return (__warp_se_229,);

    }

}

    //  @dev Deposit a supported asset and mint OUSD.
    // @param _asset Address of the asset being deposited
    // @param _amount Amount of the asset being deposited
    // @param _minimumOusdAmount Minimum OUSD to mint
    @external
    func mint_156e29f6{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0__asset : felt, __warp_1__amount : Uint256, __warp_2__minimumOusdAmount : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_2__minimumOusdAmount);
        
        warp_external_input_check_int256(__warp_1__amount);
        
        warp_external_input_check_address(__warp_0__asset);
        
        VaultCore.__warp_modifier_whenNotCapitalPaused_mint_156e29f6_4(__warp_0__asset, __warp_1__amount, __warp_2__minimumOusdAmount);
        
        let __warp_uv5 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Mint OUSD for OUSD Meta Strategy
    // @param _amount Amount of the asset being deposited
    // Notice: can't use `nonReentrant` modifier since the `mint` function can
    // call `allocate`, and that can trigger `ConvexOUSDMetaStrategy` to call this function
    // while the execution of the `mint` has not yet completed -> causing a `nonReentrant` collision.
    // Also important to understand is that this is a limitation imposed by the test suite.
    // Production / mainnet contracts should never be configured in a way where mint/redeem functions
    // that are moving funds between the Vault and end user wallets can influence strategies
    // utilizing this function.
    @external
    func mintForStrategy_ab80dafb{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_8__amount : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_8__amount);
        
        VaultCore.__warp_modifier_whenNotCapitalPaused_mintForStrategy_ab80dafb_9(__warp_8__amount);
        
        let __warp_uv6 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Withdraw a supported asset and burn OUSD.
    // @param _amount Amount of OUSD to burn
    // @param _minimumUnitAmount Minimum stablecoin units to receive in return
    @external
    func redeem_7cbc2373{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_9__amount : Uint256, __warp_10__minimumUnitAmount : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_10__minimumUnitAmount);
        
        warp_external_input_check_int256(__warp_9__amount);
        
        VaultCore.__warp_modifier_whenNotCapitalPaused_redeem_7cbc2373_13(__warp_9__amount, __warp_10__minimumUnitAmount);
        
        let __warp_uv7 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Burn OUSD for OUSD Meta Strategy
    // @param _amount Amount of OUSD to burn
    // Notice: can't use `nonReentrant` modifier since the `redeem` function could
    // require withdrawal on `ConvexOUSDMetaStrategy` and that one can call `burnForStrategy`
    // while the execution of the `redeem` has not yet completed -> causing a `nonReentrant` collision.
    // Also important to understand is that this is a limitation imposed by the test suite.
    // Production / mainnet contracts should never be configured in a way where mint/redeem functions
    // that are moving funds between the Vault and end user wallets can influence strategies
    // utilizing this function.
    @external
    func burnForStrategy_6217f3ea{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_24__amount : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_24__amount);
        
        VaultCore.__warp_modifier_whenNotCapitalPaused_burnForStrategy_6217f3ea_18(__warp_24__amount);
        
        let __warp_uv8 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @notice Withdraw a supported asset and burn all OUSD.
    // @param _minimumUnitAmount Minimum stablecoin units to receive in return
    @external
    func redeemAll_7136a7a6{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_25__minimumUnitAmount : Uint256)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_int256(__warp_25__minimumUnitAmount);
        
        VaultCore.__warp_modifier_whenNotCapitalPaused_redeemAll_7136a7a6_21(__warp_25__minimumUnitAmount);
        
        let __warp_uv9 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @notice Allocate unallocated funds on Vault to strategies.
    // @dev Allocate unallocated funds on Vault to strategies.*
    @external
    func allocate_abaa9916{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        VaultCore.__warp_modifier_whenNotCapitalPaused_allocate_abaa9916_23();
        
        let __warp_uv10 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Calculate the total value of assets held by the Vault and all
    //      strategies and update the supply of OUSD.
    @external
    func rebase_af14052c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        VaultCore._rebase_edb65cb4();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Determine the total value of assets held by the vault and its
    //         strategies.
    // @return value Total value in USD (1e18)
    @view
    func totalValue_d4c3eea0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (__warp_42_value : Uint256){
    alloc_locals;


        
        let __warp_42_value = Uint256(low=0, high=0);
        
        let (__warp_pse_55) = VaultCore._totalValue_43038ff3();
        
        let __warp_42_value = __warp_pse_55;
        
        
        
        return (__warp_42_value,);

    }

    //  @notice Get the balance of an asset held in Vault and all strategies.
    // @param _asset Address of asset
    // @return uint256 Balance of asset in decimals of asset
    @view
    func checkBalance_5f515226{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_56__asset : felt)-> (__warp_57 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_56__asset);
        
        let (__warp_pse_59) = VaultCore._checkBalance_e27a3dc8(__warp_56__asset);
        
        
        
        return (__warp_pse_59,);

    }

    //  @notice Calculate the outputs for a redeem function, i.e. the mix of
    // coins that will be returned
    @view
    func calculateRedeemOutputs_67bd7ba3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_66__amount : Uint256)-> (__warp_67_len : felt, __warp_67 : Uint256*){
    alloc_locals;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        warp_external_input_check_int256(__warp_66__amount);
        
        let (__warp_td_14, __warp_gv0) = VaultCore._calculateRedeemOutputs_46a857c4(__warp_66__amount);
        
        let __warp_68_outputs = __warp_td_14;
        
        let (__warp_se_181) = wm_to_calldata0(__warp_68_outputs);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return (__warp_se_181.len, __warp_se_181.ptr,);
    }
    }

    //  @dev Return all asset addresses in order
    @view
    func getAllAssets_2acada4d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_90_len : felt, __warp_90 : felt*){
    alloc_locals;


        
        let (__warp_se_188) = ws_dynamic_array_to_calldata0(VaultCore.allAssets);
        
        
        
        return (__warp_se_188.len, __warp_se_188.ptr,);

    }

    //  @dev Return the number of strategies active on the Vault.
    @view
    func getStrategyCount_31e19cfa{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_91 : Uint256){
    alloc_locals;


        
        let (__warp_se_189) = WARP_DARRAY0_felt_LENGTH.read(VaultCore.allStrategies);
        
        
        
        return (__warp_se_189,);

    }

    //  @dev Return the array of all strategies
    @view
    func getAllStrategies_c3b28864{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_92_len : felt, __warp_92 : felt*){
    alloc_locals;


        
        let (__warp_se_190) = ws_dynamic_array_to_calldata0(VaultCore.allStrategies);
        
        
        
        return (__warp_se_190.len, __warp_se_190.ptr,);

    }


    @view
    func isSupportedAsset_9be918e6{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_93__asset : felt)-> (__warp_94 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_93__asset);
        
        let (__warp_se_191) = WS1_INDEX_felt_to_Asset_96786d17(VaultCore.assets, __warp_93__asset);
        
        let (__warp_se_192) = WSM0_Asset_96786d17_isSupported(__warp_se_191);
        
        let (__warp_se_193) = WS0_READ_felt(__warp_se_192);
        
        
        
        return (__warp_se_193,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(){
    alloc_locals;
    WARP_USED_STORAGE.write(142);
    WARP_NAMEGEN.write(6);
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        VaultCore.__warp_init_StableMath();
        
        VaultCore.__warp_constructor_0();
        
        VaultCore.__warp_init_VaultStorage();
        
        VaultCore.__warp_init_VaultCore();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @view
    func priceProvider_b888879e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_15 : felt){
    alloc_locals;


        
        let (__warp_se_197) = WS0_READ_felt(VaultCore.__warp_0_priceProvider);
        
        
        
        return (__warp_se_197,);

    }


    @view
    func rebasePaused_53ca9f24{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_16 : felt){
    alloc_locals;


        
        let (__warp_se_198) = WS0_READ_felt(VaultCore.__warp_1_rebasePaused);
        
        
        
        return (__warp_se_198,);

    }


    @view
    func capitalPaused_e6cc5432{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_17 : felt){
    alloc_locals;


        
        let (__warp_se_199) = WS0_READ_felt(VaultCore.__warp_2_capitalPaused);
        
        
        
        return (__warp_se_199,);

    }


    @view
    func redeemFeeBps_09f6442c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_18 : Uint256){
    alloc_locals;


        
        let (__warp_se_200) = WS1_READ_Uint256(VaultCore.__warp_3_redeemFeeBps);
        
        
        
        return (__warp_se_200,);

    }


    @view
    func vaultBuffer_1edfe3da{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_19 : Uint256){
    alloc_locals;


        
        let (__warp_se_201) = WS1_READ_Uint256(VaultCore.__warp_4_vaultBuffer);
        
        
        
        return (__warp_se_201,);

    }


    @view
    func autoAllocateThreshold_9fa1826e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_20 : Uint256){
    alloc_locals;


        
        let (__warp_se_202) = WS1_READ_Uint256(VaultCore.__warp_5_autoAllocateThreshold);
        
        
        
        return (__warp_se_202,);

    }


    @view
    func rebaseThreshold_52d38e5d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_21 : Uint256){
    alloc_locals;


        
        let (__warp_se_203) = WS1_READ_Uint256(VaultCore.__warp_6_rebaseThreshold);
        
        
        
        return (__warp_se_203,);

    }


    @view
    func strategistAddr_570d8e1d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_22 : felt){
    alloc_locals;


        
        let (__warp_se_204) = WS0_READ_felt(VaultCore.__warp_7_strategistAddr);
        
        
        
        return (__warp_se_204,);

    }


    @view
    func assetDefaultStrategies_a403e4d5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_23__i0 : felt)-> (__warp_24 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_23__i0);
        
        let (__warp_se_205) = WS0_INDEX_felt_to_felt(VaultCore.__warp_8_assetDefaultStrategies, __warp_23__i0);
        
        let (__warp_se_206) = WS0_READ_felt(__warp_se_205);
        
        
        
        return (__warp_se_206,);

    }


    @view
    func maxSupplyDiff_8e510b52{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_25 : Uint256){
    alloc_locals;


        
        let (__warp_se_207) = WS1_READ_Uint256(VaultCore.__warp_9_maxSupplyDiff);
        
        
        
        return (__warp_se_207,);

    }


    @view
    func trusteeAddress_49c1d54d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_26 : felt){
    alloc_locals;


        
        let (__warp_se_208) = WS0_READ_felt(VaultCore.__warp_10_trusteeAddress);
        
        
        
        return (__warp_se_208,);

    }


    @view
    func trusteeFeeBps_207134b0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_27 : Uint256){
    alloc_locals;


        
        let (__warp_se_209) = WS1_READ_Uint256(VaultCore.__warp_11_trusteeFeeBps);
        
        
        
        return (__warp_se_209,);

    }


    @view
    func ousdMetaStrategy_18ce56bd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_28 : felt){
    alloc_locals;


        
        let (__warp_se_210) = WS0_READ_felt(VaultCore.__warp_12_ousdMetaStrategy);
        
        
        
        return (__warp_se_210,);

    }


    @view
    func netOusdMintedForStrategy_e45cc9f0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_29 : Uint256){
    alloc_locals;


        
        let (__warp_se_211) = WS1_READ_Uint256(VaultCore.__warp_13_netOusdMintedForStrategy);
        
        
        
        return (__warp_se_211,);

    }


    @view
    func netOusdMintForStrategyThreshold_7a2202f3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_30 : Uint256){
    alloc_locals;


        
        let (__warp_se_212) = WS1_READ_Uint256(VaultCore.__warp_14_netOusdMintForStrategyThreshold);
        
        
        
        return (__warp_se_212,);

    }


    @external
    func isOwner_8f32d59b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_2 : felt){
    alloc_locals;


        
        let (__warp_pse_65) = VaultCore.owner_8da5cb5b_internal();
        
        let (__warp_se_214) = get_caller_address();
        
        let (__warp_se_215) = warp_eq(__warp_se_214, __warp_pse_65);
        
        
        
        return (__warp_se_215,);

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

        
        VaultCore.__warp_modifier_onlyOwner_renounceOwnership_715018a6_27();
        
        let __warp_uv11 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Transfers ownership of the contract to a new account (`newOwner`).
    // Can only be called by the current owner.
    @external
    func transferOwnership_f2fde38b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_3_newOwner : felt)-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        warp_external_input_check_address(__warp_3_newOwner);
        
        VaultCore.__warp_modifier_onlyOwner_transferOwnership_f2fde38b_30(__warp_3_newOwner);
        
        let __warp_uv12 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Return the number of assets supported by the Vault.
    @view
    func getAssetCount_a0aead4d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_89 : Uint256){
    alloc_locals;


        
        let (__warp_pse_73) = VaultCore.getAssetCount_a0aead4d_internal();
        
        
        
        return (__warp_pse_73,);

    }

    //  @dev Returns the address of the current owner.
    @view
    func owner_8da5cb5b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_1 : felt){
    alloc_locals;


        
        let (__warp_pse_74) = VaultCore.owner_8da5cb5b_internal();
        
        
        
        return (__warp_pse_74,);

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


// Contract Def IOracle@interface


@contract_interface
namespace IOracle_warped_interface{
func price_aea91078(asset : felt)-> (__warp_0 : Uint256){
}
}


// Contract Def IVault@interface


@contract_interface
namespace IVault_warped_interface{
func transferGovernance_d38bfff4(_newGovernor : felt)-> (){
}
func claimGovernance_5d36b190()-> (){
}
func owner_8da5cb5b()-> (__warp_0 : felt){
}
func setPriceProvider_372aa224(_priceProvider : felt)-> (){
}
func priceProvider_b888879e()-> (__warp_1 : felt){
}
func setRedeemFeeBps_eb03654b(_redeemFeeBps : Uint256)-> (){
}
func redeemFeeBps_09f6442c()-> (__warp_2 : Uint256){
}
func setVaultBuffer_8ec489a2(_vaultBuffer : Uint256)-> (){
}
func vaultBuffer_1edfe3da()-> (__warp_3 : Uint256){
}
func setAutoAllocateThreshold_b2c9336d(_threshold : Uint256)-> (){
}
func autoAllocateThreshold_9fa1826e()-> (__warp_4 : Uint256){
}
func setRebaseThreshold_b890ebf6(_threshold : Uint256)-> (){
}
func rebaseThreshold_52d38e5d()-> (__warp_5 : Uint256){
}
func setStrategistAddr_773540b3(_address : felt)-> (){
}
func strategistAddr_570d8e1d()-> (__warp_6 : felt){
}
func setMaxSupplyDiff_663e64ce(_maxSupplyDiff : Uint256)-> (){
}
func maxSupplyDiff_8e510b52()-> (__warp_7 : Uint256){
}
func setTrusteeAddress_2da845a8(_address : felt)-> (){
}
func trusteeAddress_49c1d54d()-> (__warp_8 : felt){
}
func setTrusteeFeeBps_0acbda75(_basis : Uint256)-> (){
}
func trusteeFeeBps_207134b0()-> (__warp_9 : Uint256){
}
func ousdMetaStrategy_18ce56bd()-> (__warp_10 : felt){
}
func supportAsset_4cd55c2d(_asset : felt)-> (){
}
func approveStrategy_3b8ae397(_addr : felt)-> (){
}
func removeStrategy_175188e8(_addr : felt)-> (){
}
func setAssetDefaultStrategy_bc90106b(_asset : felt, _strategy : felt)-> (){
}
func assetDefaultStrategies_a403e4d5(_asset : felt)-> (__warp_11 : felt){
}
func pauseRebase_c5f00841()-> (){
}
func unpauseRebase_09f49bf5()-> (){
}
func rebasePaused_53ca9f24()-> (__warp_12 : felt){
}
func pauseCapital_3dbc911f()-> (){
}
func unpauseCapital_94828ffd()-> (){
}
func capitalPaused_e6cc5432()-> (__warp_13 : felt){
}
func transferToken_1072cbea(_asset : felt, _amount : Uint256)-> (){
}
func priceUSDMint_10d3fdac(asset : felt)-> (__warp_14 : Uint256){
}
func priceUSDRedeem_8c5cbb89(asset : felt)-> (__warp_15 : Uint256){
}
func withdrawAllFromStrategy_597c8910(_strategyAddr : felt)-> (){
}
func withdrawAllFromStrategies_c9919112()-> (){
}
func reallocate_7fe2d393(_strategyFromAddress : felt, _strategyToAddress : felt, _assets_len : felt, _assets : felt*, _amounts_len : felt, _amounts : Uint256*)-> (){
}
func withdrawFromStrategy_ae69f3cb(_strategyFromAddress : felt, _assets_len : felt, _assets : felt*, _amounts_len : felt, _amounts : Uint256*)-> (){
}
func depositToStrategy_840c4c7a(_strategyToAddress : felt, _assets_len : felt, _assets : felt*, _amounts_len : felt, _amounts : Uint256*)-> (){
}
func mint_156e29f6(_asset : felt, _amount : Uint256, _minimumOusdAmount : Uint256)-> (){
}
func mintForStrategy_ab80dafb(_amount : Uint256)-> (){
}
func redeem_7cbc2373(_amount : Uint256, _minimumUnitAmount : Uint256)-> (){
}
func burnForStrategy_6217f3ea(_amount : Uint256)-> (){
}
func redeemAll_7136a7a6(_minimumUnitAmount : Uint256)-> (){
}
func allocate_abaa9916()-> (){
}
func rebase_af14052c()-> (){
}
func totalValue_d4c3eea0()-> (value : Uint256){
}
func checkBalance_5f515226(_asset : felt)-> (__warp_16 : Uint256){
}
func calculateRedeemOutputs_67bd7ba3(_amount : Uint256)-> (__warp_17_len : felt, __warp_17 : Uint256*){
}
func getAssetCount_a0aead4d()-> (__warp_18 : Uint256){
}
func getAllAssets_2acada4d()-> (__warp_19_len : felt, __warp_19 : felt*){
}
func getStrategyCount_31e19cfa()-> (__warp_20 : Uint256){
}
func getAllStrategies_c3b28864()-> (__warp_21_len : felt, __warp_21 : felt*){
}
func isSupportedAsset_9be918e6(_asset : felt)-> (__warp_22 : felt){
}
func netOusdMintForStrategyThreshold_7a2202f3()-> (__warp_23 : Uint256){
}
func setOusdMetaStrategy_d58e3b3a(_ousdMetaStrategy : felt)-> (){
}
func setNetOusdMintForStrategyThreshold_636e6c40(_threshold : Uint256)-> (){
}
func netOusdMintedForStrategy_e45cc9f0()-> (__warp_24 : Uint256){
}
}


// Contract Def IBuyback@interface


@contract_interface
namespace IBuyback_warped_interface{
func swap_8119c065()-> (){
}
}


// Contract Def OUSD@interface


@contract_interface
namespace OUSD_warped_interface{
func __warp_modifier_onlyOwner_transferOwnership_f2fde38b_46(__warp_parameter___warp_3_newOwner45 : felt)-> (){
}
func __warp_original_function_transferOwnership_f2fde38b_44(__warp_3_newOwner : felt)-> (){
}
func __warp_modifier_onlyOwner_renounceOwnership_715018a6_43()-> (){
}
func __warp_original_function_renounceOwnership_715018a6_42()-> (){
}
func __warp_modifier_onlyVault_changeSupply_39a7919f_41(__warp_parameter___warp_75__newTotalSupply40 : Uint256)-> (){
}
func __warp_original_function_changeSupply_39a7919f_39(__warp_75__newTotalSupply : Uint256)-> (){
}
func __warp_modifier_onlyVault_burn_9dc29fac_38(__warp_parameter___warp_62_account36 : felt, __warp_parameter___warp_63_amount37 : Uint256)-> (){
}
func __warp_original_function_burn_9dc29fac_35(__warp_62_account : felt, __warp_63_amount : Uint256)-> (){
}
func __warp_modifier_onlyVault_mint_40c10f19_34(__warp_parameter___warp_56__account32 : felt, __warp_parameter___warp_57__amount33 : Uint256)-> (){
}
func __warp_original_function_mint_40c10f19_31(__warp_56__account : felt, __warp_57__amount : Uint256)-> (){
}
func totalSupply_18160ddd()-> (__warp_14 : Uint256){
}
func rebasingCreditsPerToken_6691cb3d()-> (__warp_15 : Uint256){
}
func rebasingCredits_077f22b7()-> (__warp_16 : Uint256){
}
func rebasingCreditsPerTokenHighres_7a46a9c5()-> (__warp_17 : Uint256){
}
func rebasingCreditsHighres_7d0d66ff()-> (__warp_18 : Uint256){
}
func balanceOf_70a08231(__warp_19__account : felt)-> (__warp_20 : Uint256){
}
func creditsBalanceOf_f9854bfc(__warp_21__account : felt)-> (__warp_22 : Uint256, __warp_23 : Uint256){
}
func creditsBalanceOfHighres_e5c4fffe(__warp_25__account : felt)-> (__warp_26 : Uint256, __warp_27 : Uint256, __warp_28 : felt){
}
func transfer_a9059cbb(__warp_29__to : felt, __warp_30__value : Uint256)-> (__warp_31 : felt){
}
func transferFrom_23b872dd(__warp_32__from : felt, __warp_33__to : felt, __warp_34__value : Uint256)-> (__warp_35 : felt){
}
func allowance_dd62ed3e(__warp_43__owner : felt, __warp_44__spender : felt)-> (__warp_45 : Uint256){
}
func approve_095ea7b3(__warp_46__spender : felt, __warp_47__value : Uint256)-> (__warp_48 : felt){
}
func increaseAllowance_39509351(__warp_49__spender : felt, __warp_50__addedValue : Uint256)-> (__warp_51 : felt){
}
func decreaseAllowance_a457c2d7(__warp_52__spender : felt, __warp_53__subtractedValue : Uint256)-> (__warp_54 : felt){
}
func mint_40c10f19(__warp_56__account : felt, __warp_57__amount : Uint256)-> (){
}
func burn_9dc29fac(__warp_62_account : felt, __warp_63_amount : Uint256)-> (){
}
func rebaseOptIn_f51b0fd4()-> (){
}
func rebaseOptOut_c2376dff()-> (){
}
func changeSupply_39a7919f(__warp_75__newTotalSupply : Uint256)-> (){
}
func _totalSupply_3eaaf86b()-> (__warp_76 : Uint256){
}
func vaultAddress_430bf08a()-> (__warp_77 : felt){
}
func nonRebasingSupply_e696393a()-> (__warp_78 : Uint256){
}
func nonRebasingCreditsPerToken_609350cd(__warp_79__i0 : felt)-> (__warp_80 : Uint256){
}
func rebaseState_456ee286(__warp_81__i0 : felt)-> (__warp_82 : felt){
}
func isUpgraded_95ef84b9(__warp_83__i0 : felt)-> (__warp_84 : Uint256){
}
func owner_8da5cb5b()-> (__warp_1 : felt){
}
func isOwner_8f32d59b()-> (__warp_2 : felt){
}
func renounceOwnership_715018a6()-> (){
}
func transferOwnership_f2fde38b(__warp_3_newOwner : felt)-> (){
}
func name_06fdde03()-> (__warp_9_len : felt, __warp_9 : felt*){
}
func symbol_95d89b41()-> (__warp_10_len : felt, __warp_10 : felt*){
}
func decimals_313ce567()-> (__warp_11 : felt){
}
}


// Contract Def IERC20@interface


@contract_interface
namespace IERC20_warped_interface{
func totalSupply_18160ddd()-> (__warp_1 : Uint256){
}
func balanceOf_70a08231(account : felt)-> (__warp_2 : Uint256){
}
func transfer_a9059cbb(to : felt, amount : Uint256)-> (__warp_3 : felt){
}
func allowance_dd62ed3e(owner : felt, spender : felt)-> (__warp_4 : Uint256){
}
func approve_095ea7b3(spender : felt, amount : Uint256)-> (__warp_5 : felt){
}
func transferFrom_23b872dd(__warp_6_from : felt, to : felt, amount : Uint256)-> (__warp_7 : felt){
}
}


// Contract Def IStrategy@interface


@contract_interface
namespace IStrategy_warped_interface{
func deposit_47e7ef24(_asset : felt, _amount : Uint256)-> (){
}
func depositAll_de5f6268()-> (){
}
func withdraw_d9caed12(_recipient : felt, _asset : felt, _amount : Uint256)-> (){
}
func withdrawAll_853828b6()-> (){
}
func checkBalance_5f515226(_asset : felt)-> (balance : Uint256){
}
func supportsAsset_aa388af6(_asset : felt)-> (__warp_0 : felt){
}
func collectRewardTokens_5a063f63()-> (){
}
func getRewardTokenAddresses_f6ca71b0()-> (__warp_1_len : felt, __warp_1 : felt*){
}
}


// Contract Def IBasicToken@interface


@contract_interface
namespace IBasicToken_warped_interface{
func symbol_95d89b41()-> (__warp_0_len : felt, __warp_0 : felt*){
}
func decimals_313ce567()-> (__warp_1 : felt){
}
}