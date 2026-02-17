import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/model/visit_area_customer_list_model.dart';

abstract class VisitAreaCustomerListStates extends Equatable{

  @override
  List<Object> get props => [];

}

class InitialVisitAreaCustomerListStates extends VisitAreaCustomerListStates{}

class LoadingVisitAreaCustomerListStates extends VisitAreaCustomerListStates{}

class LoadedVisitAreaCustomerListStates extends VisitAreaCustomerListStates{

  final List<VisitAreaCustomerListModel> list;
  final bool hasNextPage;
  final int totalCount;

  LoadedVisitAreaCustomerListStates({
    required this.list,
    required this.hasNextPage,
    required this.totalCount,
  });

  @override
  List<Object> get props => [list,hasNextPage];

}

class FailureVisitAreaCustomerListStates extends VisitAreaCustomerListStates{

  final String error;

  FailureVisitAreaCustomerListStates({
    required this.error,
  });

  @override
  List<Object> get props => [error];

}

class InitialCreateMasterBranchState extends VisitAreaCustomerListStates {}

class LoadingCreateMasterBranchState extends VisitAreaCustomerListStates {}

class LoadedCreateMasterBranchState extends VisitAreaCustomerListStates {
  final String message;

  LoadedCreateMasterBranchState({
    required this.message,
  });
}

class FailureCreateMasterBranchState extends VisitAreaCustomerListStates {
  final String error;

  FailureCreateMasterBranchState({
    required this.error,
  });
}