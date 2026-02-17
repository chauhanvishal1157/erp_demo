class TaskListModel {
  final int taskId;
  final int adminId;
  final int createdBy;
  final String taskName;
  final String description;
  final String remark;
  final String status;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String employeeId;
  final String employeeName;
  final String taskPriority;

  TaskListModel({
    required this.taskId,
    required this.adminId,
    required this.createdBy,
    required this.taskName,
    required this.description,
    required this.remark,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.employeeId,
    required this.employeeName,
    required this.taskPriority,
  });
}