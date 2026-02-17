import 'package:equatable/equatable.dart';

abstract class CreateEditOrderStatusEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateOrderStatusEvent extends CreateEditOrderStatusEvent {
  final String orderStatusName;
  final String status;
  final String textColor;
  final String textBgColor;
  final String moduleStatus;

  CreateOrderStatusEvent({
    required this.orderStatusName,
    required this.status,
    required this.textColor,
    required this.textBgColor,
    required this.moduleStatus,
  });
  @override
  List<Object> get props => [orderStatusName,status,textColor,textBgColor,moduleStatus];
}

class EditOrderStatusEvent extends CreateEditOrderStatusEvent {
  final String orderStatusId;
  final String orderStatusName;
  final String status;
  final String textColor;
  final String textBgColor;
  final String moduleStatus;

  EditOrderStatusEvent({
    required this.orderStatusId,
    required this.orderStatusName,
    required this.status,
    required this.textColor,
    required this.textBgColor,
    required this.moduleStatus,
  });
  @override
  List<Object> get props => [orderStatusId,orderStatusName,status,textColor,textBgColor,moduleStatus];


}