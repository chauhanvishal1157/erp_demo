import 'package:equatable/equatable.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/model/employee_list_model.dart';

abstract class EmployeeListState extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialEmployeeListState extends EmployeeListState {}

class LoadingEmployeeListState extends EmployeeListState {}

class LoadedEmployeeListState extends EmployeeListState {
  final List<EmployeeListModel> list;
  final bool hasNextPage;
  final int totalCount;

  LoadedEmployeeListState({
    required this.list,
    required this.hasNextPage,
    required this.totalCount,
  });

  @override
  List<Object> get props => [hasNextPage,list];
}

class FailureEmployeeListState extends EmployeeListState {
  final String error;

  FailureEmployeeListState({required this.error});

  @override
  List<Object> get props => [error];
}
