import 'package:equatable/equatable.dart';
import 'package:erp_demo/product_module/model/product_list_model/product_list_model.dart';

abstract class ProductListState extends Equatable{

  @override
  List<Object?> get props => [];
}

class InitialProductListState extends ProductListState{}

class LoadingProductListState extends ProductListState{}

class LoadedProductListState extends ProductListState{
  final List<ProductListModel> list;

  LoadedProductListState({required this.list});

  @override
  List<Object?> get props => [list];
}

class FailureProductListState extends ProductListState{
  final String error;

  FailureProductListState({required this.error});

  @override
  List<Object?> get props => [error];
}