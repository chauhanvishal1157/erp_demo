import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../master_module/admin_screen/branch/bloc/master_branch_bloc/master_branch_list_bloc.dart';
import '../../../../master_module/admin_screen/branch/bloc/master_branch_bloc/master_branch_list_event.dart';
import '../../../../master_module/admin_screen/branch/bloc/master_branch_bloc/master_branch_list_state.dart';

class AddBranchScreen extends StatefulWidget {
  const AddBranchScreen({super.key});

  @override
  State<AddBranchScreen> createState() => _AddBranchScreenState();
}

class _AddBranchScreenState extends State<AddBranchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> BranchListBlocs(),
      child: AddBranchScreenWidget(),
    );
  }
}


class AddBranchScreenWidget extends StatefulWidget {
  const AddBranchScreenWidget({super.key});

  @override
  State<AddBranchScreenWidget> createState() => _AddBranchScreenWidgetState();
}

class _AddBranchScreenWidgetState extends State<AddBranchScreenWidget> {


  List<String> selectedBranchIds = [];
  List<String> selectedBranchNames = [];

  @override
  void initState() {
    BlocProvider.of<BranchListBlocs>(context).add(
        FetchBranchListEvents(
          searchValue: "",
          multipleBranchId: "",
        )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Select Branch",
        showAdd: true,
        onAddTap: (){
        },
      ),
      body: BlocBuilder<BranchListBlocs,BranchListStates>(
        builder: (context, state) {
          if(state is InitialBranchListState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingBranchListState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedBranchListState) {
            return  Column(
              children: [
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
                        hintText: "Enter Branch  Name..",
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
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.list.length,
                    itemBuilder: (context,index){
                      final id = state.list[index].branchId.toString();
                      final name = state.list[index].branchName;

                      bool isSelected = selectedBranchIds.contains(id);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedBranchIds.contains(id)) {
                              selectedBranchIds.remove(id);
                              selectedBranchNames.remove(name);
                            } else {
                              selectedBranchIds.add(id);
                              selectedBranchNames.add(name);
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue[50]
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.blue.shade200
                                    : Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                        shape: CircleBorder(),
                                        side: BorderSide(
                                          color: Colors.grey,
                                        ),
                                        activeColor: AppColors.primary,
                                        value: isSelected,
                                        onChanged: (bool? value){
                                          setState(() {
                                            if (selectedBranchIds.contains(id)) {
                                              selectedBranchIds.remove(id);
                                              selectedBranchNames.remove(name);
                                            } else {
                                              selectedBranchIds.add(id);
                                              selectedBranchNames.add(name);
                                            }
                                          });
                                        }
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.list[index].branchName,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "Selected",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
                CommonActionButton(
                    title: "Save Selection",
                    horizontalMargin: 15,
                    icon: Icons.save,
                    onTap: (){
                      Navigator.of(context).pop([selectedBranchIds,selectedBranchNames,]);
                    },
                )
              ],
            );
          }
          else if(state is FailureBranchListState) {
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
