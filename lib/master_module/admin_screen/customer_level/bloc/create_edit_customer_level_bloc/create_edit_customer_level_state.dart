import 'package:equatable/equatable.dart';

abstract class CreateEditCustomerLevelState extends Equatable {
  @override
  List<Object> get props => [];
}


/// create customer level
class InitialCreateCustomerLevelState extends CreateEditCustomerLevelState {}

class LoadingCreateCustomerLevelState extends CreateEditCustomerLevelState {}

class LoadedCreateCustomerLevelState extends CreateEditCustomerLevelState {
  final String message;

  LoadedCreateCustomerLevelState({
    required this.message,
  });
}

class FailureCreateCustomerLevelState extends CreateEditCustomerLevelState {
  final String error;

  FailureCreateCustomerLevelState({
    required this.error,
  });
}

/// edit customer level

class InitialEditCustomerLevelState extends CreateEditCustomerLevelState {}

class LoadingEditCustomerLevelState extends CreateEditCustomerLevelState {}

class LoadedEditCustomerLevelState extends CreateEditCustomerLevelState {
  final String message;

  LoadedEditCustomerLevelState({
    required this.message,
  });
}

class FailureEditCustomerLevelState extends CreateEditCustomerLevelState {
  final String error;

  FailureEditCustomerLevelState({
    required this.error,
  });
}
