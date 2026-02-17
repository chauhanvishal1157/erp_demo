import 'package:equatable/equatable.dart';

abstract class CreateEditBrandState extends Equatable{
  @override
  List<Object> get props => [];

}
/// create brand

class InitialCreateBrandState extends CreateEditBrandState{}

class LoadingCreateBrandState extends CreateEditBrandState{}

class LoadedCreateBrandState extends CreateEditBrandState{
  final String message;
  LoadedCreateBrandState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureCreateBrandState extends CreateEditBrandState{
  final String error;
  FailureCreateBrandState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

/// edit brand

class InitialEditBrandState extends CreateEditBrandState{}

class LoadingEditBrandState extends CreateEditBrandState{}

class LoadedEditBrandState extends CreateEditBrandState{
  final String message;
  LoadedEditBrandState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailureEditBrandState extends CreateEditBrandState{
  final String error;
  FailureEditBrandState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}