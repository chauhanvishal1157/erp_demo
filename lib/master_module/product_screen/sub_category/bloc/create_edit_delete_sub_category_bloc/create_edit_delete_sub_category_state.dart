import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteSubCategoryState extends Equatable{

  @override
  List<Object> get props => [];
}

/// create sub category

class InitialCreateSubCategoryState extends CreateEditDeleteSubCategoryState{}

class LoadingCreateSubCategoryState extends CreateEditDeleteSubCategoryState{}

class LoadedCreateSubCategoryState extends CreateEditDeleteSubCategoryState{
  final String message;

  LoadedCreateSubCategoryState({
    required this.message,
  });
  @override
  List<Object> get props => [message,];
}

class FailureCreateSubCategoryState extends CreateEditDeleteSubCategoryState{
  final String error;

  FailureCreateSubCategoryState({
    required this.error,
  });
  @override
  List<Object> get props => [error,];
}

/// edit sub category

class InitialEditSubCategoryState extends CreateEditDeleteSubCategoryState{}

class LoadingEditSubCategoryState extends CreateEditDeleteSubCategoryState{}

class LoadedEditSubCategoryState extends CreateEditDeleteSubCategoryState{
  final String message;

  LoadedEditSubCategoryState({
    required this.message,
  });
  @override
  List<Object> get props => [message,];
}

class FailureEditSubCategoryState extends CreateEditDeleteSubCategoryState{
  final String error;

  FailureEditSubCategoryState({
    required this.error,
  });
  @override
  List<Object> get props => [error,];
}

/// delete sub category

class InitialDeleteSubCategoryState extends CreateEditDeleteSubCategoryState{}

class LoadingDeleteSubCategoryState extends CreateEditDeleteSubCategoryState{}

class LoadedDeleteSubCategoryState extends CreateEditDeleteSubCategoryState{
  final String message;

  LoadedDeleteSubCategoryState({
    required this.message,
  });
  @override
  List<Object> get props => [message,];
}

class FailureDeleteSubCategoryState extends CreateEditDeleteSubCategoryState{
  final String error;

  FailureDeleteSubCategoryState({
    required this.error,
  });
  @override
  List<Object> get props => [error,];
}





