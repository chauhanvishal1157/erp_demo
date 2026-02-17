import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_bloc.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_event.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_state.dart';
import 'package:erp_demo/master_module/product_screen/unit/screens/create_edit_unit_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/unit/screens/delete_unit_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_color.dart';
import '../../../../common/common_decoration.dart';


class UnitScreen extends StatefulWidget {
  const UnitScreen({super.key});

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UnitListBlocs(),
      child: Unit(),
    );
  }
}


class Unit extends StatefulWidget {
  const Unit({super.key});

  @override
  State<Unit> createState() => _UnitState();
}

class _UnitState extends State<Unit> {

  List<Map<String, dynamic>> unitList = [];

  @override
  void initState() {
    BlocProvider.of<UnitListBlocs>(context).add(FetchUnitListEvents());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Unit Master",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            backgroundColor: Colors.transparent,
            context: context,
            builder:(context){
              return  CreateEditUnitBottomSheet(
                isEdit: false,
                unitName: '',
                unitId: '',
                status: '',
              );
            },
          ).then(
                  (value){
                if(value == true) {
                  BlocProvider.of<UnitListBlocs>(context).add(
                    FetchUnitListEvents(),
                  );
                }
              }
          );
        },
      ),
      body: BlocBuilder<UnitListBlocs, UnitListStates>(
        builder: (context, state) {
          if (state is InitialUnitListStates) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadingUnitListStates){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadedUnitListStates){
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
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder:(context){
                        return   CreateEditUnitBottomSheet(
                            isEdit: true,
                            unitName: state.list[index].unitName,
                            unitId: state.list[index].unitId.toString(),
                            status: state.list[index].status.toString()
                        );
                      },
                    ).then(
                            (value){
                          if(value == true) {
                            BlocProvider.of<UnitListBlocs>(context).add(
                              FetchUnitListEvents(),
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
                              color:statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:  EdgeInsets.all(10),
                            child:  Icon(
                                state.list[index].status == 1
                                    ? Icons.check_circle_outline   // Active icon
                                    : Icons.pause_circle_outline,
                                color: statusColor
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 state.list[index].unitName,
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
                              ],
                            ),
                          ),


                          CommonPopMenuButton(
                              value1: (){
                                showModalBottomSheet(
                                  isScrollControlled:true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder:(context){
                                    return   CreateEditUnitBottomSheet(
                                        isEdit: true,
                                        unitName: state.list[index].unitName,
                                        unitId: state.list[index].unitId.toString(),
                                        status: state.list[index].status.toString()
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true) {
                                        BlocProvider.of<UnitListBlocs>(context).add(
                                          FetchUnitListEvents(),
                                        );
                                      }
                                    }
                                );
                              },
                              value2: (){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return DeleteUnitBottomSheet(
                                      unitId: state.list[index].unitId.toString(),
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true) {
                                        BlocProvider.of<UnitListBlocs>(context).add(
                                          FetchUnitListEvents(),
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
          else if(state is FailureUnitListStates){
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
