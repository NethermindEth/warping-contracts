%lang starknet


from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin
from warplib.maths.add import warp_add256


func WS0_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}


// Contract Def Gas


namespace Gas{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const __warp_0_i = 0;


    func __warp_while0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
            
            if (1 != 0){
            
                
                    
                    let (__warp_se_0) = WS0_READ_Uint256(__warp_0_i);
                    
                    let (__warp_se_1) = warp_add256(__warp_se_0, Uint256(low=1, high=0));
                    
                    WS_WRITE0(__warp_0_i, __warp_se_1);
                
                __warp_while0_if_part1();
                
                let __warp_uv0 = ();
                
                
                
                return ();
            }else{
            
                
                    
                    let __warp_uv1 = ();
                    
                    
                    
                    return ();
            }

    }


    func __warp_while0_if_part1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        
        
        __warp_while0();
        
        let __warp_uv2 = ();
        
        
        
        return ();

    }


    func __warp_init_Gas{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_i, Uint256(low=0, high=0));
        
        
        
        return ();

    }

}


    @external
    func forever_9ff9a603{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        Gas.__warp_while0();
        
        
        
        return ();

    }


    @view
    func i_e5aa3d58{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_1 : Uint256){
    alloc_locals;


        
        let (__warp_se_2) = WS0_READ_Uint256(Gas.__warp_0_i);
        
        
        
        return (__warp_se_2,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(2);


        
        Gas.__warp_init_Gas();
        
        
        
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