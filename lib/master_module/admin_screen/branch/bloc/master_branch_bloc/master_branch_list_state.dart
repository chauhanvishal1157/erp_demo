import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/admin_screen/branch/model/master_branch_list_model.dart';

abstract class BranchListStates extends Equatable {
  final dynamic branchList;

  const BranchListStates(this.branchList);

  @override
  List<Object> get props => [];
}

class InitialBranchListState extends BranchListStates {
  const InitialBranchListState(super.branchList);
}

class LoadingBranchListState extends BranchListStates {
  const LoadingBranchListState(super.branchList);
}

class LoadedBranchListState extends BranchListStates {
  final List<BranchListModel> list;
  final bool hasNextPage;
  final int totalCount;

  const LoadedBranchListState({
    required this.list,
    required this.hasNextPage,
    required this.totalCount,
  }) : super(list);

  @override
  List<Object> get props => [list,hasNextPage];
}

class InternalServerErrorBranchListState extends BranchListStates {
  final String error;

  const InternalServerErrorBranchListState({
    required this.error,
  }) : super(null);

  @override
  List<Object> get props => [error];
}

class ServerErrorBranchListState extends BranchListStates {
  final String error;

  const ServerErrorBranchListState({
    required this.error,
  }) : super(null);

  @override
  List<Object> get props => [error];
}

class FailureBranchListState extends BranchListStates {
  final String error;

  const FailureBranchListState({
    required this.error,
  }) : super(null);

  @override
  List<Object> get props => [error];
}
