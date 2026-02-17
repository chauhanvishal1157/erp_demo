import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/order_status_bloc/order_status_list_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/order_status_bloc/order_status_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/order_status_bloc/order_status_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/screens/create_edit_order_status_screen.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/screens/delete_order_status_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/app_color.dart';
import '../../../../common/common_decoration.dart';


class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OrderStatusListBlocs(),
        child: OrderStatus(),
    );
  }
}


class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {



  @override
  void initState() {
    BlocProvider.of<OrderStatusListBlocs>(context).add(
      FetchOrderStatusListEvents(
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar:CommonAppBar(
        title: "Order Status",
        showAdd: true,
        onAddTap: (){
          Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>CreateEditOrderStatusScreen(
              isEdit: false,
              orderStatusId: '',
              orderStatusName: '',
              status: '',
              textColor: '',
              textBgColor: '',
              moduleStatus: '',
            ),
          )).then(
                (value) {
              if(value == true) {
                BlocProvider.of<OrderStatusListBlocs>(context).add(
                  FetchOrderStatusListEvents(),
                );
              }
            },
          );
        }
      ),
      body:BlocBuilder<OrderStatusListBlocs, OrderStatusListStates>(
        builder: (context, state) {
          if (state is InitialOrderStatusListStates) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingOrderStatusListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedOrderStatusListStates){
            return  ListView.builder(
              padding:  EdgeInsets.all(15),
              itemCount: state.list.length,
              itemBuilder: (context, index) {

                String moduleLabel = "";
                if (state.list[index].moduleStatus == "0") {
                  moduleLabel = "Order";
                } else if (state.list[index].moduleStatus == "1") {
                  moduleLabel = "Production";
                } else if (state.list[index].moduleStatus == "2") {
                  moduleLabel = "Dispatch";
                }

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
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>CreateEditOrderStatusScreen(
                            isEdit: true,
                            orderStatusId: state.list[index].orderStatusId.toString(),
                            orderStatusName: state.list[index].orderStatusName,
                            status: state.list[index].status,
                            textColor: state.list[index].textColor,
                            textBgColor: state.list[index].textBgColor,
                            moduleStatus: state.list[index].moduleStatus,
                          ),
                        )
                    ).then(
                          (value) {
                        if(value == true) {
                          BlocProvider.of<OrderStatusListBlocs>(context).add(
                            FetchOrderStatusListEvents(),
                          );
                        }
                      },
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
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:  EdgeInsets.all(10),
                                child:  Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding:  EdgeInsets.all(5),
                                child:  Icon(
                                  Icons.drag_indicator,
                                  size: 16,
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
                                  state.list[index].orderStatusName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
                                        Icons.grid_view_rounded,
                                        size: 18,
                                        color: AppColors.primary,
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          "Module: $moduleLabel",
                                          style:  TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
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
                                        borderRadius: BorderRadius.circular(4),
                                        color: parseColor(state.list[index].textBgColor,),
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
                                      builder: (context)=>CreateEditOrderStatusScreen(
                                        isEdit: true,
                                        orderStatusId: state.list[index].orderStatusId.toString(),
                                        orderStatusName: state.list[index].orderStatusName,
                                        status: state.list[index].status,
                                        textColor: state.list[index].textColor,
                                        textBgColor: state.list[index].textBgColor,
                                        moduleStatus: state.list[index].moduleStatus,
                                      ),
                                    )
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<OrderStatusListBlocs>(context).add(
                                        FetchOrderStatusListEvents(),
                                      );
                                    }
                                  },
                                );
                              }
                              else if (value == 2) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return Wrap(
                                      children: [
                                        DeleteOrderStatusBottomSheet(
                                          orderStatusId: state.list[index].orderStatusId.toString(),
                                        ),
                                      ],
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<OrderStatusListBlocs>(context).add(
                                        FetchOrderStatusListEvents(),
                                      );
                                    }
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
                  ),
                );
              },
            );
          }
          else if(state is FailureOrderStatusListStates){
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
