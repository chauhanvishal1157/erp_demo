import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:erp_demo/order_module/order_screen/screen/proforma_invoice_order_screen.dart';
import 'package:erp_demo/production_module/production_screen/bloc/production_list_bloc.dart';
import 'package:erp_demo/production_module/production_screen/bloc/production_list_event.dart';
import 'package:erp_demo/production_module/production_screen/bloc/production_list_state.dart';
import 'package:erp_demo/production_module/production_screen/screen/filter_production_bottom_sheet.dart';
import 'package:erp_demo/production_module/production_screen/screen/production_history_bottom_sheet.dart';
import 'package:erp_demo/production_module/production_screen/screen/production_update_status_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../../common/common_pop_menu_button.dart';

class ProductionScreen extends StatefulWidget {
  const ProductionScreen({super.key});

  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => ProductionListBloc(),
      child: ProductionScreenWidget(),
    );
  }
}


class ProductionScreenWidget extends StatefulWidget {
  const ProductionScreenWidget({super.key});

  @override
  State<ProductionScreenWidget> createState() => _ProductionScreenWidgetState();
}

class _ProductionScreenWidgetState extends State<ProductionScreenWidget> {




  @override
  void initState() {
    BlocProvider.of<ProductionListBloc>(context).add(
        FetchProductionListEvent()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CustomAppBar(
          leadingIcon: Icons.local_shipping,
          title: "Production",
          subtitle: "Production Management",
          showAdd: true,
          addIcon: Icons.search,
          addIconColor: Colors.blue,

      ),
      body: BlocBuilder<ProductionListBloc, ProductionListState>(
        builder: (context, state) {
          if (state is InitialProductionListState) {
            return Center(
              child:  SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingProductionListState){
            return Center(
              child:  SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedProductionListState){
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
                                  color: hexToColor(state.list[index].statusBgcolor),
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
                                            textValue2: "Proforma Invoice",
                                            icon2: Icons.receipt_long_outlined,
                                            textValue3: "History",
                                            icon3: Icons.history,
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
                                                    return ProductionUpdateStatusBottomSheet(
                                                        orderNo: state.list[index].orderNo,
                                                        currentStatus: state.list[index].statusName,
                                                        currentStatusId: state.list[index].status,
                                                    );
                                                  }
                                              );
                                            },
                                            value2: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context)=> OrderProformaInvoice(
                                                        orderAmount: state.list[index].grandTotal,
                                                      )
                                                  )
                                              );

                                            },
                                            value3: (){
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context){
                                                  return ProductionHistoryBottomSheet(
                                                      statusName: state.list[index].statusName,
                                                      orderNo: state.list[index].orderNo,
                                                      orderName: state.list[index].customerName,
                                                      createAt: state.list[index].createdAt,
                                                    statusBgColor: state.list[index].statusBgcolor,
                                                    statusTextColor: state.list[index].statusTextColor,
                                                  );
                                                },
                                              );
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
                                  CommonStatusChip(
                                    text: "In Stock",
                                    icon: Icons.check_circle_outline,
                                    color: Colors.green.shade600,
                                  ),
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
                                            return FilterProductionBottomSheet();
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
          else if(state is FailureProductionListState){
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
