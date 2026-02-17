import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/bloc/visit_area_list_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/bloc/visit_area_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/bloc/visit_area_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/screens/area_wise_customer_screen.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/screens/create_visit_area_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;

import '../../../../common/common_decoration.dart';



class VisitAreaScreen extends StatefulWidget {
  const VisitAreaScreen({super.key});

  @override
  State<VisitAreaScreen> createState() => _VisitAreaScreenState();
}

class _VisitAreaScreenState extends State<VisitAreaScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> VisitAreaListBlocs(),
      child: VisitArea(),
    );
  }
}


class VisitArea extends StatefulWidget {
  const VisitArea({super.key});

  @override
  State<VisitArea> createState() => _VisitAreaState();
}

class _VisitAreaState extends State<VisitArea> {

  List<Map<String, dynamic>> visitAreas = [];

  @override
  void initState() {
    BlocProvider.of<VisitAreaListBlocs>(context).add(
        FetchVisitAreaListEvents(
            searchValue: "",
          branchId: "",
        ));
    super.initState();
  }

  String id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Area",
        showAdd: true,
        onAddTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return CreateVisitArea();
            },
          );
        },
        showFirstAction: true,
        firstActionIcon: Icons.error_outline,
      ),
      body:  BlocBuilder<VisitAreaListBlocs, VisitAreaListStates>(
        builder: (context, state) {
          if (state is InitialVisitAreaListStates) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingVisitAreaListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedVisitAreaListStates){
            return  ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>AreaWiseCustomerScreen(
                            branchId: state.list[index].id.toString(),
                            visitAreaId: '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                      padding: EdgeInsets.all(15),
                      decoration: CommonDecorations.card(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      color:AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                   state.list[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              PopupMenuButton<int>(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onSelected: (value) async {
                                  if (value == 1)  {

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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.blue.shade300,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.business,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  state.list[index].branchName,
                                  style: TextStyle(
                                    color:AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          else if(state is FailureVisitAreaListStates){
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
