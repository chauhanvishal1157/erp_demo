import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/bloc/visit_area_customer_list_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/bloc/visit_area_customer_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/bloc/visit_area_customer_list_state.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisitAreaCustomerScreen extends StatefulWidget {
  final String branchId;
  final String branchName;

  const VisitAreaCustomerScreen({
    required this.branchId,
    this.branchName = "",
    super.key,
  });

  @override
  State<VisitAreaCustomerScreen> createState() => _VisitAreaCustomerScreenState();
}

class _VisitAreaCustomerScreenState extends State<VisitAreaCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitAreaCustomerListBloc(),
      child: VisitAreaCustomer(
        branchId: widget.branchId,
        branchName: widget.branchName,
      ),
    );
  }
}

class VisitAreaCustomer extends StatefulWidget {
  final String branchId;
  final String branchName;

  const VisitAreaCustomer({
    required this.branchId,
    this.branchName = "",
    super.key,
  });

  @override
  State<VisitAreaCustomer> createState() => _VisitAreaCustomerState();
}

class _VisitAreaCustomerState extends State<VisitAreaCustomer> {

  List<String>customerName = [];

  String branchId = "";

  @override
  void initState() {
    BlocProvider.of<VisitAreaCustomerListBloc>(context).add(
        FetchVisitAreaCustomerListEvents(
          branchId: widget.branchId,
          visitAreaId: '',
        ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.screenBg,
        appBar: CommonAppBar(
            title: "Select Customer",
          showAdd: true,
          addIcon: Icons.search,
          addIconColor: AppColors.primary,
        ),
        body: BlocConsumer<VisitAreaCustomerListBloc, VisitAreaCustomerListStates>(
          listener: (context, state) {
            if(state is LoadedCreateMasterBranchState) {
              Navigator.pop(context,[true,widget.branchName]);
            }
          },
          builder: (context, state) {
            if (state is InitialVisitAreaCustomerListStates) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            else if(state is LoadingVisitAreaCustomerListStates){
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            else if(state is LoadedVisitAreaCustomerListStates){
              if (state.list.isEmpty){
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
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            padding: EdgeInsets.only(bottom: 80),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.list.length,
                            itemBuilder: (context, index) {
                              bool isSelected = customerName.contains(state.list[index].customerName);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (customerName.contains(state.list[index].customerName)) {
                                      customerName.remove(state.list[index].customerName);
                                    } else {
                                      customerName.add(state.list[index].customerName);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(left: 15,right: 15,top: 10),
                                  decoration: BoxDecoration(
                                    color:  isSelected
                                        ? Colors.blue[50]
                                        : Colors.white,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.white,
                                      width: 1.2
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                               state.list[index].customerName,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 3,),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Colors.blue[100]
                                                      : Colors.blue[50],
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  state.list[index].branchName,
                                                  style: TextStyle(
                                                    color:Colors.blue,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Transform.scale(
                                            scale: 1.2,
                                            child: Checkbox(
                                              shape: CircleBorder(),
                                              side: BorderSide(color: Colors.grey),
                                              activeColor:  AppColors.primary,
                                              value: isSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (customerName.contains(state.list[index].customerName)) {
                                                    customerName.remove(state.list[index].customerName);
                                                  } else {
                                                    customerName.add(state.list[index].customerName);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? Colors.blue[100]
                                                  : Colors.blue[50],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.mail_outline,
                                              color:  AppColors.primary,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Email",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                state.list[index].email,
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color:  isSelected
                                                  ? Colors.blue[100]
                                                  : Colors.blue[50],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.phone_outlined,
                                              color: AppColors.primary,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Mobile",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                state.list[index].mobileNo,
                                                style: TextStyle(
                                                  color:  AppColors.primary,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child:Container(
                      decoration: BoxDecoration(
                        color: AppColors.screenBg
                      ),
                      child: CommonActionButton(
                          title: "Save Selection",
                          horizontalMargin: 15,
                          icon: Icons.save,
                          onTap: (){
                            Navigator.pop(context,customerName);
                          },
                      ),
                    ),
                  )
                ],
              );
            }
            else if(state is FailureVisitAreaCustomerListStates){
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
