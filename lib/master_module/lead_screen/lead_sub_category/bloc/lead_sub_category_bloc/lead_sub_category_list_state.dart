import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/model/lead_sub_category_model.dart';

abstract class LeadSubCategoryListStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLeadSubCategoryListStates extends LeadSubCategoryListStates{}

class LoadingLeadSubCategoryListStates extends LeadSubCategoryListStates{}

class LoadedLeadSubCategoryListStates extends LeadSubCategoryListStates{

  final List<LeadSubCategoryListModel> list;

  LoadedLeadSubCategoryListStates({required this.list});

  @override
  List<Object> get props => [list];

}

class FailureLeadSubCategoryListStates extends LeadSubCategoryListStates{

  final String error;

  FailureLeadSubCategoryListStates({required this.error});

  @override
  List<Object> get props => [error];

}
