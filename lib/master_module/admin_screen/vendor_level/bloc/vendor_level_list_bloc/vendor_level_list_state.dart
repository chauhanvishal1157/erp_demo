import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/model/vendor_level_list_model.dart';

abstract class VendorLevelListStates extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialVendorLevelListStates extends VendorLevelListStates{}

class LoadingVendorLevelListStates extends VendorLevelListStates{}

class LoadedVendorLevelListStates extends VendorLevelListStates{

  final List<VendorLevelListModel> list;

  LoadedVendorLevelListStates({required this.list});

  @override
  List<Object> get props => [list];
}

class FailureVendorLevelListStates extends VendorLevelListStates{

  final String error;

  FailureVendorLevelListStates({required this.error});

  @override
  List<Object> get props => [error];
}

