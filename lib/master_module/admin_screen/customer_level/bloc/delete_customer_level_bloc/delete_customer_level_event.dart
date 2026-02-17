import 'package:equatable/equatable.dart';

abstract class DeleteCustomerLevelEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class DeleteCustomerLevelEvent extends DeleteCustomerLevelEvents {
  final String customerLevelId;

  DeleteCustomerLevelEvent({
    required this.customerLevelId,
  });

  @override
  List<Object> get props => [customerLevelId];

}

