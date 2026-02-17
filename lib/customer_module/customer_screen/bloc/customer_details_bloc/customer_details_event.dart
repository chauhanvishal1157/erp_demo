import 'package:equatable/equatable.dart';

abstract class CustomerDetailsEvent extends Equatable{

  @override
  List<Object?> get props => [];
}


class FetchCustomerDetailsEvent extends CustomerDetailsEvent {
  final String customerId;

  FetchCustomerDetailsEvent({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}