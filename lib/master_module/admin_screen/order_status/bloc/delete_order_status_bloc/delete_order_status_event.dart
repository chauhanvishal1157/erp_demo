import 'package:equatable/equatable.dart';

abstract class DeleteOrderStatusEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class DeleteOrderStatusEvent extends DeleteOrderStatusEvents {
  final String orderStatusId;
  DeleteOrderStatusEvent({
    required this.orderStatusId,
  });
  @override
  List<Object> get props => [orderStatusId];
}