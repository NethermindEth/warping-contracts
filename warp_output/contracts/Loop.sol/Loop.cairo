%lang starknet


from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from warplib.maths.lt import warp_lt256
from warplib.maths.add import warp_add256
from warplib.maths.sub import warp_sub256
from warplib.maths.eq import warp_eq256


// Contract Def Loop


namespace Loop{

    // Dynamic variables - Arrays and Maps

    // Static variables


    func __warp_while1{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_1_j : Uint256)-> (__warp_1_j : Uint256){
    alloc_locals;


        
            
            let (__warp_se_0) = warp_lt256(__warp_1_j, Uint256(low=10, high=0));
            
            if (__warp_se_0 != 0){
            
                
                    
                    let (__warp_pse_0) = warp_add256(__warp_1_j, Uint256(low=1, high=0));
                    
                    let __warp_1_j = __warp_pse_0;
                    
                    warp_sub256(__warp_pse_0, Uint256(low=1, high=0));
                
                let (__warp_pse_1) = __warp_while1_if_part1(__warp_1_j);
                
                
                
                return (__warp_pse_1,);
            }else{
            
                
                    
                    
                    
                    return (__warp_1_j,);
            }

    }


    func __warp_while1_if_part1{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_1_j : Uint256)-> (__warp_1_j : Uint256){
    alloc_locals;


        
        
        
        let (__warp_pse_3) = __warp_while1(__warp_1_j);
        
        
        
        return (__warp_pse_3,);

    }


    func __warp_while0{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_i : Uint256)-> (__warp_0_i : Uint256){
    alloc_locals;


        
            
            let (__warp_se_1) = warp_lt256(__warp_0_i, Uint256(low=10, high=0));
            
            if (__warp_se_1 != 0){
            
                
                    
                        
                        let (__warp_se_2) = warp_eq256(__warp_0_i, Uint256(low=3, high=0));
                        
                        if (__warp_se_2 != 0){
                        
                            
                                
                                let (__warp_pse_4) = warp_add256(__warp_0_i, Uint256(low=1, high=0));
                                
                                let __warp_0_i = __warp_pse_4;
                                
                                warp_sub256(__warp_pse_4, Uint256(low=1, high=0));
                                
                                let (__warp_pse_5) = __warp_while0(__warp_0_i);
                                
                                
                                
                                return (__warp_pse_5,);
                        }else{
                        
                            
                            let (__warp_pse_7) = __warp_while0_if_part2(__warp_0_i);
                            
                            
                            
                            return (__warp_pse_7,);
                        }
            }else{
            
                
                    
                    
                    
                    return (__warp_0_i,);
            }

    }


    func __warp_while0_if_part2{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_i : Uint256)-> (__warp_0_i : Uint256){
    alloc_locals;


        
            
                
                let (__warp_se_3) = warp_eq256(__warp_0_i, Uint256(low=5, high=0));
                
                if (__warp_se_3 != 0){
                
                    
                        
                        
                        
                        return (__warp_0_i,);
                }else{
                
                    
                    let (__warp_pse_10) = __warp_while0_if_part2_if_part1(__warp_0_i);
                    
                    
                    
                    return (__warp_pse_10,);
                }

    }


    func __warp_while0_if_part2_if_part1{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_i : Uint256)-> (__warp_0_i : Uint256){
    alloc_locals;


        
            
            
            
            let (__warp_pse_11) = warp_add256(__warp_0_i, Uint256(low=1, high=0));
            
            let __warp_0_i = __warp_pse_11;
            
            warp_sub256(__warp_pse_11, Uint256(low=1, high=0));
        
        let (__warp_pse_12) = __warp_while0_if_part1(__warp_0_i);
        
        
        
        return (__warp_pse_12,);

    }


    func __warp_while0_if_part1{range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_i : Uint256)-> (__warp_0_i : Uint256){
    alloc_locals;


        
        
        
        let (__warp_pse_13) = __warp_while0(__warp_0_i);
        
        
        
        return (__warp_pse_13,);

    }

}


    @external
    func loop_a92100cb{syscall_ptr : felt*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;


        
            
            let __warp_0_i = Uint256(low=0, high=0);
            
            let (__warp_pse_14) = Loop.__warp_while0(__warp_0_i);
            
            let __warp_0_i = __warp_pse_14;
        
        let __warp_1_j = Uint256(low=0, high=0);
        
        let (__warp_pse_15) = Loop.__warp_while1(__warp_1_j);
        
        let __warp_1_j = __warp_pse_15;
        
        
        
        return ();

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