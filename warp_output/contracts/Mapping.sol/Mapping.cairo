%lang starknet


from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin


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


// Contract Def Mapping


namespace Mapping{

    // Dynamic variables - Arrays and Maps

    const __warp_0_myMap = 1;

    // Static variables

}


    @view
    func get_c2bc2efc{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_1__addr : felt)-> (__warp_2 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_1__addr);
        
        let (__warp_se_0) = WS0_INDEX_felt_to_Uint256(Mapping.__warp_0_myMap, __warp_1__addr);
        
        let (__warp_se_1) = WS0_READ_Uint256(__warp_se_0);
        
        
        
        return (__warp_se_1,);

    }


    @external
    func set_3825d828{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_3__addr : felt, __warp_4__i : Uint256)-> (){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_4__i);
        
        warp_external_input_check_address(__warp_3__addr);
        
        let (__warp_se_2) = WS0_INDEX_felt_to_Uint256(Mapping.__warp_0_myMap, __warp_3__addr);
        
        WS_WRITE0(__warp_se_2, __warp_4__i);
        
        
        
        return ();

    }


    @external
    func remove_29092d0e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_5__addr : felt)-> (){
    alloc_locals;


        
        warp_external_input_check_address(__warp_5__addr);
        
        let (__warp_se_3) = WS0_INDEX_felt_to_Uint256(Mapping.__warp_0_myMap, __warp_5__addr);
        
        WS_WRITE0(__warp_se_3, Uint256(low=0, high=0));
        
        
        
        return ();

    }


    @view
    func myMap_27cbd529{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_6__i0 : felt)-> (__warp_7 : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_6__i0);
        
        let (__warp_se_4) = WS0_INDEX_felt_to_Uint256(Mapping.__warp_0_myMap, __warp_6__i0);
        
        let (__warp_se_5) = WS0_READ_Uint256(__warp_se_4);
        
        
        
        return (__warp_se_5,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(1);
    WARP_NAMEGEN.write(1);


        
        
        
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