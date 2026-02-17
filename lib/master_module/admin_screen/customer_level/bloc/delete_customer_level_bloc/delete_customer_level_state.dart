import 'package:equatable/equatable.dart';

abstract class DeleteCustomerLevelState extends Equatable {
  @override
  List<Object> get props => [];
}


/// delete customer level
class InitialDeleteCustomerLevelState extends DeleteCustomerLevelState {}

class LoadingDeleteCustomerLevelState extends DeleteCustomerLevelState {}

class LoadedDeleteCustomerLevelState extends DeleteCustomerLevelState {
  final String message;

  LoadedDeleteCustomerLevelState({
    required this.message,
  });
}

class FailureDeleteCustomerLevelState extends DeleteCustomerLevelState {
  final String error;

  FailureDeleteCustomerLevelState({
    required this.error,
  });
}


