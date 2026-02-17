import 'package:equatable/equatable.dart';

abstract class VendorDetailsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchVendorDetailsEvent extends VendorDetailsEvent {
  final String vendorId;

  FetchVendorDetailsEvent({required this.vendorId});

  @override
  List<Object?> get props => [vendorId];
}