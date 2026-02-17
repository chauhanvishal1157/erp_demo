import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/product_screen/category/model/category_list_model.dart';

abstract class CategoryListStates extends Equatable{

  @override
  List<Object> get props => [];

}

class InitialCategoryListStates extends CategoryListStates{}

class LoadingCategoryListStates extends CategoryListStates{}

class LoadedCategoryListStates extends CategoryListStates{

  final List<CategoryListModel> list;

  LoadedCategoryListStates({required this.list});

  @override
  List<Object> get props => [list,];

}

class FailureCategoryListStates extends CategoryListStates{

  final String error;

  FailureCategoryListStates({required this.error});

  @override
  List<Object> get props => [error,];
}

