import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteVendorState extends Equatable{
  
  @override
  List<Object> get props => [];
}

/// create vendor

class InitialCreateVendorState extends CreateEditDeleteVendorState{}

class LoadingCreateVendorState extends CreateEditDeleteVendorState{}

class LoadedCreateVendorState extends CreateEditDeleteVendorState{
  final String message;

  LoadedCreateVendorState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreateVendorState extends CreateEditDeleteVendorState{
  final String error;

  FailureCreateVendorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// edit vendor

class InitialEditVendorState extends CreateEditDeleteVendorState{}

class LoadingEditVendorState extends CreateEditDeleteVendorState{}

class LoadedEditVendorState extends CreateEditDeleteVendorState{
  final String message;

  LoadedEditVendorState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureEditVendorState extends CreateEditDeleteVendorState{
  final String error;

  FailureEditVendorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// delete vendor

class InitialDeleteVendorState extends CreateEditDeleteVendorState{}

class LoadingDeleteVendorState extends CreateEditDeleteVendorState{}

class LoadedDeleteVendorState extends CreateEditDeleteVendorState{
  final String message;

  LoadedDeleteVendorState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureDeleteVendorState extends CreateEditDeleteVendorState{
  final String error;

  FailureDeleteVendorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}