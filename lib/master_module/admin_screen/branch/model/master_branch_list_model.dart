class BranchListModel {
  final int branchId;
  final String branchName;
  final String customerId;
  bool isSelected = false;

  BranchListModel({
    required this.branchId,
    required this.branchName,
    required this.customerId,
  });

}
 