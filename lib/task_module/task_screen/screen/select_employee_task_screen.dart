import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/bloc/employee_list_bloc/employee_list_bloc.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/bloc/employee_list_bloc/employee_list_event.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/bloc/employee_list_bloc/employee_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../common/app_color.dart';

class SelectEmployeeTaskScreen extends StatefulWidget {
  const SelectEmployeeTaskScreen({super.key});

  @override
  State<SelectEmployeeTaskScreen> createState() => _SelectEmployeeTaskScreenState();
}

class _SelectEmployeeTaskScreenState extends State<SelectEmployeeTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListBloc(),
      child: SelectEmployeeTaskScreenWidget(),
    );
  }
}


class SelectEmployeeTaskScreenWidget extends StatefulWidget {
  const SelectEmployeeTaskScreenWidget({super.key});

  @override
  State<SelectEmployeeTaskScreenWidget> createState() => _SelectEmployeeTaskScreenWidgetState();
}

class _SelectEmployeeTaskScreenWidgetState extends State<SelectEmployeeTaskScreenWidget> {



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
      appBar: CommonAppBar(title: "Select Employee"),
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
            return  SingleChildScrollView(
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
                      cursorColor: AppColors.primary,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          hintText: "Enter Employee category Name..",
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
                                  ? Colors.blue.shade50
                                  : Colors.white,
                              border: Border.all(
                                  color: isSelected
                                      ? AppColors.arrow
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
                                        fontSize: 10,
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
      bottomNavigationBar: CommonActionButton(
        title: "Save Selection",
        horizontalMargin: 15,
        icon: Icons.save,
        onTap: (){
          Navigator.of(context).pop([selectedEmployeeId,selectedEmployeeName,]);
        },
      ),
    );
  }
}
