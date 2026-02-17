class DispatchListModel{
  final int id;
  final String description;
  final String branchId;
  final String branchName;
  final int status;
  final String orderNo;
  final String stockStatus;
  final String createdAt;
  final String billingAddress;
  final String shippingAddress;
  final String customerName;
  final String email;
  final String mobileNo;
  final String whatsappNo;
  final String address;
  final String grandTotal;
  final String pendingAmount;
  final String receivedAmount;
  final String productSerialNumber;
  final String exclusiveOrInclusive;
  final String statusName;
  final String moduleStatus;
  final String statusTextColor;
  final String statusBgColor;
  final String createdBy;
  final String createdByStatus;


  DispatchListModel({
    required this.id,
    required this.description,
    required this.branchId,
    required this.branchName,
    required this.status,
    required this.orderNo,
    required this.stockStatus,
    required this.createdAt,
    required this.billingAddress,
    required this.shippingAddress,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.whatsappNo,
    required this.address,
    required this.grandTotal,
    required this.pendingAmount,
    required this.receivedAmount,
    required this.productSerialNumber,
    required this.exclusiveOrInclusive,
    required this.statusName,
    required this.moduleStatus,
    required this.statusTextColor,
    required this.statusBgColor,
    required this.createdBy,
    required this.createdByStatus,
});
}