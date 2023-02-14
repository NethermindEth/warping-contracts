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
from warplib.maths.neq import warp_neq
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak


struct Asset_96786d17{
    isSupported : felt,
}


struct Strategy_d1c2465f{
    isSupported : felt,
    _deprecated : Uint256,
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


// Contract Def VaultStorage


// @event
// func OwnershipTransferred(previousOwner : felt, newOwner : felt){
// }


// @event
// func AssetSupported(_asset : felt){
// }


// @event
// func AssetDefaultStrategyUpdated(_asset : felt, _strategy : felt){
// }


// @event
// func AssetAllocated(_asset : felt, _strategy : felt, _amount : Uint256){
// }


// @event
// func StrategyApproved(_addr : felt){
// }


// @event
// func StrategyRemoved(_addr : felt){
// }


// @event
// func Mint(_addr : felt, _value : Uint256){
// }


// @event
// func Redeem(_addr : felt, _value : Uint256){
// }


// @event
// func CapitalPaused(){
// }


// @event
// func CapitalUnpaused(){
// }


// @event
// func RebasePaused(){
// }


// @event
// func RebaseUnpaused(){
// }


// @event
// func VaultBufferUpdated(_vaultBuffer : Uint256){
// }


// @event
// func OusdMetaStrategyUpdated(_ousdMetaStrategy : felt){
// }


// @event
// func RedeemFeeUpdated(_redeemFeeBps : Uint256){
// }


// @event
// func PriceProviderUpdated(_priceProvider : felt){
// }


// @event
// func AllocateThresholdUpdated(_threshold : Uint256){
// }


// @event
// func RebaseThresholdUpdated(_threshold : Uint256){
// }


// @event
// func StrategistUpdated(_address : felt){
// }


// @event
// func MaxSupplyDiffChanged(maxSupplyDiff : Uint256){
// }


// @event
// func YieldDistribution(_to : felt, _yield : Uint256, _fee : Uint256){
// }


// @event
// func TrusteeFeeBpsChanged(_basis : Uint256){
// }


// @event
// func TrusteeAddressChanged(_address : felt){
// }


// @event
// func NetOusdMintForStrategyThresholdChanged(_threshold : Uint256){
// }

namespace VaultStorage{

    // Dynamic variables - Arrays and Maps

    const assets = 1;

    const allAssets = 2;

    const strategies = 3;

    const allStrategies = 4;

    const __warp_8_assetDefaultStrategies = 5;

    const _deprecated_swapTokens = 6;

    // Static variables

    const __warp_0_priceProvider = 4;

    const __warp_1_rebasePaused = 5;

    const __warp_2_capitalPaused = 6;

    const __warp_3_redeemFeeBps = 7;

    const __warp_4_vaultBuffer = 9;

    const __warp_5_autoAllocateThreshold = 11;

    const __warp_6_rebaseThreshold = 13;

    const oUSD = 15;

    const _deprecated_rebaseHooksAddr = 16;

    const _deprecated_uniswapAddr = 17;

    const __warp_7_strategistAddr = 18;

    const __warp_9_maxSupplyDiff = 20;

    const __warp_10_trusteeAddress = 22;

    const __warp_11_trusteeFeeBps = 23;

    const MINT_MINIMUM_ORACLE = 26;

    const __warp_12_ousdMetaStrategy = 28;

    const __warp_13_netOusdMintedForStrategy = 29;

    const __warp_14_netOusdMintForStrategyThreshold = 31;

    const __warp_0_initialized = 33;

    const __warp_1_initializing = 34;

    const ______gap = 35;

    const __warp_0__owner = 135;


    func __warp_modifier_onlyOwner_transferOwnership_f2fde38b_4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_parameter___warp_3_newOwner3 : felt)-> (){
    alloc_locals;


        
        let (__warp_pse_0) = owner_8da5cb5b_internal();
        
        let (__warp_pse_1) = _msgSender_119df25f();
        
        let (__warp_se_0) = warp_eq(__warp_pse_0, __warp_pse_1);
        
        with_attr error_message("Ownable: caller is not the owner"){
            assert __warp_se_0 = 1;
        }
        
        __warp_original_function_transferOwnership_f2fde38b_2(__warp_parameter___warp_3_newOwner3);
        
        
        
        return ();

    }

    //  @dev Transfers ownership of the contract to a new account (`newOwner`).
    // Can only be called by the current owner.
    func __warp_original_function_transferOwnership_f2fde38b_2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_3_newOwner : felt)-> (){
    alloc_locals;


        
        let (__warp_se_1) = warp_neq(__warp_3_newOwner, 0);
        
        with_attr error_message("Ownable: new owner is the zero address"){
            assert __warp_se_1 = 1;
        }
        
        _transferOwnership_d29d44ee(__warp_3_newOwner);
        
        
        
        return ();

    }


    func __warp_modifier_onlyOwner_renounceOwnership_715018a6_1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_pse_2) = owner_8da5cb5b_internal();
        
        let (__warp_pse_3) = _msgSender_119df25f();
        
        let (__warp_se_2) = warp_eq(__warp_pse_2, __warp_pse_3);
        
        with_attr error_message("Ownable: caller is not the owner"){
            assert __warp_se_2 = 1;
        }
        
        __warp_original_function_renounceOwnership_715018a6_0();
        
        
        
        return ();

    }

    //  @dev Leaves the contract without owner. It will not be possible to call
    // `onlyOwner` functions anymore. Can only be called by the current owner.
    // NOTE: Renouncing ownership will leave the contract without an owner,
    // thereby removing any functionality that is only available to the owner.
    func __warp_original_function_renounceOwnership_715018a6_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        _transferOwnership_d29d44ee(0);
        
        
        
        return ();

    }


    func __warp_init_VaultStorage{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_1_rebasePaused, 0);
        
        WS_WRITE0(__warp_2_capitalPaused, 1);
        
        WS_WRITE0(_deprecated_rebaseHooksAddr, 0);
        
        WS_WRITE0(_deprecated_uniswapAddr, 0);
        
        WS_WRITE0(__warp_7_strategistAddr, 0);
        
        WS_WRITE1(MINT_MINIMUM_ORACLE, Uint256(low=99800000, high=0));
        
        WS_WRITE0(__warp_12_ousdMetaStrategy, 0);
        
        WS_WRITE1(__warp_13_netOusdMintedForStrategy, Uint256(low=0, high=0));
        
        WS_WRITE1(__warp_14_netOusdMintForStrategyThreshold, Uint256(low=0, high=0));
        
        
        
        return ();

    }

    //  @dev Initializes the contract setting the deployer as the initial owner.
    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_pse_4) = _msgSender_119df25f();
        
        _transferOwnership_d29d44ee(__warp_pse_4);
        
        
        
        return ();

    }

    //  @dev Returns the address of the current owner.
    func owner_8da5cb5b_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_1 : felt){
    alloc_locals;


        
        let (__warp_se_19) = WS0_READ_felt(__warp_0__owner);
        
        
        
        return (__warp_se_19,);

    }

    //  @dev Transfers ownership of the contract to a new account (`newOwner`).
    // Internal function without access restriction.
    func _transferOwnership_d29d44ee{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}(__warp_4_newOwner : felt)-> (){
    alloc_locals;


        
        let (__warp_5_oldOwner) = WS0_READ_felt(__warp_0__owner);
        
        WS_WRITE0(__warp_0__owner, __warp_4_newOwner);
        
        __warp_emit_OwnershipTransferred_8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0(__warp_5_oldOwner, __warp_4_newOwner);
        
        
        
        return ();

    }


    func _msgSender_119df25f{syscall_ptr : felt*}()-> (__warp_0 : felt){
    alloc_locals;


        
        let (__warp_se_22) = get_caller_address();
        
        
        
        return (__warp_se_22,);

    }

}


    @view
    func priceProvider_b888879e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_15 : felt){
    alloc_locals;


        
        let (__warp_se_3) = WS0_READ_felt(VaultStorage.__warp_0_priceProvider);
        
        
        
        return (__warp_se_3,);

    }


    @view
    func rebasePaused_53ca9f24{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_16 : felt){
    alloc_locals;


        
        let (__warp_se_4) = WS0_READ_felt(VaultStorage.__warp_1_rebasePaused);
        
        
        
        return (__warp_se_4,);

    }


    @view
    func capitalPaused_e6cc5432{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_17 : felt){
    alloc_locals;


        
        let (__warp_se_5) = WS0_READ_felt(VaultStorage.__warp_2_capitalPaused);
        
        
        
        return (__warp_se_5,);

    }


    @view
    func redeemFeeBps_09f6442c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_18 : Uint256){
    alloc_locals;


        
        let (__warp_se_6) = WS1_READ_Uint256(VaultStorage.__warp_3_redeemFeeBps);
        
        
        
        return (__warp_se_6,);

    }


    @view
    func vaultBuffer_1edfe3da{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_19 : Uint256){
    alloc_locals;


        
        let (__warp_se_7) = WS1_READ_Uint256(VaultStorage.__warp_4_vaultBuffer);
        
        
        
        return (__warp_se_7,);

    }


    @view
    func autoAllocateThreshold_9fa1826e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_20 : Uint256){
    alloc_locals;


        
        let (__warp_se_8) = WS1_READ_Uint256(VaultStorage.__warp_5_autoAllocateThreshold);
        
        
        
        return (__warp_se_8,);

    }


    @view
    func rebaseThreshold_52d38e5d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_21 : Uint256){
    alloc_locals;


        
        let (__warp_se_9) = WS1_READ_Uint256(VaultStorage.__warp_6_rebaseThreshold);
        
        
        
        return (__warp_se_9,);

    }


    @view
    func strategistAddr_570d8e1d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_22 : felt){
    alloc_locals;


        
        let (__warp_se_10) = WS0_READ_felt(VaultStorage.__warp_7_strategistAddr);
        
        
        
        return (__warp_se_10,);

    }


    @view
    func assetDefaultStrategies_a403e4d5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_23__i0 : felt)-> (__warp_24 : felt){
    alloc_locals;


        
        warp_external_input_check_address(__warp_23__i0);
        
        let (__warp_se_11) = WS0_INDEX_felt_to_felt(VaultStorage.__warp_8_assetDefaultStrategies, __warp_23__i0);
        
        let (__warp_se_12) = WS0_READ_felt(__warp_se_11);
        
        
        
        return (__warp_se_12,);

    }


    @view
    func maxSupplyDiff_8e510b52{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_25 : Uint256){
    alloc_locals;


        
        let (__warp_se_13) = WS1_READ_Uint256(VaultStorage.__warp_9_maxSupplyDiff);
        
        
        
        return (__warp_se_13,);

    }


    @view
    func trusteeAddress_49c1d54d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_26 : felt){
    alloc_locals;


        
        let (__warp_se_14) = WS0_READ_felt(VaultStorage.__warp_10_trusteeAddress);
        
        
        
        return (__warp_se_14,);

    }


    @view
    func trusteeFeeBps_207134b0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_27 : Uint256){
    alloc_locals;


        
        let (__warp_se_15) = WS1_READ_Uint256(VaultStorage.__warp_11_trusteeFeeBps);
        
        
        
        return (__warp_se_15,);

    }


    @view
    func ousdMetaStrategy_18ce56bd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_28 : felt){
    alloc_locals;


        
        let (__warp_se_16) = WS0_READ_felt(VaultStorage.__warp_12_ousdMetaStrategy);
        
        
        
        return (__warp_se_16,);

    }


    @view
    func netOusdMintedForStrategy_e45cc9f0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_29 : Uint256){
    alloc_locals;


        
        let (__warp_se_17) = WS1_READ_Uint256(VaultStorage.__warp_13_netOusdMintedForStrategy);
        
        
        
        return (__warp_se_17,);

    }


    @view
    func netOusdMintForStrategyThreshold_7a2202f3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_30 : Uint256){
    alloc_locals;


        
        let (__warp_se_18) = WS1_READ_Uint256(VaultStorage.__warp_14_netOusdMintForStrategyThreshold);
        
        
        
        return (__warp_se_18,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(){
    alloc_locals;
    WARP_USED_STORAGE.write(136);
    WARP_NAMEGEN.write(6);
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        VaultStorage.__warp_constructor_0();
        
        VaultStorage.__warp_init_VaultStorage();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func isOwner_8f32d59b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_2 : felt){
    alloc_locals;


        
        let (__warp_pse_5) = VaultStorage.owner_8da5cb5b_internal();
        
        let (__warp_se_20) = get_caller_address();
        
        let (__warp_se_21) = warp_eq(__warp_se_20, __warp_pse_5);
        
        
        
        return (__warp_se_21,);

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

        
        VaultStorage.__warp_modifier_onlyOwner_renounceOwnership_715018a6_1();
        
        let __warp_uv19 = ();
        
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
        
        VaultStorage.__warp_modifier_onlyOwner_transferOwnership_f2fde38b_4(__warp_3_newOwner);
        
        let __warp_uv20 = ();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }

    //  @dev Returns the address of the current owner.
    @view
    func owner_8da5cb5b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_1 : felt){
    alloc_locals;


        
        let (__warp_pse_6) = VaultStorage.owner_8da5cb5b_internal();
        
        
        
        return (__warp_pse_6,);

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


// Contract Def OUSD@interface


@contract_interface
namespace OUSD_warped_interface{
func __warp_modifier_onlyOwner_transferOwnership_f2fde38b_20(__warp_parameter___warp_3_newOwner19 : felt)-> (){
}
func __warp_original_function_transferOwnership_f2fde38b_18(__warp_3_newOwner : felt)-> (){
}
func __warp_modifier_onlyOwner_renounceOwnership_715018a6_17()-> (){
}
func __warp_original_function_renounceOwnership_715018a6_16()-> (){
}
func __warp_modifier_onlyVault_changeSupply_39a7919f_15(__warp_parameter___warp_75__newTotalSupply14 : Uint256)-> (){
}
func __warp_original_function_changeSupply_39a7919f_13(__warp_75__newTotalSupply : Uint256)-> (){
}
func __warp_modifier_onlyVault_burn_9dc29fac_12(__warp_parameter___warp_62_account10 : felt, __warp_parameter___warp_63_amount11 : Uint256)-> (){
}
func __warp_original_function_burn_9dc29fac_9(__warp_62_account : felt, __warp_63_amount : Uint256)-> (){
}
func __warp_modifier_onlyVault_mint_40c10f19_8(__warp_parameter___warp_56__account6 : felt, __warp_parameter___warp_57__amount7 : Uint256)-> (){
}
func __warp_original_function_mint_40c10f19_5(__warp_56__account : felt, __warp_57__amount : Uint256)-> (){
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


// Contract Def Initializable@interface


@contract_interface
namespace Initializable_warped_interface{
}