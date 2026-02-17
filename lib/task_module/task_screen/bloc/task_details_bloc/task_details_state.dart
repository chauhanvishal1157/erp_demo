import 'package:equatable/equatable.dart';
import 'package:erp_demo/task_module/task_screen/model/task_details_model/task_details_model.dart';

abstract class TaskDetailsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialTaskDetailsState extends TaskDetailsState{}

class LoadingTaskDetailsState extends TaskDetailsState{}

class LoadedTaskDetailsState extends TaskDetailsState{
  final List<TaskDetailsModel>list;

  LoadedTaskDetailsState({
    required this.list
  });
  @override
  List<Object?> get props => [list];
}

class FailureTaskDetailsState extends TaskDetailsState{
  final String error;

  FailureTaskDetailsState({
    required this.error
  });
  @override
  List<Object?> get props => [error];
}