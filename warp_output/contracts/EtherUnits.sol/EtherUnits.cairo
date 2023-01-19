%lang starknet


from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin


func WS0_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}

func WS1_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}

func WS_WRITE1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}


// Contract Def EtherUnits


namespace EtherUnits{

    // Dynamic variables - Arrays and Maps

    // Static variables

    const __warp_0_oneWei = 0;

    const __warp_1_isOneWei = 2;

    const __warp_2_oneEther = 3;

    const __warp_3_isOneEther = 5;


    func __warp_init_EtherUnits{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (){
    alloc_locals;


        
        WS_WRITE0(__warp_0_oneWei, Uint256(low=1, high=0));
        
        WS_WRITE1(__warp_1_isOneWei, 1);
        
        WS_WRITE0(__warp_2_oneEther, Uint256(low=1000000000000000000, high=0));
        
        WS_WRITE1(__warp_3_isOneEther, 1);
        
        
        
        return ();

    }

}


    @view
    func oneWei_4fb2e0be{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_4 : Uint256){
    alloc_locals;


        
        let (__warp_se_0) = WS0_READ_Uint256(EtherUnits.__warp_0_oneWei);
        
        
        
        return (__warp_se_0,);

    }


    @view
    func isOneWei_28dc556f{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_5 : felt){
    alloc_locals;


        
        let (__warp_se_1) = WS1_READ_felt(EtherUnits.__warp_1_isOneWei);
        
        
        
        return (__warp_se_1,);

    }


    @view
    func oneEther_d297a89f{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_6 : Uint256){
    alloc_locals;


        
        let (__warp_se_2) = WS0_READ_Uint256(EtherUnits.__warp_2_oneEther);
        
        
        
        return (__warp_se_2,);

    }


    @view
    func isOneEther_cf0f5d29{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_7 : felt){
    alloc_locals;


        
        let (__warp_se_3) = WS1_READ_felt(EtherUnits.__warp_3_isOneEther);
        
        
        
        return (__warp_se_3,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(6);


        
        EtherUnits.__warp_init_EtherUnits();
        
        
        
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