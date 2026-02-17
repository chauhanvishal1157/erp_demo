import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteVendorEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class CreateVendorEvent extends CreateEditDeleteVendorEvent{
  final String vendorName;
  final String vendorEmail;
  final String mobileNumber;
  final String address;
  final String vendorLevelId;
  final String productId;
  final String countryId;
  final String stateId;
  final String cityId;


  CreateVendorEvent({
    required this.vendorName,
    required this.vendorEmail,
    required this.mobileNumber,
    required this.address,
    required this.vendorLevelId,
    required this.productId,
    required this.countryId,
    required this.stateId,
    required this.cityId,
  });

}

class EditVendorEvent extends CreateEditDeleteVendorEvent{
  final String vendorId;
  final String vendorName;
  final String vendorEmail;
  final String mobileNumber;
  final String whatsAppNo;
  final String address;
  final String vendorLevelId;
  final String productId;
  final String branchId;

  EditVendorEvent({
    required this.vendorId,
    required this.vendorName,
    required this.vendorEmail,
    required this.mobileNumber,
    required this.whatsAppNo,
    required this.address,
    required this.vendorLevelId,
    required this.productId,
    required this.branchId,
  });

}

class DeleteVendorEvent extends CreateEditDeleteVendorEvent{
  final String vendorId;
  DeleteVendorEvent({
    required this.vendorId,
  });
}

