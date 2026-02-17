import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteTaskEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class CreateTaskEvent extends CreateEditDeleteTaskEvent{
  final String taskName;
  final String description;
  final String employeeName;
  final String employeeId;
  final String status;
  final String startDate;
  final String endDate;
  final String taskPriority;
  final String remark;


  CreateTaskEvent({
  required this.taskName,
  required this.description,
  required this.employeeName,
  required this.employeeId,
  required this.status,
  required this.startDate,
  required this.endDate,
  required this.taskPriority,
  required this.remark,
 });
  @override
  List<Object?> get props => [
    taskName,
    description,
    employeeName,
    employeeId,
    status,
    startDate,
    endDate,
    taskPriority,
    remark,

  ];
}

class EditTaskEvent extends CreateEditDeleteTaskEvent{
  final String taskId;
  final String taskName;
  final String description;
  final String employeeName;
  final String employeeId;
  final String status;
  final String startDate;
  final String endDate;
  final String taskPriority;
  final String remark;


  EditTaskEvent({
    required this.taskId,
    required this.taskName,
    required this.description,
    required this.employeeName,
    required this.employeeId,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.taskPriority,
    required this.remark,
  });

  @override
  List<Object?> get props => [
    taskId,
    taskName,
    description,
    employeeName,
    employeeId,
    status,
    startDate,
    endDate,
    taskPriority,
    remark,
  ];
}

class DeleteTaskEvent extends CreateEditDeleteTaskEvent{
  final String taskId;

  DeleteTaskEvent({
    required this.taskId,
  });
  @override
  List<Object?> get props => [taskId];
}
