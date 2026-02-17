import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/vendor_module/vendor_payment_screen/vendor_payment_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../common/app_color.dart';
import '../../common/common_date_range_filter.dart';
import '../../common/custom_app_bar.dart';
import '../vendor_screen/bloc/vendor_list_bloc/vendor_list_bloc.dart';
import '../vendor_screen/bloc/vendor_list_bloc/vendor_list_event.dart';
import '../vendor_screen/bloc/vendor_list_bloc/vendor_list_state.dart';
import 'add_vendor_payment_screen.dart';


class VendorPaymentScreen extends StatefulWidget {
  const VendorPaymentScreen({super.key});

  @override
  State<VendorPaymentScreen> createState() => _VendorPaymentScreenState();
}

class _VendorPaymentScreenState extends State<VendorPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:(context) => VendorListBloc(),
      child: VendorPaymentScreenWidget(),
    );
  }
}


class VendorPaymentScreenWidget extends StatefulWidget {
  const VendorPaymentScreenWidget({super.key});

  @override
  State<VendorPaymentScreenWidget> createState() => _VendorPaymentScreenWidgetState();
}

class _VendorPaymentScreenWidgetState extends State<VendorPaymentScreenWidget> {

  DateTime? startDate;
  DateTime? endDate;

  Future<void> selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  void initState() {
    BlocProvider.of<VendorListBloc>(context).add(
        FetchVendorListEvent()
    );
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CustomAppBar(
        leadingIcon: Icons.payment_outlined,
        title:  "Payment History",
        subtitle: "Vendor Payment History",
        showAdd: true,
        actionIcon1Color: AppColors.primary,
        addIcon: Icons.add,
        onAddTap: ()  {
          Navigator.push(
            context, MaterialPageRoute(
            builder: (context)=>AddVendorPaymentScreen(),
          ),
          );
        },
        showAction1: true,
        actionIcon1: Icons.search,
      ),
      body: BlocBuilder<VendorListBloc, VendorListState>(
        builder: (context, state) {
          if (state is InitialVendorListState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingVendorListState){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedVendorListState){
            return  SingleChildScrollView(
              child: Column(
                children: [
                  CommonDateRangeFilter(
                    startDate: startDate ?? DateTime.now(),
                    endDate: endDate ?? DateTime.now(),
                    onStartDateTap: () => selectDate(context, true),
                    onEndDateTap: () => selectDate(context, false),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: PaymentSummaryCard(
                            bgColor: Colors.green,
                            iconBgColor: Colors.green.shade300,
                            icon: Icons.trending_up,
                            title: "Collected",
                            value: "CP",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: PaymentSummaryCard(
                            bgColor: Colors.red,
                            iconBgColor: Colors.red.shade300,
                            icon: Icons.trending_down,
                            title: "Outstanding",
                            value: "OP",
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.list.length,
                    itemBuilder: (context, index){
                      return  GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,MaterialPageRoute(
                            builder: (context)=> VendorPaymentHistoryScreen(
                              totalAmount: state.list[index].totalVendorPayment,
                              collectedAmount: state.list[index].totalGivenPayment,
                              outstandingAmount: state.list[index].totalVendorPayment,
                              transactionDate: state.list[index].vendorTransactionDate,
                            ),
                          ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                          decoration: CommonDecorations.card(),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10,5,10,5),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        state.list[index].vendorName[0].toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.list[index].vendorName,
                                          style: TextStyle(
                                            color:AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.call,
                                              color: AppColors.primary,
                                              size: 14,
                                            ),
                                            SizedBox(width: 3,),
                                            Text(
                                              state.list[index].mobileNumber,
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                decoration: TextDecoration.underline,
                                                decorationColor: AppColors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColors.primary,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(6),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            "Total Amount",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 14,
                                            ),
                                            Text(
                                              state.list[index].totalVendorPayment,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(6),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade50,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            "Collected",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 14,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              state.list[index].totalGivenPayment,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(6),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade50,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            "Outstanding",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 14,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              state.list[index].totalVendorPayment,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          else if(state is FailureVendorListState){
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

class PaymentSummaryCard extends StatelessWidget {
  final Color bgColor;
  final Color iconBgColor;
  final IconData icon;
  final String title;
  final String value;

  const PaymentSummaryCard({
    super.key,
    required this.bgColor,
    required this.iconBgColor,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
