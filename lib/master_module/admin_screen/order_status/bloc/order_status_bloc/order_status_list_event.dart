import 'package:equatable/equatable.dart';

abstract class OrderStatusListEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class  FetchOrderStatusListEvents extends OrderStatusListEvents{}