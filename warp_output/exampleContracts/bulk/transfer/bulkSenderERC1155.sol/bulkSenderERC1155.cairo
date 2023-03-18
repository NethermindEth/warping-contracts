%lang starknet


from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from starkware.starknet.common.syscalls import get_caller_address
from warplib.maths.add_unsafe import warp_add_unsafe256
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256, warp_external_input_check_int8
from warplib.maths.int_conversions import warp_int256_to_int248
from warplib.maths.lt import warp_lt256
from warplib.maths.utils import felt_to_uint256


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}


struct cd_dynarray_Uint256{
     len : felt ,
     ptr : Uint256*,
}


func external_input_check_dynamic_array0{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
    warp_external_input_check_address(ptr[0]);
    external_input_check_dynamic_array0(len = len - 1, ptr = ptr + 1);
    return ();
}


func external_input_check_dynamic_array1{range_check_ptr : felt}(len: felt, ptr : Uint256*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
    warp_external_input_check_int256(ptr[0]);
    external_input_check_dynamic_array1(len = len - 1, ptr = ptr + 2);
    return ();
}


func external_input_check_dynamic_array2{range_check_ptr : felt}(len: felt, ptr : felt*) -> (){
    alloc_locals;
    if (len == 0){
        return ();
    }
    warp_external_input_check_int8(ptr[0]);
    external_input_check_dynamic_array2(len = len - 1, ptr = ptr + 1);
    return ();
}


// Contract Def bulkSenderERC1155


namespace bulkSenderERC1155{

    // Dynamic variables - Arrays and Maps

    // Static variables


    func __warp_while0{syscall_ptr : felt*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_5_i : Uint256, __warp_1_toList_dstruct : cd_dynarray_felt, __warp_0_nftAddress : felt, __warp_2_tokenIds_dstruct : cd_dynarray_Uint256, __warp_3_amounts_dstruct : cd_dynarray_Uint256, __warp_4_data_dstruct : cd_dynarray_felt)-> (__warp_5_i : Uint256, __warp_1_toList_dstruct : cd_dynarray_felt, __warp_0_nftAddress : felt, __warp_2_tokenIds_dstruct : cd_dynarray_Uint256, __warp_3_amounts_dstruct : cd_dynarray_Uint256, __warp_4_data_dstruct : cd_dynarray_felt){
    alloc_locals;


        
            
            let (__warp_se_0) = felt_to_uint256(__warp_1_toList_dstruct.len);
            
            let (__warp_se_1) = warp_lt256(__warp_5_i, __warp_se_0);
            
                
                if (__warp_se_1 != 0){
                
                    
                        
                        let (__warp_se_2) = get_caller_address();
                        
                        let (__warp_se_3) = warp_int256_to_int248(__warp_5_i);
                        
                        IERC1155_warped_interface.safeBatchTransferFrom_2eb2c2d6(__warp_0_nftAddress, __warp_se_2, __warp_1_toList_dstruct.ptr[__warp_se_3], __warp_2_tokenIds_dstruct.len, __warp_2_tokenIds_dstruct.ptr, __warp_3_amounts_dstruct.len, __warp_3_amounts_dstruct.ptr, __warp_4_data_dstruct.len, __warp_4_data_dstruct.ptr);
                        
                            
                            let (__warp_se_4) = warp_add_unsafe256(__warp_5_i, Uint256(low=1, high=0));
                            
                            let __warp_5_i = __warp_se_4;
                    tempvar range_check_ptr = range_check_ptr;
                    tempvar syscall_ptr = syscall_ptr;
                    tempvar bitwise_ptr = bitwise_ptr;
                    tempvar __warp_5_i = __warp_5_i;
                    tempvar __warp_1_toList_dstruct = __warp_1_toList_dstruct;
                    tempvar __warp_0_nftAddress = __warp_0_nftAddress;
                    tempvar __warp_2_tokenIds_dstruct = __warp_2_tokenIds_dstruct;
                    tempvar __warp_3_amounts_dstruct = __warp_3_amounts_dstruct;
                    tempvar __warp_4_data_dstruct = __warp_4_data_dstruct;
                }else{
                
                    
                    let __warp_5_i = __warp_5_i;
                    
                    let __warp_1_toList_dstruct = __warp_1_toList_dstruct;
                    
                    let __warp_0_nftAddress = __warp_0_nftAddress;
                    
                    let __warp_2_tokenIds_dstruct = __warp_2_tokenIds_dstruct;
                    
                    let __warp_3_amounts_dstruct = __warp_3_amounts_dstruct;
                    
                    let __warp_4_data_dstruct = __warp_4_data_dstruct;
                    
                    
                    
                    return (__warp_5_i, __warp_1_toList_dstruct, __warp_0_nftAddress, __warp_2_tokenIds_dstruct, __warp_3_amounts_dstruct, __warp_4_data_dstruct);
                }
                tempvar range_check_ptr = range_check_ptr;
                tempvar syscall_ptr = syscall_ptr;
                tempvar bitwise_ptr = bitwise_ptr;
                tempvar __warp_5_i = __warp_5_i;
                tempvar __warp_1_toList_dstruct = __warp_1_toList_dstruct;
                tempvar __warp_0_nftAddress = __warp_0_nftAddress;
                tempvar __warp_2_tokenIds_dstruct = __warp_2_tokenIds_dstruct;
                tempvar __warp_3_amounts_dstruct = __warp_3_amounts_dstruct;
                tempvar __warp_4_data_dstruct = __warp_4_data_dstruct;
        
        let (__warp_5_i, __warp_td_0, __warp_0_nftAddress, __warp_td_1, __warp_td_2, __warp_td_3) = __warp_while0(__warp_5_i, __warp_1_toList_dstruct, __warp_0_nftAddress, __warp_2_tokenIds_dstruct, __warp_3_amounts_dstruct, __warp_4_data_dstruct);
        
        let __warp_1_toList_dstruct = __warp_td_0;
        
        let __warp_2_tokenIds_dstruct = __warp_td_1;
        
        let __warp_3_amounts_dstruct = __warp_td_2;
        
        let __warp_4_data_dstruct = __warp_td_3;
        
        
        
        return (__warp_5_i, __warp_1_toList_dstruct, __warp_0_nftAddress, __warp_2_tokenIds_dstruct, __warp_3_amounts_dstruct, __warp_4_data_dstruct);

    }

}


    @external
    func bulkTransfer_c94a18c3{syscall_ptr : felt*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_0_nftAddress : felt, __warp_1_toList_len : felt, __warp_1_toList : felt*, __warp_2_tokenIds_len : felt, __warp_2_tokenIds : Uint256*, __warp_3_amounts_len : felt, __warp_3_amounts : Uint256*, __warp_4_data_len : felt, __warp_4_data : felt*)-> (){
    alloc_locals;


        
        external_input_check_dynamic_array2(__warp_4_data_len, __warp_4_data);
        
        external_input_check_dynamic_array1(__warp_3_amounts_len, __warp_3_amounts);
        
        external_input_check_dynamic_array1(__warp_2_tokenIds_len, __warp_2_tokenIds);
        
        external_input_check_dynamic_array0(__warp_1_toList_len, __warp_1_toList);
        
        warp_external_input_check_address(__warp_0_nftAddress);
        
        local __warp_4_data_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_4_data_len, __warp_4_data);
        
        local __warp_3_amounts_dstruct : cd_dynarray_Uint256 = cd_dynarray_Uint256(__warp_3_amounts_len, __warp_3_amounts);
        
        local __warp_2_tokenIds_dstruct : cd_dynarray_Uint256 = cd_dynarray_Uint256(__warp_2_tokenIds_len, __warp_2_tokenIds);
        
        local __warp_1_toList_dstruct : cd_dynarray_felt = cd_dynarray_felt(__warp_1_toList_len, __warp_1_toList);
        
            
            let __warp_5_i = Uint256(low=0, high=0);
            
                
                let (__warp_tv_0, __warp_td_4, __warp_tv_2, __warp_td_5, __warp_td_6, __warp_td_7) = bulkSenderERC1155.__warp_while0(__warp_5_i, __warp_1_toList_dstruct, __warp_0_nftAddress, __warp_2_tokenIds_dstruct, __warp_3_amounts_dstruct, __warp_4_data_dstruct);
                
                let __warp_tv_1 = __warp_td_4;
                
                let __warp_tv_3 = __warp_td_5;
                
                let __warp_tv_4 = __warp_td_6;
                
                let __warp_tv_5 = __warp_td_7;
                
                let __warp_0_nftAddress = __warp_tv_2;
                
                let __warp_5_i = __warp_tv_0;
        
        
        
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


// Contract Def IERC1155@interface


@contract_interface
namespace IERC1155_warped_interface{
func safeBatchTransferFrom_2eb2c2d6(__warp_0_from : felt, to : felt, ids_len : felt, ids : Uint256*, amounts_len : felt, amounts : Uint256*, data_len : felt, data : felt*)-> (){
}
}