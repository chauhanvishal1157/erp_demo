import 'package:equatable/equatable.dart';

abstract class DeleteTaxMasterState extends Equatable{
  @override
  List<Object?> get props => [];

}

class InitialDeleteTaxMasterState extends DeleteTaxMasterState{}

class LoadingDeleteTaxMasterState extends DeleteTaxMasterState{}

class LoadedDeleteTaxMasterState extends DeleteTaxMasterState{
  final String message;
  LoadedDeleteTaxMasterState({
    required this.message
  });
  @override
  List<Object?> get props => [message];
}

class FailureDeleteTaxMasterState extends DeleteTaxMasterState{
  final String error;
  FailureDeleteTaxMasterState({
    required this.error
  });
  @override
  List<Object?> get props => [error];
}