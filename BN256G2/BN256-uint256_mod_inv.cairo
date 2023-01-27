%lang starknet


from warplib.memory import wm_alloc, wm_write_256, wm_read_256, wm_index_static
from starkware.cairo.common.dict import dict_write
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.dict_access import DictAccess
from warplib.maths.neq import warp_neq256
from warplib.maths.bitwise_and import warp_bitwise_and256
from warplib.maths.div import warp_div256
from warplib.maths.eq import warp_eq256
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from warplib.maths.sub import warp_sub256
from warplib.maths.addmod import warp_addmod
from warplib.maths.mulmod import warp_mulmod
from warplib.maths.add import warp_add256
from starkware.cairo.common.uint256 import uint256_mul_div_mod
 from starkware.cairo.common.uint256 import (
    Uint256, uint256_add, uint256_sub, uint256_mul,
    uint256_unsigned_div_rem, uint256_eq, uint256_check, uint256_lt
    )

func WM0_s_arr{range_check_ptr, warp_memory: DictAccess*}(e0: Uint256, e1: Uint256, e2: Uint256, e3: Uint256, e4: Uint256, e5: Uint256) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0xc, 0x0));
dict_write{dict_ptr=warp_memory}(start, e0.low);
dict_write{dict_ptr=warp_memory}(start + 1, e0.high);
dict_write{dict_ptr=warp_memory}(start + 2, e1.low);
dict_write{dict_ptr=warp_memory}(start + 3, e1.high);
dict_write{dict_ptr=warp_memory}(start + 4, e2.low);
dict_write{dict_ptr=warp_memory}(start + 5, e2.high);
dict_write{dict_ptr=warp_memory}(start + 6, e3.low);
dict_write{dict_ptr=warp_memory}(start + 7, e3.high);
dict_write{dict_ptr=warp_memory}(start + 8, e4.low);
dict_write{dict_ptr=warp_memory}(start + 9, e4.high);
dict_write{dict_ptr=warp_memory}(start + 10, e5.low);
dict_write{dict_ptr=warp_memory}(start + 11, e5.high);
    return (start,);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}


// Contract Def BN256G2

//  @title Elliptic curve operations on twist points for alt_bn128
// @author Mustafa Al-Bassam (mus@musalbas.com)
// @dev Homepage: https://github.com/musalbas/solidity-BN256G2

namespace BN256G2{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const FIELD_MODULUS = 0;

    const TWISTBX = 2;

    const TWISTBY = 4;

    const PTXX = 6;

    const PTXY = 8;

    const PTYX = 10;

    const PTYY = 12;

    const PTZX = 14;

    const PTZY = 16;


    func __warp_while0{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_112_d : Uint256, __warp_119_pt2 : felt, __warp_113_pt1xx : Uint256, __warp_114_pt1xy : Uint256, __warp_115_pt1yx : Uint256, __warp_116_pt1yy : Uint256, __warp_117_pt1zx : Uint256, __warp_118_pt1zy : Uint256)-> (__warp_112_d : Uint256, __warp_119_pt2 : felt, __warp_113_pt1xx : Uint256, __warp_114_pt1xy : Uint256, __warp_115_pt1yx : Uint256, __warp_116_pt1yy : Uint256, __warp_117_pt1zx : Uint256, __warp_118_pt1zy : Uint256){
    alloc_locals;


        
            
            let (__warp_se_0) = warp_neq256(__warp_112_d, Uint256(low=0, high=0));
            
                
                if (__warp_se_0 != 0){
                
                    
                    let (__warp_se_1) = warp_bitwise_and256(__warp_112_d, Uint256(low=1, high=0));
                    
                    let (__warp_se_2) = warp_neq256(__warp_se_1, Uint256(low=0, high=0));
                    
                        
                        if (__warp_se_2 != 0){
                        
                            
                            let (__warp_se_3) = wm_index_static(__warp_119_pt2, Uint256(low=0, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            let (__warp_se_4) = wm_read_256(__warp_se_3);
                            
                            let (__warp_se_5) = wm_index_static(__warp_119_pt2, Uint256(low=1, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            let (__warp_se_6) = wm_read_256(__warp_se_5);
                            
                            let (__warp_se_7) = wm_index_static(__warp_119_pt2, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            let (__warp_se_8) = wm_read_256(__warp_se_7);
                            
                            let (__warp_se_9) = wm_index_static(__warp_119_pt2, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            let (__warp_se_10) = wm_read_256(__warp_se_9);
                            
                            let (__warp_se_11) = wm_index_static(__warp_119_pt2, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            let (__warp_se_12) = wm_read_256(__warp_se_11);
                            
                            let (__warp_se_13) = wm_index_static(__warp_119_pt2, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            let (__warp_se_14) = wm_read_256(__warp_se_13);
                            
                            let (__warp_pse_0) = _ECTwistAddJacobian_4a863fe0(__warp_se_4, __warp_se_6, __warp_se_8, __warp_se_10, __warp_se_12, __warp_se_14, __warp_113_pt1xx, __warp_114_pt1xy, __warp_115_pt1yx, __warp_116_pt1yy, __warp_117_pt1zx, __warp_118_pt1zy);
                            
                            let __warp_119_pt2 = __warp_pse_0;
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar warp_memory = warp_memory;
                            tempvar __warp_112_d = __warp_112_d;
                            tempvar __warp_119_pt2 = __warp_119_pt2;
                            tempvar __warp_113_pt1xx = __warp_113_pt1xx;
                            tempvar __warp_114_pt1xy = __warp_114_pt1xy;
                            tempvar __warp_115_pt1yx = __warp_115_pt1yx;
                            tempvar __warp_116_pt1yy = __warp_116_pt1yy;
                            tempvar __warp_117_pt1zx = __warp_117_pt1zx;
                            tempvar __warp_118_pt1zy = __warp_118_pt1zy;
                        }else{
                        
                            tempvar range_check_ptr = range_check_ptr;
                            tempvar bitwise_ptr = bitwise_ptr;
                            tempvar warp_memory = warp_memory;
                            tempvar __warp_112_d = __warp_112_d;
                            tempvar __warp_119_pt2 = __warp_119_pt2;
                            tempvar __warp_113_pt1xx = __warp_113_pt1xx;
                            tempvar __warp_114_pt1xy = __warp_114_pt1xy;
                            tempvar __warp_115_pt1yx = __warp_115_pt1yx;
                            tempvar __warp_116_pt1yy = __warp_116_pt1yy;
                            tempvar __warp_117_pt1zx = __warp_117_pt1zx;
                            tempvar __warp_118_pt1zy = __warp_118_pt1zy;
                        }
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar __warp_112_d = __warp_112_d;
                        tempvar __warp_119_pt2 = __warp_119_pt2;
                        tempvar __warp_113_pt1xx = __warp_113_pt1xx;
                        tempvar __warp_114_pt1xy = __warp_114_pt1xy;
                        tempvar __warp_115_pt1yx = __warp_115_pt1yx;
                        tempvar __warp_116_pt1yy = __warp_116_pt1yy;
                        tempvar __warp_117_pt1zx = __warp_117_pt1zx;
                        tempvar __warp_118_pt1zy = __warp_118_pt1zy;
                    
                        
                        let (__warp_tv_0, __warp_tv_1, __warp_tv_2, __warp_tv_3, __warp_tv_4, __warp_tv_5) = _ECTwistDoubleJacobian_f2664d9a(__warp_113_pt1xx, __warp_114_pt1xy, __warp_115_pt1yx, __warp_116_pt1yy, __warp_117_pt1zx, __warp_118_pt1zy);
                        
                        let __warp_118_pt1zy = __warp_tv_5;
                        
                        let __warp_117_pt1zx = __warp_tv_4;
                        
                        let __warp_116_pt1yy = __warp_tv_3;
                        
                        let __warp_115_pt1yx = __warp_tv_2;
                        
                        let __warp_114_pt1xy = __warp_tv_1;
                        
                        let __warp_113_pt1xx = __warp_tv_0;
                    
                    let (__warp_se_15) = warp_div256(__warp_112_d, Uint256(low=2, high=0));
                    
                    let __warp_112_d = __warp_se_15;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar __warp_112_d = __warp_112_d;
                    tempvar __warp_119_pt2 = __warp_119_pt2;
                    tempvar __warp_113_pt1xx = __warp_113_pt1xx;
                    tempvar __warp_114_pt1xy = __warp_114_pt1xy;
                    tempvar __warp_115_pt1yx = __warp_115_pt1yx;
                    tempvar __warp_116_pt1yy = __warp_116_pt1yy;
                    tempvar __warp_117_pt1zx = __warp_117_pt1zx;
                    tempvar __warp_118_pt1zy = __warp_118_pt1zy;
                }else{
                
                    
                    let __warp_112_d = __warp_112_d;
                    
                    let __warp_119_pt2 = __warp_119_pt2;
                    
                    let __warp_113_pt1xx = __warp_113_pt1xx;
                    
                    let __warp_114_pt1xy = __warp_114_pt1xy;
                    
                    let __warp_115_pt1yx = __warp_115_pt1yx;
                    
                    let __warp_116_pt1yy = __warp_116_pt1yy;
                    
                    let __warp_117_pt1zx = __warp_117_pt1zx;
                    
                    let __warp_118_pt1zy = __warp_118_pt1zy;
                    
                    
                    
                    return (__warp_112_d, __warp_119_pt2, __warp_113_pt1xx, __warp_114_pt1xy, __warp_115_pt1yx, __warp_116_pt1yy, __warp_117_pt1zx, __warp_118_pt1zy);
                }
                tempvar range_check_ptr = range_check_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar __warp_112_d = __warp_112_d;
                tempvar __warp_119_pt2 = __warp_119_pt2;
                tempvar __warp_113_pt1xx = __warp_113_pt1xx;
                tempvar __warp_114_pt1xy = __warp_114_pt1xy;
                tempvar __warp_115_pt1yx = __warp_115_pt1yx;
                tempvar __warp_116_pt1yy = __warp_116_pt1yy;
                tempvar __warp_117_pt1zx = __warp_117_pt1zx;
                tempvar __warp_118_pt1zy = __warp_118_pt1zy;
        
        let (__warp_112_d, __warp_td_0, __warp_113_pt1xx, __warp_114_pt1xy, __warp_115_pt1yx, __warp_116_pt1yy, __warp_117_pt1zx, __warp_118_pt1zy) = __warp_while0(__warp_112_d, __warp_119_pt2, __warp_113_pt1xx, __warp_114_pt1xy, __warp_115_pt1yx, __warp_116_pt1yy, __warp_117_pt1zx, __warp_118_pt1zy);
        
        let __warp_119_pt2 = __warp_td_0;
        
        
        
        return (__warp_112_d, __warp_119_pt2, __warp_113_pt1xx, __warp_114_pt1xy, __warp_115_pt1yx, __warp_116_pt1yy, __warp_117_pt1zx, __warp_118_pt1zy);

    }


    func __warp_conditional___warp_conditional___warp_conditional_ECTwistAdd_61a931ec_1_3_5{range_check_ptr : felt}(__warp_0_pt1xx : Uint256, __warp_1_pt1xy : Uint256)-> (__warp_rc_4 : felt, __warp_0_pt1xx : Uint256, __warp_1_pt1xy : Uint256){
    alloc_locals;


        
        let (__warp_se_16) = warp_eq256(__warp_0_pt1xx, Uint256(low=0, high=0));
        
        if (__warp_se_16 != 0){
        
            
            let (__warp_se_17) = warp_eq256(__warp_1_pt1xy, Uint256(low=0, high=0));
            
            let __warp_rc_4 = __warp_se_17;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_0_pt1xx = __warp_0_pt1xx;
            
            let __warp_1_pt1xy = __warp_1_pt1xy;
            
            
            
            return (__warp_rc_4, __warp_0_pt1xx, __warp_1_pt1xy);
        }else{
        
            
            let __warp_rc_4 = 0;
            
            let __warp_rc_4 = __warp_rc_4;
            
            let __warp_0_pt1xx = __warp_0_pt1xx;
            
            let __warp_1_pt1xy = __warp_1_pt1xy;
            
            
            
            return (__warp_rc_4, __warp_0_pt1xx, __warp_1_pt1xy);
        }

    }


    func __warp_conditional___warp_conditional_ECTwistAdd_61a931ec_1_3{range_check_ptr : felt}(__warp_0_pt1xx : Uint256, __warp_1_pt1xy : Uint256, __warp_2_pt1yx : Uint256)-> (__warp_rc_2 : felt, __warp_0_pt1xx : Uint256, __warp_1_pt1xy : Uint256, __warp_2_pt1yx : Uint256){
    alloc_locals;


        
        let __warp_rc_4 = 0;
        
            
            let (__warp_tv_6, __warp_tv_7, __warp_tv_8) = __warp_conditional___warp_conditional___warp_conditional_ECTwistAdd_61a931ec_1_3_5(__warp_0_pt1xx, __warp_1_pt1xy);
            
            let __warp_1_pt1xy = __warp_tv_8;
            
            let __warp_0_pt1xx = __warp_tv_7;
            
            let __warp_rc_4 = __warp_tv_6;
        
        if (__warp_rc_4 != 0){
        
            
            let (__warp_se_18) = warp_eq256(__warp_2_pt1yx, Uint256(low=0, high=0));
            
            let __warp_rc_2 = __warp_se_18;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_0_pt1xx = __warp_0_pt1xx;
            
            let __warp_1_pt1xy = __warp_1_pt1xy;
            
            let __warp_2_pt1yx = __warp_2_pt1yx;
            
            
            
            return (__warp_rc_2, __warp_0_pt1xx, __warp_1_pt1xy, __warp_2_pt1yx);
        }else{
        
            
            let __warp_rc_2 = 0;
            
            let __warp_rc_2 = __warp_rc_2;
            
            let __warp_0_pt1xx = __warp_0_pt1xx;
            
            let __warp_1_pt1xy = __warp_1_pt1xy;
            
            let __warp_2_pt1yx = __warp_2_pt1yx;
            
            
            
            return (__warp_rc_2, __warp_0_pt1xx, __warp_1_pt1xy, __warp_2_pt1yx);
        }

    }


    func __warp_conditional_ECTwistAdd_61a931ec_1{range_check_ptr : felt}(__warp_0_pt1xx : Uint256, __warp_1_pt1xy : Uint256, __warp_2_pt1yx : Uint256, __warp_3_pt1yy : Uint256)-> (__warp_rc_0 : felt, __warp_0_pt1xx : Uint256, __warp_1_pt1xy : Uint256, __warp_2_pt1yx : Uint256, __warp_3_pt1yy : Uint256){
    alloc_locals;


        
        let __warp_rc_2 = 0;
        
            
            let (__warp_tv_9, __warp_tv_10, __warp_tv_11, __warp_tv_12) = __warp_conditional___warp_conditional_ECTwistAdd_61a931ec_1_3(__warp_0_pt1xx, __warp_1_pt1xy, __warp_2_pt1yx);
            
            let __warp_2_pt1yx = __warp_tv_12;
            
            let __warp_1_pt1xy = __warp_tv_11;
            
            let __warp_0_pt1xx = __warp_tv_10;
            
            let __warp_rc_2 = __warp_tv_9;
        
        if (__warp_rc_2 != 0){
        
            
            let (__warp_se_19) = warp_eq256(__warp_3_pt1yy, Uint256(low=0, high=0));
            
            let __warp_rc_0 = __warp_se_19;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_0_pt1xx = __warp_0_pt1xx;
            
            let __warp_1_pt1xy = __warp_1_pt1xy;
            
            let __warp_2_pt1yx = __warp_2_pt1yx;
            
            let __warp_3_pt1yy = __warp_3_pt1yy;
            
            
            
            return (__warp_rc_0, __warp_0_pt1xx, __warp_1_pt1xy, __warp_2_pt1yx, __warp_3_pt1yy);
        }else{
        
            
            let __warp_rc_0 = 0;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_0_pt1xx = __warp_0_pt1xx;
            
            let __warp_1_pt1xy = __warp_1_pt1xy;
            
            let __warp_2_pt1yx = __warp_2_pt1yx;
            
            let __warp_3_pt1yy = __warp_3_pt1yy;
            
            
            
            return (__warp_rc_0, __warp_0_pt1xx, __warp_1_pt1xy, __warp_2_pt1yx, __warp_3_pt1yy);
        }

    }


    func __warp_conditional___warp_conditional___warp_conditional_ECTwistAdd_61a931ec_7_9_11{range_check_ptr : felt}(__warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256)-> (__warp_rc_10 : felt, __warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256){
    alloc_locals;


        
        let (__warp_se_20) = warp_eq256(__warp_4_pt2xx, Uint256(low=0, high=0));
        
        if (__warp_se_20 != 0){
        
            
            let (__warp_se_21) = warp_eq256(__warp_5_pt2xy, Uint256(low=0, high=0));
            
            let __warp_rc_10 = __warp_se_21;
            
            let __warp_rc_10 = __warp_rc_10;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            
            
            return (__warp_rc_10, __warp_4_pt2xx, __warp_5_pt2xy);
        }else{
        
            
            let __warp_rc_10 = 0;
            
            let __warp_rc_10 = __warp_rc_10;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            
            
            return (__warp_rc_10, __warp_4_pt2xx, __warp_5_pt2xy);
        }

    }


    func __warp_conditional___warp_conditional_ECTwistAdd_61a931ec_7_9{range_check_ptr : felt}(__warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256, __warp_6_pt2yx : Uint256)-> (__warp_rc_8 : felt, __warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256, __warp_6_pt2yx : Uint256){
    alloc_locals;


        
        let __warp_rc_10 = 0;
        
            
            let (__warp_tv_18, __warp_tv_19, __warp_tv_20) = __warp_conditional___warp_conditional___warp_conditional_ECTwistAdd_61a931ec_7_9_11(__warp_4_pt2xx, __warp_5_pt2xy);
            
            let __warp_5_pt2xy = __warp_tv_20;
            
            let __warp_4_pt2xx = __warp_tv_19;
            
            let __warp_rc_10 = __warp_tv_18;
        
        if (__warp_rc_10 != 0){
        
            
            let (__warp_se_22) = warp_eq256(__warp_6_pt2yx, Uint256(low=0, high=0));
            
            let __warp_rc_8 = __warp_se_22;
            
            let __warp_rc_8 = __warp_rc_8;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            let __warp_6_pt2yx = __warp_6_pt2yx;
            
            
            
            return (__warp_rc_8, __warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx);
        }else{
        
            
            let __warp_rc_8 = 0;
            
            let __warp_rc_8 = __warp_rc_8;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            let __warp_6_pt2yx = __warp_6_pt2yx;
            
            
            
            return (__warp_rc_8, __warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx);
        }

    }


    func __warp_conditional_ECTwistAdd_61a931ec_7{range_check_ptr : felt}(__warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256, __warp_6_pt2yx : Uint256, __warp_7_pt2yy : Uint256)-> (__warp_rc_6 : felt, __warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256, __warp_6_pt2yx : Uint256, __warp_7_pt2yy : Uint256){
    alloc_locals;


        
        let __warp_rc_8 = 0;
        
            
            let (__warp_tv_21, __warp_tv_22, __warp_tv_23, __warp_tv_24) = __warp_conditional___warp_conditional_ECTwistAdd_61a931ec_7_9(__warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx);
            
            let __warp_6_pt2yx = __warp_tv_24;
            
            let __warp_5_pt2xy = __warp_tv_23;
            
            let __warp_4_pt2xx = __warp_tv_22;
            
            let __warp_rc_8 = __warp_tv_21;
        
        if (__warp_rc_8 != 0){
        
            
            let (__warp_se_23) = warp_eq256(__warp_7_pt2yy, Uint256(low=0, high=0));
            
            let __warp_rc_6 = __warp_se_23;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            let __warp_6_pt2yx = __warp_6_pt2yx;
            
            let __warp_7_pt2yy = __warp_7_pt2yy;
            
            
            
            return (__warp_rc_6, __warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx, __warp_7_pt2yy);
        }else{
        
            
            let __warp_rc_6 = 0;
            
            let __warp_rc_6 = __warp_rc_6;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            let __warp_6_pt2yx = __warp_6_pt2yx;
            
            let __warp_7_pt2yy = __warp_7_pt2yy;
            
            
            
            return (__warp_rc_6, __warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx, __warp_7_pt2yy);
        }

    }


    func __warp_conditional___warp_conditional___warp_conditional_ECTwistAdd_61a931ec_13_15_17{range_check_ptr : felt}(__warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256)-> (__warp_rc_16 : felt, __warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256){
    alloc_locals;


        
        let (__warp_se_24) = warp_eq256(__warp_4_pt2xx, Uint256(low=0, high=0));
        
        if (__warp_se_24 != 0){
        
            
            let (__warp_se_25) = warp_eq256(__warp_5_pt2xy, Uint256(low=0, high=0));
            
            let __warp_rc_16 = __warp_se_25;
            
            let __warp_rc_16 = __warp_rc_16;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            
            
            return (__warp_rc_16, __warp_4_pt2xx, __warp_5_pt2xy);
        }else{
        
            
            let __warp_rc_16 = 0;
            
            let __warp_rc_16 = __warp_rc_16;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            
            
            return (__warp_rc_16, __warp_4_pt2xx, __warp_5_pt2xy);
        }

    }


    func __warp_conditional___warp_conditional_ECTwistAdd_61a931ec_13_15{range_check_ptr : felt}(__warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256, __warp_6_pt2yx : Uint256)-> (__warp_rc_14 : felt, __warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256, __warp_6_pt2yx : Uint256){
    alloc_locals;


        
        let __warp_rc_16 = 0;
        
            
            let (__warp_tv_30, __warp_tv_31, __warp_tv_32) = __warp_conditional___warp_conditional___warp_conditional_ECTwistAdd_61a931ec_13_15_17(__warp_4_pt2xx, __warp_5_pt2xy);
            
            let __warp_5_pt2xy = __warp_tv_32;
            
            let __warp_4_pt2xx = __warp_tv_31;
            
            let __warp_rc_16 = __warp_tv_30;
        
        if (__warp_rc_16 != 0){
        
            
            let (__warp_se_26) = warp_eq256(__warp_6_pt2yx, Uint256(low=0, high=0));
            
            let __warp_rc_14 = __warp_se_26;
            
            let __warp_rc_14 = __warp_rc_14;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            let __warp_6_pt2yx = __warp_6_pt2yx;
            
            
            
            return (__warp_rc_14, __warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx);
        }else{
        
            
            let __warp_rc_14 = 0;
            
            let __warp_rc_14 = __warp_rc_14;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            let __warp_6_pt2yx = __warp_6_pt2yx;
            
            
            
            return (__warp_rc_14, __warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx);
        }

    }


    func __warp_conditional_ECTwistAdd_61a931ec_13{range_check_ptr : felt}(__warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256, __warp_6_pt2yx : Uint256, __warp_7_pt2yy : Uint256)-> (__warp_rc_12 : felt, __warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256, __warp_6_pt2yx : Uint256, __warp_7_pt2yy : Uint256){
    alloc_locals;


        
        let __warp_rc_14 = 0;
        
            
            let (__warp_tv_33, __warp_tv_34, __warp_tv_35, __warp_tv_36) = __warp_conditional___warp_conditional_ECTwistAdd_61a931ec_13_15(__warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx);
            
            let __warp_6_pt2yx = __warp_tv_36;
            
            let __warp_5_pt2xy = __warp_tv_35;
            
            let __warp_4_pt2xx = __warp_tv_34;
            
            let __warp_rc_14 = __warp_tv_33;
        
        if (__warp_rc_14 != 0){
        
            
            let (__warp_se_27) = warp_eq256(__warp_7_pt2yy, Uint256(low=0, high=0));
            
            let __warp_rc_12 = __warp_se_27;
            
            let __warp_rc_12 = __warp_rc_12;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            let __warp_6_pt2yx = __warp_6_pt2yx;
            
            let __warp_7_pt2yy = __warp_7_pt2yy;
            
            
            
            return (__warp_rc_12, __warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx, __warp_7_pt2yy);
        }else{
        
            
            let __warp_rc_12 = 0;
            
            let __warp_rc_12 = __warp_rc_12;
            
            let __warp_4_pt2xx = __warp_4_pt2xx;
            
            let __warp_5_pt2xy = __warp_5_pt2xy;
            
            let __warp_6_pt2yx = __warp_6_pt2yx;
            
            let __warp_7_pt2yy = __warp_7_pt2yy;
            
            
            
            return (__warp_rc_12, __warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx, __warp_7_pt2yy);
        }

    }


    func __warp_conditional___warp_conditional___warp_conditional_ECTwistMul_b73ab75d_19_21_23{range_check_ptr : felt}(__warp_14_pt1xx : Uint256, __warp_15_pt1xy : Uint256)-> (__warp_rc_22 : felt, __warp_14_pt1xx : Uint256, __warp_15_pt1xy : Uint256){
    alloc_locals;


        
        let (__warp_se_40) = warp_eq256(__warp_14_pt1xx, Uint256(low=0, high=0));
        
        if (__warp_se_40 != 0){
        
            
            let (__warp_se_41) = warp_eq256(__warp_15_pt1xy, Uint256(low=0, high=0));
            
            let __warp_rc_22 = __warp_se_41;
            
            let __warp_rc_22 = __warp_rc_22;
            
            let __warp_14_pt1xx = __warp_14_pt1xx;
            
            let __warp_15_pt1xy = __warp_15_pt1xy;
            
            
            
            return (__warp_rc_22, __warp_14_pt1xx, __warp_15_pt1xy);
        }else{
        
            
            let __warp_rc_22 = 0;
            
            let __warp_rc_22 = __warp_rc_22;
            
            let __warp_14_pt1xx = __warp_14_pt1xx;
            
            let __warp_15_pt1xy = __warp_15_pt1xy;
            
            
            
            return (__warp_rc_22, __warp_14_pt1xx, __warp_15_pt1xy);
        }

    }


    func __warp_conditional___warp_conditional_ECTwistMul_b73ab75d_19_21{range_check_ptr : felt}(__warp_14_pt1xx : Uint256, __warp_15_pt1xy : Uint256, __warp_16_pt1yx : Uint256)-> (__warp_rc_20 : felt, __warp_14_pt1xx : Uint256, __warp_15_pt1xy : Uint256, __warp_16_pt1yx : Uint256){
    alloc_locals;


        
        let __warp_rc_22 = 0;
        
            
            let (__warp_tv_42, __warp_tv_43, __warp_tv_44) = __warp_conditional___warp_conditional___warp_conditional_ECTwistMul_b73ab75d_19_21_23(__warp_14_pt1xx, __warp_15_pt1xy);
            
            let __warp_15_pt1xy = __warp_tv_44;
            
            let __warp_14_pt1xx = __warp_tv_43;
            
            let __warp_rc_22 = __warp_tv_42;
        
        if (__warp_rc_22 != 0){
        
            
            let (__warp_se_42) = warp_eq256(__warp_16_pt1yx, Uint256(low=0, high=0));
            
            let __warp_rc_20 = __warp_se_42;
            
            let __warp_rc_20 = __warp_rc_20;
            
            let __warp_14_pt1xx = __warp_14_pt1xx;
            
            let __warp_15_pt1xy = __warp_15_pt1xy;
            
            let __warp_16_pt1yx = __warp_16_pt1yx;
            
            
            
            return (__warp_rc_20, __warp_14_pt1xx, __warp_15_pt1xy, __warp_16_pt1yx);
        }else{
        
            
            let __warp_rc_20 = 0;
            
            let __warp_rc_20 = __warp_rc_20;
            
            let __warp_14_pt1xx = __warp_14_pt1xx;
            
            let __warp_15_pt1xy = __warp_15_pt1xy;
            
            let __warp_16_pt1yx = __warp_16_pt1yx;
            
            
            
            return (__warp_rc_20, __warp_14_pt1xx, __warp_15_pt1xy, __warp_16_pt1yx);
        }

    }


    func __warp_conditional_ECTwistMul_b73ab75d_19{range_check_ptr : felt}(__warp_14_pt1xx : Uint256, __warp_15_pt1xy : Uint256, __warp_16_pt1yx : Uint256, __warp_17_pt1yy : Uint256)-> (__warp_rc_18 : felt, __warp_14_pt1xx : Uint256, __warp_15_pt1xy : Uint256, __warp_16_pt1yx : Uint256, __warp_17_pt1yy : Uint256){
    alloc_locals;


        
        let __warp_rc_20 = 0;
        
            
            let (__warp_tv_45, __warp_tv_46, __warp_tv_47, __warp_tv_48) = __warp_conditional___warp_conditional_ECTwistMul_b73ab75d_19_21(__warp_14_pt1xx, __warp_15_pt1xy, __warp_16_pt1yx);
            
            let __warp_16_pt1yx = __warp_tv_48;
            
            let __warp_15_pt1xy = __warp_tv_47;
            
            let __warp_14_pt1xx = __warp_tv_46;
            
            let __warp_rc_20 = __warp_tv_45;
        
        if (__warp_rc_20 != 0){
        
            
            let (__warp_se_43) = warp_eq256(__warp_17_pt1yy, Uint256(low=0, high=0));
            
            let __warp_rc_18 = __warp_se_43;
            
            let __warp_rc_18 = __warp_rc_18;
            
            let __warp_14_pt1xx = __warp_14_pt1xx;
            
            let __warp_15_pt1xy = __warp_15_pt1xy;
            
            let __warp_16_pt1yx = __warp_16_pt1yx;
            
            let __warp_17_pt1yy = __warp_17_pt1yy;
            
            
            
            return (__warp_rc_18, __warp_14_pt1xx, __warp_15_pt1xy, __warp_16_pt1yx, __warp_17_pt1yy);
        }else{
        
            
            let __warp_rc_18 = 0;
            
            let __warp_rc_18 = __warp_rc_18;
            
            let __warp_14_pt1xx = __warp_14_pt1xx;
            
            let __warp_15_pt1xy = __warp_15_pt1xy;
            
            let __warp_16_pt1yx = __warp_16_pt1yx;
            
            let __warp_17_pt1yy = __warp_17_pt1yy;
            
            
            
            return (__warp_rc_18, __warp_14_pt1xx, __warp_15_pt1xy, __warp_16_pt1yx, __warp_17_pt1yy);
        }

    }


    func submod_40c91c05{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_25_a : Uint256, __warp_26_b : Uint256, __warp_27_n : Uint256)-> (__warp_28 : Uint256){
    alloc_locals;


        
        let (__warp_se_56) = warp_sub256(__warp_27_n, __warp_26_b);
        
        let (__warp_se_57) = warp_addmod(__warp_25_a, __warp_se_56, __warp_27_n);
        
        
        
        return (__warp_se_57,);

    }


    func _FQ2Mul_f7835b96{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_29_xx : Uint256, __warp_30_xy : Uint256, __warp_31_yx : Uint256, __warp_32_yy : Uint256)-> (__warp_33 : Uint256, __warp_34 : Uint256){
    alloc_locals;


        
        let (__warp_se_58) = warp_mulmod(__warp_29_xx, __warp_31_yx, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_se_59) = warp_mulmod(__warp_30_xy, __warp_32_yy, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_pse_6) = submod_40c91c05(__warp_se_58, __warp_se_59, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let __warp_33 = __warp_pse_6;
        
        let (__warp_se_60) = warp_mulmod(__warp_29_xx, __warp_32_yy, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_se_61) = warp_mulmod(__warp_30_xy, __warp_31_yx, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_34) = warp_addmod(__warp_se_60, __warp_se_61, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        
        
        return (__warp_33, __warp_34);

    }


    func _FQ2Muc_3fc7e233{range_check_ptr}(__warp_35_xx : Uint256, __warp_36_xy : Uint256, __warp_37_c : Uint256)-> (__warp_38 : Uint256, __warp_39 : Uint256){
    alloc_locals;


        
        let (__warp_38) = warp_mulmod(__warp_35_xx, __warp_37_c, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_39) = warp_mulmod(__warp_36_xy, __warp_37_c, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        
        
        return (__warp_38, __warp_39);

    }


    func _FQ2Sub_16265402{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_46_xx : Uint256, __warp_47_xy : Uint256, __warp_48_yx : Uint256, __warp_49_yy : Uint256)-> (rx : Uint256, ry : Uint256){
    alloc_locals;


        
        let (__warp_pse_7) = submod_40c91c05(__warp_46_xx, __warp_48_yx, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_pse_8) = submod_40c91c05(__warp_47_xy, __warp_49_yy, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let rx = __warp_pse_7;
        
        let ry = __warp_pse_8;
        
        
        
        return (rx, ry);

    }


    func _FQ2Inv_41f7deb8{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_56_x : Uint256, __warp_57_y : Uint256)-> (__warp_58 : Uint256, __warp_59 : Uint256){
    alloc_locals;


        
        let (__warp_se_62) = warp_mulmod(__warp_57_y, __warp_57_y, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_se_63) = warp_mulmod(__warp_56_x, __warp_56_x, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_se_64) = warp_addmod(__warp_se_62, __warp_se_63, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_60_inv) = _modInv_11923dc3(__warp_se_64, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_58) = warp_mulmod(__warp_56_x, __warp_60_inv, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_se_65) = warp_mulmod(__warp_57_y, __warp_60_inv, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        let (__warp_59) = warp_sub256(Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389), __warp_se_65);
        
        
        
        return (__warp_58, __warp_59);

    }


    func __warp_conditional__isOnCurve_140fcd99_25{range_check_ptr : felt}(__warp_66_yyx : Uint256, __warp_67_yyy : Uint256)-> (__warp_rc_24 : felt, __warp_66_yyx : Uint256, __warp_67_yyy : Uint256){
    alloc_locals;


        
        let (__warp_se_66) = warp_eq256(__warp_66_yyx, Uint256(low=0, high=0));
        
        if (__warp_se_66 != 0){
        
            
            let (__warp_se_67) = warp_eq256(__warp_67_yyy, Uint256(low=0, high=0));
            
            let __warp_rc_24 = __warp_se_67;
            
            let __warp_rc_24 = __warp_rc_24;
            
            let __warp_66_yyx = __warp_66_yyx;
            
            let __warp_67_yyy = __warp_67_yyy;
            
            
            
            return (__warp_rc_24, __warp_66_yyx, __warp_67_yyy);
        }else{
        
            
            let __warp_rc_24 = 0;
            
            let __warp_rc_24 = __warp_rc_24;
            
            let __warp_66_yyx = __warp_66_yyx;
            
            let __warp_67_yyy = __warp_67_yyy;
            
            
            
            return (__warp_rc_24, __warp_66_yyx, __warp_67_yyy);
        }

    }


    func _isOnCurve_140fcd99{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_61_xx : Uint256, __warp_62_xy : Uint256, __warp_63_yx : Uint256, __warp_64_yy : Uint256)-> (__warp_65 : felt){
    alloc_locals;


        
        let __warp_66_yyx = Uint256(low=0, high=0);
        
        let __warp_67_yyy = Uint256(low=0, high=0);
        
        let __warp_68_xxxx = Uint256(low=0, high=0);
        
        let __warp_69_xxxy = Uint256(low=0, high=0);
        
            
            let (__warp_tv_56, __warp_tv_57) = _FQ2Mul_f7835b96(__warp_63_yx, __warp_64_yy, __warp_63_yx, __warp_64_yy);
            
            let __warp_67_yyy = __warp_tv_57;
            
            let __warp_66_yyx = __warp_tv_56;
        
            
            let (__warp_tv_58, __warp_tv_59) = _FQ2Mul_f7835b96(__warp_61_xx, __warp_62_xy, __warp_61_xx, __warp_62_xy);
            
            let __warp_69_xxxy = __warp_tv_59;
            
            let __warp_68_xxxx = __warp_tv_58;
        
            
            let (__warp_tv_60, __warp_tv_61) = _FQ2Mul_f7835b96(__warp_68_xxxx, __warp_69_xxxy, __warp_61_xx, __warp_62_xy);
            
            let __warp_69_xxxy = __warp_tv_61;
            
            let __warp_68_xxxx = __warp_tv_60;
        
            
            let (__warp_tv_62, __warp_tv_63) = _FQ2Sub_16265402(__warp_66_yyx, __warp_67_yyy, __warp_68_xxxx, __warp_69_xxxy);
            
            let __warp_67_yyy = __warp_tv_63;
            
            let __warp_66_yyx = __warp_tv_62;
        
            
            let (__warp_tv_64, __warp_tv_65) = _FQ2Sub_16265402(__warp_66_yyx, __warp_67_yyy, Uint256(low=241528894477357229398967524003378444517, high=57263839228809413707999148736847571651), Uint256(low=222394522462485822084624302373924443602, high=784436153819307037095878749819829748));
            
            let __warp_67_yyy = __warp_tv_65;
            
            let __warp_66_yyx = __warp_tv_64;
        
        let __warp_rc_24 = 0;
        
            
            let (__warp_tv_66, __warp_tv_67, __warp_tv_68) = __warp_conditional__isOnCurve_140fcd99_25(__warp_66_yyx, __warp_67_yyy);
            
            let __warp_67_yyy = __warp_tv_68;
            
            let __warp_66_yyx = __warp_tv_67;
            
            let __warp_rc_24 = __warp_tv_66;
        
        
        
        return (__warp_rc_24,);

    }




    func _modInv_11923dc3{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(a : Uint256, div : Uint256)-> (result : Uint256){
    alloc_locals;
    local res: Uint256;
    %{
        a = (ids.a.high << 128) + ids.a.low
        div = (ids.div.high << 128) + ids.div.low
        res = pow(a, -1, div)
        ids.res.low = res & ((1 << 128) - 1)
        ids.res.high = res >> 128
    %}
    let (quotient_low, quotient_high, remainder) = uint256_mul_div_mod(a,res,div);
    assert Uint256(low=1,high=0) = (remainder);
    return (result=res);
    }


    func _fromJacobian_000265f8{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_75_pt1xx : Uint256, __warp_76_pt1xy : Uint256, __warp_77_pt1yx : Uint256, __warp_78_pt1yy : Uint256, __warp_79_pt1zx : Uint256, __warp_80_pt1zy : Uint256)-> (__warp_81_pt2xx : Uint256, __warp_82_pt2xy : Uint256, __warp_83_pt2yx : Uint256, __warp_84_pt2yy : Uint256){
    alloc_locals;


        
        let __warp_84_pt2yy = Uint256(low=0, high=0);
        
        let __warp_83_pt2yx = Uint256(low=0, high=0);
        
        let __warp_82_pt2xy = Uint256(low=0, high=0);
        
        let __warp_81_pt2xx = Uint256(low=0, high=0);
        
        let __warp_85_invzx = Uint256(low=0, high=0);
        
        let __warp_86_invzy = Uint256(low=0, high=0);
        
            
            let (__warp_tv_69, __warp_tv_70) = _FQ2Inv_41f7deb8(__warp_79_pt1zx, __warp_80_pt1zy);
            
            let __warp_86_invzy = __warp_tv_70;
            
            let __warp_85_invzx = __warp_tv_69;
        
            
            let (__warp_tv_71, __warp_tv_72) = _FQ2Mul_f7835b96(__warp_75_pt1xx, __warp_76_pt1xy, __warp_85_invzx, __warp_86_invzy);
            
            let __warp_82_pt2xy = __warp_tv_72;
            
            let __warp_81_pt2xx = __warp_tv_71;
        
            
            let (__warp_tv_73, __warp_tv_74) = _FQ2Mul_f7835b96(__warp_77_pt1yx, __warp_78_pt1yy, __warp_85_invzx, __warp_86_invzy);
            
            let __warp_84_pt2yy = __warp_tv_74;
            
            let __warp_83_pt2yx = __warp_tv_73;
        
        let __warp_81_pt2xx = __warp_81_pt2xx;
        
        let __warp_82_pt2xy = __warp_82_pt2xy;
        
        let __warp_83_pt2yx = __warp_83_pt2yx;
        
        let __warp_84_pt2yy = __warp_84_pt2yy;
        
        
        
        return (__warp_81_pt2xx, __warp_82_pt2xy, __warp_83_pt2yx, __warp_84_pt2yy);

    }


    func __warp_conditional__ECTwistAddJacobian_4a863fe0_27{range_check_ptr : felt}(__warp_91_pt1zx : Uint256, __warp_92_pt1zy : Uint256)-> (__warp_rc_26 : felt, __warp_91_pt1zx : Uint256, __warp_92_pt1zy : Uint256){
    alloc_locals;


        
        let (__warp_se_71) = warp_eq256(__warp_91_pt1zx, Uint256(low=0, high=0));
        
        if (__warp_se_71 != 0){
        
            
            let (__warp_se_72) = warp_eq256(__warp_92_pt1zy, Uint256(low=0, high=0));
            
            let __warp_rc_26 = __warp_se_72;
            
            let __warp_rc_26 = __warp_rc_26;
            
            let __warp_91_pt1zx = __warp_91_pt1zx;
            
            let __warp_92_pt1zy = __warp_92_pt1zy;
            
            
            
            return (__warp_rc_26, __warp_91_pt1zx, __warp_92_pt1zy);
        }else{
        
            
            let __warp_rc_26 = 0;
            
            let __warp_rc_26 = __warp_rc_26;
            
            let __warp_91_pt1zx = __warp_91_pt1zx;
            
            let __warp_92_pt1zy = __warp_92_pt1zy;
            
            
            
            return (__warp_rc_26, __warp_91_pt1zx, __warp_92_pt1zy);
        }

    }


    func __warp_conditional__ECTwistAddJacobian_4a863fe0_29{range_check_ptr : felt}(__warp_97_pt2zx : Uint256, __warp_98_pt2zy : Uint256)-> (__warp_rc_28 : felt, __warp_97_pt2zx : Uint256, __warp_98_pt2zy : Uint256){
    alloc_locals;


        
        let (__warp_se_73) = warp_eq256(__warp_97_pt2zx, Uint256(low=0, high=0));
        
        if (__warp_se_73 != 0){
        
            
            let (__warp_se_74) = warp_eq256(__warp_98_pt2zy, Uint256(low=0, high=0));
            
            let __warp_rc_28 = __warp_se_74;
            
            let __warp_rc_28 = __warp_rc_28;
            
            let __warp_97_pt2zx = __warp_97_pt2zx;
            
            let __warp_98_pt2zy = __warp_98_pt2zy;
            
            
            
            return (__warp_rc_28, __warp_97_pt2zx, __warp_98_pt2zy);
        }else{
        
            
            let __warp_rc_28 = 0;
            
            let __warp_rc_28 = __warp_rc_28;
            
            let __warp_97_pt2zx = __warp_97_pt2zx;
            
            let __warp_98_pt2zy = __warp_98_pt2zy;
            
            
            
            return (__warp_rc_28, __warp_97_pt2zx, __warp_98_pt2zy);
        }

    }


    func __warp_conditional__ECTwistAddJacobian_4a863fe0_31{range_check_ptr : felt, warp_memory : DictAccess*}(__warp_93_pt2xx : Uint256, __warp_99_pt3 : felt, __warp_94_pt2xy : Uint256)-> (__warp_rc_30 : felt, __warp_93_pt2xx : Uint256, __warp_99_pt3 : felt, __warp_94_pt2xy : Uint256){
    alloc_locals;


        
        let (__warp_se_75) = wm_index_static(__warp_99_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_76) = wm_read_256(__warp_se_75);
        
        let (__warp_se_77) = warp_eq256(__warp_93_pt2xx, __warp_se_76);
        
        if (__warp_se_77 != 0){
        
            
            let (__warp_se_78) = wm_index_static(__warp_99_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_79) = wm_read_256(__warp_se_78);
            
            let (__warp_se_80) = warp_eq256(__warp_94_pt2xy, __warp_se_79);
            
            let __warp_rc_30 = __warp_se_80;
            
            let __warp_rc_30 = __warp_rc_30;
            
            let __warp_93_pt2xx = __warp_93_pt2xx;
            
            let __warp_99_pt3 = __warp_99_pt3;
            
            let __warp_94_pt2xy = __warp_94_pt2xy;
            
            
            
            return (__warp_rc_30, __warp_93_pt2xx, __warp_99_pt3, __warp_94_pt2xy);
        }else{
        
            
            let __warp_rc_30 = 0;
            
            let __warp_rc_30 = __warp_rc_30;
            
            let __warp_93_pt2xx = __warp_93_pt2xx;
            
            let __warp_99_pt3 = __warp_99_pt3;
            
            let __warp_94_pt2xy = __warp_94_pt2xy;
            
            
            
            return (__warp_rc_30, __warp_93_pt2xx, __warp_99_pt3, __warp_94_pt2xy);
        }

    }


    func __warp_conditional__ECTwistAddJacobian_4a863fe0_33{range_check_ptr : felt, warp_memory : DictAccess*}(__warp_95_pt2yx : Uint256, __warp_99_pt3 : felt, __warp_96_pt2yy : Uint256)-> (__warp_rc_32 : felt, __warp_95_pt2yx : Uint256, __warp_99_pt3 : felt, __warp_96_pt2yy : Uint256){
    alloc_locals;


        
        let (__warp_se_81) = wm_index_static(__warp_99_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_82) = wm_read_256(__warp_se_81);
        
        let (__warp_se_83) = warp_eq256(__warp_95_pt2yx, __warp_se_82);
        
        if (__warp_se_83 != 0){
        
            
            let (__warp_se_84) = wm_index_static(__warp_99_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_85) = wm_read_256(__warp_se_84);
            
            let (__warp_se_86) = warp_eq256(__warp_96_pt2yy, __warp_se_85);
            
            let __warp_rc_32 = __warp_se_86;
            
            let __warp_rc_32 = __warp_rc_32;
            
            let __warp_95_pt2yx = __warp_95_pt2yx;
            
            let __warp_99_pt3 = __warp_99_pt3;
            
            let __warp_96_pt2yy = __warp_96_pt2yy;
            
            
            
            return (__warp_rc_32, __warp_95_pt2yx, __warp_99_pt3, __warp_96_pt2yy);
        }else{
        
            
            let __warp_rc_32 = 0;
            
            let __warp_rc_32 = __warp_rc_32;
            
            let __warp_95_pt2yx = __warp_95_pt2yx;
            
            let __warp_99_pt3 = __warp_99_pt3;
            
            let __warp_96_pt2yy = __warp_96_pt2yy;
            
            
            
            return (__warp_rc_32, __warp_95_pt2yx, __warp_99_pt3, __warp_96_pt2yy);
        }

    }


    func _ECTwistAddJacobian_4a863fe0{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_87_pt1xx : Uint256, __warp_88_pt1xy : Uint256, __warp_89_pt1yx : Uint256, __warp_90_pt1yy : Uint256, __warp_91_pt1zx : Uint256, __warp_92_pt1zy : Uint256, __warp_93_pt2xx : Uint256, __warp_94_pt2xy : Uint256, __warp_95_pt2yx : Uint256, __warp_96_pt2yy : Uint256, __warp_97_pt2zx : Uint256, __warp_98_pt2zy : Uint256)-> (__warp_99_pt3 : felt){
    alloc_locals;


        
        let (__warp_99_pt3) = WM0_s_arr(Uint256(low=0, high=0), Uint256(low=0, high=0), Uint256(low=0, high=0), Uint256(low=0, high=0), Uint256(low=0, high=0), Uint256(low=0, high=0));
        
        let __warp_rc_26 = 0;
        
            
            let (__warp_tv_75, __warp_tv_76, __warp_tv_77) = __warp_conditional__ECTwistAddJacobian_4a863fe0_27(__warp_91_pt1zx, __warp_92_pt1zy);
            
            let __warp_92_pt1zy = __warp_tv_77;
            
            let __warp_91_pt1zx = __warp_tv_76;
            
            let __warp_rc_26 = __warp_tv_75;
        
            
            if (__warp_rc_26 != 0){
            
                
                    
                    let __warp_tv_78 = __warp_93_pt2xx;
                    
                    let __warp_tv_79 = __warp_94_pt2xy;
                    
                    let __warp_tv_80 = __warp_95_pt2yx;
                    
                    let __warp_tv_81 = __warp_96_pt2yy;
                    
                    let __warp_tv_82 = __warp_97_pt2zx;
                    
                    let __warp_tv_83 = __warp_98_pt2zy;
                    
                    let (__warp_se_87) = wm_index_static(__warp_99_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_87, __warp_tv_83);
                    
                    let (__warp_se_88) = wm_index_static(__warp_99_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_88, __warp_tv_82);
                    
                    let (__warp_se_89) = wm_index_static(__warp_99_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_89, __warp_tv_81);
                    
                    let (__warp_se_90) = wm_index_static(__warp_99_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_90, __warp_tv_80);
                    
                    let (__warp_se_91) = wm_index_static(__warp_99_pt3, Uint256(low=1, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_91, __warp_tv_79);
                    
                    let (__warp_se_92) = wm_index_static(__warp_99_pt3, Uint256(low=0, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_92, __warp_tv_78);
                
                
                
                return (__warp_99_pt3,);
            }else{
            
                
                let __warp_rc_28 = 0;
                
                    
                    let (__warp_tv_84, __warp_tv_85, __warp_tv_86) = __warp_conditional__ECTwistAddJacobian_4a863fe0_29(__warp_97_pt2zx, __warp_98_pt2zy);
                    
                    let __warp_98_pt2zy = __warp_tv_86;
                    
                    let __warp_97_pt2zx = __warp_tv_85;
                    
                    let __warp_rc_28 = __warp_tv_84;
                
                    
                    if (__warp_rc_28 != 0){
                    
                        
                            
                            let __warp_tv_87 = __warp_87_pt1xx;
                            
                            let __warp_tv_88 = __warp_88_pt1xy;
                            
                            let __warp_tv_89 = __warp_89_pt1yx;
                            
                            let __warp_tv_90 = __warp_90_pt1yy;
                            
                            let __warp_tv_91 = __warp_91_pt1zx;
                            
                            let __warp_tv_92 = __warp_92_pt1zy;
                            
                            let (__warp_se_93) = wm_index_static(__warp_99_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_93, __warp_tv_92);
                            
                            let (__warp_se_94) = wm_index_static(__warp_99_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_94, __warp_tv_91);
                            
                            let (__warp_se_95) = wm_index_static(__warp_99_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_95, __warp_tv_90);
                            
                            let (__warp_se_96) = wm_index_static(__warp_99_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_96, __warp_tv_89);
                            
                            let (__warp_se_97) = wm_index_static(__warp_99_pt3, Uint256(low=1, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_97, __warp_tv_88);
                            
                            let (__warp_se_98) = wm_index_static(__warp_99_pt3, Uint256(low=0, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_98, __warp_tv_87);
                        
                        
                        
                        return (__warp_99_pt3,);
                    }else{
                    
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar __warp_99_pt3 = __warp_99_pt3;
                        tempvar __warp_89_pt1yx = __warp_89_pt1yx;
                        tempvar __warp_90_pt1yy = __warp_90_pt1yy;
                        tempvar __warp_87_pt1xx = __warp_87_pt1xx;
                        tempvar __warp_88_pt1xy = __warp_88_pt1xy;
                        tempvar __warp_91_pt1zx = __warp_91_pt1zx;
                        tempvar __warp_92_pt1zy = __warp_92_pt1zy;
                        tempvar __warp_95_pt2yx = __warp_95_pt2yx;
                        tempvar __warp_96_pt2yy = __warp_96_pt2yy;
                        tempvar __warp_93_pt2xx = __warp_93_pt2xx;
                        tempvar __warp_94_pt2xy = __warp_94_pt2xy;
                        tempvar __warp_97_pt2zx = __warp_97_pt2zx;
                        tempvar __warp_98_pt2zy = __warp_98_pt2zy;
                    }
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_99_pt3 = __warp_99_pt3;
                    tempvar __warp_89_pt1yx = __warp_89_pt1yx;
                    tempvar __warp_90_pt1yy = __warp_90_pt1yy;
                    tempvar __warp_87_pt1xx = __warp_87_pt1xx;
                    tempvar __warp_88_pt1xy = __warp_88_pt1xy;
                    tempvar __warp_91_pt1zx = __warp_91_pt1zx;
                    tempvar __warp_92_pt1zy = __warp_92_pt1zy;
                    tempvar __warp_95_pt2yx = __warp_95_pt2yx;
                    tempvar __warp_96_pt2yy = __warp_96_pt2yy;
                    tempvar __warp_93_pt2xx = __warp_93_pt2xx;
                    tempvar __warp_94_pt2xy = __warp_94_pt2xy;
                    tempvar __warp_97_pt2zx = __warp_97_pt2zx;
                    tempvar __warp_98_pt2zy = __warp_98_pt2zy;
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_99_pt3 = __warp_99_pt3;
                tempvar __warp_89_pt1yx = __warp_89_pt1yx;
                tempvar __warp_90_pt1yy = __warp_90_pt1yy;
                tempvar __warp_87_pt1xx = __warp_87_pt1xx;
                tempvar __warp_88_pt1xy = __warp_88_pt1xy;
                tempvar __warp_91_pt1zx = __warp_91_pt1zx;
                tempvar __warp_92_pt1zy = __warp_92_pt1zy;
                tempvar __warp_95_pt2yx = __warp_95_pt2yx;
                tempvar __warp_96_pt2yy = __warp_96_pt2yy;
                tempvar __warp_93_pt2xx = __warp_93_pt2xx;
                tempvar __warp_94_pt2xy = __warp_94_pt2xy;
                tempvar __warp_97_pt2zx = __warp_97_pt2zx;
                tempvar __warp_98_pt2zy = __warp_98_pt2zy;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar warp_memory = warp_memory;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar __warp_99_pt3 = __warp_99_pt3;
            tempvar __warp_89_pt1yx = __warp_89_pt1yx;
            tempvar __warp_90_pt1yy = __warp_90_pt1yy;
            tempvar __warp_87_pt1xx = __warp_87_pt1xx;
            tempvar __warp_88_pt1xy = __warp_88_pt1xy;
            tempvar __warp_91_pt1zx = __warp_91_pt1zx;
            tempvar __warp_92_pt1zy = __warp_92_pt1zy;
            tempvar __warp_95_pt2yx = __warp_95_pt2yx;
            tempvar __warp_96_pt2yy = __warp_96_pt2yy;
            tempvar __warp_93_pt2xx = __warp_93_pt2xx;
            tempvar __warp_94_pt2xy = __warp_94_pt2xy;
            tempvar __warp_97_pt2zx = __warp_97_pt2zx;
            tempvar __warp_98_pt2zy = __warp_98_pt2zy;
        
            
            let (__warp_tv_93, __warp_tv_94) = _FQ2Mul_f7835b96(__warp_95_pt2yx, __warp_96_pt2yy, __warp_91_pt1zx, __warp_92_pt1zy);
            
            let __warp_96_pt2yy = __warp_tv_94;
            
            let __warp_95_pt2yx = __warp_tv_93;
        
            
            let (__warp_tv_95, __warp_tv_96) = _FQ2Mul_f7835b96(__warp_89_pt1yx, __warp_90_pt1yy, __warp_97_pt2zx, __warp_98_pt2zy);
            
            let (__warp_se_99) = wm_index_static(__warp_99_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_99, __warp_tv_96);
            
            let (__warp_se_100) = wm_index_static(__warp_99_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_100, __warp_tv_95);
        
            
            let (__warp_tv_97, __warp_tv_98) = _FQ2Mul_f7835b96(__warp_93_pt2xx, __warp_94_pt2xy, __warp_91_pt1zx, __warp_92_pt1zy);
            
            let __warp_94_pt2xy = __warp_tv_98;
            
            let __warp_93_pt2xx = __warp_tv_97;
        
            
            let (__warp_tv_99, __warp_tv_100) = _FQ2Mul_f7835b96(__warp_87_pt1xx, __warp_88_pt1xy, __warp_97_pt2zx, __warp_98_pt2zy);
            
            let (__warp_se_101) = wm_index_static(__warp_99_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_101, __warp_tv_100);
            
            let (__warp_se_102) = wm_index_static(__warp_99_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_102, __warp_tv_99);
        
        let __warp_rc_30 = 0;
        
            
            let (__warp_tv_101, __warp_tv_102, __warp_td_1, __warp_tv_104) = __warp_conditional__ECTwistAddJacobian_4a863fe0_31(__warp_93_pt2xx, __warp_99_pt3, __warp_94_pt2xy);
            
            let __warp_tv_103 = __warp_td_1;
            
            let __warp_94_pt2xy = __warp_tv_104;
            
            let __warp_99_pt3 = __warp_tv_103;
            
            let __warp_93_pt2xx = __warp_tv_102;
            
            let __warp_rc_30 = __warp_tv_101;
        
            
            if (__warp_rc_30 != 0){
            
                
                let __warp_rc_32 = 0;
                
                    
                    let (__warp_tv_105, __warp_tv_106, __warp_td_2, __warp_tv_108) = __warp_conditional__ECTwistAddJacobian_4a863fe0_33(__warp_95_pt2yx, __warp_99_pt3, __warp_96_pt2yy);
                    
                    let __warp_tv_107 = __warp_td_2;
                    
                    let __warp_96_pt2yy = __warp_tv_108;
                    
                    let __warp_99_pt3 = __warp_tv_107;
                    
                    let __warp_95_pt2yx = __warp_tv_106;
                    
                    let __warp_rc_32 = __warp_tv_105;
                
                    
                    if (__warp_rc_32 != 0){
                    
                        
                            
                            let (__warp_tv_109, __warp_tv_110, __warp_tv_111, __warp_tv_112, __warp_tv_113, __warp_tv_114) = _ECTwistDoubleJacobian_f2664d9a(__warp_87_pt1xx, __warp_88_pt1xy, __warp_89_pt1yx, __warp_90_pt1yy, __warp_91_pt1zx, __warp_92_pt1zy);
                            
                            let (__warp_se_103) = wm_index_static(__warp_99_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_103, __warp_tv_114);
                            
                            let (__warp_se_104) = wm_index_static(__warp_99_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_104, __warp_tv_113);
                            
                            let (__warp_se_105) = wm_index_static(__warp_99_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_105, __warp_tv_112);
                            
                            let (__warp_se_106) = wm_index_static(__warp_99_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_106, __warp_tv_111);
                            
                            let (__warp_se_107) = wm_index_static(__warp_99_pt3, Uint256(low=1, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_107, __warp_tv_110);
                            
                            let (__warp_se_108) = wm_index_static(__warp_99_pt3, Uint256(low=0, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                            
                            wm_write_256(__warp_se_108, __warp_tv_109);
                        
                        
                        
                        return (__warp_99_pt3,);
                    }else{
                    
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar __warp_99_pt3 = __warp_99_pt3;
                        tempvar __warp_89_pt1yx = __warp_89_pt1yx;
                        tempvar __warp_90_pt1yy = __warp_90_pt1yy;
                        tempvar __warp_87_pt1xx = __warp_87_pt1xx;
                        tempvar __warp_88_pt1xy = __warp_88_pt1xy;
                        tempvar __warp_91_pt1zx = __warp_91_pt1zx;
                        tempvar __warp_92_pt1zy = __warp_92_pt1zy;
                        tempvar __warp_95_pt2yx = __warp_95_pt2yx;
                        tempvar __warp_96_pt2yy = __warp_96_pt2yy;
                        tempvar __warp_93_pt2xx = __warp_93_pt2xx;
                        tempvar __warp_94_pt2xy = __warp_94_pt2xy;
                        tempvar __warp_97_pt2zx = __warp_97_pt2zx;
                        tempvar __warp_98_pt2zy = __warp_98_pt2zy;
                    }
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_99_pt3 = __warp_99_pt3;
                    tempvar __warp_89_pt1yx = __warp_89_pt1yx;
                    tempvar __warp_90_pt1yy = __warp_90_pt1yy;
                    tempvar __warp_87_pt1xx = __warp_87_pt1xx;
                    tempvar __warp_88_pt1xy = __warp_88_pt1xy;
                    tempvar __warp_91_pt1zx = __warp_91_pt1zx;
                    tempvar __warp_92_pt1zy = __warp_92_pt1zy;
                    tempvar __warp_95_pt2yx = __warp_95_pt2yx;
                    tempvar __warp_96_pt2yy = __warp_96_pt2yy;
                    tempvar __warp_93_pt2xx = __warp_93_pt2xx;
                    tempvar __warp_94_pt2xy = __warp_94_pt2xy;
                    tempvar __warp_97_pt2zx = __warp_97_pt2zx;
                    tempvar __warp_98_pt2zy = __warp_98_pt2zy;
                
                    
                    let __warp_tv_115 = Uint256(low=1, high=0);
                    
                    let __warp_tv_116 = Uint256(low=0, high=0);
                    
                    let __warp_tv_117 = Uint256(low=1, high=0);
                    
                    let __warp_tv_118 = Uint256(low=0, high=0);
                    
                    let __warp_tv_119 = Uint256(low=0, high=0);
                    
                    let __warp_tv_120 = Uint256(low=0, high=0);
                    
                    let (__warp_se_109) = wm_index_static(__warp_99_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_109, __warp_tv_120);
                    
                    let (__warp_se_110) = wm_index_static(__warp_99_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_110, __warp_tv_119);
                    
                    let (__warp_se_111) = wm_index_static(__warp_99_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_111, __warp_tv_118);
                    
                    let (__warp_se_112) = wm_index_static(__warp_99_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_112, __warp_tv_117);
                    
                    let (__warp_se_113) = wm_index_static(__warp_99_pt3, Uint256(low=1, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_113, __warp_tv_116);
                    
                    let (__warp_se_114) = wm_index_static(__warp_99_pt3, Uint256(low=0, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
                    
                    wm_write_256(__warp_se_114, __warp_tv_115);
                
                
                
                return (__warp_99_pt3,);
            }else{
            
                tempvar range_check_ptr = range_check_ptr;
                tempvar warp_memory = warp_memory;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_99_pt3 = __warp_99_pt3;
                tempvar __warp_89_pt1yx = __warp_89_pt1yx;
                tempvar __warp_90_pt1yy = __warp_90_pt1yy;
                tempvar __warp_87_pt1xx = __warp_87_pt1xx;
                tempvar __warp_88_pt1xy = __warp_88_pt1xy;
                tempvar __warp_91_pt1zx = __warp_91_pt1zx;
                tempvar __warp_92_pt1zy = __warp_92_pt1zy;
                tempvar __warp_95_pt2yx = __warp_95_pt2yx;
                tempvar __warp_96_pt2yy = __warp_96_pt2yy;
                tempvar __warp_93_pt2xx = __warp_93_pt2xx;
                tempvar __warp_94_pt2xy = __warp_94_pt2xy;
                tempvar __warp_97_pt2zx = __warp_97_pt2zx;
                tempvar __warp_98_pt2zy = __warp_98_pt2zy;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar warp_memory = warp_memory;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar __warp_99_pt3 = __warp_99_pt3;
            tempvar __warp_89_pt1yx = __warp_89_pt1yx;
            tempvar __warp_90_pt1yy = __warp_90_pt1yy;
            tempvar __warp_87_pt1xx = __warp_87_pt1xx;
            tempvar __warp_88_pt1xy = __warp_88_pt1xy;
            tempvar __warp_91_pt1zx = __warp_91_pt1zx;
            tempvar __warp_92_pt1zy = __warp_92_pt1zy;
            tempvar __warp_95_pt2yx = __warp_95_pt2yx;
            tempvar __warp_96_pt2yy = __warp_96_pt2yy;
            tempvar __warp_93_pt2xx = __warp_93_pt2xx;
            tempvar __warp_94_pt2xy = __warp_94_pt2xy;
            tempvar __warp_97_pt2zx = __warp_97_pt2zx;
            tempvar __warp_98_pt2zy = __warp_98_pt2zy;
        
            
            let (__warp_tv_121, __warp_tv_122) = _FQ2Mul_f7835b96(__warp_91_pt1zx, __warp_92_pt1zy, __warp_97_pt2zx, __warp_98_pt2zy);
            
            let __warp_98_pt2zy = __warp_tv_122;
            
            let __warp_97_pt2zx = __warp_tv_121;
        
            
            let (__warp_se_115) = wm_index_static(__warp_99_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_116) = wm_read_256(__warp_se_115);
            
            let (__warp_se_117) = wm_index_static(__warp_99_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_118) = wm_read_256(__warp_se_117);
            
            let (__warp_tv_123, __warp_tv_124) = _FQ2Sub_16265402(__warp_95_pt2yx, __warp_96_pt2yy, __warp_se_116, __warp_se_118);
            
            let __warp_88_pt1xy = __warp_tv_124;
            
            let __warp_87_pt1xx = __warp_tv_123;
        
            
            let (__warp_se_119) = wm_index_static(__warp_99_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_120) = wm_read_256(__warp_se_119);
            
            let (__warp_se_121) = wm_index_static(__warp_99_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_122) = wm_read_256(__warp_se_121);
            
            let (__warp_tv_125, __warp_tv_126) = _FQ2Sub_16265402(__warp_93_pt2xx, __warp_94_pt2xy, __warp_se_120, __warp_se_122);
            
            let __warp_90_pt1yy = __warp_tv_126;
            
            let __warp_89_pt1yx = __warp_tv_125;
        
            
            let (__warp_tv_127, __warp_tv_128) = _FQ2Mul_f7835b96(__warp_89_pt1yx, __warp_90_pt1yy, __warp_89_pt1yx, __warp_90_pt1yy);
            
            let __warp_92_pt1zy = __warp_tv_128;
            
            let __warp_91_pt1zx = __warp_tv_127;
        
            
            let (__warp_se_123) = wm_index_static(__warp_99_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_124) = wm_read_256(__warp_se_123);
            
            let (__warp_se_125) = wm_index_static(__warp_99_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_126) = wm_read_256(__warp_se_125);
            
            let (__warp_tv_129, __warp_tv_130) = _FQ2Mul_f7835b96(__warp_91_pt1zx, __warp_92_pt1zy, __warp_se_124, __warp_se_126);
            
            let __warp_96_pt2yy = __warp_tv_130;
            
            let __warp_95_pt2yx = __warp_tv_129;
        
            
            let (__warp_tv_131, __warp_tv_132) = _FQ2Mul_f7835b96(__warp_91_pt1zx, __warp_92_pt1zy, __warp_89_pt1yx, __warp_90_pt1yy);
            
            let __warp_92_pt1zy = __warp_tv_132;
            
            let __warp_91_pt1zx = __warp_tv_131;
        
            
            let (__warp_tv_133, __warp_tv_134) = _FQ2Mul_f7835b96(__warp_91_pt1zx, __warp_92_pt1zy, __warp_97_pt2zx, __warp_98_pt2zy);
            
            let (__warp_se_127) = wm_index_static(__warp_99_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_127, __warp_tv_134);
            
            let (__warp_se_128) = wm_index_static(__warp_99_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_128, __warp_tv_133);
        
            
            let (__warp_tv_135, __warp_tv_136) = _FQ2Mul_f7835b96(__warp_87_pt1xx, __warp_88_pt1xy, __warp_87_pt1xx, __warp_88_pt1xy);
            
            let __warp_94_pt2xy = __warp_tv_136;
            
            let __warp_93_pt2xx = __warp_tv_135;
        
            
            let (__warp_tv_137, __warp_tv_138) = _FQ2Mul_f7835b96(__warp_93_pt2xx, __warp_94_pt2xy, __warp_97_pt2zx, __warp_98_pt2zy);
            
            let __warp_94_pt2xy = __warp_tv_138;
            
            let __warp_93_pt2xx = __warp_tv_137;
        
            
            let (__warp_tv_139, __warp_tv_140) = _FQ2Sub_16265402(__warp_93_pt2xx, __warp_94_pt2xy, __warp_91_pt1zx, __warp_92_pt1zy);
            
            let __warp_94_pt2xy = __warp_tv_140;
            
            let __warp_93_pt2xx = __warp_tv_139;
        
            
            let (__warp_tv_141, __warp_tv_142) = _FQ2Muc_3fc7e233(__warp_95_pt2yx, __warp_96_pt2yy, Uint256(low=2, high=0));
            
            let __warp_98_pt2zy = __warp_tv_142;
            
            let __warp_97_pt2zx = __warp_tv_141;
        
            
            let (__warp_tv_143, __warp_tv_144) = _FQ2Sub_16265402(__warp_93_pt2xx, __warp_94_pt2xy, __warp_97_pt2zx, __warp_98_pt2zy);
            
            let __warp_94_pt2xy = __warp_tv_144;
            
            let __warp_93_pt2xx = __warp_tv_143;
        
            
            let (__warp_tv_145, __warp_tv_146) = _FQ2Mul_f7835b96(__warp_89_pt1yx, __warp_90_pt1yy, __warp_93_pt2xx, __warp_94_pt2xy);
            
            let (__warp_se_129) = wm_index_static(__warp_99_pt3, Uint256(low=1, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_129, __warp_tv_146);
            
            let (__warp_se_130) = wm_index_static(__warp_99_pt3, Uint256(low=0, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_130, __warp_tv_145);
        
            
            let (__warp_tv_147, __warp_tv_148) = _FQ2Sub_16265402(__warp_95_pt2yx, __warp_96_pt2yy, __warp_93_pt2xx, __warp_94_pt2xy);
            
            let __warp_90_pt1yy = __warp_tv_148;
            
            let __warp_89_pt1yx = __warp_tv_147;
        
            
            let (__warp_tv_149, __warp_tv_150) = _FQ2Mul_f7835b96(__warp_87_pt1xx, __warp_88_pt1xy, __warp_89_pt1yx, __warp_90_pt1yy);
            
            let __warp_90_pt1yy = __warp_tv_150;
            
            let __warp_89_pt1yx = __warp_tv_149;
        
            
            let (__warp_se_131) = wm_index_static(__warp_99_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_132) = wm_read_256(__warp_se_131);
            
            let (__warp_se_133) = wm_index_static(__warp_99_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            let (__warp_se_134) = wm_read_256(__warp_se_133);
            
            let (__warp_tv_151, __warp_tv_152) = _FQ2Mul_f7835b96(__warp_91_pt1zx, __warp_92_pt1zy, __warp_se_132, __warp_se_134);
            
            let __warp_88_pt1xy = __warp_tv_152;
            
            let __warp_87_pt1xx = __warp_tv_151;
        
            
            let (__warp_tv_153, __warp_tv_154) = _FQ2Sub_16265402(__warp_89_pt1yx, __warp_90_pt1yy, __warp_87_pt1xx, __warp_88_pt1xy);
            
            let (__warp_se_135) = wm_index_static(__warp_99_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_135, __warp_tv_154);
            
            let (__warp_se_136) = wm_index_static(__warp_99_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
            
            wm_write_256(__warp_se_136, __warp_tv_153);
        
        
        
        return (__warp_99_pt3,);

    }


    func _ECTwistDoubleJacobian_f2664d9a{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_100_pt1xx : Uint256, __warp_101_pt1xy : Uint256, __warp_102_pt1yx : Uint256, __warp_103_pt1yy : Uint256, __warp_104_pt1zx : Uint256, __warp_105_pt1zy : Uint256)-> (__warp_106_pt2xx : Uint256, __warp_107_pt2xy : Uint256, __warp_108_pt2yx : Uint256, __warp_109_pt2yy : Uint256, __warp_110_pt2zx : Uint256, __warp_111_pt2zy : Uint256){
    alloc_locals;


        
        let __warp_111_pt2zy = Uint256(low=0, high=0);
        
        let __warp_110_pt2zx = Uint256(low=0, high=0);
        
        let __warp_109_pt2yy = Uint256(low=0, high=0);
        
        let __warp_108_pt2yx = Uint256(low=0, high=0);
        
        let __warp_107_pt2xy = Uint256(low=0, high=0);
        
        let __warp_106_pt2xx = Uint256(low=0, high=0);
        
            
            let (__warp_tv_155, __warp_tv_156) = _FQ2Muc_3fc7e233(__warp_100_pt1xx, __warp_101_pt1xy, Uint256(low=3, high=0));
            
            let __warp_107_pt2xy = __warp_tv_156;
            
            let __warp_106_pt2xx = __warp_tv_155;
        
            
            let (__warp_tv_157, __warp_tv_158) = _FQ2Mul_f7835b96(__warp_106_pt2xx, __warp_107_pt2xy, __warp_100_pt1xx, __warp_101_pt1xy);
            
            let __warp_107_pt2xy = __warp_tv_158;
            
            let __warp_106_pt2xx = __warp_tv_157;
        
            
            let (__warp_tv_159, __warp_tv_160) = _FQ2Mul_f7835b96(__warp_102_pt1yx, __warp_103_pt1yy, __warp_104_pt1zx, __warp_105_pt1zy);
            
            let __warp_105_pt1zy = __warp_tv_160;
            
            let __warp_104_pt1zx = __warp_tv_159;
        
            
            let (__warp_tv_161, __warp_tv_162) = _FQ2Mul_f7835b96(__warp_100_pt1xx, __warp_101_pt1xy, __warp_102_pt1yx, __warp_103_pt1yy);
            
            let __warp_109_pt2yy = __warp_tv_162;
            
            let __warp_108_pt2yx = __warp_tv_161;
        
            
            let (__warp_tv_163, __warp_tv_164) = _FQ2Mul_f7835b96(__warp_108_pt2yx, __warp_109_pt2yy, __warp_104_pt1zx, __warp_105_pt1zy);
            
            let __warp_109_pt2yy = __warp_tv_164;
            
            let __warp_108_pt2yx = __warp_tv_163;
        
            
            let (__warp_tv_165, __warp_tv_166) = _FQ2Mul_f7835b96(__warp_106_pt2xx, __warp_107_pt2xy, __warp_106_pt2xx, __warp_107_pt2xy);
            
            let __warp_101_pt1xy = __warp_tv_166;
            
            let __warp_100_pt1xx = __warp_tv_165;
        
            
            let (__warp_tv_167, __warp_tv_168) = _FQ2Muc_3fc7e233(__warp_108_pt2yx, __warp_109_pt2yy, Uint256(low=8, high=0));
            
            let __warp_111_pt2zy = __warp_tv_168;
            
            let __warp_110_pt2zx = __warp_tv_167;
        
            
            let (__warp_tv_169, __warp_tv_170) = _FQ2Sub_16265402(__warp_100_pt1xx, __warp_101_pt1xy, __warp_110_pt2zx, __warp_111_pt2zy);
            
            let __warp_101_pt1xy = __warp_tv_170;
            
            let __warp_100_pt1xx = __warp_tv_169;
        
            
            let (__warp_tv_171, __warp_tv_172) = _FQ2Mul_f7835b96(__warp_104_pt1zx, __warp_105_pt1zy, __warp_104_pt1zx, __warp_105_pt1zy);
            
            let __warp_111_pt2zy = __warp_tv_172;
            
            let __warp_110_pt2zx = __warp_tv_171;
        
            
            let (__warp_tv_173, __warp_tv_174) = _FQ2Muc_3fc7e233(__warp_108_pt2yx, __warp_109_pt2yy, Uint256(low=4, high=0));
            
            let __warp_109_pt2yy = __warp_tv_174;
            
            let __warp_108_pt2yx = __warp_tv_173;
        
            
            let (__warp_tv_175, __warp_tv_176) = _FQ2Sub_16265402(__warp_108_pt2yx, __warp_109_pt2yy, __warp_100_pt1xx, __warp_101_pt1xy);
            
            let __warp_109_pt2yy = __warp_tv_176;
            
            let __warp_108_pt2yx = __warp_tv_175;
        
            
            let (__warp_tv_177, __warp_tv_178) = _FQ2Mul_f7835b96(__warp_108_pt2yx, __warp_109_pt2yy, __warp_106_pt2xx, __warp_107_pt2xy);
            
            let __warp_109_pt2yy = __warp_tv_178;
            
            let __warp_108_pt2yx = __warp_tv_177;
        
            
            let (__warp_tv_179, __warp_tv_180) = _FQ2Muc_3fc7e233(__warp_102_pt1yx, __warp_103_pt1yy, Uint256(low=8, high=0));
            
            let __warp_107_pt2xy = __warp_tv_180;
            
            let __warp_106_pt2xx = __warp_tv_179;
        
            
            let (__warp_tv_181, __warp_tv_182) = _FQ2Mul_f7835b96(__warp_106_pt2xx, __warp_107_pt2xy, __warp_102_pt1yx, __warp_103_pt1yy);
            
            let __warp_107_pt2xy = __warp_tv_182;
            
            let __warp_106_pt2xx = __warp_tv_181;
        
            
            let (__warp_tv_183, __warp_tv_184) = _FQ2Mul_f7835b96(__warp_106_pt2xx, __warp_107_pt2xy, __warp_110_pt2zx, __warp_111_pt2zy);
            
            let __warp_107_pt2xy = __warp_tv_184;
            
            let __warp_106_pt2xx = __warp_tv_183;
        
            
            let (__warp_tv_185, __warp_tv_186) = _FQ2Sub_16265402(__warp_108_pt2yx, __warp_109_pt2yy, __warp_106_pt2xx, __warp_107_pt2xy);
            
            let __warp_109_pt2yy = __warp_tv_186;
            
            let __warp_108_pt2yx = __warp_tv_185;
        
            
            let (__warp_tv_187, __warp_tv_188) = _FQ2Muc_3fc7e233(__warp_100_pt1xx, __warp_101_pt1xy, Uint256(low=2, high=0));
            
            let __warp_107_pt2xy = __warp_tv_188;
            
            let __warp_106_pt2xx = __warp_tv_187;
        
            
            let (__warp_tv_189, __warp_tv_190) = _FQ2Mul_f7835b96(__warp_106_pt2xx, __warp_107_pt2xy, __warp_104_pt1zx, __warp_105_pt1zy);
            
            let __warp_107_pt2xy = __warp_tv_190;
            
            let __warp_106_pt2xx = __warp_tv_189;
        
            
            let (__warp_tv_191, __warp_tv_192) = _FQ2Mul_f7835b96(__warp_104_pt1zx, __warp_105_pt1zy, __warp_110_pt2zx, __warp_111_pt2zy);
            
            let __warp_111_pt2zy = __warp_tv_192;
            
            let __warp_110_pt2zx = __warp_tv_191;
        
            
            let (__warp_tv_193, __warp_tv_194) = _FQ2Muc_3fc7e233(__warp_110_pt2zx, __warp_111_pt2zy, Uint256(low=8, high=0));
            
            let __warp_111_pt2zy = __warp_tv_194;
            
            let __warp_110_pt2zx = __warp_tv_193;
        
        let __warp_106_pt2xx = __warp_106_pt2xx;
        
        let __warp_107_pt2xy = __warp_107_pt2xy;
        
        let __warp_108_pt2yx = __warp_108_pt2yx;
        
        let __warp_109_pt2yy = __warp_109_pt2yy;
        
        let __warp_110_pt2zx = __warp_110_pt2zx;
        
        let __warp_111_pt2zy = __warp_111_pt2zy;
        
        
        
        return (__warp_106_pt2xx, __warp_107_pt2xy, __warp_108_pt2yx, __warp_109_pt2yy, __warp_110_pt2zx, __warp_111_pt2zy);

    }


    func _ECTwistMulJacobian_5a3c8d36{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*, warp_memory : DictAccess*}(__warp_112_d : Uint256, __warp_113_pt1xx : Uint256, __warp_114_pt1xy : Uint256, __warp_115_pt1yx : Uint256, __warp_116_pt1yy : Uint256, __warp_117_pt1zx : Uint256, __warp_118_pt1zy : Uint256)-> (__warp_119_pt2 : felt){
    alloc_locals;


        
        let (__warp_119_pt2) = WM0_s_arr(Uint256(low=0, high=0), Uint256(low=0, high=0), Uint256(low=0, high=0), Uint256(low=0, high=0), Uint256(low=0, high=0), Uint256(low=0, high=0));
        
            
            let (__warp_tv_195, __warp_td_3, __warp_tv_197, __warp_tv_198, __warp_tv_199, __warp_tv_200, __warp_tv_201, __warp_tv_202) = __warp_while0(__warp_112_d, __warp_119_pt2, __warp_113_pt1xx, __warp_114_pt1xy, __warp_115_pt1yx, __warp_116_pt1yy, __warp_117_pt1zx, __warp_118_pt1zy);
            
            let __warp_tv_196 = __warp_td_3;
            
            let __warp_118_pt1zy = __warp_tv_202;
            
            let __warp_117_pt1zx = __warp_tv_201;
            
            let __warp_116_pt1yy = __warp_tv_200;
            
            let __warp_115_pt1yx = __warp_tv_199;
            
            let __warp_114_pt1xy = __warp_tv_198;
            
            let __warp_113_pt1xx = __warp_tv_197;
            
            let __warp_119_pt2 = __warp_tv_196;
            
            let __warp_112_d = __warp_tv_195;
        
        
        
        return (__warp_119_pt2,);

    }


    func __warp_init_BN256G2{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(FIELD_MODULUS, Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389));
        
        WS_WRITE0(TWISTBX, Uint256(low=241528894477357229398967524003378444517, high=57263839228809413707999148736847571651));
        
        WS_WRITE0(TWISTBY, Uint256(low=222394522462485822084624302373924443602, high=784436153819307037095878749819829748));
        
        WS_WRITE0(PTXX, Uint256(low=0, high=0));
        
        WS_WRITE0(PTXY, Uint256(low=1, high=0));
        
        WS_WRITE0(PTYX, Uint256(low=2, high=0));
        
        WS_WRITE0(PTYY, Uint256(low=3, high=0));
        
        WS_WRITE0(PTZX, Uint256(low=4, high=0));
        
        WS_WRITE0(PTZY, Uint256(low=5, high=0));
        
        
        
        return ();

    }

}

    //  @notice Add two twist points
    // @param pt1xx Coefficient 1 of x on point 1
    // @param pt1xy Coefficient 2 of x on point 1
    // @param pt1yx Coefficient 1 of y on point 1
    // @param pt1yy Coefficient 2 of y on point 1
    // @param pt2xx Coefficient 1 of x on point 2
    // @param pt2xy Coefficient 2 of x on point 2
    // @param pt2yx Coefficient 1 of y on point 2
    // @param pt2yy Coefficient 2 of y on point 2
    // @return (pt3xx, pt3xy, pt3yx, pt3yy)
    @view
    func ECTwistAdd_61a931ec{syscall_ptr : felt*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_pt1xx : Uint256, __warp_1_pt1xy : Uint256, __warp_2_pt1yx : Uint256, __warp_3_pt1yy : Uint256, __warp_4_pt2xx : Uint256, __warp_5_pt2xy : Uint256, __warp_6_pt2yx : Uint256, __warp_7_pt2yy : Uint256)-> (__warp_8 : Uint256, __warp_9 : Uint256, __warp_10 : Uint256, __warp_11 : Uint256){
    alloc_locals;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        warp_external_input_check_int256(__warp_7_pt2yy);
        
        warp_external_input_check_int256(__warp_6_pt2yx);
        
        warp_external_input_check_int256(__warp_5_pt2xy);
        
        warp_external_input_check_int256(__warp_4_pt2xx);
        
        warp_external_input_check_int256(__warp_3_pt1yy);
        
        warp_external_input_check_int256(__warp_2_pt1yx);
        
        warp_external_input_check_int256(__warp_1_pt1xy);
        
        warp_external_input_check_int256(__warp_0_pt1xx);
        
        let __warp_rc_0 = 0;
        
            
            let (__warp_tv_13, __warp_tv_14, __warp_tv_15, __warp_tv_16, __warp_tv_17) = BN256G2.__warp_conditional_ECTwistAdd_61a931ec_1(__warp_0_pt1xx, __warp_1_pt1xy, __warp_2_pt1yx, __warp_3_pt1yy);
            
            let __warp_3_pt1yy = __warp_tv_17;
            
            let __warp_2_pt1yx = __warp_tv_16;
            
            let __warp_1_pt1xy = __warp_tv_15;
            
            let __warp_0_pt1xx = __warp_tv_14;
            
            let __warp_rc_0 = __warp_tv_13;
        
            
            if (__warp_rc_0 != 0){
            
                
                let __warp_rc_6 = 0;
                
                    
                    let (__warp_tv_25, __warp_tv_26, __warp_tv_27, __warp_tv_28, __warp_tv_29) = BN256G2.__warp_conditional_ECTwistAdd_61a931ec_7(__warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx, __warp_7_pt2yy);
                    
                    let __warp_7_pt2yy = __warp_tv_29;
                    
                    let __warp_6_pt2yx = __warp_tv_28;
                    
                    let __warp_5_pt2xy = __warp_tv_27;
                    
                    let __warp_4_pt2xx = __warp_tv_26;
                    
                    let __warp_rc_6 = __warp_tv_25;
                
                    
                    if (1 - __warp_rc_6 != 0){
                    
                        
                        let (__warp_pse_1) = BN256G2._isOnCurve_140fcd99(__warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx, __warp_7_pt2yy);
                        
                        assert __warp_pse_1 = 1;
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar __warp_0_pt1xx = __warp_0_pt1xx;
                        tempvar __warp_1_pt1xy = __warp_1_pt1xy;
                        tempvar __warp_2_pt1yx = __warp_2_pt1yx;
                        tempvar __warp_3_pt1yy = __warp_3_pt1yy;
                        tempvar __warp_4_pt2xx = __warp_4_pt2xx;
                        tempvar __warp_5_pt2xy = __warp_5_pt2xy;
                        tempvar __warp_6_pt2yx = __warp_6_pt2yx;
                        tempvar __warp_7_pt2yy = __warp_7_pt2yy;
                    }else{
                    
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar __warp_0_pt1xx = __warp_0_pt1xx;
                        tempvar __warp_1_pt1xy = __warp_1_pt1xy;
                        tempvar __warp_2_pt1yx = __warp_2_pt1yx;
                        tempvar __warp_3_pt1yy = __warp_3_pt1yy;
                        tempvar __warp_4_pt2xx = __warp_4_pt2xx;
                        tempvar __warp_5_pt2xy = __warp_5_pt2xy;
                        tempvar __warp_6_pt2yx = __warp_6_pt2yx;
                        tempvar __warp_7_pt2yy = __warp_7_pt2yy;
                    }
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar __warp_0_pt1xx = __warp_0_pt1xx;
                    tempvar __warp_1_pt1xy = __warp_1_pt1xy;
                    tempvar __warp_2_pt1yx = __warp_2_pt1yx;
                    tempvar __warp_3_pt1yy = __warp_3_pt1yy;
                    tempvar __warp_4_pt2xx = __warp_4_pt2xx;
                    tempvar __warp_5_pt2xy = __warp_5_pt2xy;
                    tempvar __warp_6_pt2yx = __warp_6_pt2yx;
                    tempvar __warp_7_pt2yy = __warp_7_pt2yy;
                
                let __warp_8 = __warp_4_pt2xx;
                
                let __warp_9 = __warp_5_pt2xy;
                
                let __warp_10 = __warp_6_pt2yx;
                
                let __warp_11 = __warp_7_pt2yy;
                
                default_dict_finalize(warp_memory_start, warp_memory, 0);
                
                
                return (__warp_8, __warp_9, __warp_10, __warp_11);
            }else{
            
                
                let __warp_rc_12 = 0;
                
                    
                    let (__warp_tv_37, __warp_tv_38, __warp_tv_39, __warp_tv_40, __warp_tv_41) = BN256G2.__warp_conditional_ECTwistAdd_61a931ec_13(__warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx, __warp_7_pt2yy);
                    
                    let __warp_7_pt2yy = __warp_tv_41;
                    
                    let __warp_6_pt2yx = __warp_tv_40;
                    
                    let __warp_5_pt2xy = __warp_tv_39;
                    
                    let __warp_4_pt2xx = __warp_tv_38;
                    
                    let __warp_rc_12 = __warp_tv_37;
                
                    
                    if (__warp_rc_12 != 0){
                    
                        
                        let (__warp_pse_2) = BN256G2._isOnCurve_140fcd99(__warp_0_pt1xx, __warp_1_pt1xy, __warp_2_pt1yx, __warp_3_pt1yy);
                        
                        assert __warp_pse_2 = 1;
                        
                        let __warp_8 = __warp_0_pt1xx;
                        
                        let __warp_9 = __warp_1_pt1xy;
                        
                        let __warp_10 = __warp_2_pt1yx;
                        
                        let __warp_11 = __warp_3_pt1yy;
                        
                        default_dict_finalize(warp_memory_start, warp_memory, 0);
                        
                        
                        return (__warp_8, __warp_9, __warp_10, __warp_11);
                    }else{
                    
                        tempvar range_check_ptr = range_check_ptr;
                        tempvar syscall_ptr = syscall_ptr;
                        tempvar bitwise_ptr = bitwise_ptr;
                        tempvar warp_memory = warp_memory;
                        tempvar __warp_0_pt1xx = __warp_0_pt1xx;
                        tempvar __warp_1_pt1xy = __warp_1_pt1xy;
                        tempvar __warp_2_pt1yx = __warp_2_pt1yx;
                        tempvar __warp_3_pt1yy = __warp_3_pt1yy;
                        tempvar __warp_4_pt2xx = __warp_4_pt2xx;
                        tempvar __warp_5_pt2xy = __warp_5_pt2xy;
                        tempvar __warp_6_pt2yx = __warp_6_pt2yx;
                        tempvar __warp_7_pt2yy = __warp_7_pt2yy;
                    }
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar warp_memory = warp_memory;
                    tempvar __warp_0_pt1xx = __warp_0_pt1xx;
                    tempvar __warp_1_pt1xy = __warp_1_pt1xy;
                    tempvar __warp_2_pt1yx = __warp_2_pt1yx;
                    tempvar __warp_3_pt1yy = __warp_3_pt1yy;
                    tempvar __warp_4_pt2xx = __warp_4_pt2xx;
                    tempvar __warp_5_pt2xy = __warp_5_pt2xy;
                    tempvar __warp_6_pt2yx = __warp_6_pt2yx;
                    tempvar __warp_7_pt2yy = __warp_7_pt2yy;
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar __warp_0_pt1xx = __warp_0_pt1xx;
                tempvar __warp_1_pt1xy = __warp_1_pt1xy;
                tempvar __warp_2_pt1yx = __warp_2_pt1yx;
                tempvar __warp_3_pt1yy = __warp_3_pt1yy;
                tempvar __warp_4_pt2xx = __warp_4_pt2xx;
                tempvar __warp_5_pt2xy = __warp_5_pt2xy;
                tempvar __warp_6_pt2yx = __warp_6_pt2yx;
                tempvar __warp_7_pt2yy = __warp_7_pt2yy;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar syscall_ptr = syscall_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar __warp_0_pt1xx = __warp_0_pt1xx;
            tempvar __warp_1_pt1xy = __warp_1_pt1xy;
            tempvar __warp_2_pt1yx = __warp_2_pt1yx;
            tempvar __warp_3_pt1yy = __warp_3_pt1yy;
            tempvar __warp_4_pt2xx = __warp_4_pt2xx;
            tempvar __warp_5_pt2xy = __warp_5_pt2xy;
            tempvar __warp_6_pt2yx = __warp_6_pt2yx;
            tempvar __warp_7_pt2yy = __warp_7_pt2yy;
        
        let (__warp_pse_3) = BN256G2._isOnCurve_140fcd99(__warp_0_pt1xx, __warp_1_pt1xy, __warp_2_pt1yx, __warp_3_pt1yy);
        
        assert __warp_pse_3 = 1;
        
        let (__warp_pse_4) = BN256G2._isOnCurve_140fcd99(__warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx, __warp_7_pt2yy);
        
        assert __warp_pse_4 = 1;
        
        let (__warp_12_pt3) = BN256G2._ECTwistAddJacobian_4a863fe0(__warp_0_pt1xx, __warp_1_pt1xy, __warp_2_pt1yx, __warp_3_pt1yy, Uint256(low=1, high=0), Uint256(low=0, high=0), __warp_4_pt2xx, __warp_5_pt2xy, __warp_6_pt2yx, __warp_7_pt2yy, Uint256(low=1, high=0), Uint256(low=0, high=0));
        
        let (__warp_se_28) = wm_index_static(__warp_12_pt3, Uint256(low=0, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_29) = wm_read_256(__warp_se_28);
        
        let (__warp_se_30) = wm_index_static(__warp_12_pt3, Uint256(low=1, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_31) = wm_read_256(__warp_se_30);
        
        let (__warp_se_32) = wm_index_static(__warp_12_pt3, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_33) = wm_read_256(__warp_se_32);
        
        let (__warp_se_34) = wm_index_static(__warp_12_pt3, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_35) = wm_read_256(__warp_se_34);
        
        let (__warp_se_36) = wm_index_static(__warp_12_pt3, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_37) = wm_read_256(__warp_se_36);
        
        let (__warp_se_38) = wm_index_static(__warp_12_pt3, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_39) = wm_read_256(__warp_se_38);
        
        let (__warp_8, __warp_9, __warp_10, __warp_11) = BN256G2._fromJacobian_000265f8(__warp_se_29, __warp_se_31, __warp_se_33, __warp_se_35, __warp_se_37, __warp_se_39);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return (__warp_8, __warp_9, __warp_10, __warp_11);
    }
    }

    //  @notice Multiply a twist point by a scalar
    // @param s     Scalar to multiply by
    // @param pt1xx Coefficient 1 of x
    // @param pt1xy Coefficient 2 of x
    // @param pt1yx Coefficient 1 of y
    // @param pt1yy Coefficient 2 of y
    // @return (pt2xx, pt2xy, pt2yx, pt2yy)
    @view
    func ECTwistMul_b73ab75d{syscall_ptr : felt*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_13_s : Uint256, __warp_14_pt1xx : Uint256, __warp_15_pt1xy : Uint256, __warp_16_pt1yx : Uint256, __warp_17_pt1yy : Uint256)-> (__warp_18 : Uint256, __warp_19 : Uint256, __warp_20 : Uint256, __warp_21 : Uint256){
    alloc_locals;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        warp_external_input_check_int256(__warp_17_pt1yy);
        
        warp_external_input_check_int256(__warp_16_pt1yx);
        
        warp_external_input_check_int256(__warp_15_pt1xy);
        
        warp_external_input_check_int256(__warp_14_pt1xx);
        
        warp_external_input_check_int256(__warp_13_s);
        
        let __warp_22_pt1zx = Uint256(low=1, high=0);
        
        let __warp_rc_18 = 0;
        
            
            let (__warp_tv_49, __warp_tv_50, __warp_tv_51, __warp_tv_52, __warp_tv_53) = BN256G2.__warp_conditional_ECTwistMul_b73ab75d_19(__warp_14_pt1xx, __warp_15_pt1xy, __warp_16_pt1yx, __warp_17_pt1yy);
            
            let __warp_17_pt1yy = __warp_tv_53;
            
            let __warp_16_pt1yx = __warp_tv_52;
            
            let __warp_15_pt1xy = __warp_tv_51;
            
            let __warp_14_pt1xx = __warp_tv_50;
            
            let __warp_rc_18 = __warp_tv_49;
        
            
            if (__warp_rc_18 != 0){
            
                
                let __warp_14_pt1xx = Uint256(low=1, high=0);
                
                let __warp_16_pt1yx = Uint256(low=1, high=0);
                
                let __warp_22_pt1zx = Uint256(low=0, high=0);
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar __warp_13_s = __warp_13_s;
                tempvar __warp_14_pt1xx = __warp_14_pt1xx;
                tempvar __warp_15_pt1xy = __warp_15_pt1xy;
                tempvar __warp_16_pt1yx = __warp_16_pt1yx;
                tempvar __warp_17_pt1yy = __warp_17_pt1yy;
                tempvar __warp_22_pt1zx = __warp_22_pt1zx;
            }else{
            
                
                let (__warp_pse_5) = BN256G2._isOnCurve_140fcd99(__warp_14_pt1xx, __warp_15_pt1xy, __warp_16_pt1yx, __warp_17_pt1yy);
                
                assert __warp_pse_5 = 1;
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar warp_memory = warp_memory;
                tempvar __warp_13_s = __warp_13_s;
                tempvar __warp_14_pt1xx = __warp_14_pt1xx;
                tempvar __warp_15_pt1xy = __warp_15_pt1xy;
                tempvar __warp_16_pt1yx = __warp_16_pt1yx;
                tempvar __warp_17_pt1yy = __warp_17_pt1yy;
                tempvar __warp_22_pt1zx = __warp_22_pt1zx;
            }
            tempvar range_check_ptr = range_check_ptr;
            tempvar syscall_ptr = syscall_ptr;
            tempvar bitwise_ptr = bitwise_ptr;
            tempvar warp_memory = warp_memory;
            tempvar __warp_13_s = __warp_13_s;
            tempvar __warp_14_pt1xx = __warp_14_pt1xx;
            tempvar __warp_15_pt1xy = __warp_15_pt1xy;
            tempvar __warp_16_pt1yx = __warp_16_pt1yx;
            tempvar __warp_17_pt1yy = __warp_17_pt1yy;
            tempvar __warp_22_pt1zx = __warp_22_pt1zx;
        
        let (__warp_23_pt2) = BN256G2._ECTwistMulJacobian_5a3c8d36(__warp_13_s, __warp_14_pt1xx, __warp_15_pt1xy, __warp_16_pt1yx, __warp_17_pt1yy, __warp_22_pt1zx, Uint256(low=0, high=0));
        
        let (__warp_se_44) = wm_index_static(__warp_23_pt2, Uint256(low=0, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_45) = wm_read_256(__warp_se_44);
        
        let (__warp_se_46) = wm_index_static(__warp_23_pt2, Uint256(low=1, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_47) = wm_read_256(__warp_se_46);
        
        let (__warp_se_48) = wm_index_static(__warp_23_pt2, Uint256(low=2, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_49) = wm_read_256(__warp_se_48);
        
        let (__warp_se_50) = wm_index_static(__warp_23_pt2, Uint256(low=3, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_51) = wm_read_256(__warp_se_50);
        
        let (__warp_se_52) = wm_index_static(__warp_23_pt2, Uint256(low=4, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_53) = wm_read_256(__warp_se_52);
        
        let (__warp_se_54) = wm_index_static(__warp_23_pt2, Uint256(low=5, high=0), Uint256(low=2, high=0), Uint256(low=6, high=0));
        
        let (__warp_se_55) = wm_read_256(__warp_se_54);
        
        let (__warp_18, __warp_19, __warp_20, __warp_21) = BN256G2._fromJacobian_000265f8(__warp_se_45, __warp_se_47, __warp_se_49, __warp_se_51, __warp_se_53, __warp_se_55);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return (__warp_18, __warp_19, __warp_20, __warp_21);
    }
    }

    //  @notice Get the field modulus
    // @return The field modulus
    @view
    func GetFieldModulus_55a3e90f{syscall_ptr : felt*, range_check_ptr : felt}()-> (__warp_24 : Uint256){
    alloc_locals;


        
        
        
        return (Uint256(low=201385395114098847380338600778089168199, high=64323764613183177041862057485226039389),);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(18);


        
        BN256G2.__warp_init_BN256G2();
        
        
        
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
