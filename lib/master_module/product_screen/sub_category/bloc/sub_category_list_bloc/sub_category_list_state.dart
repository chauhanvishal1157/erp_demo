import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/model/sub_category_list_model.dart';

abstract class SubCategoryListStates extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialSubCategoryListStates extends SubCategoryListStates{}

class LoadingSubCategoryListStates extends SubCategoryListStates{}

class LoadedSubCategoryListStates extends SubCategoryListStates{

  final List<SubCategoryListModel> list;

  LoadedSubCategoryListStates({required this.list});

  @override
  List<Object> get props => [list];

}

class FailureSubCategoryListState extends SubCategoryListStates{

  final String error;

  FailureSubCategoryListState({required this.error});

  @override
  List<Object> get props => [error];


}