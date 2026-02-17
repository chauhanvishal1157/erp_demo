import 'package:equatable/equatable.dart';

abstract class CreateEditTermsConditionState extends Equatable{
  @override
  List<Object?> get props => [];
}

/// create terms condition

class InitialCreateTermsConditionState extends CreateEditTermsConditionState{}

class LoadingCreateTermsConditionState extends CreateEditTermsConditionState{}

class LoadedCreateTermsConditionState extends CreateEditTermsConditionState{
  final String message;

  LoadedCreateTermsConditionState({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

class FailureCreateTermsConditionState extends CreateEditTermsConditionState{
  final String error;

  FailureCreateTermsConditionState({
    required this.error,
  });
  @override
  List<Object?> get props => [error];

}


/// edit terms condition

class InitialEditTermsConditionState extends CreateEditTermsConditionState{}

class LoadingEditTermsConditionState extends CreateEditTermsConditionState{}

class LoadedEditTermsConditionState extends CreateEditTermsConditionState{
  final String message;

  LoadedEditTermsConditionState({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

class FailureEditTermsConditionState extends CreateEditTermsConditionState{
  final String error;

  FailureEditTermsConditionState({
    required this.error,
  });
  @override
  List<Object?> get props => [error];

}