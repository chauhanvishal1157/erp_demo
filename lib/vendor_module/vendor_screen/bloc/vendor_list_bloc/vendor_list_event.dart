import 'package:equatable/equatable.dart';

abstract class VendorListEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class FetchVendorListEvent extends VendorListEvent{}

