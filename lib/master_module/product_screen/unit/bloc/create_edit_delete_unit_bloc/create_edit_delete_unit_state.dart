import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteUnitState extends Equatable {

  @override
  List<Object> get props => [];
}

/// create unit

class InitialCreateUnitState extends CreateEditDeleteUnitState {}

class LoadingCreateUnitState extends CreateEditDeleteUnitState {}

class LoadedCreateUnitState extends CreateEditDeleteUnitState {
  final String message;

  LoadedCreateUnitState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreateUnitState extends CreateEditDeleteUnitState{
  final String error;
  FailureCreateUnitState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// edit unit

class InitialEditUnitState extends CreateEditDeleteUnitState {}

class LoadingEditUnitState extends CreateEditDeleteUnitState {}

class LoadedEditUnitState extends CreateEditDeleteUnitState {
  final String message;

  LoadedEditUnitState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureEditUnitState extends CreateEditDeleteUnitState{
  final String error;

  FailureEditUnitState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// delete unit

class InitialDeleteUnitState extends CreateEditDeleteUnitState {}

class LoadingDeleteUnitState extends CreateEditDeleteUnitState{}

class LoadedDeleteUnitState extends CreateEditDeleteUnitState {
  final String message;

  LoadedDeleteUnitState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureDeleteUnitState extends CreateEditDeleteUnitState{
  final String error;
  FailureDeleteUnitState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}