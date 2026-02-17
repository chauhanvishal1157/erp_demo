import 'package:equatable/equatable.dart';

abstract class CreateEditMasterBranchState extends Equatable {
  @override
  List<Object> get props => [];
}


/// CREATE branch

class InitialCreateMasterBranchState extends CreateEditMasterBranchState {}

class LoadingCreateMasterBranchState extends CreateEditMasterBranchState {}

class LoadedCreateMasterBranchState extends CreateEditMasterBranchState {
  final String message;

  LoadedCreateMasterBranchState({
    required this.message,
  });
}

class FailureCreateMasterBranchState extends CreateEditMasterBranchState {
  final String error;

  FailureCreateMasterBranchState({
    required this.error,
  });
}

/// edit branch

class InitialEditMasterBranchState extends CreateEditMasterBranchState {}

class LoadingEditMasterBranchState extends CreateEditMasterBranchState {}

class LoadedEditMasterBranchState extends CreateEditMasterBranchState {
  final String message;

  LoadedEditMasterBranchState({
    required this.message,
  });
}

class FailureEditMasterBranchState extends CreateEditMasterBranchState {
  final String error;

  FailureEditMasterBranchState({
    required this.error,
  });
}
