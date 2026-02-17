import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/bloc/employee_category_list_bloc/employee_category_list_bloc.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/bloc/employee_category_list_bloc/employee_category_list_event.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/bloc/employee_category_list_bloc/employee_category_list_state.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/screens/create_edit_employee_category_bottom_sheet.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/screens/delete_employee_category_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../common/common_decoration.dart';


class EmployeeCategoryScreen extends StatefulWidget {
  const EmployeeCategoryScreen({super.key});

  @override
  State<EmployeeCategoryScreen> createState() => _EmployeeCategoryScreenState();
}

class _EmployeeCategoryScreenState extends State<EmployeeCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeCategoryListBloc(),
      child: EmployeeCategory(),
    );
  }
}


class EmployeeCategory extends StatefulWidget {
  const EmployeeCategory({super.key});

  @override
  State<EmployeeCategory> createState() => _EmployeeCategoryState();
}

class _EmployeeCategoryState extends State<EmployeeCategory> {



  @override
  void initState() {
    BlocProvider.of<EmployeeCategoryListBloc>(context).add(FetchEmployeeCategoryListEvents());
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Employee Category",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            backgroundColor: Colors.transparent,
            context: context,
            builder:(context){
              return CreateEditEmployeeCategoryBottomSheet(
                  isEdit: false,
                  employeeCategoryId: '',
                  employeeCategoryName: '',
                  status: ''
              );
            },
          ).then(
                  (value){
                if(value == true){
                  BlocProvider.of<EmployeeCategoryListBloc>(context).add(
                      FetchEmployeeCategoryListEvents()
                  );
                }
              }
          );
        }
      ),
      body: BlocBuilder<EmployeeCategoryListBloc, EmployeeCategoryListStates>(
        builder: (context, state) {
          if (state is InitialEmployeeCategoryListStates) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingEmployeeCategoryListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedEmployeeCategoryListStates){
            return  ListView.builder(
              itemCount: state.list.length  ,
              padding:  EdgeInsets.all(15),
              itemBuilder: (context, index) {

                String statusLabel = state.list[index].status == 1
                    ? "Active"
                    : "Inactive";

                Color statusColor = (state.list[index].status) == 1
                    ? Colors.green
                    : Colors.red;

                return GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                      isScrollControlled:true,
                      context: context,
                      builder:(context){
                        return CreateEditEmployeeCategoryBottomSheet(
                            isEdit: true,
                            employeeCategoryId: state.list[index].employeeCategoryId.toString(),
                            employeeCategoryName: state.list[index].employeeCategoryName,
                            status: state.list[index].status.toString()
                        );
                      },
                    ).then(
                            (value){
                          if(value == true){
                            BlocProvider.of<EmployeeCategoryListBloc>(context).add(
                                FetchEmployeeCategoryListEvents()
                            );
                          }
                        }
                    );
                  },
                  child: Container(
                    margin:  EdgeInsets.only(bottom: 15),
                    decoration: CommonDecorations.card(),
                    child: Padding(
                      padding:  EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:  EdgeInsets.all(10),
                            child:  Icon(
                              state.list[index].status == 1
                                  ? Icons.check_circle_outline   // Active icon
                                  : Icons.pause_circle_outline,
                              color: statusColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.list[index].employeeCategoryName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(alpha: 0.1),
                                    border: Border.all(
                                      color: statusColor.withValues(alpha: 1),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                       statusLabel,
                                        style: TextStyle(
                                          color:statusColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CommonPopMenuButton(
                              value1: (){
                                showModalBottomSheet(
                                  isScrollControlled:true,
                                  context: context,
                                  builder:(context){
                                    return CreateEditEmployeeCategoryBottomSheet(
                                        isEdit: true,
                                        employeeCategoryId: state.list[index].employeeCategoryId.toString(),
                                        employeeCategoryName: state.list[index].employeeCategoryName,
                                        status: state.list[index].status.toString()
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true){
                                        BlocProvider.of<EmployeeCategoryListBloc>(context).add(
                                            FetchEmployeeCategoryListEvents()
                                        );
                                      }
                                    }
                                );
                              },
                              value2: (){
                                showModalBottomSheet(
                                  isScrollControlled:true,
                                  context: context,
                                  builder:(context){
                                    return DeleteEmployeeCategoryBottomSheet(
                                      employeeCategoryId: state.list[index].employeeCategoryId.toString(),
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true){
                                        BlocProvider.of<EmployeeCategoryListBloc>(context).add(
                                            FetchEmployeeCategoryListEvents()
                                        );
                                      }
                                    }
                                );
                              }
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else if(state is FailureEmployeeCategoryListStates){
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
