import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteLeadCategoryEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class CreateLeadCategoryEvent extends CreateEditDeleteLeadCategoryEvent{
  final String leadCategoryName;
  final String status;

  CreateLeadCategoryEvent({
    required this.leadCategoryName,
    required this.status,
  });

  @override
  List<Object?> get props => [leadCategoryName,status];
}

class EditLeadCategoryEvent extends CreateEditDeleteLeadCategoryEvent{
  final String leadCategoryId;
  final String leadCategoryName;
  final String status;

  EditLeadCategoryEvent({
    required this.leadCategoryId,
    required this.leadCategoryName,
    required this.status,
  });

  @override
  List<Object?> get props => [leadCategoryId,leadCategoryName,status];
}

class DeleteLeadCategoryEvent extends CreateEditDeleteLeadCategoryEvent{
  final String leadCategoryId;

  DeleteLeadCategoryEvent({
    required this.leadCategoryId,
  });

  @override
  List<Object?> get props => [leadCategoryId];
}
