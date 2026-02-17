import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/admin_screen/lead_status/bloc/lead_status_list_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/lead_status/bloc/lead_status_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/lead_status/bloc/lead_status_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/lead_status/screens/create_lead_status_screen.dart';
import 'package:erp_demo/master_module/admin_screen/lead_status/screens/edit_lead_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/app_color.dart';
import '../../../../common/common_decoration.dart';


class LeadStatusScreen extends StatefulWidget {
  const LeadStatusScreen({super.key});

  @override
  State<LeadStatusScreen> createState() => _LeadStatusScreenState();
}

class _LeadStatusScreenState extends State<LeadStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:  (context) => LeadStatusListBlocs(),
      child: LeadStatus(),
    );
  }
}


class LeadStatus extends StatefulWidget {
  const LeadStatus({super.key});

  @override
  State<LeadStatus> createState() => _LeadStatusState();
}

class _LeadStatusState extends State<LeadStatus> {



  @override
  void initState() {
    BlocProvider.of<LeadStatusListBlocs>(context).add(
      FetchLeadStatusListEvents(
      ),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
        title: "Lead Status",
        showAdd: true,
        onAddTap: (){
          Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>CreateLeadStatus(),
          ));
        },
      ),
      body: BlocBuilder<LeadStatusListBlocs, LeadStatusListStates>(
        builder: (context, state) {
          if (state is InitialLeadStatusListStates) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingLeadStatusListStates){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedLeadStatusListStates){
            return  ListView.builder(
              padding:  EdgeInsets.all(15),
              itemCount: state.list.length,
              itemBuilder: (context, index) {

                String statusLabel = state.list[index].status == "1"
                    ? "Active"
                    : "Inactive";

                Color statusColor = (state.list[index].status) == "Active"
                    ? Colors.orange
                    : Colors.green;

                Color parseColor(String colorString) {
                  colorString = colorString.replaceAll('#', '');
                  if (colorString.length == 6) {
                    colorString = 'FF$colorString';
                  }
                  return Color(int.parse(colorString, radix: 16));
                }

                return Container(
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
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding:  EdgeInsets.all(10),
                              child:  Icon(
                                Icons.trending_up,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding:  EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child:  Icon(
                                Icons.drag_indicator,
                                size: 20,
                                color: Colors.grey,
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
                               state.list[index].name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  border: Border.all(
                                    color: statusColor,
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
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "BG:",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: parseColor(state.list[index].textBgColor,),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Text(
                                    "Text:",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: parseColor(state.list[index].textColor,),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                ],
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
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context)=>EditLeadStatus(),
                                  )
                              );
                            } else if (value == 2) {
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
                                    "Edit",
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
                              borderRadius: BorderRadius.circular(8),
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
                );
              },
            );
          }
          else if(state is FailureLeadStatusListStates){
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
