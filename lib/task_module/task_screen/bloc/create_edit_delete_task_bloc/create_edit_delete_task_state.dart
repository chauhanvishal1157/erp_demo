import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteTaskState extends Equatable{
  @override
  List<Object?> get props => [];
}

/// create task

class InitialCreateTaskState extends CreateEditDeleteTaskState{}

class LoadingCreateTaskState extends CreateEditDeleteTaskState{}

class LoadedCreateTaskState extends CreateEditDeleteTaskState{
  final String message;

  LoadedCreateTaskState({
    required this.message
  });
  @override
  List<Object?> get props => [message];
}

class FailureCreateTaskState extends CreateEditDeleteTaskState{
  final String error;

  FailureCreateTaskState({
    required this.error
  });
  @override
  List<Object?> get props => [error];

}

/// edit task

class InitialEditTaskState extends CreateEditDeleteTaskState{}

class LoadingEditTaskState extends CreateEditDeleteTaskState{}

class LoadedEditTaskState extends CreateEditDeleteTaskState{
  final String message;

  LoadedEditTaskState({
    required this.message
  });
  @override
  List<Object?> get props => [message];

}

class FailureEditTaskState extends CreateEditDeleteTaskState{
  final String error;

  FailureEditTaskState({
    required this.error
  });
  @override
  List<Object?> get props => [error];

}

/// delete task

class InitialDeleteTaskState extends CreateEditDeleteTaskState{}

class LoadingDeleteTaskState extends CreateEditDeleteTaskState{}

class LoadedDeleteTaskState extends CreateEditDeleteTaskState{
  final String message;

  LoadedDeleteTaskState({
    required this.message
  });
  @override
  List<Object?> get props => [message];

}

class FailureDeleteTaskState extends CreateEditDeleteTaskState{
  final String error;

  FailureDeleteTaskState({
    required this.error
  });
  @override
  List<Object?> get props => [error];

}