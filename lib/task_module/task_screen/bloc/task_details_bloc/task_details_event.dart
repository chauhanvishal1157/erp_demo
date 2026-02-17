import 'package:equatable/equatable.dart';

abstract class TaskDetailsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchTaskDetailsEvent extends TaskDetailsEvent {
  final String taskId;

  FetchTaskDetailsEvent({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
