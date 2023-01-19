%lang starknet


from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from warplib.maths.external_input_check_bool import warp_external_input_check_bool
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin


func WS0_READ_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = readId(loc);
    return (read0,);
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

@storage_var
func WARP_MAPPING0(name: felt, index: Uint256) -> (resLoc : felt){
}
func WS0_INDEX_Uint256_to_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: Uint256) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING0.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_MAPPING0.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}

@storage_var
func WARP_MAPPING1(name: felt, index: felt) -> (resLoc : felt){
}
func WS1_INDEX_felt_to_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING1.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_MAPPING1.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}


// Contract Def NestedMapping


namespace NestedMapping{

    // Dynamic variables - Arrays and Maps

    const __warp_0_nested = 1;

    // Static variables

}


    @view
    func get_b464631b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_1__addr1 : felt, __warp_2__i : Uint256)-> (__warp_3 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_2__i);
        
        warp_external_input_check_address(__warp_1__addr1);
        
        let (__warp_se_0) = WS1_INDEX_felt_to_warp_id(NestedMapping.__warp_0_nested, __warp_1__addr1);
        
        let (__warp_se_1) = WS0_READ_warp_id(__warp_se_0);
        
        let (__warp_se_2) = WS0_INDEX_Uint256_to_felt(__warp_se_1, __warp_2__i);
        
        let (__warp_se_3) = WS1_READ_felt(__warp_se_2);
        
        
        
        return (__warp_se_3,);

    }


    @external
    func set_0b139194{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_4__addr1 : felt, __warp_5__i : Uint256, __warp_6__boo : felt)-> (){
    alloc_locals;


        
        warp_external_input_check_bool(__warp_6__boo);
        
        warp_external_input_check_int256(__warp_5__i);
        
        warp_external_input_check_address(__warp_4__addr1);
        
        let (__warp_se_4) = WS1_INDEX_felt_to_warp_id(NestedMapping.__warp_0_nested, __warp_4__addr1);
        
        let (__warp_se_5) = WS0_READ_warp_id(__warp_se_4);
        
        let (__warp_se_6) = WS0_INDEX_Uint256_to_felt(__warp_se_5, __warp_5__i);
        
        WS_WRITE0(__warp_se_6, __warp_6__boo);
        
        
        
        return ();

    }


    @external
    func remove_abe7f1ab{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_7__addr1 : felt, __warp_8__i : Uint256)-> (){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_8__i);
        
        warp_external_input_check_address(__warp_7__addr1);
        
        let (__warp_se_7) = WS1_INDEX_felt_to_warp_id(NestedMapping.__warp_0_nested, __warp_7__addr1);
        
        let (__warp_se_8) = WS0_READ_warp_id(__warp_se_7);
        
        let (__warp_se_9) = WS0_INDEX_Uint256_to_felt(__warp_se_8, __warp_8__i);
        
        WS_WRITE0(__warp_se_9, 0);
        
        
        
        return ();

    }


    @view
    func nested_14bd0a7b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_9__i0 : felt, __warp_10__i1 : Uint256)-> (__warp_11 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_10__i1);
        
        warp_external_input_check_address(__warp_9__i0);
        
        let (__warp_se_10) = WS1_INDEX_felt_to_warp_id(NestedMapping.__warp_0_nested, __warp_9__i0);
        
        let (__warp_se_11) = WS0_READ_warp_id(__warp_se_10);
        
        let (__warp_se_12) = WS0_INDEX_Uint256_to_felt(__warp_se_11, __warp_10__i1);
        
        let (__warp_se_13) = WS1_READ_felt(__warp_se_12);
        
        
        
        return (__warp_se_13,);

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