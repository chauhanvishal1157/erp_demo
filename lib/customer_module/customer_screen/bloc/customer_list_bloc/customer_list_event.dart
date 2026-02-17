import 'package:equatable/equatable.dart';

abstract class CustomerListEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchCustomerListEvent extends CustomerListEvent{}

