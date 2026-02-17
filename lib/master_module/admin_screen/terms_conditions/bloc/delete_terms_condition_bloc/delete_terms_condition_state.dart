import 'package:equatable/equatable.dart';

abstract class DeleteTermsConditionState extends Equatable{
  @override
  List<Object?> get props => [];

}

class InitialDeleteTermsConditionState extends DeleteTermsConditionState {}

class LoadingDeleteTermsConditionState extends DeleteTermsConditionState{}

class LoadedDeleteTermsConditionState extends DeleteTermsConditionState {
  final String message;

  LoadedDeleteTermsConditionState({
    required this.message,
  });
}

class FailureDeleteTermsConditionState extends DeleteTermsConditionState{
  final String error;

  FailureDeleteTermsConditionState({
    required this.error,
  });
}

