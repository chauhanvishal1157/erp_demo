import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteLeadSubCategoryEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class CreateLeadSubCategoryEvent extends CreateEditDeleteLeadSubCategoryEvent{
  final String leadCategoryId;
  final String leadCategoryName;
  final String leadSubCategoryName;
  final String status;

  CreateLeadSubCategoryEvent({
   required this.leadCategoryId,
   required this.leadCategoryName,
   required this.leadSubCategoryName,
   required this.status,
  });

  @override
  List<Object?> get props => [
    leadCategoryId,
    leadCategoryName,
    leadSubCategoryName,
    status,
  ];

}

class EditLeadSubCategoryEvent extends CreateEditDeleteLeadSubCategoryEvent{
  final String leadSubCategoryId;
  final String leadCategoryId;
  final String leadCategoryName;
  final String leadSubCategoryName;
  final String status;

  EditLeadSubCategoryEvent({
    required this.leadSubCategoryId,
    required this.leadCategoryId,
    required this.leadCategoryName,
    required this.leadSubCategoryName,
    required this.status
  });

  @override
  List<Object?> get props => [
    leadSubCategoryId,
    leadCategoryId,
    leadCategoryName,
    leadSubCategoryName,
    status,
  ];

}

class DeleteLeadSubCategoryEvent extends CreateEditDeleteLeadSubCategoryEvent{
  final String leadSubCategoryId;

  DeleteLeadSubCategoryEvent({
    required this.leadSubCategoryId,
  });

  @override
  List<Object?> get props => [
    leadSubCategoryId,
  ];

}

