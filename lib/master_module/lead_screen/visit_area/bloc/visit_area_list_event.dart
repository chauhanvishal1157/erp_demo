import 'package:equatable/equatable.dart';

abstract class VisitAreaListEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchVisitAreaListEvents extends VisitAreaListEvents{

  final String searchValue;
  final String branchId;

  FetchVisitAreaListEvents({
    required this.searchValue,
    required this.branchId,
  });

  @override
  List<Object> get props => [];
}