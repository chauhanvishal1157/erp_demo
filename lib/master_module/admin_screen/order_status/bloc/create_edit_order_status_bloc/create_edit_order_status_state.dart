import 'package:equatable/equatable.dart';

abstract class CreateEditOrderStatusState extends Equatable{
  @override
  List<Object> get props => [];
}

/// create order status

class InitialCreateOrderStatusState extends CreateEditOrderStatusState {}

class LoadingCreateOrderStatusState extends CreateEditOrderStatusState{}

class LoadedCreateOrderStatusState extends CreateEditOrderStatusState {
  final String message;

  LoadedCreateOrderStatusState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreateOrderStatusState extends CreateEditOrderStatusState{
  final String error;

  FailureCreateOrderStatusState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}


/// edit order status

class InitialEditOrderStatusState extends CreateEditOrderStatusState {}

class LoadingEditOrderStatusState extends CreateEditOrderStatusState{}

class LoadedEditOrderStatusState extends CreateEditOrderStatusState {
  final String message;

  LoadedEditOrderStatusState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureEditOrderStatusState extends CreateEditOrderStatusState{
  final String error;

  FailureEditOrderStatusState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}