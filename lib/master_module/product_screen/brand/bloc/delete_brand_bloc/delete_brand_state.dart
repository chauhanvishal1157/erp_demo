import 'package:equatable/equatable.dart';

abstract class DeleteBrandState extends Equatable{
  @override
  List<Object> get props => [];

}

class InitialDeleteBrandState extends DeleteBrandState {}

class LoadingDeleteBrandState extends DeleteBrandState{}

class LoadedDeleteBrandState extends DeleteBrandState{
  final String message;

  LoadedDeleteBrandState({
    required this.message,
  });
}

class FailureDeleteBrandState extends DeleteBrandState{
  final String error;

  FailureDeleteBrandState({
    required this.error,
  });

}