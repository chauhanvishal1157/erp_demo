import 'package:equatable/equatable.dart';

abstract class DeleteTermsConditionEvent extends Equatable{
  @override
  List<Object?> get props => [];

}

class DeleteTermsConditionEvents extends DeleteTermsConditionEvent {
  final String termsConditionId;

  DeleteTermsConditionEvents({
    required this.termsConditionId,
  });

  @override
  List<Object?> get props => [termsConditionId];
}