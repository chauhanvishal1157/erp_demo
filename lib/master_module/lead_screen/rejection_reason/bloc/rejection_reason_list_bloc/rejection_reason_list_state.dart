import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/model/rejection_reason_list_model.dart';

abstract class RejectionReasonListStates extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialRejectionReasonListStates extends RejectionReasonListStates{}

class LoadingRejectionReasonListStates extends RejectionReasonListStates{}

class LoadedRejectionReasonListStates extends RejectionReasonListStates{

  final List<RejectionReasonListModel> list;

  LoadedRejectionReasonListStates({required this.list});

  @override
  List<Object> get props => [list];
}

class FailureRejectionReasonListStates extends RejectionReasonListStates{

  final String error;

  FailureRejectionReasonListStates({required this.error});

  @override
  List<Object> get props => [error];

}
