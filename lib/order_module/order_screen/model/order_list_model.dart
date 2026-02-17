class OrderListModel{
  final int id;
  final String branchId;
  final String branchName;
  final int status;
  final String orderNo;
  final String stockStatus;
  final String billingAddress;
  final String shippingAddress;
  final String createdAt;
  final String grandTotal;
  final String pendingAmount;
  final String receivedAmount;
  final String productSerialNumber;
  final String customerName;
  final String email;
  final String mobileNo;
  final String statusName;
  final String moduleStatus;
  final String statusTextColor;
  final String statusBgColor;
  final String newTotalMrp;

  OrderListModel({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.status,
    required this.orderNo,
    required this.stockStatus,
    required this.billingAddress,
    required this.shippingAddress,
    required this.createdAt,
    required this.grandTotal,
    required this.pendingAmount,
    required this.receivedAmount,
    required this.productSerialNumber,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.statusName,
    required this.moduleStatus,
    required this.statusTextColor,
    required this.statusBgColor,
    required this.newTotalMrp,
});

}