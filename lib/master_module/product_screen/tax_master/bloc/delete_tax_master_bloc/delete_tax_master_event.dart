import 'package:equatable/equatable.dart';

abstract class DeleteTaxMasterEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class DeleteTaxMasterEvents extends DeleteTaxMasterEvent{
  final String taxId;

  DeleteTaxMasterEvents({
    required this.taxId
  });
  @override
  List<Object?> get props => [taxId];
}