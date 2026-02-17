import 'package:erp_demo/dispatch_module/dispatch_screen/bloc/dispatch_list_bloc.dart';
import 'package:erp_demo/dispatch_module/dispatch_screen/bloc/dispatch_list_event.dart';
import 'package:erp_demo/dispatch_module/dispatch_screen/bloc/dispatch_list_state.dart';
import 'package:erp_demo/dispatch_module/dispatch_screen/screen/dispatch_history_bottom_sheet.dart';
import 'package:erp_demo/dispatch_module/dispatch_screen/screen/dispatch_update_status_bottom_sheet.dart';
import 'package:erp_demo/dispatch_module/dispatch_screen/screen/filter_dispatch_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../common/app_color.dart';
import '../../../common/common_decoration.dart';
import '../../../common/common_pop_menu_button.dart';
import '../../../common/custom_app_bar.dart';

class DispatchScreen extends StatefulWidget {
  const DispatchScreen({super.key});

  @override
  State<DispatchScreen> createState() => _DispatchScreenState();
}

class _DispatchScreenState extends State<DispatchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => DispatchListBloc(),
      child: DispatchScreenWidget(),
    );
  }
}


class DispatchScreenWidget extends StatefulWidget {
  const DispatchScreenWidget({super.key});

  @override
  State<DispatchScreenWidget> createState() => _DispatchScreenWidgetState();
}

class _DispatchScreenWidgetState extends State<DispatchScreenWidget> {

  @override
  void initState() {
    BlocProvider.of<DispatchListBloc>(context).add(
        FetchDispatchListEvent()
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CustomAppBar(
        leadingIcon: Icons.local_shipping,
        title: "Dispatch",
        subtitle: "Dispatch Management",
        showAdd: true,
        addIcon: Icons.search,
        addIconColor: Colors.blue,
      ),
      body: BlocBuilder<DispatchListBloc, DispatchListState>(
        builder: (context, state) {
          if (state is InitialDispatchListState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadingDispatchListState){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadedDispatchListState){
            return Stack(
              children: [
                ListView.builder(
                    padding: EdgeInsets.only(top: 120),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.list.length,
                    itemBuilder: (context,index){

                      Color hexToColor(String hexColor) {
                        hexColor = hexColor.replaceAll("#", "");
                        if (hexColor.length == 6) {
                          hexColor = "FF$hexColor";
                        }
                        return Color(int.parse(hexColor, radix: 16));
                      }

                      return  GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                          decoration: CommonDecorations.card(),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: hexToColor(state.list[index].statusBgColor),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "# ${state.list[index].orderNo}",
                                      style: TextStyle(
                                        color: hexToColor(state.list[index].statusTextColor),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          state.list[index].statusName,
                                          style: TextStyle(
                                            color: hexToColor(state.list[index].statusTextColor),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 15,),
                                        CommonPopMenuButton(
                                            textValue1: "Edit Status",
                                            icon1: Icons.edit_outlined,
                                            textValue2: "History",
                                            icon2: Icons.history,
                                            textValue3: "With Tax Invoice",
                                            icon3: Icons.receipt_outlined,
                                            textValue4: "WithOut Tax Invoice",
                                            icon4: Icons.receipt_long_outlined,
                                            child:  Icon(
                                              Icons.more_vert,
                                              size: 20,
                                              color: hexToColor(state.list[index].statusTextColor),
                                            ),
                                            value1: (){
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context){
                                                    return DispatchUpdateStatusBottomSheet(
                                                        orderNo: state.list[index].orderNo,
                                                        currentStatusId: state.list[index].status,
                                                        currentStatus: state.list[index].statusName,
                                                    );
                                                  }
                                              );
                                            },
                                            value2: (){
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context){
                                                    return DispatchHistoryBottomSheet(
                                                        statusName: state.list[index].statusName,
                                                        orderNo: state.list[index].orderNo,
                                                        orderName: state.list[index].customerName,
                                                        createAt: state.list[index].createdAt,
                                                        statusBgColor: state.list[index].statusBgColor,
                                                        statusTextColor: state.list[index].statusTextColor,
                                                    );
                                                  }
                                              );

                                            },
                                            value3: (){

                                            },
                                            value4: (){

                                            }
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15,top: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ),
                                    SizedBox(width: 12,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Customer",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          state.list[index].customerName,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          state.list[index].email,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CommonInfoCard(
                                      title: "Branch",
                                      value: state.list[index].branchName,
                                      icon: Icons.location_on_outlined,
                                      iconColor: AppColors.primary,
                                      containerColor: Colors.grey.shade50,
                                      borderColor: Colors.grey.shade300,
                                      margin: EdgeInsets.only(left: 15,top: 10),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: CommonInfoCard(
                                      title: "Phone",
                                      value: state.list[index].mobileNo,
                                      icon: Icons.phone_android,
                                      iconColor: AppColors.primary,
                                      titleColor: Colors.black,
                                      valueColor: AppColors.primary,
                                      containerColor: Colors.grey.shade50,
                                      borderColor: Colors.grey.shade300,
                                      margin: EdgeInsets.only(right: 15,top: 10),
                                    ),
                                  ),


                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CommonInfoCard(
                                      title: "Billing Address",
                                      value: state.list[index].billingAddress,
                                      icon: Icons.sticky_note_2_outlined,
                                      iconColor: AppColors.primary,
                                      titleColor: AppColors.primary,
                                      containerColor: Colors.blue.shade50,
                                      borderColor: Colors.blue.shade100,
                                      margin: const EdgeInsets.only(left: 15,top: 10),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: CommonInfoCard(
                                      title: "Shipping Address",
                                      value: state.list[index].shippingAddress,
                                      icon: Icons.local_shipping_outlined,
                                      iconColor: Colors.green,
                                      titleColor: Colors.green,
                                      containerColor: Colors.green.shade50,
                                      borderColor: Colors.green.shade100,
                                      margin: const EdgeInsets.only(right: 15, top: 10),
                                    ),

                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Divider(
                                color: Colors.blueGrey.shade200,
                                thickness: 1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if(state.list[index].statusName == "Order Completed")...[
                                    CommonStatusChip(
                                      text: "Pending",
                                      icon: Icons.recycling,
                                      color: Colors.red,
                                    ),
                                  ],
                                  if(state.list[index].statusName == "Order Dispatched")...[
                                    Text("")
                                  ],
                                  CommonStatusChip(
                                      text: "${state.list[index].grandTotal}.00",
                                      icon: Icons.currency_rupee,
                                      color: Colors.blue.shade800
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColors.screenBg
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            decoration: CommonDecorations.card(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.list_alt,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "All Production Orders",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Showing all Production Order statuses",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context){
                                            return FilterDispatchBottomSheet();
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade100,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.tune,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    offset:  Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              child:  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.calendar_today_rounded,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    DateFormat('MMM dd, yyyy').format(DateTime.now()),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            );
          }
          else if(state is FailureDispatchListState){
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

class CommonInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? containerColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? titleColor;
  final Color? valueColor;
  final EdgeInsets margin;

  const CommonInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.containerColor,
    this.borderColor,
    this.iconColor,
    this.titleColor,
    this.valueColor,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: margin,
      decoration: BoxDecoration(
        color: containerColor ?? Colors.grey.shade50,
        border: Border.all(
          color: borderColor ?? Colors.grey.shade100,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: iconColor ?? Colors.black87,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: titleColor ?? Colors.black87,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
class CommonStatusChip extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const CommonStatusChip({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: 4,
            offset: const Offset(1, 1),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
