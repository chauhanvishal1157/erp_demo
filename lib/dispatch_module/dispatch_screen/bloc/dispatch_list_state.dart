import 'package:equatable/equatable.dart';
import 'package:erp_demo/dispatch_module/dispatch_screen/model/dispatch_list_model.dart';

abstract class DispatchListState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialDispatchListState extends DispatchListState{}

class LoadingDispatchListState extends DispatchListState{}

class LoadedDispatchListState extends DispatchListState{
  final List<DispatchListModel> list;

  LoadedDispatchListState({required this.list});

  @override
  List<Object?> get props => [list];
}

class FailureDispatchListState extends DispatchListState{
  final String error;

  FailureDispatchListState({required this.error});

  @override
  List<Object?> get props => [error];
}