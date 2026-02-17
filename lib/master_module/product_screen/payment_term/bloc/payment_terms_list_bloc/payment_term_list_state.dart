import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/model/payment_term_list_model.dart';

abstract class PaymentTermListStates extends Equatable{

  @override
  List<Object> get props => [];
}

class InitialPaymentTermListStates extends PaymentTermListStates{}

class LoadingPaymentTermListStates extends PaymentTermListStates{}

class LoadedPaymentTermListStates extends PaymentTermListStates{

  final List<PaymentTermListModel> list;

  LoadedPaymentTermListStates({required this.list});

  @override
  List<Object> get props => [list];

}

class FailurePaymentTermListStates extends PaymentTermListStates{

  final String error;

  FailurePaymentTermListStates({required this.error});

  @override
  List<Object> get props => [error];
}

