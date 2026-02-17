import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/task_module/task_screen/bloc/task_list_bloc/task_list_bloc.dart';
import 'package:erp_demo/task_module/task_screen/bloc/task_list_bloc/task_list_event.dart';
import 'package:erp_demo/task_module/task_screen/bloc/task_list_bloc/task_list_state.dart';
import 'package:erp_demo/task_module/task_screen/screen/create_edit_task_screen.dart';
import 'package:erp_demo/task_module/task_screen/screen/delete_task_bottom_sheet.dart';
import 'package:erp_demo/task_module/task_screen/screen/filter_task_bottom_sheet.dart';
import 'package:erp_demo/task_module/task_screen/screen/task_details_screen.dart';
import 'package:erp_demo/task_module/task_screen/screen/task_history_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../../common/custom_app_bar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskListBloc(),
      child: TaskScreenWidget(),
    );
  }
}


class TaskScreenWidget extends StatefulWidget {
  const TaskScreenWidget({super.key});

  @override
  State<TaskScreenWidget> createState() => _TaskScreenWidgetState();
}

class _TaskScreenWidgetState extends State<TaskScreenWidget> {
  int selectedTab = 0;


  @override
  void initState() {
    BlocProvider.of<TaskListBloc>(context).add(
        FetchTaskListEvent()
    );
    super.initState();
  }

  String formatDate(String apiDate) {
    try {
      final DateTime parsedDate = DateTime.parse(apiDate);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return apiDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar:CustomAppBar(
        leadingIcon: Icons.task_outlined,
        title: "Task",
        subtitle: "Task Management",
        showAction1: true,
        actionIcon1Color: AppColors.primary,
        showAdd: true,
        actionIcon1: Icons.search,
        addIcon: Icons.add,
        onAddTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=>CreateEditTaskScreen(
                isEdit: false,
                taskId: '',
                taskName: '',
                description: '',
                employeeName: '',
                employeeId: '',
                status: '',
                startDate: '',
                endDate: '',
                taskPriority: '',
                remark: '',
              ),
            ),
          ).then(
                  (value){
                if (value == true) {
                  BlocProvider.of<TaskListBloc>(context).add(
                      FetchTaskListEvent()
                  );
                }
              }
          );
        },
      ),
      body: BlocBuilder<TaskListBloc, TaskListState>(
        builder: (context, state) {
          if (state is InitialTaskListState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingTaskListState){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedTaskListState){
            return   Stack(
              children: [
                ListView.builder(
                    itemCount: state.list.length,
                    padding: EdgeInsets.only(top: 190),
                    itemBuilder: (context ,index){

                      String taskPriority = "";
                      switch (state.list[index].taskPriority) {
                        case "1":
                          taskPriority = "Low";
                          break;
                        case "2":
                          taskPriority = "Medium";
                          break;
                        case "3":
                          taskPriority = "High";
                          break;
                        default:
                          taskPriority = "-";
                      }

                      Color taskPriorityColor(String priority) {
                        switch (priority) {
                          case "1":
                            return Colors.blue;
                          case "2":
                            return Colors.yellowAccent;
                          case "3":
                            return Colors.red;
                          default:
                            return Colors.grey;
                        }
                      }

                      String status = "";
                      switch (state.list[index].status.toString()) {
                        case "1":
                          status = "Pending";
                          break;
                        case "2":
                          status = "InProgress";
                          break;
                        case "3":
                          status = "Rejected";
                          break;
                        case "4":
                          status = "Completed";
                          break;
                        case "5":
                          status = "Re-open";
                          break;
                        case "6":
                          status = "Closed";
                          break;
                        default:
                          status = "Pending";
                      }

                      Color statusColor(String statusCode) {
                        switch (statusCode) {
                          case "1":
                            return Colors.orange;
                          case "2":
                            return Colors.blue;
                          case "3":
                            return Colors.red;
                          case "4":
                            return Colors.green;
                          case "5":
                            return Colors.black;
                          case "6":
                            return Colors.blueGrey;
                          default:
                            return Colors.orange;
                        }
                      }

                      return  GestureDetector(
                        onTap:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskDetailsScreen(
                                    taskId: state.list[index].taskId.toString(),
                                    taskName: state.list[index].taskName,
                                    status: state.list[index].status,
                                    employeeName: state.list[index].employeeName,
                                    startDate: state.list[index].startDate,
                                    endDate: state.list[index].endDate,
                                    description:  state.list[index].description,
                                    remark:state.list[index].remark,
                                    employeeId: state.list[index].employeeId,
                                    taskPriority: state.list[index].taskPriority,
                                  )
                              )
                          ).then(
                                  (value){
                                    if (value == true) {
                                      BlocProvider.of<TaskListBloc>(context).add(
                                          FetchTaskListEvent()
                                      );
                                    }
                                  }
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                          decoration: CommonDecorations.card(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: statusColor(
                                      state.list[index].status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                     state.list[index].taskName,
                                      style: TextStyle(
                                        color: statusColor(state.list[index].status).withValues(alpha: 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding:  EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor(state.list[index].status).withValues(alpha: 0.2),
                                            border: Border.all(
                                              color: statusColor(state.list[index].status).withValues(alpha: 0.3),
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child:  Text(
                                            status,
                                            style: TextStyle(
                                              color: statusColor(state.list[index].status).withValues(alpha: 1),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        PopupMenuButton<int>(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          onSelected: (value) async {
                                            if (value == 1)  {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context)=>CreateEditTaskScreen(
                                                    isEdit: true,
                                                    taskId: state.list[index].taskId.toString(),
                                                    taskName: state.list[index].taskName,
                                                    description: state.list[index].description,
                                                    employeeName: state.list[index].employeeName,
                                                    employeeId: state.list[index].employeeId,
                                                    status: state.list[index].status,
                                                    startDate: state.list[index].startDate,
                                                    endDate: state.list[index].endDate,
                                                    taskPriority: state.list[index].taskPriority,
                                                    remark: state.list[index].remark,
                                                  ),
                                                ),
                                              ).then(
                                                      (value){
                                                    if (value == true) {
                                                      BlocProvider.of<TaskListBloc>(context).add(
                                                          FetchTaskListEvent()
                                                      );
                                                    }
                                                  }
                                              );

                                            }
                                            else if(value == 2){
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context){
                                                  return  TaskHistoryBottomSheet(
                                                    taskId: state.list[index].taskId.toString(),
                                                    taskName: state.list[index].taskName,
                                                    status: state.list[index].status,
                                                    startDate: state.list[index].startDate,
                                                  );
                                                },
                                              ).then(
                                                      (value){
                                                    if (value == true) {
                                                      BlocProvider.of<TaskListBloc>(context).add(
                                                          FetchTaskListEvent()
                                                      );
                                                    }
                                                  }
                                              );
                                            }
                                            else if (value == 3) {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context){
                                                  return DeleteTaskBottomSheet(
                                                      taskId: state.list[index].taskId.toString()
                                                  );
                                                },
                                              ).then(
                                                      (value){
                                                    if (value == true) {
                                                      BlocProvider.of<TaskListBloc>(context).add(
                                                          FetchTaskListEvent()
                                                      );
                                                    }
                                                  }
                                              );
                                            }
                                          },
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 1,
                                              child: Row(
                                                children:  [
                                                  Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue.shade50,
                                                        borderRadius: BorderRadius.circular(6)
                                                    ),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.blue,
                                                      size: 18,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "Edit",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 2,
                                              child: Row(
                                                children:  [
                                                  Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue.shade50,
                                                        borderRadius: BorderRadius.circular(6)
                                                    ),
                                                    child: Icon(
                                                      Icons.history,
                                                      color: Colors.blue,
                                                      size: 18,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "History",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 3,
                                              child: Row(
                                                children:  [
                                                  Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red.shade50,
                                                        borderRadius: BorderRadius.circular(6)
                                                    ),
                                                    child: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                      size: 18,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          child:  Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: statusColor(state.list[index].status).withValues(alpha: 0.3),
                                              borderRadius: BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade100,
                                                  blurRadius: 4,
                                                  offset: Offset(2, 2),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.more_vert,
                                              size: 16,
                                              color: statusColor(state.list[index].status).withValues(alpha: 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.person_outline,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Assigned to",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                              state.list[index].employeeName,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          color: taskPriorityColor(state.list[index].taskPriority).withValues(alpha: 0.3),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        taskPriority,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    )
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
                                          color: Colors.blue.shade50,
                                          border: Border.all(
                                              color: Colors.blue.shade200
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding:  EdgeInsets.all(10),
                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.play_arrow_outlined,
                                                  size: 18,
                                                  color: Colors.blue,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Start Date",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              formatDate(state.list[index].startDate),
                                              style: TextStyle(
                                                color: Colors.blue.shade700,
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
                                              color: Colors.orange.shade200
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding:  EdgeInsets.all(10),
                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.flag_outlined,
                                                  size: 18,
                                                  color: Colors.orange,
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
                                              formatDate(state.list[index].endDate),
                                              style: TextStyle(
                                                color: Colors.orange.shade700,
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
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  border: Border.all(
                                      color: Colors.grey.shade200
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:  EdgeInsets.all(10),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.description_outlined,
                                          size: 16,
                                          color: Colors.black54,
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
                                      state.list[index].description,
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
                      );
                    }),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColors.screenBg
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                _buildTab("All", 0),
                                _buildTab("Assigned", 1),
                                _buildTab("Jn-Assigned", 2),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade100,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade50,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.list_alt,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "All Task",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Showing all Task statuses",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context){
                                            return FilterTaskBottomSheet();
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade100,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.tune,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    offset:  Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              child:  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.calendar_today_rounded,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    DateFormat('MMM dd, yyyy').format(DateTime.now()),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            );
          }
          else if(state is FailureTaskListState){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedTab = index);
        },
        child: Container(
          padding:  EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.shade300
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

}
