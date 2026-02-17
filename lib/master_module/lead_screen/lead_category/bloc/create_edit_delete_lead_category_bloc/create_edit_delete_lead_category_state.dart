import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteLeadCategoryState extends Equatable{

  @override
  List<Object?> get props => [];
}

/// create lead category

class InitialCreateLeadCategoryState extends CreateEditDeleteLeadCategoryState{}

class LoadingCreateLeadCategoryState extends CreateEditDeleteLeadCategoryState{}

class LoadedCreateLeadCategoryState extends CreateEditDeleteLeadCategoryState{
  final String message;
  LoadedCreateLeadCategoryState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FailureCreateLeadCategoryState extends CreateEditDeleteLeadCategoryState{
  final String error;
  FailureCreateLeadCategoryState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

/// edit lead category

class InitialEditLeadCategoryState extends CreateEditDeleteLeadCategoryState{}

class LoadingEditLeadCategoryState extends CreateEditDeleteLeadCategoryState{}

class LoadedEditLeadCategoryState extends CreateEditDeleteLeadCategoryState{
  final String message;
  LoadedEditLeadCategoryState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FailureEditLeadCategoryState extends CreateEditDeleteLeadCategoryState{
  final String error;
  FailureEditLeadCategoryState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

/// delete lead category

class InitialDeleteLeadCategoryState extends CreateEditDeleteLeadCategoryState{}

class LoadingDeleteLeadCategoryState extends CreateEditDeleteLeadCategoryState{}

class LoadedDeleteLeadCategoryState extends CreateEditDeleteLeadCategoryState{
  final String message;
  LoadedDeleteLeadCategoryState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FailureDeleteLeadCategoryState extends CreateEditDeleteLeadCategoryState{
  final String error;
  FailureDeleteLeadCategoryState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
