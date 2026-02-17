import 'package:equatable/equatable.dart';

abstract class DeleteOrderStatusState extends Equatable{
  @override
  List<Object> get props => [];
}

/// delete order status

class InitialDeleteOrderStatusState extends DeleteOrderStatusState{}

class LoadingDeleteOrderStatusState extends DeleteOrderStatusState{}

class LoadedDeleteOrderStatusState extends DeleteOrderStatusState{
  final String message;

  LoadedDeleteOrderStatusState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureDeleteOrderStatusState extends DeleteOrderStatusState{
  final String error;

  FailureDeleteOrderStatusState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}