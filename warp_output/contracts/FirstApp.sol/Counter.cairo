%lang starknet


from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from warplib.maths.add import warp_add256
from warplib.maths.sub import warp_sub256


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


// Contract Def Counter


namespace Counter{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const __warp_0_count = 0;

}


    @view
    func get_6d4ce63c{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_1 : Uint256){
    alloc_locals;


        
        let (__warp_se_0) = WS0_READ_Uint256(Counter.__warp_0_count);
        
        
        
        return (__warp_se_0,);

    }


    @external
    func inc_371303c0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        let (__warp_se_1) = WS0_READ_Uint256(Counter.__warp_0_count);
        
        let (__warp_se_2) = warp_add256(__warp_se_1, Uint256(low=1, high=0));
        
        WS_WRITE0(Counter.__warp_0_count, __warp_se_2);
        
        
        
        return ();

    }


    @external
    func dec_b3bcfa82{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}()-> (){
    alloc_locals;


        
        let (__warp_se_3) = WS0_READ_Uint256(Counter.__warp_0_count);
        
        let (__warp_se_4) = warp_sub256(__warp_se_3, Uint256(low=1, high=0));
        
        WS_WRITE0(Counter.__warp_0_count, __warp_se_4);
        
        
        
        return ();

    }


    @view
    func count_06661abd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_2 : Uint256){
    alloc_locals;


        
        let (__warp_se_5) = WS0_READ_Uint256(Counter.__warp_0_count);
        
        
        
        return (__warp_se_5,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(2);


        
        
        
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