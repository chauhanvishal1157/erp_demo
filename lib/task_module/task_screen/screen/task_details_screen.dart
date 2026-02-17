import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/task_module/task_screen/bloc/task_details_bloc/task_details_bloc.dart';
import 'package:erp_demo/task_module/task_screen/bloc/task_details_bloc/task_details_event.dart';
import 'package:erp_demo/task_module/task_screen/bloc/task_details_bloc/task_details_state.dart';
import 'package:erp_demo/task_module/task_screen/screen/create_edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../../common/app_color.dart';


class TaskDetailsScreen extends StatefulWidget {
  final String taskId;
  final String taskName;
  final String status;
  final String employeeName;
  final String startDate;
  final String endDate;
  final String description;
  final String remark;
  final String employeeId;
  final String taskPriority;

  const TaskDetailsScreen({
    required this.taskId,
    required this.taskName,
    required this.status,
    required this.employeeName,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.remark,
    required this.employeeId,
    required this.taskPriority,
    super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => TaskDetailsBloc(),
      child: TaskDetailsScreenWidget(
        taskId: widget.taskId,
        taskName: widget.taskName,
        status: widget.status,
        employeeName: widget.employeeName,
        startDate: widget.startDate,
        endDate: widget.endDate,
        description: widget.description,
        remark: widget.remark,
        employeeId: widget.employeeId,
        taskPriority: widget.taskPriority,

      ),
    );
  }
}


class TaskDetailsScreenWidget extends StatefulWidget {
  final String taskId;
  final String taskName;
  final String status;
  final String employeeName;
  final String startDate;
  final String endDate;
  final String description;
  final String remark;
  final String employeeId;
  final String taskPriority;

  const TaskDetailsScreenWidget({
    required this.taskId,
    required this.taskName,
    required this.status,
    required this.employeeName,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.remark,
    required this.employeeId,
    required this.taskPriority,
    super.key,});

  @override
  State<TaskDetailsScreenWidget> createState() => _TaskDetailsScreenWidgetState();
}

class _TaskDetailsScreenWidgetState extends State<TaskDetailsScreenWidget> {

  TextEditingController commentController = TextEditingController();

  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  @override
  void initState() {
    BlocProvider.of<TaskDetailsBloc>(context).add(
        FetchTaskDetailsEvent(
            taskId: widget.taskId,
        )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Task Details",
        showAdd: true,
        addIconColor: AppColors.primary,
        addIcon: Icons.edit_outlined,
        onAddTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateEditTaskScreen(
                          isEdit: true,
                          taskId: widget.taskId,
                          taskName: widget.taskName,
                          description: widget.description,
                          employeeName: widget.employeeName,
                          employeeId: widget.employeeId,
                          status: widget.status,
                          startDate: widget.startDate,
                          endDate: widget.endDate,
                          taskPriority: widget.taskPriority,
                          remark: widget.remark
                      )
              )
          ).then(
              (value){
                if (value == true) {
                  BlocProvider.of<TaskDetailsBloc>(context).add(
                      FetchTaskDetailsEvent(taskId: widget.taskId)
                  );
                }
              }
          );
        }
      ),
      body:  BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
        builder: (context, state) {
          if (state is InitialTaskDetailsState) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingTaskDetailsState){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedTaskDetailsState){

            final task = state.list.first;

            String getStatusText(String status) {
              switch (task.status) {
                case "1":
                  return "Pending";
                case "2":
                  return "InProgress";
                case "3":
                  return "Rejected";
                case "4":
                  return "Completed";
                case "5":
                  return "Re-open";
                case "6":
                  return "Closed";
                default:
                  return "Pending";
              }
            }

            Color getStatusColor(String status) {
              switch (task.status) {
                case '1':
                  return Colors.orange;
                case '2':
                  return Colors.blue;
                case '3':
                  return Colors.red;
                case '4':
                  return Colors.green;
                case '5':
                  return Colors.black;
                case '6':
                  return Colors.blueGrey;
                default:
                  return Colors.grey;
              }
            }


            return   SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: CommonDecorations.card(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: getStatusColor(task.status).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                task.taskName,
                                style: TextStyle(
                                  color: getStatusColor(task.status).withValues(alpha: 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: getStatusColor(task.status).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  getStatusText(task.status),
                                  style: TextStyle(
                                      color: getStatusColor(task.status).withValues(alpha: 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.person_outline,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Assigned to",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Text(
                                task.employeeName,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    border: Border.all(
                                      color: Colors.green.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(
                                              Icons.play_arrow_outlined,
                                              size: 18,
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "Start Date",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        formatDate(task.startDate),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    border: Border.all(
                                      color: Colors.orange.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.orange.shade100,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(
                                              Icons.square_outlined,
                                              size: 12,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "End Date",
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        formatDate(task.endDate),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black26,
                          indent: 15,
                          endIndent: 15,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.shade50,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(
                                      Icons.description_outlined,
                                      size: 16,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                task.description,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: CommonDecorations.card(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Comment",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_up_outlined,
                              color: Colors.blue,
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 50),
                          padding: EdgeInsets.only(left: 10,),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                                fontWeight: FontWeight.w500
                            ),
                            controller: commentController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Add your Comment here...",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintStyle:  TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                                suffixIcon: Icon(
                                    Icons.send
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          else if(state is FailureTaskDetailsState){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      )
    );
  }

}
