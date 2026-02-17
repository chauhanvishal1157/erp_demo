import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:erp_demo/hr_manager_module/salary_screen/salary_slip_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/common_decoration.dart';
import '../employee_screen/bloc/employee_list_bloc/employee_list_bloc.dart';
import '../employee_screen/bloc/employee_list_bloc/employee_list_event.dart';
import '../employee_screen/bloc/employee_list_bloc/employee_list_state.dart';

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListBloc(),
      child: SalaryScreenWidget(),
    );
  }
}


class SalaryScreenWidget extends StatefulWidget {
  const SalaryScreenWidget({super.key});

  @override
  State<SalaryScreenWidget> createState() => _SalaryScreenWidgetState();
}

class _SalaryScreenWidgetState extends State<SalaryScreenWidget> {
  @override
  void initState() {
    BlocProvider.of<EmployeeListBloc>(context).add(
      FetchEmployeeListEvent(
          searchValue: ''
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CustomAppBar(
          leadingIcon: Icons.payments_outlined,
          title:  "Salary",
          subtitle: "Monthly pay details",
      ),
      body:  BlocBuilder<EmployeeListBloc, EmployeeListState>(
        builder: (context, state) {
          if (state is InitialEmployeeListState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadingEmployeeListState){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadedEmployeeListState){
            return SingleChildScrollView(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 50),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.list.length,
                itemBuilder: (context,index){

                  return  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>SalarySlip(),
                      ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                      decoration: CommonDecorations.card(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue.shade100,
                              child: Icon(
                                Icons.person_outline,
                                size: 25,
                                color: AppColors.primary,
                              )
                          ),
                          SizedBox(width: 5,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        border: Border.all(
                                          color: Colors.blue.shade100,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child:  Text(
                                        state.list[index].employeeCode,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        state.list[index].name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,

                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(
                                      color: Colors.blue.shade100,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.phone_outlined,
                                        size: 14,
                                        color: AppColors.primary,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "+91 ${state.list[index].mobileNo}",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    margin: EdgeInsets.only(left: 20,right: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.person_outline,
                                      color: Colors.blue,
                                      size: 14,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5,right: 5,),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.red,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee_sharp,
                                          color: Colors.red,
                                          size: 10,
                                        ),
                                        Text(
                                          state.list[index].salary.toString(),
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.green.shade200,
                                  ),
                                ),
                                child: Text(
                                  state.list[index].categoryName,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.green.shade400,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
    );
  }
}
