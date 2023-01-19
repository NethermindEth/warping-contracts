%lang starknet


from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin


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


// Contract Def Primitives


namespace Primitives{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const __warp_0_boo = 0;

    const __warp_1_u8 = 1;

    const __warp_2_u256 = 2;

    const __warp_3_u = 4;

    const __warp_4_i8 = 6;

    const __warp_5_i256 = 7;

    const __warp_6_i = 9;

    const __warp_7_minInt = 11;

    const __warp_8_maxInt = 13;

    const __warp_9_addr = 15;

    const a = 16;

    const b = 17;

    const __warp_10_defaultBoo = 18;

    const __warp_11_defaultUint = 19;

    const __warp_12_defaultInt = 21;

    const __warp_13_defaultAddr = 23;


    func __warp_init_Primitives{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_boo, 1);
        
        WS_WRITE0(__warp_1_u8, 1);
        
        WS_WRITE1(__warp_2_u256, Uint256(low=456, high=0));
        
        WS_WRITE1(__warp_3_u, Uint256(low=123, high=0));
        
        WS_WRITE0(__warp_4_i8, 255);
        
        WS_WRITE1(__warp_5_i256, Uint256(low=456, high=0));
        
        WS_WRITE1(__warp_6_i, Uint256(low=340282366920938463463374607431768211333, high=340282366920938463463374607431768211455));
        
        WS_WRITE1(__warp_7_minInt, Uint256(low=0, high=170141183460469231731687303715884105728));
        
        WS_WRITE1(__warp_8_maxInt, Uint256(low=340282366920938463463374607431768211455, high=170141183460469231731687303715884105727));
        
        WS_WRITE0(__warp_9_addr, 1154414090619811796818182302139415280051214250812);
        
        WS_WRITE0(a, 181);
        
        WS_WRITE0(b, 86);
        
        
        
        return ();

    }

}


    @view
    func boo_4b3df200{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_14 : felt){
    alloc_locals;


        
        let (__warp_se_0) = WS0_READ_felt(Primitives.__warp_0_boo);
        
        
        
        return (__warp_se_0,);

    }


    @view
    func u8_ab3a58a3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_15 : felt){
    alloc_locals;


        
        let (__warp_se_1) = WS0_READ_felt(Primitives.__warp_1_u8);
        
        
        
        return (__warp_se_1,);

    }


    @view
    func u256_459b1acf{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_16 : Uint256){
    alloc_locals;


        
        let (__warp_se_2) = WS1_READ_Uint256(Primitives.__warp_2_u256);
        
        
        
        return (__warp_se_2,);

    }


    @view
    func u_c6a898c5{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_17 : Uint256){
    alloc_locals;


        
        let (__warp_se_3) = WS1_READ_Uint256(Primitives.__warp_3_u);
        
        
        
        return (__warp_se_3,);

    }


    @view
    func i8_921cda74{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_18 : felt){
    alloc_locals;


        
        let (__warp_se_4) = WS0_READ_felt(Primitives.__warp_4_i8);
        
        
        
        return (__warp_se_4,);

    }


    @view
    func i256_4c27fd62{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_19 : Uint256){
    alloc_locals;


        
        let (__warp_se_5) = WS1_READ_Uint256(Primitives.__warp_5_i256);
        
        
        
        return (__warp_se_5,);

    }


    @view
    func i_e5aa3d58{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_20 : Uint256){
    alloc_locals;


        
        let (__warp_se_6) = WS1_READ_Uint256(Primitives.__warp_6_i);
        
        
        
        return (__warp_se_6,);

    }


    @view
    func minInt_7e4e14cc{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_21 : Uint256){
    alloc_locals;


        
        let (__warp_se_7) = WS1_READ_Uint256(Primitives.__warp_7_minInt);
        
        
        
        return (__warp_se_7,);

    }


    @view
    func maxInt_7a4c2571{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_22 : Uint256){
    alloc_locals;


        
        let (__warp_se_8) = WS1_READ_Uint256(Primitives.__warp_8_maxInt);
        
        
        
        return (__warp_se_8,);

    }


    @view
    func addr_767800de{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_23 : felt){
    alloc_locals;


        
        let (__warp_se_9) = WS0_READ_felt(Primitives.__warp_9_addr);
        
        
        
        return (__warp_se_9,);

    }


    @view
    func defaultBoo_074eef3f{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_24 : felt){
    alloc_locals;


        
        let (__warp_se_10) = WS0_READ_felt(Primitives.__warp_10_defaultBoo);
        
        
        
        return (__warp_se_10,);

    }


    @view
    func defaultUint_1570c2cb{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_25 : Uint256){
    alloc_locals;


        
        let (__warp_se_11) = WS1_READ_Uint256(Primitives.__warp_11_defaultUint);
        
        
        
        return (__warp_se_11,);

    }


    @view
    func defaultInt_5abe622b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_26 : Uint256){
    alloc_locals;


        
        let (__warp_se_12) = WS1_READ_Uint256(Primitives.__warp_12_defaultInt);
        
        
        
        return (__warp_se_12,);

    }


    @view
    func defaultAddr_f2427d37{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_27 : felt){
    alloc_locals;


        
        let (__warp_se_13) = WS0_READ_felt(Primitives.__warp_13_defaultAddr);
        
        
        
        return (__warp_se_13,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(24);


        
        Primitives.__warp_init_Primitives();
        
        
        
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