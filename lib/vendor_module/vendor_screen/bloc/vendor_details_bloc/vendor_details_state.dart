import 'package:equatable/equatable.dart';

import '../../model/vendor_details_model/vendor_details_model.dart';

abstract class VendorDetailsState extends Equatable{

  @override
  List<Object?> get props => [];
}

class InitialVendorDetailsState extends VendorDetailsState{}

class LoadingVendorDetailsState extends VendorDetailsState{}

class LoadedVendorDetailsState extends VendorDetailsState{
  final List<VendorDetailsModel> list;

  LoadedVendorDetailsState({required this.list});

  @override
  List<Object?> get props => [list];
}

class FailureVendorDetailsState extends VendorDetailsState{
  final String error;

  FailureVendorDetailsState({required this.error});

  @override
  List<Object?> get props => [error];

}