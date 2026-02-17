import 'package:equatable/equatable.dart';

import '../model/production_list_model.dart';

abstract class ProductionListState extends Equatable{

  @override
  List<Object?> get props => [];
}

class InitialProductionListState extends ProductionListState{}

class LoadingProductionListState extends ProductionListState{}

class LoadedProductionListState extends ProductionListState{
  final List<ProductionListModel> list;

  LoadedProductionListState({required this.list});

  @override
  List<Object?> get props => [list];
}

class FailureProductionListState extends ProductionListState{
  final String error;

  FailureProductionListState({required this.error});

  @override
  List<Object?> get props => [error];
}

