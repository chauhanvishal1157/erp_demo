import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/app_color.dart';
import '../../../../common/common_action_button.dart';
import '../../../../common/common_app_bar.dart';
import '../bloc/working_shift_list_bloc/working_shift_list_bloc.dart';
import '../bloc/working_shift_list_bloc/working_shift_list_event.dart';
import '../bloc/working_shift_list_bloc/working_shift_list_state.dart';


class SelectWorkingShiftListScreen extends StatefulWidget {
  const SelectWorkingShiftListScreen({super.key});

  @override
  State<SelectWorkingShiftListScreen> createState() => _SelectWorkingShiftListScreenState();
}

class _SelectWorkingShiftListScreenState extends State<SelectWorkingShiftListScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=> WorkingShiftListBlocs(),
      child: SelectWorkingShiftListScreenWidget(),
    );
  }
}


class SelectWorkingShiftListScreenWidget extends StatefulWidget {
  const SelectWorkingShiftListScreenWidget({super.key});

  @override
  State<SelectWorkingShiftListScreenWidget> createState() => _SelectWorkingShiftListScreenWidgetState();
}

class _SelectWorkingShiftListScreenWidgetState extends State<SelectWorkingShiftListScreenWidget> {

  List<String> selectedWorkingShiftIds = [];
  List<String> selectedWorkingShiftNames = [];



  @override
  void initState() {
    BlocProvider.of<WorkingShiftListBlocs>(context).add(FetchWorkingShiftListEvents());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
        title: "Working Shift List",
        showAdd: true,
      ),
      body: BlocBuilder<WorkingShiftListBlocs, WorkingShiftListStates>(
        builder: (context, state) {
          if (state is InitialWorkingShiftListStates) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingWorkingShiftListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedWorkingShiftListStates){
            return  ListView.builder(
                padding: EdgeInsets.only(bottom: 150),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedWorkingShiftIds.contains(
                      state.list[index].id.toString());
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        String id = state.list[index].id.toString();
                        String name = state.list[index].name;

                        if (selectedWorkingShiftIds.contains(id)) {
                          selectedWorkingShiftIds.remove(id);
                          selectedWorkingShiftNames.remove(name);
                        } else {
                          selectedWorkingShiftIds.add(id);
                          selectedWorkingShiftNames.add(name);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                      decoration: BoxDecoration(
                        color:  isSelected
                            ? Colors.blue.shade50
                            : Colors.white,
                        border: Border.all(
                            color: isSelected
                                ? AppColors.arrow
                                : Colors.white,
                            width: 1.2
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            shape: CircleBorder(),
                            side: BorderSide(color: Colors.grey),
                            activeColor: AppColors.primary,
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                String id = state.list[index].id.toString();
                                String name = state.list[index].name;

                                if (selectedWorkingShiftIds.contains(id)) {
                                  selectedWorkingShiftIds.remove(id);
                                  selectedWorkingShiftNames.remove(name);
                                } else {
                                  selectedWorkingShiftIds.add(id);
                                  selectedWorkingShiftNames.add(name);
                                }
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              state.list[index].name,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              padding: EdgeInsets.symmetric(vertical:2,horizontal: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Selected",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
          else if(state is FailureWorkingShiftListStates){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: CommonActionButton(
        title: "Save",
        horizontalMargin: 15,
        icon: Icons.save,
        onTap: (){
          Navigator.of(context).pop([selectedWorkingShiftIds,selectedWorkingShiftNames,]);
        },
      ),
    );
  }
}
