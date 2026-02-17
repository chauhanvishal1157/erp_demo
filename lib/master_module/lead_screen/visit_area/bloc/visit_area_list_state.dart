import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/model/visit_area_list_model.dart';

abstract class VisitAreaListStates extends Equatable{
  @override
  List<Object> get props => [];
}


class InitialVisitAreaListStates extends VisitAreaListStates{}

class LoadingVisitAreaListStates extends VisitAreaListStates{}

class LoadedVisitAreaListStates extends VisitAreaListStates{

  final List<VisitAreaListModel> list;
  final bool hasNextPage;
  final int totalCount;

   LoadedVisitAreaListStates({
    required this.list,
    required this.hasNextPage,
    required this.totalCount,
  });

  @override
  List<Object> get props => [list,hasNextPage];
}

class FailureVisitAreaListStates extends VisitAreaListStates{
  final String error;

   FailureVisitAreaListStates({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}