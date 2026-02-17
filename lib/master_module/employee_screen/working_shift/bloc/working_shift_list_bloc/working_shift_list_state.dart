import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/employee_screen/working_shift/model/working_shift_list_model.dart';

abstract class WorkingShiftListStates extends Equatable{

  @override
  List<Object> get props => [];

}

class InitialWorkingShiftListStates extends WorkingShiftListStates{}

class LoadingWorkingShiftListStates extends WorkingShiftListStates{}

class LoadedWorkingShiftListStates extends WorkingShiftListStates{

  final List<WorkingShiftListModel>list;

  LoadedWorkingShiftListStates({required this.list});

  @override
  List<Object> get props => [list];

}

class FailureWorkingShiftListStates extends WorkingShiftListStates{

  final String error;

  FailureWorkingShiftListStates({required this.error});

  @override
  List<Object> get props => [error];

}