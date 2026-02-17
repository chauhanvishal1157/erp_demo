import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/customer_level_bloc/customer_level_list_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/customer_level_bloc/customer_level_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/customer_level_bloc/customer_level_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/screens/create_edit_customer_level_bottom_sheet.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/screens/delete_customer_level_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/common_decoration.dart';


class CustomerLevelScreen extends StatefulWidget {
  const CustomerLevelScreen({super.key});

  @override
  State<CustomerLevelScreen> createState() => _CustomerLevelScreenState();
}

class _CustomerLevelScreenState extends State<CustomerLevelScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerLevelListBlocs(),
      child: CustomerLevel(),
    );
  }
}


class CustomerLevel extends StatefulWidget {
  const CustomerLevel({super.key});

  @override
  State<CustomerLevel> createState() => _CustomerLevelState();
}

class _CustomerLevelState extends State<CustomerLevel> {




  @override
  void initState() {
    BlocProvider.of<CustomerLevelListBlocs>(context).add(
      FetchCustomerLevelListEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Customers Level",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            context: context,
            builder:(context)=> CreateEditCustomerLevelBottomSheet(
              isEdit: false,
            ),
          ).then(
                (value) {
              if(value == true) {
                BlocProvider.of<CustomerLevelListBlocs>(context).add(
                  FetchCustomerLevelListEvent(),
                );
              }
            },
          );
        },
      ),
      body: BlocBuilder<CustomerLevelListBlocs, CustomerLevelListStates>(
        builder: (context, state) {
          if (state is InitialCustomerLevelListState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingCustomerLevelListState){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedCustomerLevelListState){
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      isScrollControlled:true,
                      context: context,
                      builder:(context)=> CreateEditCustomerLevelBottomSheet(
                        isEdit: true,
                        customerLevelName: state.list[index].customerLevelName,
                        customerLevelId:  state.list[index].customerLevelId.toString(),
                      ),
                    ).then(
                          (value) {
                        if(value == true) {
                          BlocProvider.of<CustomerLevelListBlocs>(context).add(
                            FetchCustomerLevelListEvent(),
                          );
                        }
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                    padding: EdgeInsets.all(15),
                    decoration: CommonDecorations.card(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            state.list[index].customerLevelName,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        CommonPopMenuButton(
                            value1: (){
                              showModalBottomSheet(
                                isScrollControlled:true,
                                context: context,
                                builder:(context)=> CreateEditCustomerLevelBottomSheet(
                                  isEdit: true,
                                  customerLevelName: state.list[index].customerLevelName,
                                  customerLevelId:  state.list[index].customerLevelId.toString(),
                                ),
                              ).then(
                                    (value) {
                                  if(value == true) {
                                    BlocProvider.of<CustomerLevelListBlocs>(context).add(
                                      FetchCustomerLevelListEvent(),
                                    );
                                  }
                                },
                              );
                            },
                            value2: (){
                              showModalBottomSheet(
                                isScrollControlled:true,
                                context: context,
                                builder:(context)=> DeleteCustomerLevelBottomSheet(
                                  customerLevelId:  state.list[index].customerLevelId.toString(),
                                ),
                              ).then(
                                    (value) {
                                  if(value == true) {
                                    BlocProvider.of<CustomerLevelListBlocs>(context).add(
                                      FetchCustomerLevelListEvent(),
                                    );
                                  }
                                },
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          else if(state is FailureCustomerLevelListState){
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
