import 'package:equatable/equatable.dart';

abstract class ProductionListEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class FetchProductionListEvent extends ProductionListEvent {}