import 'package:equatable/equatable.dart';

abstract class CreateEditMasterBranchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateMasterBranchEvent extends CreateEditMasterBranchEvent {
  final String branchName;
  final String multipleCustomerId;

  CreateMasterBranchEvent({
    required this.branchName,
    required this.multipleCustomerId,
  });

  @override
  List<Object> get props => [];
}

class EditMasterBranchEvent extends CreateEditMasterBranchEvent {
  final String branchName;
  final String multipleCustomerId;
  final String branchId;

  EditMasterBranchEvent({
    required this.branchName,
    required this.multipleCustomerId,
    required this.branchId,
  });

  @override
  List<Object> get props => [branchName,multipleCustomerId,branchId];
}
