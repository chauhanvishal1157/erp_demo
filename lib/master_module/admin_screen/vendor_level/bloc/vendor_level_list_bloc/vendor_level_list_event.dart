import 'package:equatable/equatable.dart';

abstract class VendorLevelListEvents extends Equatable{

  @override
  List<Object> get props => [];

}

class FetchVendorLevelListEvent extends VendorLevelListEvents{}