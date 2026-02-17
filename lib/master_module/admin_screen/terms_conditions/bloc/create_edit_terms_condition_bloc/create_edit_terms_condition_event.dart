import 'package:equatable/equatable.dart';

abstract class CreateEditTermsConditionEvent extends Equatable{
  @override
  List<Object?> get props => [];

}

class CreateTermsConditionEvent extends CreateEditTermsConditionEvent {
  final String title;
  final String text;
  final String type;

  CreateTermsConditionEvent({
    required this.title,
    required this.text,
    required this.type,
  });
  @override
  List<Object?> get props => [title,text,type];

}

class EditTermsConditionEvent extends CreateEditTermsConditionEvent {
  final String title;
  final String text;
  final String type;
  final String termsConditionId;

  EditTermsConditionEvent({
    required this.title,
    required this.text,
    required this.type,
    required this.termsConditionId,
  });
  @override
  List<Object?> get props => [title,text,type,termsConditionId];

}
