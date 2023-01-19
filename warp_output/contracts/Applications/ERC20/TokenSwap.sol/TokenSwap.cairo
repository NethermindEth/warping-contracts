%lang starknet


from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address, get_contract_address
from warplib.maths.eq import warp_eq
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


// Contract Def TokenSwap


namespace TokenSwap{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const __warp_0_token1 = 0;

    const __warp_1_owner1 = 1;

    const __warp_2_amount1 = 2;

    const __warp_3_token2 = 4;

    const __warp_4_owner2 = 5;

    const __warp_5_amount2 = 6;


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_6__token1 : felt, __warp_7__owner1 : felt, __warp_8__amount1 : Uint256, __warp_9__token2 : felt, __warp_10__owner2 : felt, __warp_11__amount2 : Uint256)-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_token1, __warp_6__token1);
        
        WS_WRITE0(__warp_1_owner1, __warp_7__owner1);
        
        WS_WRITE1(__warp_2_amount1, __warp_8__amount1);
        
        WS_WRITE0(__warp_3_token2, __warp_9__token2);
        
        WS_WRITE0(__warp_4_owner2, __warp_10__owner2);
        
        WS_WRITE1(__warp_5_amount2, __warp_11__amount2);
        
        
        
        return ();

    }


    func __warp_conditional_swap_8119c065_1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_rc_0 : felt){
    alloc_locals;


        
        let (__warp_se_0) = get_caller_address();
        
        let (__warp_se_1) = WS0_READ_felt(__warp_1_owner1);
        
        let (__warp_se_2) = warp_eq(__warp_se_0, __warp_se_1);
        
        if (__warp_se_2 != 0){
        
            
            let __warp_rc_0 = 1;
            
            
            
            return (__warp_rc_0,);
        }else{
        
            
            let (__warp_se_3) = get_caller_address();
            
            let (__warp_se_4) = WS0_READ_felt(__warp_4_owner2);
            
            let (__warp_se_5) = warp_eq(__warp_se_3, __warp_se_4);
            
            let __warp_rc_0 = __warp_se_5;
            
            
            
            return (__warp_rc_0,);
        }

    }


    func _safeTransferFrom_d6bf0a4e{syscall_ptr : felt*, range_check_ptr : felt}(__warp_12_token : felt, __warp_13_sender : felt, __warp_14_recipient : felt, __warp_15_amount : Uint256)-> (){
    alloc_locals;


        
        let (__warp_16_sent) = IERC20_warped_interface.transferFrom_23b872dd(__warp_12_token, __warp_13_sender, __warp_14_recipient, __warp_15_amount);
        
        with_attr error_message("Token transfer failed"){
            assert __warp_16_sent = 1;
        }
        
        
        
        return ();

    }

}


    @external
    func swap_8119c065{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        let __warp_rc_0 = 0;
        
        let (__warp_pse_0) = TokenSwap.__warp_conditional_swap_8119c065_1();
        
        let __warp_rc_0 = __warp_pse_0;
        
        with_attr error_message("Not authorized"){
            assert __warp_rc_0 = 1;
        }
        
        let (__warp_se_6) = WS0_READ_felt(TokenSwap.__warp_0_token1);
        
        let (__warp_se_7) = WS0_READ_felt(TokenSwap.__warp_1_owner1);
        
        let (__warp_se_8) = get_contract_address();
        
        let (__warp_pse_1) = IERC20_warped_interface.allowance_dd62ed3e(__warp_se_6, __warp_se_7, __warp_se_8);
        
        let (__warp_se_9) = WS1_READ_Uint256(TokenSwap.__warp_2_amount1);
        
        let (__warp_se_10) = warp_ge256(__warp_pse_1, __warp_se_9);
        
        with_attr error_message("Token 1 allowance too low"){
            assert __warp_se_10 = 1;
        }
        
        let (__warp_se_11) = WS0_READ_felt(TokenSwap.__warp_3_token2);
        
        let (__warp_se_12) = WS0_READ_felt(TokenSwap.__warp_4_owner2);
        
        let (__warp_se_13) = get_contract_address();
        
        let (__warp_pse_2) = IERC20_warped_interface.allowance_dd62ed3e(__warp_se_11, __warp_se_12, __warp_se_13);
        
        let (__warp_se_14) = WS1_READ_Uint256(TokenSwap.__warp_5_amount2);
        
        let (__warp_se_15) = warp_ge256(__warp_pse_2, __warp_se_14);
        
        with_attr error_message("Token 2 allowance too low"){
            assert __warp_se_15 = 1;
        }
        
        let (__warp_se_16) = WS0_READ_felt(TokenSwap.__warp_0_token1);
        
        let (__warp_se_17) = WS0_READ_felt(TokenSwap.__warp_1_owner1);
        
        let (__warp_se_18) = WS0_READ_felt(TokenSwap.__warp_4_owner2);
        
        let (__warp_se_19) = WS1_READ_Uint256(TokenSwap.__warp_2_amount1);
        
        TokenSwap._safeTransferFrom_d6bf0a4e(__warp_se_16, __warp_se_17, __warp_se_18, __warp_se_19);
        
        let (__warp_se_20) = WS0_READ_felt(TokenSwap.__warp_3_token2);
        
        let (__warp_se_21) = WS0_READ_felt(TokenSwap.__warp_4_owner2);
        
        let (__warp_se_22) = WS0_READ_felt(TokenSwap.__warp_1_owner1);
        
        let (__warp_se_23) = WS1_READ_Uint256(TokenSwap.__warp_5_amount2);
        
        TokenSwap._safeTransferFrom_d6bf0a4e(__warp_se_20, __warp_se_21, __warp_se_22, __warp_se_23);
        
        
        
        return ();

    }


    @view
    func token1_d21220a7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_17 : felt){
    alloc_locals;


        
        let (__warp_se_24) = WS0_READ_felt(TokenSwap.__warp_0_token1);
        
        
        
        return (__warp_se_24,);

    }


    @view
    func owner1_73688914{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_18 : felt){
    alloc_locals;


        
        let (__warp_se_25) = WS0_READ_felt(TokenSwap.__warp_1_owner1);
        
        
        
        return (__warp_se_25,);

    }


    @view
    func amount1_f400fde4{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_19 : Uint256){
    alloc_locals;


        
        let (__warp_se_26) = WS1_READ_Uint256(TokenSwap.__warp_2_amount1);
        
        
        
        return (__warp_se_26,);

    }


    @view
    func token2_25be124e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_20 : felt){
    alloc_locals;


        
        let (__warp_se_27) = WS0_READ_felt(TokenSwap.__warp_3_token2);
        
        
        
        return (__warp_se_27,);

    }


    @view
    func owner2_52709725{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_21 : felt){
    alloc_locals;


        
        let (__warp_se_28) = WS0_READ_felt(TokenSwap.__warp_4_owner2);
        
        
        
        return (__warp_se_28,);

    }


    @view
    func amount2_057bfcc7{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_22 : Uint256){
    alloc_locals;


        
        let (__warp_se_29) = WS1_READ_Uint256(TokenSwap.__warp_5_amount2);
        
        
        
        return (__warp_se_29,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_6__token1 : felt, __warp_7__owner1 : felt, __warp_8__amount1 : Uint256, __warp_9__token2 : felt, __warp_10__owner2 : felt, __warp_11__amount2 : Uint256){
    alloc_locals;
    WARP_USED_STORAGE.write(8);


        
        warp_external_input_check_int256(__warp_11__amount2);
        
        warp_external_input_check_address(__warp_10__owner2);
        
        warp_external_input_check_address(__warp_9__token2);
        
        warp_external_input_check_int256(__warp_8__amount1);
        
        warp_external_input_check_address(__warp_7__owner1);
        
        warp_external_input_check_address(__warp_6__token1);
        
        TokenSwap.__warp_constructor_0(__warp_6__token1, __warp_7__owner1, __warp_8__amount1, __warp_9__token2, __warp_10__owner2, __warp_11__amount2);
        
        
        
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
func totalSupply_18160ddd()-> (__warp_0 : Uint256){
}
func balanceOf_70a08231(account : felt)-> (__warp_1 : Uint256){
}
func transfer_a9059cbb(recipient : felt, amount : Uint256)-> (__warp_2 : felt){
}
func allowance_dd62ed3e(owner : felt, spender : felt)-> (__warp_3 : Uint256){
}
func approve_095ea7b3(spender : felt, amount : Uint256)-> (__warp_4 : felt){
}
func transferFrom_23b872dd(sender : felt, recipient : felt, amount : Uint256)-> (__warp_5 : felt){
}
}