import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/employee_screen/working_shift/bloc/working_shift_list_bloc/working_shift_list_bloc.dart';
import 'package:erp_demo/master_module/employee_screen/working_shift/bloc/working_shift_list_bloc/working_shift_list_event.dart';
import 'package:erp_demo/master_module/employee_screen/working_shift/bloc/working_shift_list_bloc/working_shift_list_state.dart';
import 'package:erp_demo/master_module/employee_screen/working_shift/screens/create_edit_working_shift_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../../../common/common_decoration.dart';



class WorkingShiftEmployeeScreen extends StatefulWidget {
  const WorkingShiftEmployeeScreen({super.key});

  @override
  State<WorkingShiftEmployeeScreen> createState() => _WorkingShiftEmployeeScreenState();
}

class _WorkingShiftEmployeeScreenState extends State<WorkingShiftEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> WorkingShiftListBlocs(),
      child: WorkingShiftEmployee(),
    );
  }
}


class WorkingShiftEmployee extends StatefulWidget {
  const WorkingShiftEmployee({super.key});

  @override
  State<WorkingShiftEmployee> createState() => _WorkingShiftEmployeeState();
}

class _WorkingShiftEmployeeState extends State<WorkingShiftEmployee> {



  String formatTime(String timeString) {
    try {
      final time = DateFormat("HH:mm:ss").parse(timeString);
      return DateFormat("hh:mm a").format(time);
    } catch (e) {
      return timeString;
    }
  }

  @override
  void initState() {
    BlocProvider.of<WorkingShiftListBlocs>(context).add(FetchWorkingShiftListEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Working Shift",
        showAdd: true,
        onAddTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=>CreateEditWorkingShiftScreenWidget(),
            ),
          );
        },
      ),
      body: BlocBuilder<WorkingShiftListBlocs, WorkingShiftListStates>(
        builder: (context, state) {
          if (state is InitialWorkingShiftListStates) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingWorkingShiftListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedWorkingShiftListStates){
            return ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: state.list.length  ,
                itemBuilder: (context,index){

                  String statusLabel = state.list[index].status == "1"
                      ? "Active"
                      : "Inactive";

                  Color statusColor = (state.list[index].status) == "1"
                      ? Colors.green
                      : Colors.red;


                  return  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.all(15),
                    decoration: CommonDecorations.card(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if ((state.list[index].shiftCode).isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2,horizontal: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                ),
                                child: Text(
                                  state.list[index].shiftCode,
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text(
                                state.list[index].name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
                                      builder: (context)=>CreateEditWorkingShiftScreenWidget(),
                                    ),
                                  );
                                }
                                else if (value == 2)  {}
                                else if (value == 3) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context){
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                        ),
                                        child: Wrap(
                                          children: [

                                          ],
                                        ),
                                      );
                                    },
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
                                        "Update",
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
                                            color: Colors.green.shade50,
                                            borderRadius: BorderRadius.circular(6)
                                        ),
                                        child: Icon(
                                          Icons.person_add_outlined,
                                          color: Colors.green,
                                          size: 18,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Assign",
                                        style: TextStyle(
                                            color: Colors.black
                                        ),
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 4,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.more_vert,
                                  size: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(bottom: 15,top: 15),
                          padding: EdgeInsets.all(15),
                          decoration: CommonDecorations.card(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "Start Time",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    formatTime(state.list[index].startTime),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                ],
                              ),
                              Container(
                                width: 1,
                                height: 30,
                                color: Colors.black26,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_filled,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "End Time",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    formatTime(state.list[index].endTime),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Status:",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black38,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding:  EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                border: Border.all(
                                  color:statusColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child:  Text(
                               statusLabel,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
          else if(state is FailureWorkingShiftListStates){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }

}
