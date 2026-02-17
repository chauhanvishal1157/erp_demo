import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/task_module/task_screen/bloc/create_edit_delete_task_bloc/create_edit_delete_task_bloc.dart';
import 'package:erp_demo/task_module/task_screen/bloc/create_edit_delete_task_bloc/create_edit_delete_task_event.dart';
import 'package:erp_demo/task_module/task_screen/bloc/create_edit_delete_task_bloc/create_edit_delete_task_state.dart';
import 'package:erp_demo/task_module/task_screen/screen/select_employee_task_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../../common/common_toast.dart';

class CreateEditTaskScreen extends StatefulWidget {
  final bool isEdit;
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


  const CreateEditTaskScreen({
    required this.isEdit,
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
    super.key
  });

  @override
  State<CreateEditTaskScreen> createState() => _CreateEditTaskScreenState();
}

class _CreateEditTaskScreenState extends State<CreateEditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteTaskBloc(),
      child: CreateEditTaskScreenWidget(
        isEdit: widget.isEdit,
        taskId: widget.taskId,
        taskName: widget.taskName,
        description: widget.description,
        employeeName:widget.employeeName,
        employeeId: widget.employeeId,
        status: widget.status,
        startDate: widget.startDate,
        endDate: widget.endDate,
        taskPriority: widget.taskPriority,
        remark: widget.remark,
      ),
    );
  }
}


class CreateEditTaskScreenWidget extends StatefulWidget {
  final bool isEdit;
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

  const CreateEditTaskScreenWidget({
    required this.isEdit,
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
    super.key
  });

  @override
  State<CreateEditTaskScreenWidget> createState() => _CreateEditTaskScreenWidgetState();
}

class _CreateEditTaskScreenWidgetState extends State<CreateEditTaskScreenWidget> {

  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();


  String selectedTaskPriority = "Low";
  String selectedStatus = "Pending";

  bool reminderEnabled = true;
  DateTime? startDate;
  DateTime? endDate;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          startDateController.text = formatter.format(picked);
        } else {
          endDate = picked;
          endDateController.text = formatter.format(picked);
        }
      });
    }
  }

  String selectedEmployeeId = "";

  @override
  void initState() {
    final now = DateTime.now();
    startDate ??= now;
    endDate ??= now;
    startDateController.text = formatter.format(startDate!);
    endDateController.text = formatter.format(endDate!);

    taskNameController.text = widget.taskName;
    descriptionController.text = widget.description;
    remarkController.text = widget.remark;
    employeeNameController.text = widget.employeeName;

    selectedEmployeeId = widget.employeeId.toString();

    if (widget.isEdit && widget.startDate.isNotEmpty) {
      startDate = DateTime.parse(widget.startDate);
      startDateController.text = formatter.format(startDate!);
    }

    if (widget.isEdit && widget.endDate.isNotEmpty) {
      endDate = DateTime.parse(widget.endDate);
      endDateController.text = formatter.format(endDate!);
    }

    if (widget.isEdit) {
      switch (widget.taskPriority) {
        case "1":
          selectedTaskPriority = "Low";
          break;
        case "2":
          selectedTaskPriority = "Medium";
          break;
        case "3":
          selectedTaskPriority = "High";
          break;
        default:
          selectedTaskPriority = "Low";
      }
    }

    if (widget.isEdit) {
      switch (widget.status) {
        case "1":
          selectedStatus = "Pending";
          break;
        case "2":
          selectedStatus = "InProgress";
          break;
        case "3":
          selectedStatus = "Rejected";
          break;
        case "4":
          selectedStatus = "Completed";
          break;
        case "5":
          selectedStatus = "Re-open";
          break;
        case "6":
          selectedStatus = "Closed";
          break;
        default:
          selectedStatus = "Pending";
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title:  widget.isEdit == true
              ? "Update Task"
              : "Create Task",
      ),
      body:  BlocConsumer<CreateEditDeleteTaskBloc, CreateEditDeleteTaskState>(
        listener: (context, state){
          if (state is LoadedCreateTaskState) {
            CommonToast.show(context,state.message);
            Navigator.of(context).pop(true);
          }
          else if(state is FailureCreateTaskState) {
            CommonToast.show(context,state.error);
          }
          else if (state is LoadedEditTaskState) {
            CommonToast.show(context,state.message);
            Navigator.of(context).pop(true);
          }
          else if(state is FailureEditTaskState) {
            CommonToast.show(context,state.error);
          }
        },
        builder: (context, state){
          if (state is LoadingCreateTaskState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingEditTaskState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          return   SingleChildScrollView(
            child: Column(
              children: [
                CommonTextField(
                    controller: taskNameController,
                    label: "Task Name",
                    horizontalMargin: 15,
                    hint: "Enter Task Name..",
                ),
                CommonTextField(
                  controller: descriptionController,
                  horizontalMargin: 15,
                  label: "Description",
                  maxLines: 3,
                  hint:  "Enter Description...",
                ),
                CommonTextField(
                    horizontalMargin: 15,
                    controller: employeeNameController,
                    label:"Select Employee",
                    hint: "Tap to select Employee...",
                   readOnly: true,
                   suffixIconBoxed: false,
                   suffixIcon: Icons.arrow_forward_ios,
                   onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectEmployeeTaskScreen()
                        )
                    ).then(
                          (value) {
                        selectedEmployeeId = value[0];
                        employeeNameController.text = value[1];
                        setState(() {});
                      },
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  padding:  EdgeInsets.symmetric(horizontal: 10,),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedTaskPriority,
                    icon:  Icon(
                      color: AppColors.primary,
                      Icons.keyboard_arrow_down,
                    ),
                    decoration: InputDecoration(
                      labelText: "Select Task Priority",
                      labelStyle:  TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      setState(() {
                        selectedTaskPriority = val ?? "";}
                      );},
                    items: ['Low', 'Medium', 'High'].map((e) {
                      Color dotColor;
                      if (e == "Low") {
                        dotColor = AppColors.primary;
                      } else if (e == "Medium") {
                        dotColor = Colors.yellow.shade700;
                      } else {
                        dotColor = Colors.red;
                      }
                      return DropdownMenuItem(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e,
                              style:  TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: dotColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15,right: 15),
                  padding:  EdgeInsets.symmetric(horizontal: 10,),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedStatus,
                    icon:  Icon(
                      color: AppColors.primary,
                      Icons.keyboard_arrow_down,
                    ),
                    decoration: InputDecoration(
                      labelText: "Status",
                      labelStyle:  TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      setState(() {
                        selectedStatus = val ?? "";}
                      );},
                    items: ['Pending', 'InProgress', 'Rejected', 'Completed', 'Re-open', 'Closed',].map((e) {
                      Color dotColors;

                      switch (e) {
                        case "Pending":
                          dotColors = Colors.orange;
                          break;
                        case "InProgress":
                          dotColors = AppColors.primary;
                          break;
                        case "Rejected":
                          dotColors = Colors.red;
                          break;
                        case "Completed":
                          dotColors = Colors.green;
                          break;
                        case "Re-open":
                          dotColors = Colors.black;
                          break;
                        case "Closed":
                          dotColors = Colors.blueGrey;
                          break;
                        default:
                          dotColors = Colors.grey;
                      }
                      return DropdownMenuItem(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e,
                              style:  TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              width: 10,
                              height: 10,
                              margin:  EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: dotColors,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                CommonDateField(
                  label: "Start Date",
                  horizontalMargin: 15,
                  controller: startDateController,
                  onTap: () => _selectDate(context, true),
                ),
                CommonDateField(
                  label: "End Date",
                  horizontalMargin: 15,
                  controller: endDateController,
                  onTap: () => _selectDate(context, false),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15,15,15,0),
                  padding:  EdgeInsets.all(10),
                  decoration: CommonDecorations.card(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Reminder Notification",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Enable Notification For Reminder",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: reminderEnabled,
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue.shade200,
                        onChanged: (val) {
                          setState(() {
                            reminderEnabled = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                CommonTextField(
                  controller: remarkController,
                  label: "Remark for Employee",
                  maxLines: 3,
                  readOnly: true,
                  hint:  "Write Something...",
                  horizontalMargin: 15,
                ),
                CommonBottomActionButtons(
                    onTap: () {
                      final String taskPriorityStatus;
                      switch (selectedTaskPriority) {
                        case "Low":
                          taskPriorityStatus = "1";
                          break;
                        case "Medium":
                          taskPriorityStatus = "2";
                          break;
                        case "High":
                          taskPriorityStatus = "3";
                          break;
                        default:
                          taskPriorityStatus = "1";
                      }


                      final String mappedStatus;
                      switch (selectedStatus) {
                        case "Pending":
                          mappedStatus = "1";
                          break;
                        case "InProgress":
                          mappedStatus = "2";
                          break;
                        case "Rejected":
                          mappedStatus = "3";
                          break;
                        case "Completed":
                          mappedStatus = "4";
                          break;
                        case "Re-open":
                          mappedStatus = "5";
                          break;
                        case "Closed":
                          mappedStatus = "6";
                          break;
                        default:
                          mappedStatus = "1";
                      }


                      final String formattedStartDate =
                      formatter.format(startDate ?? DateTime.now());

                      final String formattedEndDate =
                      formatter.format(endDate ?? DateTime.now());

                      if (widget.isEdit == true) {
                        BlocProvider.of<CreateEditDeleteTaskBloc>(context).add(
                            EditTaskEvent(
                              taskId: widget.taskId,
                              taskName: taskNameController.text,
                              description: descriptionController.text,
                              employeeName: employeeNameController.text,
                              employeeId: selectedEmployeeId,
                              status: mappedStatus,
                              startDate: formattedStartDate,
                              endDate: formattedEndDate,
                              taskPriority: taskPriorityStatus,
                              remark: remarkController.text,
                            )
                        );
                      }
                      else {
                        BlocProvider.of<CreateEditDeleteTaskBloc>(context).add(
                            CreateTaskEvent(
                              taskName: taskNameController.text,
                              description: descriptionController.text,
                              employeeName: employeeNameController.text,
                              employeeId: selectedEmployeeId,
                              status: mappedStatus,
                              startDate: formattedStartDate,
                              endDate: formattedEndDate,
                              taskPriority: taskPriorityStatus,
                              remark: remarkController.text,
                            )
                        );
                      }


                    },
                  horizontalMargin: 15,
                    submitText: "Save",
                    submitIcon: Icons.check,
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
