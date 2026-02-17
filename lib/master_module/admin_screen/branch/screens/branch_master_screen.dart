import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/admin_screen/branch/bloc/master_branch_bloc/master_branch_list_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/branch/bloc/master_branch_bloc/master_branch_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/branch/bloc/master_branch_bloc/master_branch_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/branch/screens/customer_master_screen.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/screen/visit_area_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../common/app_color.dart';
import '../../../../common/common_decoration.dart';
import 'create_branch_master_bottom_sheet.dart';

class BranchMasterScreen extends StatefulWidget {
  const BranchMasterScreen({super.key});


  @override
  State<BranchMasterScreen> createState() => _BranchMasterScreenState();
}

class _BranchMasterScreenState extends State<BranchMasterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BranchListBlocs(),
      child: BranchMaster(),
    );
  }
}

class BranchMaster extends StatefulWidget {
  const BranchMaster({super.key});

  @override
  State<BranchMaster> createState() => _BranchMasterState();
}

class _BranchMasterState extends State<BranchMaster> {

  @override
  void initState() {
    BlocProvider.of<BranchListBlocs>(context).add(
      FetchBranchListEvents(
        searchValue: "",
        multipleBranchId: "",
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Branch Master",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => CreateBranchMasterBottomSheetWidget(
              isEdit: false,
              branchId: '',
              branchName: '',
            ),
          ).then(
                (value) {
              if(value[0] == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VisitAreaCustomerScreen(
                      branchId: "",
                      branchName: value[1],
                    ),
                  ),
                );
              }
            },
          );
        },
        showFirstAction: true,
        showSecondAction: true,
        firstActionColor: AppColors.primary,
        firstActionIcon: Icons.search,
        secondActionIcon: Icons.info_outline,
      ),
      body: BlocBuilder<BranchListBlocs,BranchListStates>(
        builder: (context, state) {
          if(state is InitialBranchListState) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingBranchListState) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedBranchListState) {
            if (state.list.isNotEmpty){
              return Padding(
                padding:  EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: CommonDecorations.card(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.business,
                              size: 20,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              "Master",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.list.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerMasterScreen(
                                    branchId: state.list[index].branchId.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.business,
                                      size: 20,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      state.list[index].branchName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton<int>(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onSelected: (value) {
                                      if (value == 1) {

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
                      ),
                    ),
                  ],
                ),
              );
            }
            else if (state.list.isEmpty){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Image.asset("asset/employee/data.png"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Data Not Found!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }
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
