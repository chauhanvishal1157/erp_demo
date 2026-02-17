import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/admin_screen/lead_status/model/lead_status_list_model.dart';

abstract class LeadStatusListStates extends Equatable{

  @override
  List<Object> get props => [];

}

class InitialLeadStatusListStates extends LeadStatusListStates{}

class LoadingLeadStatusListStates extends LeadStatusListStates{}

class LoadedLeadStatusListStates extends LeadStatusListStates{
  final List<LeadStatusListModel> list;

  LoadedLeadStatusListStates({required this.list});


  @override
  List<Object> get props => [list,];

}

class FailureLeadStatusListStates extends LeadStatusListStates {
  final String error;

  FailureLeadStatusListStates({required this.error});

  @override
  List<Object> get props => [error];
}
