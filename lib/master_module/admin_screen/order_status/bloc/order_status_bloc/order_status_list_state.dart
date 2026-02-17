
import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/model/order_status_list_model.dart';

abstract class OrderStatusListStates extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialOrderStatusListStates extends OrderStatusListStates{}

class LoadingOrderStatusListStates extends OrderStatusListStates{}

class LoadedOrderStatusListStates extends OrderStatusListStates{
  final List<OrderStatusListModel> list;

  LoadedOrderStatusListStates({required this.list});


  @override
  List<Object> get props => [list,];

}

class FailureOrderStatusListStates extends OrderStatusListStates {
  final String error;

  FailureOrderStatusListStates({required this.error});

  @override
  List<Object> get props => [error];
}