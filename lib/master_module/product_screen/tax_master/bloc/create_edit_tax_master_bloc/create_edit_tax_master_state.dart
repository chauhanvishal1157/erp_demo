import 'package:equatable/equatable.dart';

abstract class CreateEditTaxMasterState extends Equatable{
  @override
  List<Object> get props => [];
}

/// create Tax Master

class InitialCreateTaxMasterState extends CreateEditTaxMasterState{}

class LoadingCreateTaxMasterState extends CreateEditTaxMasterState{}

class LoadedCreateTaxMasterState extends CreateEditTaxMasterState{
  final String message;

  LoadedCreateTaxMasterState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreateTaxMasterState extends CreateEditTaxMasterState{
  final String error;

  FailureCreateTaxMasterState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// Edit Tax Master

class InitialEditTaxMasterState extends CreateEditTaxMasterState{}

class LoadingEditTaxMasterState extends CreateEditTaxMasterState{}

class LoadedEditTaxMasterState extends CreateEditTaxMasterState{
  final String message;

  LoadedEditTaxMasterState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureEditTaxMasterState extends CreateEditTaxMasterState{
  final String error;

  FailureEditTaxMasterState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}