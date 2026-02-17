import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/product_screen/brand/model/brand_list_model.dart';

abstract class BrandListStates extends Equatable{

  @override
  List<Object> get props => [];

}

class InitialBrandListStates extends BrandListStates{}

class LoadingBrandListStates extends BrandListStates{}

class LoadedBrandListStates extends BrandListStates{

  final List<BrandListModel> list;

  LoadedBrandListStates({required this.list,});

  @override
  List<Object> get props => [list,];

}

class FailureBrandListStates extends BrandListStates{

  final String error;

  FailureBrandListStates({required this.error});

  @override
  List<Object> get props => [error,];

}