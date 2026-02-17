import 'package:equatable/equatable.dart';
import 'package:erp_demo/vendor_module/vendor_screen/model/vendor_list_model/vendor_list_model.dart';

abstract class VendorListState extends Equatable{

  @override
  List<Object> get props => [];
}

class InitialVendorListState extends VendorListState{}

class LoadingVendorListState extends VendorListState{}

class LoadedVendorListState extends VendorListState{
  final List<VendorListModel> list;

  LoadedVendorListState({required this.list});

  @override
  List<Object> get props => [list];

}

class FailureVendorListState extends VendorListState{
  final String error;

  FailureVendorListState({required this.error});

  @override
  List<Object> get props => [error];

}
