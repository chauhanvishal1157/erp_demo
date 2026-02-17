import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/lead_category_list_bloc/lead_category_list_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/lead_category_list_bloc/lead_category_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/lead_category_list_bloc/lead_category_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/screens/create_edit_lead_category_bottom_sheet.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/screens/delete_lead_category_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;

import '../../../../common/common_decoration.dart';

class LeadCategoryScreen extends StatefulWidget {
  const LeadCategoryScreen({super.key});

  @override
  State<LeadCategoryScreen> createState() => _LeadCategoryScreenState();
}

class _LeadCategoryScreenState extends State<LeadCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeadCategoryListBlocs(),
      child: LeadCategory(),
    );
  }
}


class LeadCategory extends StatefulWidget {
  const LeadCategory({super.key});

  @override
  State<LeadCategory> createState() => _LeadCategoryState();
}

class _LeadCategoryState extends State<LeadCategory> {

  List<Map<String, dynamic>> leadCategoryList = [];

  @override
  void initState() {
    BlocProvider.of<LeadCategoryListBlocs>(context).add(
      FetchLeadCategoryListEvents(
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Lead Category",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            context: context,
            builder:(context){
              return CreateEditLeadCategoryBottomSheet(
                  isEdit: false,
                  leadCategoryId: '',
                  leadCategoryName: '',
                  status: ''
              );
            },
          ).then(
                (value) {
              if(value == true) {
                BlocProvider.of<LeadCategoryListBlocs>(context).add(
                  FetchLeadCategoryListEvents(),
                );
              }
            },
          );
        },
      ),
      body:BlocBuilder<LeadCategoryListBlocs, LeadCategoryListStates>(
        builder: (context, state) {
          if (state is InitialLeadCategoryListStates) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingLeadCategoryListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedLeadCategoryListStates){
            return ListView.builder(
              itemCount: state.list.length,
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
                      context: context,
                      isScrollControlled: true,
                      builder: (context){
                        return CreateEditLeadCategoryBottomSheet(
                            isEdit: true,
                            leadCategoryId: state.list[index].leadCategoryId.toString(),
                            leadCategoryName: state.list[index].leadCategoryName,
                            status: state.list[index].status.toString()
                        );
                      },
                    ).then(
                          (value) {
                        if(value == true) {
                          BlocProvider.of<LeadCategoryListBlocs>(context).add(
                            FetchLeadCategoryListEvents(),
                          );
                        }
                      },
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
                            margin:  EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:  EdgeInsets.all(10),
                            child:  Icon(
                              state.list[index].status == 1
                                  ? Icons.check_circle_outline
                                  : Icons.pause_circle_filled_outlined,
                              color: statusColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.list[index].leadCategoryName,
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
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context){
                                    return  CreateEditLeadCategoryBottomSheet(
                                        isEdit: true,
                                        leadCategoryId: state.list[index].leadCategoryId.toString(),
                                        leadCategoryName: state.list[index].leadCategoryName,
                                        status: state.list[index].status.toString()
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<LeadCategoryListBlocs>(context).add(
                                        FetchLeadCategoryListEvents(),
                                      );
                                    }
                                  },
                                );
                              },
                              value2: (){
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context){
                                    return DeleteLeadCategoryBottomSheet(
                                        leadCategoryId: state.list[index].leadCategoryId.toString()
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<LeadCategoryListBlocs>(context).add(
                                        FetchLeadCategoryListEvents(),
                                      );
                                    }
                                  },
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else if(state is FailureLeadCategoryListStates){
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
