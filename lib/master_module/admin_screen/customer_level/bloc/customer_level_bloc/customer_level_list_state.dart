import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/model/customer_level_list_model.dart';

abstract class CustomerLevelListStates extends Equatable{

  final dynamic getCustomerLevelList;

  const CustomerLevelListStates(this.getCustomerLevelList);

  @override
  List<Object> get props => [];
}

class InitialCustomerLevelListState extends CustomerLevelListStates{
  const InitialCustomerLevelListState(super.getCustomerLevelList);
}

class LoadingCustomerLevelListState extends CustomerLevelListStates{
  const LoadingCustomerLevelListState(super.getCustomerLevelList);
}

class LoadedCustomerLevelListState extends CustomerLevelListStates {
  final List<CustomerLevelListModel> list;

  const LoadedCustomerLevelListState({
    required this.list,
  }) : super(list);

  @override
  List<Object> get props => [list,];
}

class InternalServerErrorCustomerLevelListState extends CustomerLevelListStates {
  final String error;

  const InternalServerErrorCustomerLevelListState({
    required this.error,
  }) : super(null);

  @override
  List<Object> get props => [error];
}

class ServerErrorCustomerLevelListState extends CustomerLevelListStates {
  final String error;

  const ServerErrorCustomerLevelListState({
    required this.error,
  }) : super(null);

  @override
  List<Object> get props => [error];
}

class FailureCustomerLevelListState extends CustomerLevelListStates {
  final String error;

  const FailureCustomerLevelListState({
    required this.error,
  }) : super(null);

  @override
  List<Object> get props => [error];
}