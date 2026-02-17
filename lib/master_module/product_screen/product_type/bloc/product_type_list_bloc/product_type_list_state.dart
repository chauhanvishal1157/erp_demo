import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/product_screen/product_type/model/product_type_list_model.dart';

abstract class ProductTypeListStates extends Equatable{

  @override
  List<Object> get props => [];

}

class InitialProductTypeListStates extends ProductTypeListStates{}

class LoadingProductTypeListStates extends ProductTypeListStates{}

class LoadedProductTypeListStates extends ProductTypeListStates{

  final List<ProductTypeListModel> list;

  LoadedProductTypeListStates({required this.list});

  @override
  List<Object> get props => [list,];

}

class FailureProductTypeListStates extends ProductTypeListStates{

  final String error;
  FailureProductTypeListStates({required this.error});

  @override
  List<Object> get props => [error,];
}