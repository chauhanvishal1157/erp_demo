import 'package:equatable/equatable.dart';

abstract class CreateEditVendorLevelState extends Equatable {
  @override
  List<Object> get props => [];
}


/// create customer level
class InitialCreateVendorLevelState extends CreateEditVendorLevelState {}

class LoadingCreateVendorLevelState extends CreateEditVendorLevelState {}

class LoadedCreateVendorLevelState extends CreateEditVendorLevelState {
  final String message;

  LoadedCreateVendorLevelState({
    required this.message,
  });
}

class FailureCreateVendorLevelState extends CreateEditVendorLevelState {
  final String error;

  FailureCreateVendorLevelState({
    required this.error,
  });
}

/// edit customer level

class InitialEditVendorLevelState extends CreateEditVendorLevelState {}

class LoadingEditVendorLevelState extends CreateEditVendorLevelState {}

class LoadedEditVendorLevelState extends CreateEditVendorLevelState {
  final String message;

  LoadedEditVendorLevelState({
    required this.message,
  });
}

class FailureEditVendorLevelState extends CreateEditVendorLevelState {
  final String error;

  FailureEditVendorLevelState({
    required this.error,
  });
}
