import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/task_module/report_screen/screen/task_report_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../common/common_action_button.dart';
import '../../../hr_manager_module/employee_screen/bloc/employee_list_bloc/employee_list_bloc.dart';
import '../../../hr_manager_module/employee_screen/bloc/employee_list_bloc/employee_list_event.dart';
import '../../../hr_manager_module/employee_screen/bloc/employee_list_bloc/employee_list_state.dart';

class ParticularEmployeeScreen extends StatefulWidget {
  const ParticularEmployeeScreen({super.key});

  @override
  State<ParticularEmployeeScreen> createState() => _ParticularEmployeeScreenState();
}

class _ParticularEmployeeScreenState extends State<ParticularEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListBloc(),
      child: ParticularEmployeeScreenWidget(),
    );
  }
}

class ParticularEmployeeScreenWidget extends StatefulWidget {
  const ParticularEmployeeScreenWidget({super.key});

  @override
  State<ParticularEmployeeScreenWidget> createState() => _ParticularEmployeeScreenWidgetState();
}

class _ParticularEmployeeScreenWidgetState extends State<ParticularEmployeeScreenWidget> {

  String selectedEmployeeName = "";
  String selectedEmployeeId = "";

  @override
  void initState() {
    BlocProvider.of<EmployeeListBloc>(context).add(
        FetchEmployeeListEvent(searchValue: '')
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Select Employee"
      ),
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
        builder: (context, state) {
          if (state is InitialEmployeeListState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingEmployeeListState){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedEmployeeListState){
            return  Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                              hintText: "Enter sub category Name..",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black26,
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                size: 20,
                                color: Colors.grey,
                              ),
                              suffixIcon: Icon(
                                Icons.mic_none,
                                size: 20,
                                color: Colors.grey,
                              )
                          ),
                        ),
                      ),
                      ListView.builder(
                          padding: EdgeInsets.only(bottom: 150),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            bool isSelected = selectedEmployeeName == state.list[index].name;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEmployeeId = state.list[index].employeeId.toString();
                                  selectedEmployeeName = state.list[index].name;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 15),
                                margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                                decoration: BoxDecoration(
                                  color:  isSelected
                                      ? Colors.blue[50]
                                      : Colors.white,
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.blue.shade200
                                          : Colors.white,
                                      width: 1.2
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 2,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      shape: CircleBorder(),
                                      side: BorderSide(color: Colors.grey),
                                      activeColor: AppColors.primary,
                                      value: isSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedEmployeeId = state.list[index].employeeId.toString();
                                          selectedEmployeeName = state.list[index].name;
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.list[index].name,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical:2,horizontal: 6),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Selected",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent
                    ),
                    child: CommonActionButton(
                      title: "Next",
                      horizontalMargin: 15,
                      icon: Icons.save,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskReportScreen()));
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          else if(state is FailureEmployeeListState){
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

