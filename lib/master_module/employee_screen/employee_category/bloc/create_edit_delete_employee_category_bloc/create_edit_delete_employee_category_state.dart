import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteEmployeeCategoryState extends Equatable{

  @override
  List<Object?> get props => [];
}


/// create lead category

class InitialCreateEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{}

class LoadingCreateEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{}

class LoadedCreateEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{
  final String message;
  LoadedCreateEmployeeCategoryState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FailureCreateEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{
  final String error;
  FailureCreateEmployeeCategoryState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

/// edit lead category

class InitialEditEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{}

class LoadingEditEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{}

class LoadedEditEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{
  final String message;
  LoadedEditEmployeeCategoryState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FailureEditEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{
  final String error;
  FailureEditEmployeeCategoryState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

/// delete lead category

class InitialDeleteEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{}

class LoadingDeleteEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{}

class LoadedDeleteEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{
  final String message;
  LoadedDeleteEmployeeCategoryState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class FailureDeleteEmployeeCategoryState extends CreateEditDeleteEmployeeCategoryState{
  final String error;
  FailureDeleteEmployeeCategoryState({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
