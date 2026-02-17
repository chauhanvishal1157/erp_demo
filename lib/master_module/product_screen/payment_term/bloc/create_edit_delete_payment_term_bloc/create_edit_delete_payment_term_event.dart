import 'package:equatable/equatable.dart';

abstract class CreateEditDeletePaymentTermEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CreatePaymentTermEvent extends CreateEditDeletePaymentTermEvent{
  final String paymentTermsName;
  final String status;

  CreatePaymentTermEvent({
    required this.paymentTermsName,
    required this.status,
  });
  @override
  List<Object> get props => [paymentTermsName,status];
}

class EditPaymentTermEvent extends CreateEditDeletePaymentTermEvent{
  final String paymentTermsId;
  final String paymentTermsName;
  final String status;


  EditPaymentTermEvent({
    required this.paymentTermsName,
    required this.status,
    required this.paymentTermsId,
  });
  @override
  List<Object> get props => [paymentTermsName,status,paymentTermsId];
}

class DeletePaymentTermEvent extends CreateEditDeletePaymentTermEvent{
  final String paymentTermsId;

  DeletePaymentTermEvent({
    required this.paymentTermsId,
  });
  @override
  List<Object> get props => [paymentTermsId];
}
