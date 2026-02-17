import 'package:equatable/equatable.dart';
import 'package:erp_demo/task_module/task_screen/model/task_list_model/task_list_model.dart';

abstract class TaskListState extends Equatable{

  @override
  List<Object?> get props => [];
}

class InitialTaskListState extends TaskListState{}

class LoadingTaskListState extends TaskListState{}

class LoadedTaskListState extends TaskListState{
  final List<TaskListModel> list;

  LoadedTaskListState({required this.list});

  @override
  List<Object?> get props => [list];
}

class FailureTaskListState extends TaskListState{
  final String error;

  FailureTaskListState({required this.error});

  @override
  List<Object?> get props => [error];
}
