class TaskDetailsModel{
  final int taskId;
  final String taskName;
  final String employeeId;
  final String description;
  final String remark;
  final String status;
  final String startDate;
  final String endDate;
  final String taskPriority;
  final String employeeName;

  TaskDetailsModel({
    required this.taskId,
    required this.taskName,
    required this.employeeId,
    required this.description,
    required this.remark,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.taskPriority,
    required this.employeeName,
  });

  /// 🔹 From JSON
  factory TaskDetailsModel.fromJson(Map<String, dynamic> json) {
    return TaskDetailsModel(
      taskId: int.parse(json['id'].toString()),
      taskName: json['name'] ?? '',
      employeeId: json['employee_id'].toString(),
      description: json['description'] ?? '',
      remark: json['remark'] ?? '',
      status: json['status'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      taskPriority: json['task_priority'] ?? '',
      employeeName: json['employee_name'] ?? '',
    );
  }

  /// 🔹 To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': taskId,
      'name': taskName,
      'employee_id': employeeId,
      'description': description,
      'remark': remark,
      'status': status,
      'start_date': startDate,
      'end_date': endDate,
      'task_priority': taskPriority,
      'employee_name': employeeName,
    };
  }

}