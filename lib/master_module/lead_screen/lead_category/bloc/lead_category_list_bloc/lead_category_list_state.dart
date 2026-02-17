
import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/model/lead_category_list_model.dart';


abstract class LeadCategoryListStates extends Equatable{


  @override
  List<Object> get props => [];
}

class InitialLeadCategoryListStates extends LeadCategoryListStates{
}

class LoadingLeadCategoryListStates extends LeadCategoryListStates{
}

class LoadedLeadCategoryListStates extends LeadCategoryListStates{
  final List<LeadCategoryListModel> list;

  LoadedLeadCategoryListStates({required this.list});


  @override
  List<Object> get props => [list,];

}

class FailureLeadCategoryListStates extends LeadCategoryListStates {
  final String error;

  FailureLeadCategoryListStates({required this.error});

  @override
  List<Object> get props => [error];
}