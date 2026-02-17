import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/rejection_reason_list_bloc/rejection_reason_list_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/rejection_reason_list_bloc/rejection_reason_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/rejection_reason_list_bloc/rejection_reason_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/screens/create_edit_rejection_reason_bottom_sheet.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/screens/delete_rejection_reason_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;

import '../../../../common/common_decoration.dart';



class RejectionReasonScreen extends StatefulWidget {
  const RejectionReasonScreen({super.key});

  @override
  State<RejectionReasonScreen> createState() => _RejectionReasonScreenState();
}

class _RejectionReasonScreenState extends State<RejectionReasonScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RejectionReasonListBlocs(),
      child: RejectionReasonScreenWidget(),
    );
  }
}


class RejectionReasonScreenWidget extends StatefulWidget {
  const RejectionReasonScreenWidget({super.key});

  @override
  State<RejectionReasonScreenWidget> createState() => _RejectionReasonScreenWidgetState();
}

class _RejectionReasonScreenWidgetState extends State<RejectionReasonScreenWidget> {



  @override
  void initState() {
    BlocProvider.of<RejectionReasonListBlocs>(context).add(FetchRejectionReasonListEvents());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Rejection Reason",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            context: context,
            builder:(context){
              return CreateEditRejectionReasonBottomSheet(
                  isEdit: false,
                  reasonId: '',
                  reason: '',
                  status: ''
              );
            },
          ).then(
                  (value){
                if(value == true){
                  BlocProvider.of<RejectionReasonListBlocs>(context).add(
                      FetchRejectionReasonListEvents()
                  );
                }
              }
          );
        },
      ),
      body: BlocBuilder<RejectionReasonListBlocs, RejectionReasonListStates>(
        builder: (context, state) {
          if (state is InitialRejectionReasonListStates) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingRejectionReasonListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedRejectionReasonListStates){
            return ListView.builder(
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
                      context: context,
                      builder: (context){
                        return  CreateEditRejectionReasonBottomSheet(
                          isEdit: true,
                          reasonId: state.list[index].reasonId.toString(),
                          reason: state.list[index].reason,
                          status: state.list[index].status.toString(),
                        );
                      },
                    ).then(
                            (value){
                          if(value == true){
                            BlocProvider.of<RejectionReasonListBlocs>(context).add(
                                FetchRejectionReasonListEvents()
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
                                  state.list[index].reason,
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
                                  builder: (context){
                                    return   CreateEditRejectionReasonBottomSheet(
                                      isEdit: true,
                                      reasonId: state.list[index].reasonId.toString(),
                                      reason: state.list[index].reason,
                                      status: state.list[index].status.toString(),
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true){
                                        BlocProvider.of<RejectionReasonListBlocs>(context).add(
                                            FetchRejectionReasonListEvents()
                                        );
                                      }
                                    }
                                );
                              },
                              value2: (){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return  DeleteRejectionReasonBottomSheet(
                                      reasonId: state.list[index].reasonId.toString(),
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true){
                                        BlocProvider.of<RejectionReasonListBlocs>(context).add(
                                            FetchRejectionReasonListEvents()
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
          else if(state is FailureRejectionReasonListStates){
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

