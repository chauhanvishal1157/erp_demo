import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/model/employee_category_list_model.dart';

abstract class EmployeeCategoryListStates extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialEmployeeCategoryListStates extends EmployeeCategoryListStates{}

class LoadingEmployeeCategoryListStates extends EmployeeCategoryListStates{}

class LoadedEmployeeCategoryListStates extends EmployeeCategoryListStates{

  final List<EmployeeCategoryListModel> list;

  LoadedEmployeeCategoryListStates({required this.list});

  @override
  List<Object> get props => [list];
}

class FailureEmployeeCategoryListStates extends EmployeeCategoryListStates{

  final String error;

  FailureEmployeeCategoryListStates({required this.error});

  @override
  List<Object> get props => [error];
}

