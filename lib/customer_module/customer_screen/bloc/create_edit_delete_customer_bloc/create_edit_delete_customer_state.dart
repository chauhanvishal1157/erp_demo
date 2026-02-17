import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteCustomerState extends Equatable{

  @override
  List<Object> get props => [];
}

/// create customer

class InitialCreateCustomerState extends CreateEditDeleteCustomerState{}

class LoadingCreateCustomerState extends CreateEditDeleteCustomerState{}

class LoadedCreateCustomerState extends CreateEditDeleteCustomerState{
  final String message;

  LoadedCreateCustomerState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreateCustomerState extends CreateEditDeleteCustomerState{
  final String error;

  FailureCreateCustomerState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// edit customer

class InitialEditCustomerState extends CreateEditDeleteCustomerState{}

class LoadingEditCustomerState extends CreateEditDeleteCustomerState{}

class LoadedEditCustomerState extends CreateEditDeleteCustomerState{
  final String message;

  LoadedEditCustomerState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureEditCustomerState extends CreateEditDeleteCustomerState{
  final String error;

  FailureEditCustomerState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// delete customer

class InitialDeleteCustomerState extends CreateEditDeleteCustomerState{}

class LoadingDeleteCustomerState extends CreateEditDeleteCustomerState{}

class LoadedDeleteCustomerState extends CreateEditDeleteCustomerState{
  final String message;

  LoadedDeleteCustomerState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureDeleteCustomerState extends CreateEditDeleteCustomerState{
  final String error;

  FailureDeleteCustomerState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}