class OrderStatusListModel {
  final int orderStatusId;
  final String orderStatusName;
  final String status;
  final String textColor;
  final String textBgColor;
  final String orderBy;
  final String moduleStatus;

  OrderStatusListModel( {
    required this.orderStatusId,
    required this.orderStatusName,
    required this.status,
    required this.textColor,
    required this.textBgColor,
    required this.orderBy,
    required this.moduleStatus,
});
}