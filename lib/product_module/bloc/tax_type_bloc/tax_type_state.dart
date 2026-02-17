import 'package:equatable/equatable.dart';
import 'package:erp_demo/product_module/model/tax_type_model/tax_type_model.dart';

abstract class TaxTypeState extends Equatable {

  @override
  List<Object?> get props => [];
}


class InitialTaxTypeState extends TaxTypeState{}

class LoadingTaxTypeState extends TaxTypeState{}

class LoadedTaxTypeState extends TaxTypeState{
  final List<TaxTypeModel> list;

  LoadedTaxTypeState({required this.list});

  @override
  List<Object?> get props => [list];
}

class FailureTaxTypeState extends TaxTypeState{
  final String error;

  FailureTaxTypeState({required this.error});

  @override
  List<Object?> get props => [error];
}