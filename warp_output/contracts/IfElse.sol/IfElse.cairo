%lang starknet


from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.uint256 import Uint256
from warplib.maths.lt import warp_lt256
from warplib.maths.int_conversions import warp_uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin


// Contract Def IfElse


namespace IfElse{

    // Dynamic variables - Arrays and Maps

    // Static variables


    func __warp_conditional_ternary_55278c5b_1{range_check_ptr : felt}(__warp_2__x : Uint256)-> (__warp_rc_0 : felt, __warp_2__x : Uint256){
    alloc_locals;


        
        let (__warp_se_2) = warp_lt256(__warp_2__x, Uint256(low=10, high=0));
        
        if (__warp_se_2 != 0){
        
            
            let __warp_rc_0 = 1;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_2__x = __warp_2__x;
            
            
            
            return (__warp_rc_0, __warp_2__x);
        }else{
        
            
            let __warp_rc_0 = 2;
            
            let __warp_rc_0 = __warp_rc_0;
            
            let __warp_2__x = __warp_2__x;
            
            
            
            return (__warp_rc_0, __warp_2__x);
        }

    }

}


    @view
    func foo_2fbebd38{syscall_ptr : felt*, range_check_ptr : felt}(__warp_0_x : Uint256)-> (__warp_1 : Uint256){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_0_x);
        
        let (__warp_se_0) = warp_lt256(__warp_0_x, Uint256(low=10, high=0));
        
        if (__warp_se_0 != 0){
        
            
            
            
            return (Uint256(low=0, high=0),);
        }else{
        
            
            let (__warp_se_1) = warp_lt256(__warp_0_x, Uint256(low=20, high=0));
            
            if (__warp_se_1 != 0){
            
                
                
                
                return (Uint256(low=1, high=0),);
            }else{
            
                
                
                
                return (Uint256(low=2, high=0),);
            }
        }

    }


    @view
    func ternary_55278c5b{syscall_ptr : felt*, range_check_ptr : felt}(__warp_2__x : Uint256)-> (__warp_3 : Uint256){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_2__x);
        
        let __warp_rc_0 = 0;
        
            
            let (__warp_tv_0, __warp_tv_1) = IfElse.__warp_conditional_ternary_55278c5b_1(__warp_2__x);
            
            let __warp_2__x = __warp_tv_1;
            
            let __warp_rc_0 = __warp_tv_0;
        
        let (__warp_se_3) = warp_uint256(__warp_rc_0);
        
        
        
        return (__warp_se_3,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;


        
        
        
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