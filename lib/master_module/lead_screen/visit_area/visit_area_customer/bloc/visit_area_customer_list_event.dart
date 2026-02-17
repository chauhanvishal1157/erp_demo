import 'package:equatable/equatable.dart';

abstract class VisitAreaCustomerListEvents extends Equatable{

  @override
  List<Object> get props => [];

}

class FetchVisitAreaCustomerListEvents extends VisitAreaCustomerListEvents{
  final String branchId;
  final String visitAreaId;

  FetchVisitAreaCustomerListEvents({
    required this.branchId,
    required this.visitAreaId
  });
}

class CreateMasterBranchEvent extends VisitAreaCustomerListEvents {
  final String branchName;
  final String multipleCustomerId;

  CreateMasterBranchEvent({
    required this.branchName,
    required this.multipleCustomerId,
  });

  @override
  List<Object> get props => [];
}
