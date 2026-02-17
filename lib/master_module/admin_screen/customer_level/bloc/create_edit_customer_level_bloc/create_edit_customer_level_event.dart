import 'package:equatable/equatable.dart';

abstract class CreateEditCustomerLevelEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateCustomerLevelEvent extends CreateEditCustomerLevelEvent {
  final String customerLevelName;

  CreateCustomerLevelEvent({
    required this.customerLevelName,
  });

  @override
  List<Object> get props => [customerLevelName];
}


class EditCustomerLevelEvent extends CreateEditCustomerLevelEvent {
  final String customerLevelName;
  final String customerLevelId;

  EditCustomerLevelEvent({
    required this.customerLevelName,
    required this.customerLevelId,
});

  @override
  List<Object> get props => [customerLevelName,customerLevelId];

}
