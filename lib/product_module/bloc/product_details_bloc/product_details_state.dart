import 'package:equatable/equatable.dart';
import 'package:erp_demo/product_module/model/product_details_model/product_details_model.dart';

abstract class ProductDetailsState extends Equatable{

  @override
  List<Object?> get props => [];
}

class InitialProductDetailsState extends ProductDetailsState{}

class LoadingProductDetailsState extends ProductDetailsState{}

class LoadedProductDetailsState extends ProductDetailsState{
  final List<ProductDetailsModel> list;

  LoadedProductDetailsState({required this.list});

  @override
  List<Object?> get props => [list];
}

class FailureProductDetailsState extends ProductDetailsState{
  final String error;

  FailureProductDetailsState({required this.error});

  @override
  List<Object?> get props => [error];
}