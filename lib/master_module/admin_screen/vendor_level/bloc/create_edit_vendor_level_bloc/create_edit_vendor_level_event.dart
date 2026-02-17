import 'package:equatable/equatable.dart';

abstract class CreateEditVendorLevelEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateVendorLevelEvent extends CreateEditVendorLevelEvent {

  final String vendorLevelName;

  CreateVendorLevelEvent({
    required this.vendorLevelName,
  });

  @override
  List<Object> get props => [vendorLevelName];
}


class EditVendorLevelEvent extends CreateEditVendorLevelEvent {

  final String vendorLevelName;
  final String vendorLevelId;

  EditVendorLevelEvent({
    required this.vendorLevelName,
    required this.vendorLevelId,
  });

  @override
  List<Object> get props => [vendorLevelName,vendorLevelId];

}
