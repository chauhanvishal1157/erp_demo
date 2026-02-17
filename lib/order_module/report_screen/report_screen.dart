import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_list_tile_screen.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:erp_demo/order_module/report_screen/monthly_transaction_report_screen.dart';
import 'package:erp_demo/order_module/report_screen/outstanding_report_screen.dart';
import 'package:erp_demo/order_module/report_screen/refund_report_screen.dart';
import 'package:flutter/material.dart';
import 'customer_payment_report_screen.dart';
import 'order_report_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CustomAppBar(
          leadingIcon:  Icons.article_outlined,
          title: "Report",
          subtitle: "Order Reports"
      ),
      body: SingleChildScrollView(
        child: Column(
         children: [
           Container(
             padding: EdgeInsets.all(10),
             margin: EdgeInsets.all(15),
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: [
                   AppColors.primary,
                   AppColors.primary.withValues(alpha: 0.5),

                 ],
               ),
               borderRadius: BorderRadius.circular(16),
             ),
             child: Row(
               children: [
                 Container(
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     color: AppColors.arrow,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: Icon(
                     Icons.bar_chart_rounded,
                     color: Colors.white,
                     size: 25,
                   ),
                 ),
                 SizedBox(width: 10,),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                   Text(
                     "Analytics Hub",
                     style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.w600,
                         fontSize: 18,
                     ),
                   ),
                     SizedBox(height: 5,),
                     Text(
                       "Get insights from your business data",
                       style: TextStyle(
                         color: Colors.grey.shade200,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
           CommonListTile(
               title:  "Order Report",
               subTitle: "Track and analyze all your orders",
               icon:  Icons.shopping_cart_outlined,
               color: Colors.purple,
               onTap: (){
                 Navigator.push(
                   context, MaterialPageRoute(
                   builder: (context)=>OrderReport(),
                 ),);
               },
           ),
           CommonListTile(
               title:  "Outstanding Report",
               subTitle:  "Monitor pending payment and dues",
               icon: Icons.note_add_outlined,
               color: Colors.red,
               onTap: (){
                 Navigator.push(
                   context, MaterialPageRoute(
                   builder: (context)=>OutstandingReport(),
                 ),);
               },
           ),
           CommonListTile(
               title: "Payment Report",
               subTitle: "View customer payment records",
               icon:  Icons.payment,
               color: Colors.green,
               onTap: (){
                 Navigator.push(
                   context, MaterialPageRoute(
                   builder: (context)=>CustomerPaymentReport(),
                 ),);
               },
           ),
           CommonListTile(
               title: "Refund Report",
               subTitle: "Manage and Track refunds",
               icon: Icons.currency_exchange_outlined,
               color:  Colors.yellow,
               onTap:  (){
                 Navigator.push(
                   context, MaterialPageRoute(
                   builder: (context)=>RefundReport(),
                 ),);
               },
           ),
           CommonListTile(
               title: "Monthly Transaction",
               subTitle:  "Analyze monthly transactions trends",
               icon: Icons.trending_up,
               color:  Colors.purple,
               onTap: (){
                 Navigator.push(
                   context, MaterialPageRoute(
                   builder: (context)=>MonthlyTransaction(),
                 ),);
               },
           ),
         ],
        ),
      ),
    );
  }
}


