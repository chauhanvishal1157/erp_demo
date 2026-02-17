import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/product_screen/unit/model/unit_list_model.dart';

abstract class UnitListStates extends Equatable{

  @override
  List<Object> get props => [];

}

class InitialUnitListStates extends UnitListStates{}

class LoadingUnitListStates extends UnitListStates{}

class LoadedUnitListStates extends UnitListStates{

  final List<UnitListModel> list;

  LoadedUnitListStates({required this.list});

  @override
  List<Object> get props => [list,];

}

class FailureUnitListStates extends UnitListStates{

  final String error;

  FailureUnitListStates({required this.error});

  @override
  List<Object> get props => [error,];
}