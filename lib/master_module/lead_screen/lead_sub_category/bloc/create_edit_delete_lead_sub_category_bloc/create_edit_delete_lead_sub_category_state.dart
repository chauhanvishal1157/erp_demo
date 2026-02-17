import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteLeadSubCategoryState extends Equatable{

  @override
  List<Object?> get props => [];
}

/// create sub category

class InitialCreateLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{}

class LoadingCreateLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{}

class LoadedCreateLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{
  final String message;

  LoadedCreateLeadSubCategoryState({
    required this.message,
  });
  @override
  List<Object> get props => [message,];
}

class FailureCreateLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{
  final String error;

  FailureCreateLeadSubCategoryState({
    required this.error,
  });
  @override
  List<Object> get props => [error,];
}

/// edit sub category

class InitialEditLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{}

class LoadingEditLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{}

class LoadedEditLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{
  final String message;

  LoadedEditLeadSubCategoryState({
    required this.message,
  });
  @override
  List<Object> get props => [message,];
}

class FailureEditLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{
  final String error;

  FailureEditLeadSubCategoryState({
    required this.error,
  });
  @override
  List<Object> get props => [error,];
}

/// delete sub category

class InitialDeleteLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{}

class LoadingDeleteLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{}

class LoadedDeleteLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{
  final String message;

  LoadedDeleteLeadSubCategoryState({
    required this.message,
  });
  @override
  List<Object> get props => [message,];
}

class FailureDeleteLeadSubCategoryState extends CreateEditDeleteLeadSubCategoryState{
  final String error;

  FailureDeleteLeadSubCategoryState({
    required this.error,
  });
  @override
  List<Object> get props => [error,];
}



