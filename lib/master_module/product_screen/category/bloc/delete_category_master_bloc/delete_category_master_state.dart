import 'package:equatable/equatable.dart';

abstract class DeleteCategoryMasterState extends Equatable{
  @override
  List<Object> get props => [];

}

class InitialDeleteCategoryMasterState extends DeleteCategoryMasterState {}

class LoadingDeleteCategoryMasterState extends DeleteCategoryMasterState{}

class LoadedDeleteCategoryMasterState extends DeleteCategoryMasterState{
  final String message;

  LoadedDeleteCategoryMasterState({
    required this.message,
  });

}

class FailureDeleteCategoryMasterState extends DeleteCategoryMasterState{
  final String error;

  FailureDeleteCategoryMasterState({
    required this.error,
  });
}