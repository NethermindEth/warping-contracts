%lang starknet


from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from warplib.block_methods import warp_block_timestamp
from warplib.maths.add import warp_add256
from warplib.maths.mul import warp_mul256
from warplib.maths.ge import warp_ge256
from warplib.maths.sub import warp_sub256
from warplib.maths.lt import warp_lt256


func WS0_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}

func WS1_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
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


// Contract Def DutchAuction


namespace DutchAuction{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const DURATION = 0;

    const __warp_0_nft = 2;

    const __warp_1_nftId = 3;

    const __warp_2_seller = 5;

    const __warp_3_startingPrice = 6;

    const __warp_4_startAt = 8;

    const __warp_5_expiresAt = 10;

    const __warp_6_discountRate = 12;


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_7__startingPrice : Uint256, __warp_8__discountRate : Uint256, __warp_9__nft : felt, __warp_10__nftId : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_0) = get_caller_address();
        
        WS_WRITE0(__warp_2_seller, __warp_se_0);
        
        WS_WRITE1(__warp_3_startingPrice, __warp_7__startingPrice);
        
        let (__warp_se_1) = warp_block_timestamp();
        
        WS_WRITE1(__warp_4_startAt, __warp_se_1);
        
        let (__warp_se_2) = warp_block_timestamp();
        
        let (__warp_se_3) = warp_add256(__warp_se_2, Uint256(low=604800, high=0));
        
        WS_WRITE1(__warp_5_expiresAt, __warp_se_3);
        
        WS_WRITE1(__warp_6_discountRate, __warp_8__discountRate);
        
        let (__warp_se_4) = warp_mul256(__warp_8__discountRate, Uint256(low=604800, high=0));
        
        let (__warp_se_5) = warp_ge256(__warp_7__startingPrice, __warp_se_4);
        
        with_attr error_message("starting price < min"){
            assert __warp_se_5 = 1;
        }
        
        WS_WRITE0(__warp_0_nft, __warp_9__nft);
        
        WS_WRITE1(__warp_1_nftId, __warp_10__nftId);
        
        
        
        return ();

    }


    func getPrice_98d5fdca_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (__warp_11 : Uint256){
    alloc_locals;


        
        let (__warp_se_6) = warp_block_timestamp();
        
        let (__warp_se_7) = WS0_READ_Uint256(__warp_4_startAt);
        
        let (__warp_12_timeElapsed) = warp_sub256(__warp_se_6, __warp_se_7);
        
        let (__warp_se_8) = WS0_READ_Uint256(__warp_6_discountRate);
        
        let (__warp_13_discount) = warp_mul256(__warp_se_8, __warp_12_timeElapsed);
        
        let (__warp_se_9) = WS0_READ_Uint256(__warp_3_startingPrice);
        
        let (__warp_se_10) = warp_sub256(__warp_se_9, __warp_13_discount);
        
        
        
        return (__warp_se_10,);

    }


    func __warp_init_DutchAuction{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE1(DURATION, Uint256(low=604800, high=0));
        
        
        
        return ();

    }

}


    @external
    func buy_a6f2ae3a{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;


        
        let (__warp_se_11) = warp_block_timestamp();
        
        let (__warp_se_12) = WS0_READ_Uint256(DutchAuction.__warp_5_expiresAt);
        
        let (__warp_se_13) = warp_lt256(__warp_se_11, __warp_se_12);
        
        with_attr error_message("auction expired"){
            assert __warp_se_13 = 1;
        }
        
        let (price) = DutchAuction.getPrice_98d5fdca_internal();
        
        let (__warp_se_14) = WS1_READ_felt(DutchAuction.__warp_0_nft);
        
        let (__warp_se_15) = WS1_READ_felt(DutchAuction.__warp_2_seller);
        
        let (__warp_se_16) = get_caller_address();
        
        let (__warp_se_17) = WS0_READ_Uint256(DutchAuction.__warp_1_nftId);
        
        IERC721_warped_interface.transferFrom_23b872dd(__warp_se_14, __warp_se_15, __warp_se_16, __warp_se_17);
        
        
        
        return ();

    }


    @view
    func nft_47ccca02{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_14 : felt){
    alloc_locals;


        
        let (__warp_se_18) = WS1_READ_felt(DutchAuction.__warp_0_nft);
        
        
        
        return (__warp_se_18,);

    }


    @view
    func nftId_c6bc5182{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_15 : Uint256){
    alloc_locals;


        
        let (__warp_se_19) = WS0_READ_Uint256(DutchAuction.__warp_1_nftId);
        
        
        
        return (__warp_se_19,);

    }


    @view
    func seller_08551a53{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_16 : felt){
    alloc_locals;


        
        let (__warp_se_20) = WS1_READ_felt(DutchAuction.__warp_2_seller);
        
        
        
        return (__warp_se_20,);

    }


    @view
    func startingPrice_d6fbf202{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_17 : Uint256){
    alloc_locals;


        
        let (__warp_se_21) = WS0_READ_Uint256(DutchAuction.__warp_3_startingPrice);
        
        
        
        return (__warp_se_21,);

    }


    @view
    func startAt_c7446565{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_18 : Uint256){
    alloc_locals;


        
        let (__warp_se_22) = WS0_READ_Uint256(DutchAuction.__warp_4_startAt);
        
        
        
        return (__warp_se_22,);

    }


    @view
    func expiresAt_8622a689{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_19 : Uint256){
    alloc_locals;


        
        let (__warp_se_23) = WS0_READ_Uint256(DutchAuction.__warp_5_expiresAt);
        
        
        
        return (__warp_se_23,);

    }


    @view
    func discountRate_e6c0e6d5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_20 : Uint256){
    alloc_locals;


        
        let (__warp_se_24) = WS0_READ_Uint256(DutchAuction.__warp_6_discountRate);
        
        
        
        return (__warp_se_24,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_7__startingPrice : Uint256, __warp_8__discountRate : Uint256, __warp_9__nft : felt, __warp_10__nftId : Uint256){
    alloc_locals;
    WARP_USED_STORAGE.write(14);


        
        warp_external_input_check_int256(__warp_10__nftId);
        
        warp_external_input_check_address(__warp_9__nft);
        
        warp_external_input_check_int256(__warp_8__discountRate);
        
        warp_external_input_check_int256(__warp_7__startingPrice);
        
        DutchAuction.__warp_init_DutchAuction();
        
        DutchAuction.__warp_constructor_0(__warp_7__startingPrice, __warp_8__discountRate, __warp_9__nft, __warp_10__nftId);
        
        
        
        return ();

    }


    @view
    func getPrice_98d5fdca{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (__warp_11 : Uint256){
    alloc_locals;


        
        let (__warp_pse_0) = DutchAuction.getPrice_98d5fdca_internal();
        
        
        
        return (__warp_pse_0,);

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
func transferFrom_23b872dd(_from : felt, _to : felt, _nftId : Uint256)-> (){
}
}