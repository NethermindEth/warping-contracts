%lang starknet


from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.uint256 import Uint256
from warplib.maths.bytes_conversions import warp_bytes_narrow_256
from starkware.starknet.common.syscalls import deploy
from starkware.cairo.common.cairo_builtins import HashBuiltin


// @declare contracts/Applications/Create2Factory.sol/TestContract.cairo
const TestContract_class_hash_382c4ec8 = 0;


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

func encode_as_felt0(arg_0 : felt,arg_1 : Uint256) -> (calldata_array : cd_dynarray_felt){
   alloc_locals;
   let total_size : felt = 0;
   let (decode_array : felt*) = alloc();
assert decode_array[total_size] = arg_0;
let total_size = total_size + 1;
assert decode_array[total_size] = arg_1.low;
assert decode_array[total_size + 1] = arg_1.high;
let total_size = total_size + 2;
   let result = cd_dynarray_felt(total_size, decode_array);
   return (result,);
}


// Contract Def Factory


namespace Factory{

    // Dynamic variables - Arrays and Maps

    // Static variables

}


    @external
    func deploy_e7008afa{syscall_ptr : felt*, range_check_ptr : felt}(__warp_0__owner : felt, __warp_1__foo : Uint256, __warp_2__salt : Uint256)-> (__warp_3 : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_2__salt);
        
        warp_external_input_check_int256(__warp_1__foo);
        
        warp_external_input_check_address(__warp_0__owner);
        
        let (__warp_se_0) = warp_bytes_narrow_256(__warp_2__salt, 8);
        
        let (__warp_se_1) = encode_as_felt0(__warp_0__owner, __warp_1__foo);
        
        let (__warp_se_2) = deploy(TestContract_class_hash_382c4ec8,__warp_se_0,__warp_se_1.len, __warp_se_1.ptr,0);
        
        
        
        return (__warp_se_2,);

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