%lang starknet


from warplib.maths.external_input_check_address import warp_external_input_check_address
from starkware.cairo.common.cairo_builtins import HashBuiltin


// Contract Def MinimalProxy


namespace MinimalProxy{

    // Dynamic variables - Arrays and Maps

    // Static variables

}


    @external
    func clone_8124b78e{syscall_ptr : felt*, range_check_ptr : felt}(target : felt)-> (result : felt){
    alloc_locals;


        
        warp_external_input_check_address(target);
        
        let result = 0;
        
        
        
        return (result,);

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