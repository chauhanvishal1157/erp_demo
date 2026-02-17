import 'package:equatable/equatable.dart';

abstract class CustomerLevelListEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchCustomerLevelListEvent extends CustomerLevelListEvents{}

class LoadMoreCustomerLevelListEvent extends CustomerLevelListEvents{}