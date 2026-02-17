import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteRejectionReasonEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class CreateRejectionReasonEvent extends CreateEditDeleteRejectionReasonEvent{
  final String reason;
  final String status;

  CreateRejectionReasonEvent({
    required this.reason,
    required this.status,
  });

  @override
  List<Object?> get props => [reason,status];
}

class EditRejectionReasonEvent extends CreateEditDeleteRejectionReasonEvent{
  final String reasonId;
  final String reason;
  final String status;

  EditRejectionReasonEvent({
    required this.reasonId,
    required this.reason,
    required this.status,
  });

  @override
  List<Object?> get props => [reasonId,reason,status];
}

class DeleteRejectionReasonEvent extends CreateEditDeleteRejectionReasonEvent{
  final String reasonId;

  DeleteRejectionReasonEvent({
    required this.reasonId,
  });

  @override
  List<Object?> get props => [reasonId];
}