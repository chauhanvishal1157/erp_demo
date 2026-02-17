import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/screen/visit_area_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../common/app_color.dart';
import '../../../../common/common_decoration.dart';
import '../../../lead_screen/visit_area/visit_area_customer/bloc/visit_area_customer_list_bloc.dart';
import '../../../lead_screen/visit_area/visit_area_customer/bloc/visit_area_customer_list_event.dart';
import '../../../lead_screen/visit_area/visit_area_customer/bloc/visit_area_customer_list_state.dart';

class CustomerMasterScreen extends StatefulWidget {
  final String branchId;
  const CustomerMasterScreen({super.key,required this.branchId});

  @override
  State<CustomerMasterScreen> createState() => _CustomerMasterScreenState();
}

class _CustomerMasterScreenState extends State<CustomerMasterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitAreaCustomerListBloc(),
      child: CustomerMaster(
          branchId: widget.branchId,
      ),
    );
  }
}


class CustomerMaster extends StatefulWidget {
  final String branchId;


  const CustomerMaster({super.key, required this.branchId,});

  @override
  State<CustomerMaster> createState() => _CustomerMasterState();
}

class _CustomerMasterState extends State<CustomerMaster> {


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

  String branchId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Customer",
        showAdd: true,
        onAddTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VisitAreaCustomerScreen(
                branchId: widget.branchId,
              ),
            ),
          );
        },
        showFirstAction: true,
        firstActionColor: AppColors.primary,
        firstActionIcon: Icons.search,
      ),
      body:  BlocBuilder<VisitAreaCustomerListBloc, VisitAreaCustomerListStates>(
        builder: (context, state) {
          if (state is InitialVisitAreaCustomerListStates) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingVisitAreaCustomerListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
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
            return  Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.list.length,
                          itemBuilder: (context,index){
                            return  Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.all(15),
                              decoration: CommonDecorations.card(),
                              child:  Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue.shade400,
                                              Colors.blue.shade600,
                                            ],
                                          ),
                                        ),
                                        child: Text(
                                          state.list[index].customerName[0].toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.list[index].customerName,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              state.list[index].email,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuButton<int>(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        onSelected: (value) {
                                          if (value == 1) {
                                            setState(() {

                                            });
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
                                                  "Remove",
                                                  style: TextStyle(
                                                      color: Colors.red
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        child:  Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(4),
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
                                      margin: EdgeInsets.only(top: 15),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: AppColors.primary,
                                            size: 18,
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            state.list[index].mobileNo,
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                    ]
                ),
              ),
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

