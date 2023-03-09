%lang starknet


// Contract Def KeeperCompatibleInterface


@contract_interface
namespace KeeperCompatibleInterface{
func checkUpkeep_6e04ff0d(checkData_len : felt, checkData : felt*)-> (upkeepNeeded : felt, performData_len : felt, performData : felt*){
}
func performUpkeep_4585e33b(performData_len : felt, performData : felt*)-> (){
}
}