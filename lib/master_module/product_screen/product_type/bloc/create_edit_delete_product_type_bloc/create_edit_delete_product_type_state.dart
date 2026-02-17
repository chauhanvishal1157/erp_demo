import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteProductTypeState extends Equatable{
  @override
  List<Object> get props => [];

}

/// create product

class InitialCreateProductTypeState extends CreateEditDeleteProductTypeState{}

class LoadingCreateProductTypeState extends CreateEditDeleteProductTypeState{}

class LoadedCreateProductTypeState extends CreateEditDeleteProductTypeState{
  final String message;

  LoadedCreateProductTypeState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreateProductTypeState extends CreateEditDeleteProductTypeState{
  final String error;

  FailureCreateProductTypeState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// edit product

class InitialEditProductTypeState extends CreateEditDeleteProductTypeState{}

class LoadingEditProductTypeState extends CreateEditDeleteProductTypeState{}

class LoadedEditProductTypeState extends CreateEditDeleteProductTypeState{
  final String message;

  LoadedEditProductTypeState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureEditProductTypeState extends CreateEditDeleteProductTypeState{
  final String error;

  FailureEditProductTypeState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// delete product

class InitialDeleteProductTypeState extends CreateEditDeleteProductTypeState{}

class LoadingDeleteProductTypeState extends CreateEditDeleteProductTypeState{}

class LoadedDeleteProductTypeState extends CreateEditDeleteProductTypeState{
  final String message;

  LoadedDeleteProductTypeState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureDeleteProductTypeState extends CreateEditDeleteProductTypeState{
  final String error;

  FailureDeleteProductTypeState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
