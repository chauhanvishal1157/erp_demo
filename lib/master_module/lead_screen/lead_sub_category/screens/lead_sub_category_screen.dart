import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/bloc/lead_sub_category_bloc/lead_sub_category_list_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/bloc/lead_sub_category_bloc/lead_sub_category_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/bloc/lead_sub_category_bloc/lead_sub_category_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/screens/create_edit_lead_sub_category_bottom_sheet.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/screens/delete_lead_sub_category_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;

import '../../../../common/app_color.dart';
import '../../../../common/common_decoration.dart';



class LeadSubCategoryScreen extends StatefulWidget {
  const LeadSubCategoryScreen({
    super.key});

  @override
  State<LeadSubCategoryScreen> createState() => _LeadSubCategoryScreenState();
}

class _LeadSubCategoryScreenState extends State<LeadSubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> LeadSubCategoryListBlocs(),
      child: LeadSubCategoryScreenWidget(),
    );
  }
}


class LeadSubCategoryScreenWidget extends StatefulWidget {

  const LeadSubCategoryScreenWidget({
    super.key});

  @override
  State<LeadSubCategoryScreenWidget> createState() => _LeadSubCategoryScreenWidgetState();
}

class _LeadSubCategoryScreenWidgetState extends State<LeadSubCategoryScreenWidget> {


  @override
  void initState() {
    BlocProvider.of<LeadSubCategoryListBlocs>(context).add(
        FetchLeadSubCategoryListEvents()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Sub Category Master",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            context: context,
            builder:(context){
              return Wrap(
                children: [
                  CreateEditLeadSubCategoryBottomSheet(
                      isEdit: false,
                      subLeadCategoryName: '',
                      subLeadCategoryId: '',
                      leadCategoryName: '',
                      leadCategoryId: '',
                      status: ''
                  )
                ],
              );
            },
          ).then(
                  (value){
                if(value == true){
                  BlocProvider.of<LeadSubCategoryListBlocs>(context).add(
                      FetchLeadSubCategoryListEvents()
                  );
                }
              }
          );
        },
      ),
      body:  BlocBuilder<LeadSubCategoryListBlocs, LeadSubCategoryListStates>(
        builder: (context, state) {
          if (state is InitialLeadSubCategoryListStates) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingLeadSubCategoryListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedLeadSubCategoryListStates){
            return   ListView.builder(
              itemCount: state.list.length  ,
              padding:  EdgeInsets.all(15),
              itemBuilder: (context, index) {

                String statusLabel = state.list[index].status == "1"
                    ? "Active"
                    : "Inactive";

                Color statusColor = (state.list[index].status) == "1"
                    ? Colors.green
                    : Colors.red;

                return GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Wrap(
                            children: [
                              CreateEditLeadSubCategoryBottomSheet(
                                  isEdit: true,
                                  subLeadCategoryName: state.list[index].leadSubCategoryName,
                                  subLeadCategoryId: state.list[index].leadSubCategoryId.toString(),
                                  leadCategoryName: state.list[index].leadCategoryName,
                                  leadCategoryId: state.list[index].leadCategoryId.toString(),
                                  status: state.list[index].status
                              )
                            ],
                          ),
                        );
                      },
                    ).then(
                            (value){
                          if(value == true){
                            BlocProvider.of<LeadSubCategoryListBlocs>(context).add(
                                FetchLeadSubCategoryListEvents()
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
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:  EdgeInsets.all(10),
                                child:  Icon(
                                    state.list[index].status == "1"
                                        ? Icons.check_circle_outline
                                        : Icons.pause_circle_outline,
                                    color: statusColor
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.list[index].leadSubCategoryName,
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
                                          color: statusColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6,),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.blue.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.file_copy,
                                        size: 16,
                                        color: AppColors.primary,
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          "Category: ${state.list[index].leadCategoryName}",
                                          style:  TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          PopupMenuButton<int>(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onSelected: (value) async {
                              if (value == 1)  {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                      ),
                                      child: Wrap(
                                        children: [
                                          CreateEditLeadSubCategoryBottomSheet(
                                              isEdit: true,
                                              subLeadCategoryName: state.list[index].leadSubCategoryName,
                                              subLeadCategoryId: state.list[index].leadSubCategoryId.toString(),
                                              leadCategoryName: state.list[index].leadCategoryName,
                                              leadCategoryId: state.list[index].leadCategoryId.toString(),
                                              status: state.list[index].status.toString()
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true){
                                        BlocProvider.of<LeadSubCategoryListBlocs>(context).add(
                                            FetchLeadSubCategoryListEvents()
                                        );
                                      }
                                    }
                                );
                              }
                              else if (value == 2) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                      ),
                                      child: Wrap(
                                        children: [
                                          DeleteLeadSubCategoryBottomSheet(
                                              leadSubCategoryId:
                                              state.list[index].leadSubCategoryId.toString()
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true){
                                        BlocProvider.of<LeadSubCategoryListBlocs>(context).add(
                                            FetchLeadSubCategoryListEvents()
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
                    ),
                  ),
                );
              },
            );
          }
          else if(state is FailureLeadSubCategoryListStates){
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