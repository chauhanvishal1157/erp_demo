class TaxMasterListModel {
  final int taxId;
  final String taxType;
  final String taxName;
  final String taxRate;
  final String status;

  TaxMasterListModel({
    required this.taxId,
    required this.taxType,
    required this.taxName,
    required this.taxRate,
    required this.status,
  });
}