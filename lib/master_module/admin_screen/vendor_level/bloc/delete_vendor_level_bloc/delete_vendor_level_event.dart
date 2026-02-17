import 'package:equatable/equatable.dart';

abstract class DeleteVendorLevelEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class DeleteVendorLevelEvent extends DeleteVendorLevelEvents {
  final String vendorLevelId;

  DeleteVendorLevelEvent({
    required this.vendorLevelId,
  });

  @override
  List<Object> get props => [vendorLevelId];

}

