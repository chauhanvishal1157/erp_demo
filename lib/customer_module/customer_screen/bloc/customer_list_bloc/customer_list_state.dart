import 'package:equatable/equatable.dart';

import '../../model/customer_list_model/customer_list_model.dart';

abstract class CustomerListState extends Equatable{

  @override
  List<Object> get props => [];
}

class InitialCustomerListState extends CustomerListState{}

class LoadingCustomerListState extends CustomerListState{}

class LoadedCustomerListState extends CustomerListState{
  final List<CustomerListModel> list;

  LoadedCustomerListState({required this.list});

  @override
  List<Object> get props => [list];

}

class FailureCustomerListState extends CustomerListState{
  final String error;

  FailureCustomerListState({required this.error});

  @override
  List<Object> get props => [error];

}


