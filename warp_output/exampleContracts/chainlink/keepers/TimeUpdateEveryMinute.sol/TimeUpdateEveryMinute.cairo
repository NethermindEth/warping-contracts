%lang starknet


from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.default_dict import default_dict_finalize, default_dict_new
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.dict import dict_write
from starkware.cairo.common.uint256 import Uint256
from warplib.block_methods import warp_block_timestamp
from warplib.maths.add import warp_add256
from warplib.maths.external_input_check_ints import warp_external_input_check_int8
from warplib.maths.ge import warp_ge256
from warplib.maths.utils import narrow_safe
from warplib.memory import wm_new, wm_read_256, wm_read_felt


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}


func external_input_check_dynamic_array0{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
    warp_external_input_check_int8(ptr[0]);
    external_input_check_dynamic_array0(len = len - 1, ptr = ptr + 1);
    return ();
}


func wm_to_calldata_dynamic_array_reader0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(len: felt, ptr: felt*, mem_loc: felt) -> (){
    alloc_locals;
    if (len == 0){
         return ();
    }
let (mem_read0) = wm_read_felt(mem_loc);
assert ptr[0] = mem_read0;
    wm_to_calldata_dynamic_array_reader0(len=len - 1, ptr=ptr + 1, mem_loc=mem_loc + 1);
    return ();
}
func wm_to_calldata_dynamic_array0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(mem_loc: felt) -> (retData: cd_dynarray_felt){
    alloc_locals;
    let (len_256) = wm_read_256(mem_loc);
    let (ptr : felt*) = alloc();
    let (len_felt) = narrow_safe(len_256);
    wm_to_calldata_dynamic_array_reader0(len_felt, ptr, mem_loc + 2);
    return (cd_dynarray_felt(len=len_felt, ptr=ptr),);
}


func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}


func WS0_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}


// Contract Def TimeUpdateEveryMinute


namespace TimeUpdateEveryMinute{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const interval = 0;

    const __warp_0_nextUpKeepTimeUnix = 2;


    func __warp_init_TimeUpdateEveryMinute{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(interval, Uint256(low=60, high=0));
        
        let (__warp_se_7) = warp_block_timestamp();
        
        let (__warp_se_8) = warp_add256(__warp_se_7, Uint256(low=60, high=0));
        
        WS_WRITE0(__warp_0_nextUpKeepTimeUnix, __warp_se_8);
        
        
        
        return ();

    }

}


    @view
    func checkUpkeep_6e04ff0d{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(checkData_len : felt, checkData : felt*)-> (__warp_1_upkeepNeeded : felt, performData_len : felt, performData : felt*){
    alloc_locals;
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        external_input_check_dynamic_array0(checkData_len, checkData);
        
        let (performData) = wm_new(Uint256(low=0, high=0), Uint256(low=1, high=0));
        
        let __warp_1_upkeepNeeded = 0;
        
        let (__warp_se_0) = warp_block_timestamp();
        
        let (__warp_se_1) = WS0_READ_Uint256(TimeUpdateEveryMinute.__warp_0_nextUpKeepTimeUnix);
        
        let (__warp_se_2) = warp_ge256(__warp_se_0, __warp_se_1);
        
        let __warp_1_upkeepNeeded = __warp_se_2;
        
        let __warp_1_upkeepNeeded = __warp_1_upkeepNeeded;
        
        let performData = performData;
        
        let (__warp_se_3) = wm_to_calldata_dynamic_array0(performData);
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return (__warp_1_upkeepNeeded, __warp_se_3.len, __warp_se_3.ptr);
    }
    }


    @external
    func performUpkeep_4585e33b{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(performData_len : felt, performData : felt*)-> (){
    alloc_locals;


        
        external_input_check_dynamic_array0(performData_len, performData);
        
        let (__warp_se_4) = warp_block_timestamp();
        
        let (__warp_se_5) = warp_add256(__warp_se_4, Uint256(low=60, high=0));
        
        WS_WRITE0(TimeUpdateEveryMinute.__warp_0_nextUpKeepTimeUnix, __warp_se_5);
        
        
        
        return ();

    }


    @view
    func interval_947a36fb{syscall_ptr : felt*, range_check_ptr : felt}()-> (__warp_2 : Uint256){
    alloc_locals;


        
        
        
        return (Uint256(low=60, high=0),);

    }


    @view
    func nextUpKeepTimeUnix_05a4f69a{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_3 : Uint256){
    alloc_locals;


        
        let (__warp_se_6) = WS0_READ_Uint256(TimeUpdateEveryMinute.__warp_0_nextUpKeepTimeUnix);
        
        
        
        return (__warp_se_6,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(4);


        
        TimeUpdateEveryMinute.__warp_init_TimeUpdateEveryMinute();
        
        
        
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