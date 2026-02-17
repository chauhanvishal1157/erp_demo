import 'package:equatable/equatable.dart';

abstract class OrderListEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class FetchOrderListEvent extends OrderListEvent{}