import 'package:equatable/equatable.dart';
import 'package:erp_demo/order_module/order_screen/model/order_list_model.dart';

abstract class OrderListState extends Equatable{

  @override
  List<Object> get props => [];
}

class InitialOrderListState extends OrderListState{}

class LoadingOrderListState extends OrderListState{}

class LoadedOrderListState extends OrderListState{
  final List<OrderListModel>list;

  LoadedOrderListState({
    required this.list
  });

  @override
  List<Object> get props => [list,];

}

class FailureOrderListState extends OrderListState{
  final String error;

  FailureOrderListState({required this.error});

  @override
  List<Object> get props => [error];
}
