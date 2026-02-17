import 'package:equatable/equatable.dart';

abstract class CreateEditCategoryMasterState extends Equatable{
  @override
  List<Object> get props => [];
}


/// create category master

class InitialCreateCategoryMasterState extends CreateEditCategoryMasterState {}

class LoadingCreateCategoryMasterState extends CreateEditCategoryMasterState {}

class LoadedCreateCategoryMasterState extends CreateEditCategoryMasterState{
  final String message;

  LoadedCreateCategoryMasterState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreateCategoryMasterState extends CreateEditCategoryMasterState{
  final String error;
  FailureCreateCategoryMasterState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// edit category master

class InitialEditCategoryMasterState extends CreateEditCategoryMasterState{}

class LoadingEditCategoryMasterState extends CreateEditCategoryMasterState{}

class LoadedEditCategoryMasterState extends CreateEditCategoryMasterState{
  final String message;

  LoadedEditCategoryMasterState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureEditCategoryMasterState extends CreateEditCategoryMasterState{
  final String error;
  FailureEditCategoryMasterState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}