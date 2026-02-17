import 'package:equatable/equatable.dart';

import '../../model/customer_details_model/customer_details_model.dart';

abstract class CustomerDetailsState extends Equatable{

  @override
  List<Object?> get props => [];
}

class InitialCustomerDetailsState extends CustomerDetailsState{}

class LoadingCustomerDetailsState extends CustomerDetailsState{}

class LoadedCustomerDetailsState extends CustomerDetailsState{
  final List<CustomerDetailsModel> list;

  LoadedCustomerDetailsState({required this.list});

  @override
  List<Object?> get props => [list];
}

class FailureCustomerDetailsState extends CustomerDetailsState{
  final String error;

  FailureCustomerDetailsState({required this.error});

  @override
  List<Object?> get props => [error];

}