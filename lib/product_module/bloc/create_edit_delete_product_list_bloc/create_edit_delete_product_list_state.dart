import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteProductListState extends Equatable{

  @override
  List<Object> get props => [];
}

/// create product list

class InitialCreateProductListState extends CreateEditDeleteProductListState{}

class LoadingCreateProductListState extends CreateEditDeleteProductListState{}

class LoadedCreateProductListState extends CreateEditDeleteProductListState{
  final String message;

  LoadedCreateProductListState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreateProductListState extends CreateEditDeleteProductListState{
  final String error;

  FailureCreateProductListState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// edit product list

class InitialEditProductListState extends CreateEditDeleteProductListState{}

class LoadingEditProductListState extends CreateEditDeleteProductListState{}

class LoadedEditProductListState extends CreateEditDeleteProductListState{
  final String message;

  LoadedEditProductListState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureEditProductListState extends CreateEditDeleteProductListState{
  final String error;

  FailureEditProductListState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// delete product list

class InitialDeleteProductListState extends CreateEditDeleteProductListState{}

class LoadingDeleteProductListState extends CreateEditDeleteProductListState{}

class LoadedDeleteProductListState extends CreateEditDeleteProductListState{
  final String message;

  LoadedDeleteProductListState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureDeleteProductListState extends CreateEditDeleteProductListState{
  final String error;

  FailureDeleteProductListState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}