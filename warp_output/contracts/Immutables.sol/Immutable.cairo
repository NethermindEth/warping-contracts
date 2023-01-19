%lang starknet


from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address


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


// Contract Def Immutable


namespace Immutable{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const __warp_0_MY_ADDRESS = 0;

    const __warp_1_MY_UINT = 1;


    func __warp_constructor_0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_2__myUint : Uint256)-> (){
    alloc_locals;


        
        let (__warp_se_0) = get_caller_address();
        
        WS_WRITE0(__warp_0_MY_ADDRESS, __warp_se_0);
        
        WS_WRITE1(__warp_1_MY_UINT, __warp_2__myUint);
        
        
        
        return ();

    }

}


    @view
    func MY_ADDRESS_3a756cec{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_3 : felt){
    alloc_locals;


        
        let (__warp_se_1) = WS0_READ_felt(Immutable.__warp_0_MY_ADDRESS);
        
        
        
        return (__warp_se_1,);

    }


    @view
    func MY_UINT_1f6649e3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_4 : Uint256){
    alloc_locals;


        
        let (__warp_se_2) = WS1_READ_Uint256(Immutable.__warp_1_MY_UINT);
        
        
        
        return (__warp_se_2,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_2__myUint : Uint256){
    alloc_locals;
    WARP_USED_STORAGE.write(3);


        
        warp_external_input_check_int256(__warp_2__myUint);
        
        Immutable.__warp_constructor_0(__warp_2__myUint);
        
        
        
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