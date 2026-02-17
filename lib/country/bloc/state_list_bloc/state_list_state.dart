import 'package:equatable/equatable.dart';
import 'package:erp_demo/country/model/state_model/state_model.dart';

abstract class StateListState extends Equatable{

  @override
  List<Object> get props => [];
}

class InitialStateListState extends StateListState{}

class LoadingStateListState extends StateListState{}

class LoadedStateListState extends StateListState{
  final List<StateModel> list;

  LoadedStateListState({required this.list});

  @override
  List<Object> get props => [list];

}

class FailureStateListState extends StateListState{
  final String error;

  FailureStateListState({required this.error});

  @override
  List<Object> get props => [error];

}