import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteRejectionReasonState extends Equatable{

  @override
  List<Object?> get props => [];
}

/// create reason

class InitialCreateRejectionReasonState extends CreateEditDeleteRejectionReasonState{}

class LoadingCreateRejectionReasonState extends CreateEditDeleteRejectionReasonState{}

class LoadedCreateRejectionReasonState extends CreateEditDeleteRejectionReasonState{
  final String message;

  LoadedCreateRejectionReasonState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FailureCreateRejectionReasonState extends CreateEditDeleteRejectionReasonState{
  final String error;

  FailureCreateRejectionReasonState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

/// edit reason

class InitialEditRejectionReasonState extends CreateEditDeleteRejectionReasonState{}

class LoadingEditRejectionReasonState extends CreateEditDeleteRejectionReasonState{}

class LoadedEditRejectionReasonState extends CreateEditDeleteRejectionReasonState{
  final String message;

  LoadedEditRejectionReasonState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FailureEditRejectionReasonState extends CreateEditDeleteRejectionReasonState{
  final String error;

  FailureEditRejectionReasonState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

/// delete reason

class InitialDeleteRejectionReasonState extends CreateEditDeleteRejectionReasonState{}

class LoadingDeleteRejectionReasonState extends CreateEditDeleteRejectionReasonState{}

class LoadedDeleteRejectionReasonState extends CreateEditDeleteRejectionReasonState{
  final String message;

  LoadedDeleteRejectionReasonState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FailureDeleteRejectionReasonState extends CreateEditDeleteRejectionReasonState{
  final String error;

  FailureDeleteRejectionReasonState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}