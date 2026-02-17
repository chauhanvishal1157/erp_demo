import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteCustomerEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateCustomerEvent extends CreateEditDeleteCustomerEvent{
  final String customerName;
  final String email;
  final String mobileNo;
  final String whatsappNo;
  final String gstNo;
  final String address;
  final String customerLevelId;
  final String productId;

  CreateCustomerEvent({
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.whatsappNo,
    required this.gstNo,
    required this.address,
    required this.customerLevelId,
    required this.productId,
  });

}

class EditCustomerEvent extends CreateEditDeleteCustomerEvent{
  final String customerId;
  final String customerName;
  final String email;
  final String mobileNo;
  final String whatsappNo;
  final String gstNo;
  final String address;
  final String productId;

  EditCustomerEvent({
    required this.customerId,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.whatsappNo,
    required this.gstNo,
    required this.address,
    required this.productId,
});

}

class DeleteCustomerEvent extends CreateEditDeleteCustomerEvent{
  final String customerId;
  DeleteCustomerEvent({
    required this.customerId,
  });
}
