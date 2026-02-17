import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/model/tax_master_list_model.dart';

abstract class TaxMasterListStates extends Equatable {

  @override
  List<Object> get props => [];

}

class InitialTaxMasterListStates extends TaxMasterListStates{}

class LoadingTaxMasterListStates extends TaxMasterListStates{}

class LoadedTaxMasterListStates extends TaxMasterListStates{

  final List<TaxMasterListModel> list;

  LoadedTaxMasterListStates({required this.list});

  @override
  List<Object> get props => [list];

}

class FailureTaxMasterListStates extends TaxMasterListStates{

  final String error;

  FailureTaxMasterListStates({required this.error});

  @override
  List<Object> get props => [error];

}
