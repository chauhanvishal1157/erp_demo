import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/bloc/employee_list_bloc/employee_list_bloc.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/bloc/employee_list_bloc/employee_list_event.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/bloc/employee_list_bloc/employee_list_state.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/add_employee_screen/add_new_employee_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/details_screen/employee_details_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/sort_employee_bottom_sheet/sort_employee_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../employee_recalculate_screen/employee_recalculate.dart';


class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListBloc(),
      child: EmployeeScreenWidget(),
    );
  }
}


class EmployeeScreenWidget extends StatefulWidget {
  const EmployeeScreenWidget({super.key});

  @override
  State<EmployeeScreenWidget> createState() => _EmployeeScreenWidgetState();
}

class _EmployeeScreenWidgetState extends State<EmployeeScreenWidget> {

  final String baseUrl = "https://shiserp.com/demo/";

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
      backgroundColor:  AppColors.screenBg,
      appBar: CustomAppBar(
          leadingIcon:  Icons.group_outlined,
          title: "Employee",
          subtitle:  "Manage your team",
        showAdd: true,
        addIconColor: AppColors.primary,
        addIcon: Icons.error_outline,

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
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.shade100)
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Pending Salary",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "₹800.00",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context){
                                        return Wrap(
                                          children: [
                                            EmployeeRecalculate(),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade300,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "Recalculate",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>AddNewEmployeeScreen(),
                      ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(left: 15,right: 15),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.arrow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.person_add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Add New Employee",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.arrow,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    "7 / 10",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                          hintText: "Enter Search Employee Name..",
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
                  Padding(
                    padding:  EdgeInsets.only(left: 15,right: 15,top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Team Members",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "7 employee",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context){
                                  return Wrap(
                                    children: [
                                      SortEmployeeBottomSheet(),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColors.arrow,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade200,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  )
                                ]
                            ),
                            child: Icon(
                              Icons.tune_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.only(bottom: 50),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.list.length,
                    itemBuilder: (context,index){
                      return  GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context)=>EmployeeDetailsScreen(),
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
                                backgroundColor: Colors.grey.shade200,
                                child: ClipOval(
                                  child: Image.network(
                                    baseUrl + (state.list[index].employeeProfile),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.person_outline,
                                        color: AppColors.primary,
                                      );
                                    },
                                  ),
                                ),
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
                                            state.list[index].employeeCode.toString(),
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
    );
  }
}
