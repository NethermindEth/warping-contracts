%lang starknet


from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from warplib.dynamic_arrays_util import fixed_bytes256_to_felt_dynamic_array, felt_array_to_warp_memory_array, fixed_bytes256_to_felt_dynamic_array_spl
from warplib.maths.utils import felt_to_uint256
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from warplib.memory import wm_new, wm_to_felt_array
from starkware.starknet.common.syscalls import emit_event, get_caller_address, get_contract_address
from warplib.keccak import pack_bytes_felt, felt_array_concat
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.cairo_keccak.keccak import finalize_keccak
from warplib.maths.eq import warp_eq
from warplib.block_methods import warp_block_timestamp
from warplib.maths.add import warp_add256
from warplib.maths.lt import warp_lt256
from warplib.maths.neq import warp_neq
from warplib.maths.ge import warp_ge256


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

func _emit_Start_1b55ba3a{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x186d29cf149c49dc42b51d186df8c682286361a0ae522aa3da3fd551e5a24c6);// keccak of event signature: Start()
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
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

func _emit_Withdraw_884edad9{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x355d7a17d68f018369bfcc9e887d65c3581b7f22aa11a23a6382dfec809d163);// keccak of event signature: Withdraw(address,uint256)
    let (keys_len: felt) = fixed_bytes256_to_felt_dynamic_array_spl(keys_len, keys, 0, topic256);
   let (mem_encode: felt) = abi_encode0(param0);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (keys_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, keys_len, keys);
   // keys: pack 31 byte felts into a single 248 bit felt
   let (keys_len: felt, keys: felt*) = pack_bytes_felt(31, 1, keys_len, keys);
   // data arrays
   let data_len: felt = 0;
   let (data: felt*) = alloc();
   let (mem_encode: felt) = abi_encode1(param1);
   let (encode_bytes_len: felt, encode_bytes: felt*) = wm_to_felt_array(mem_encode);
   let (data_len: felt) = felt_array_concat(encode_bytes_len, 0, encode_bytes, data_len, data);
   // data: pack 31 bytes felts into a single 248 bits felt
   let (data_len: felt, data: felt*) = pack_bytes_felt(31, 1, data_len, data);
   emit_event(keys_len, keys, data_len, data);
   return ();
}

func _emit_End_7d7570b0{syscall_ptr: felt*, bitwise_ptr : BitwiseBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*, keccak_ptr: felt*}(param0 : felt, param1 : Uint256){
   alloc_locals;
   // keys arrays
   let keys_len: felt = 0;
   let (keys: felt*) = alloc();
   //Insert topic
    let (topic256: Uint256) = felt_to_uint256(0x3b418b4b8f29a0ece95cb43440648b4b72a259e609c316f946c06bd75487216);// keccak of event signature: End(address,uint256)
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


// Contract Def EnglishAuction


// @event
// func Start(){
// }


// @event
// func Bid(sender : felt, amount : Uint256){
// }


// @event
// func Withdraw(bidder : felt, amount : Uint256){
// }


// @event
// func End(winner : felt, amount : Uint256){
// }

namespace EnglishAuction{

    // Dynamic variables - Arrays and Maps

    const __warp_8_bids = 1;

    // Static variables

    const __warp_0_nft = 0;

    const __warp_1_nftId = 1;

    const __warp_2_seller = 3;

    const __warp_3_endAt = 4;

    const __warp_4_started = 6;

    const __warp_5_ended = 7;

    const __warp_6_highestBidder = 8;

    const __warp_7_highestBid = 9;


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_9__nft : felt, __warp_10__nftId : Uint256, __warp_11__startingBid : Uint256)-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_nft, __warp_9__nft);
        
        WS_WRITE1(__warp_1_nftId, __warp_10__nftId);
        
        let (__warp_se_0) = get_caller_address();
        
        WS_WRITE0(__warp_2_seller, __warp_se_0);
        
        WS_WRITE1(__warp_7_highestBid, __warp_11__startingBid);
        
        
        
        return ();

    }


    func bid_1998aeef_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        let (__warp_se_22) = get_caller_address();
        
        WS_WRITE0(__warp_6_highestBidder, __warp_se_22);
        
        
        
        return ();

    }


    func end_efbe1c1c_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*, keccak_ptr : felt*}()-> (){
    alloc_locals;


        
        let (__warp_se_43) = WS0_READ_felt(__warp_6_highestBidder);
        
        let (__warp_se_44) = WS1_READ_Uint256(__warp_7_highestBid);
        
        _emit_End_7d7570b0(__warp_se_43, __warp_se_44);
        
        
        
        return ();

    }

}


    @external
    func start_be9a6555{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        let (__warp_se_1) = WS0_READ_felt(EnglishAuction.__warp_4_started);
        
        with_attr error_message("started"){
            assert 1 - __warp_se_1 = 1;
        }
        
        let (__warp_se_2) = get_caller_address();
        
        let (__warp_se_3) = WS0_READ_felt(EnglishAuction.__warp_2_seller);
        
        let (__warp_se_4) = warp_eq(__warp_se_2, __warp_se_3);
        
        with_attr error_message("not seller"){
            assert __warp_se_4 = 1;
        }
        
        let (__warp_se_5) = WS0_READ_felt(EnglishAuction.__warp_0_nft);
        
        let (__warp_se_6) = get_caller_address();
        
        let (__warp_se_7) = get_contract_address();
        
        let (__warp_se_8) = WS1_READ_Uint256(EnglishAuction.__warp_1_nftId);
        
        IERC721_warped_interface.transferFrom_23b872dd(__warp_se_5, __warp_se_6, __warp_se_7, __warp_se_8);
        
        WS_WRITE0(EnglishAuction.__warp_4_started, 1);
        
        let (__warp_se_9) = warp_block_timestamp();
        
        let (__warp_se_10) = warp_add256(__warp_se_9, Uint256(low=604800, high=0));
        
        WS_WRITE1(EnglishAuction.__warp_3_endAt, __warp_se_10);
        
        _emit_Start_1b55ba3a();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func bid_1998aeef{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        let (__warp_se_11) = WS0_READ_felt(EnglishAuction.__warp_4_started);
        
        with_attr error_message("not started"){
            assert __warp_se_11 = 1;
        }
        
        let (__warp_se_12) = warp_block_timestamp();
        
        let (__warp_se_13) = WS1_READ_Uint256(EnglishAuction.__warp_3_endAt);
        
        let (__warp_se_14) = warp_lt256(__warp_se_12, __warp_se_13);
        
        with_attr error_message("ended"){
            assert __warp_se_14 = 1;
        }
        
        let (__warp_se_15) = WS0_READ_felt(EnglishAuction.__warp_6_highestBidder);
        
        let (__warp_se_16) = warp_neq(__warp_se_15, 0);
        
        if (__warp_se_16 != 0){
        
            
                
                let (__warp_cs_0) = WS0_READ_felt(EnglishAuction.__warp_6_highestBidder);
                
                let (__warp_se_17) = WS0_INDEX_felt_to_Uint256(EnglishAuction.__warp_8_bids, __warp_cs_0);
                
                let (__warp_se_18) = WS0_INDEX_felt_to_Uint256(EnglishAuction.__warp_8_bids, __warp_cs_0);
                
                let (__warp_se_19) = WS1_READ_Uint256(__warp_se_18);
                
                let (__warp_se_20) = WS1_READ_Uint256(EnglishAuction.__warp_7_highestBid);
                
                let (__warp_se_21) = warp_add256(__warp_se_19, __warp_se_20);
                
                WS_WRITE1(__warp_se_17, __warp_se_21);
            
            EnglishAuction.bid_1998aeef_if_part1();
            
            let __warp_uv0 = ();
            
            
            
            return ();
        }else{
        
            
            EnglishAuction.bid_1998aeef_if_part1();
            
            let __warp_uv1 = ();
            
            
            
            return ();
        }

    }


    @external
    func withdraw_3ccfd60b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        let (__warp_se_23) = get_caller_address();
        
        let (__warp_se_24) = WS0_INDEX_felt_to_Uint256(EnglishAuction.__warp_8_bids, __warp_se_23);
        
        let (__warp_12_bal) = WS1_READ_Uint256(__warp_se_24);
        
        let (__warp_se_25) = get_caller_address();
        
        let (__warp_se_26) = WS0_INDEX_felt_to_Uint256(EnglishAuction.__warp_8_bids, __warp_se_25);
        
        WS_WRITE1(__warp_se_26, Uint256(low=0, high=0));
        
        let (__warp_se_27) = get_caller_address();
        
        _emit_Withdraw_884edad9(__warp_se_27, __warp_12_bal);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        finalize_keccak(keccak_ptr_start, keccak_ptr);
        
        return ();
    }
    }


    @external
    func end_efbe1c1c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;
    let (local keccak_ptr_start : felt*) = alloc();
    let keccak_ptr = keccak_ptr_start;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory, keccak_ptr{

        
        let (__warp_se_28) = WS0_READ_felt(EnglishAuction.__warp_4_started);
        
        with_attr error_message("not started"){
            assert __warp_se_28 = 1;
        }
        
        let (__warp_se_29) = warp_block_timestamp();
        
        let (__warp_se_30) = WS1_READ_Uint256(EnglishAuction.__warp_3_endAt);
        
        let (__warp_se_31) = warp_ge256(__warp_se_29, __warp_se_30);
        
        with_attr error_message("not ended"){
            assert __warp_se_31 = 1;
        }
        
        let (__warp_se_32) = WS0_READ_felt(EnglishAuction.__warp_5_ended);
        
        with_attr error_message("ended"){
            assert 1 - __warp_se_32 = 1;
        }
        
        WS_WRITE0(EnglishAuction.__warp_5_ended, 1);
        
        let (__warp_se_33) = WS0_READ_felt(EnglishAuction.__warp_6_highestBidder);
        
        let (__warp_se_34) = warp_neq(__warp_se_33, 0);
        
        if (__warp_se_34 != 0){
        
            
                
                let (__warp_se_35) = WS0_READ_felt(EnglishAuction.__warp_0_nft);
                
                let (__warp_se_36) = get_contract_address();
                
                let (__warp_se_37) = WS0_READ_felt(EnglishAuction.__warp_6_highestBidder);
                
                let (__warp_se_38) = WS1_READ_Uint256(EnglishAuction.__warp_1_nftId);
                
                IERC721_warped_interface.safeTransferFrom_42842e0e(__warp_se_35, __warp_se_36, __warp_se_37, __warp_se_38);
            
            EnglishAuction.end_efbe1c1c_if_part1();
            
            let __warp_uv2 = ();
            
            default_dict_finalize(warp_memory_start, warp_memory, 0);
            
            finalize_keccak(keccak_ptr_start, keccak_ptr);
            
            return ();
        }else{
        
            
                
                let (__warp_se_39) = WS0_READ_felt(EnglishAuction.__warp_0_nft);
                
                let (__warp_se_40) = get_contract_address();
                
                let (__warp_se_41) = WS0_READ_felt(EnglishAuction.__warp_2_seller);
                
                let (__warp_se_42) = WS1_READ_Uint256(EnglishAuction.__warp_1_nftId);
                
                IERC721_warped_interface.safeTransferFrom_42842e0e(__warp_se_39, __warp_se_40, __warp_se_41, __warp_se_42);
            
            EnglishAuction.end_efbe1c1c_if_part1();
            
            let __warp_uv3 = ();
            
            default_dict_finalize(warp_memory_start, warp_memory, 0);
            
            finalize_keccak(keccak_ptr_start, keccak_ptr);
            
            return ();
        }
    }
    }


    @view
    func nft_47ccca02{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_13 : felt){
    alloc_locals;


        
        let (__warp_se_45) = WS0_READ_felt(EnglishAuction.__warp_0_nft);
        
        
        
        return (__warp_se_45,);

    }


    @view
    func nftId_c6bc5182{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_14 : Uint256){
    alloc_locals;


        
        let (__warp_se_46) = WS1_READ_Uint256(EnglishAuction.__warp_1_nftId);
        
        
        
        return (__warp_se_46,);

    }


    @view
    func seller_08551a53{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_15 : felt){
    alloc_locals;


        
        let (__warp_se_47) = WS0_READ_felt(EnglishAuction.__warp_2_seller);
        
        
        
        return (__warp_se_47,);

    }


    @view
    func endAt_7cc3ae8c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_16 : Uint256){
    alloc_locals;


        
        let (__warp_se_48) = WS1_READ_Uint256(EnglishAuction.__warp_3_endAt);
        
        
        
        return (__warp_se_48,);

    }


    @view
    func started_1f2698ab{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_17 : felt){
    alloc_locals;


        
        let (__warp_se_49) = WS0_READ_felt(EnglishAuction.__warp_4_started);
        
        
        
        return (__warp_se_49,);

    }


    @view
    func ended_12fa6feb{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_18 : felt){
    alloc_locals;


        
        let (__warp_se_50) = WS0_READ_felt(EnglishAuction.__warp_5_ended);
        
        
        
        return (__warp_se_50,);

    }


    @view
    func highestBidder_91f90157{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_19 : felt){
    alloc_locals;


        
        let (__warp_se_51) = WS0_READ_felt(EnglishAuction.__warp_6_highestBidder);
        
        
        
        return (__warp_se_51,);

    }


    @view
    func highestBid_d57bde79{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_20 : Uint256){
    alloc_locals;


        
        let (__warp_se_52) = WS1_READ_Uint256(EnglishAuction.__warp_7_highestBid);
        
        
        
        return (__warp_se_52,);

    }


    @view
    func bids_62ea82db{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_21__i0 : felt)-> (__warp_22 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_21__i0);
        
        let (__warp_se_53) = WS0_INDEX_felt_to_Uint256(EnglishAuction.__warp_8_bids, __warp_21__i0);
        
        let (__warp_se_54) = WS1_READ_Uint256(__warp_se_53);
        
        
        
        return (__warp_se_54,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_9__nft : felt, __warp_10__nftId : Uint256, __warp_11__startingBid : Uint256){
    alloc_locals;
    WARP_USED_STORAGE.write(12);
    WARP_NAMEGEN.write(1);


        
        warp_external_input_check_int256(__warp_11__startingBid);
        
        warp_external_input_check_int256(__warp_10__nftId);
        
        warp_external_input_check_address(__warp_9__nft);
        
        EnglishAuction.__warp_constructor_0(__warp_9__nft, __warp_10__nftId, __warp_11__startingBid);
        
        
        
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


// Contract Def IERC721@interface


@contract_interface
namespace IERC721_warped_interface{
func safeTransferFrom_42842e0e(__warp_0_from : felt, to : felt, tokenId : Uint256)-> (){
}
func transferFrom_23b872dd(__warp_1 : felt, __warp_2 : felt, __warp_3 : Uint256)-> (){
}
}