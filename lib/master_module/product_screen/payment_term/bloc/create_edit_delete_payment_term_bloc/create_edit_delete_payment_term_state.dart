import 'package:equatable/equatable.dart';

abstract class CreateEditDeletePaymentTermState extends Equatable{
  @override
  List<Object> get props => [];
}

/// create payment term

class InitialCreatePaymentTermState extends CreateEditDeletePaymentTermState {}

class LoadingCreatePaymentTermState extends CreateEditDeletePaymentTermState {}

class LoadedCreatePaymentTermState extends CreateEditDeletePaymentTermState{
  final String message;

  LoadedCreatePaymentTermState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreatePaymentTermState extends CreateEditDeletePaymentTermState{
  final String error;
  FailureCreatePaymentTermState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// edit payment term

class InitialEditPaymentTermState extends CreateEditDeletePaymentTermState {}

class LoadingEditPaymentTermState extends CreateEditDeletePaymentTermState {}

class LoadedEditPaymentTermState extends CreateEditDeletePaymentTermState{
  final String message;

  LoadedEditPaymentTermState({
    required this.message,
  });
  @override
  List<Object> get props => [message];

}

class FailureEditPaymentTermState extends CreateEditDeletePaymentTermState{
  final String error;

  FailureEditPaymentTermState({
    required this.error,
  });
  @override
  List<Object> get props => [error];

}

/// delete payment term

class InitialDeletePaymentTermState extends CreateEditDeletePaymentTermState {}

class LoadingDeletePaymentTermState extends CreateEditDeletePaymentTermState{}

class LoadedDeletePaymentTermState extends CreateEditDeletePaymentTermState{
  final String message;

  LoadedDeletePaymentTermState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureDeletePaymentTermState extends CreateEditDeletePaymentTermState{
  final String error;
  FailureDeletePaymentTermState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

