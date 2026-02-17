import 'package:equatable/equatable.dart';

abstract class CreateEditTaxMasterEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateTaxMasterEvent extends CreateEditTaxMasterEvent{
  final String taxType;
  final String taxName;
  final String taxRate;
  final String status;

  CreateTaxMasterEvent({
    required this.taxType,
    required this.taxName,
    required this.taxRate,
    required this.status,
  });
  @override
  List<Object> get props => [taxType,taxName,taxRate,status];
}

class EditTaxMasterEvent extends CreateEditTaxMasterEvent{
  final String taxId;
  final String taxType;
  final String taxName;
  final String taxRate;
  final String status;

  EditTaxMasterEvent({
    required this.taxId,
    required this.taxType,
    required this.taxName,
    required this.taxRate,
    required this.status,
  });
  @override
  List<Object> get props => [taxId,taxType,taxName,taxRate,status];
}