import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_date_range_filter.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:erp_demo/order_module/payment_screen/payment_add_order.dart';
import 'package:erp_demo/order_module/payment_screen/payment_history_screen.dart';
import 'package:flutter/material.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}


class _PaymentListState extends State<PaymentList> {
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

  final List<Map<String, dynamic>> customers = const [
    {
      "name": "Branch ID",
      "phone": "3124659780",
      "total": 1050.0,
      "collected": 0.0,
      "outstanding": 1050.00,
    },
    {
      "name": "Dhoni",
      "phone": "9999988441",
      "total": 450.00,
      "collected": 450.00,
      "outstanding": 0.00,
    },
    {
      "name": "Harsh",
      "phone": "9054457039",
      "total": 1211962.00,
      "collected": 515456.00,
      "outstanding": 696506.00,
    },
    {
      "name": "Jatin",
      "phone": "4613795484",
      "total": 460.00,
      "collected": 0.00,
      "outstanding": 460.00,
    },
    {
      "name": "Manthan",
      "phone": "1643495444",
      "total": 920.00,
      "collected": 0.00,
      "outstanding": 920.00,
    },
    {
      "name": "Milan",
      "phone": "8200355332",
      "total": 11200.00,
      "collected": 0.00,
      "outstanding": 11200.00,
    },
    {
      "name": "Parth Patel",
      "phone": "8140212111",
      "total": 12378.00,
      "collected": 0.00,
      "outstanding": 4500.00,
    },
    {
      "name": "Shivangi Patel",
      "phone": "9874563210",
      "total": 4500.00,
      "collected": 0.00,
      "outstanding": 4500.00,
    },
    {
      "name": "testing demo",
      "phone": "1111122222",
      "total": 1496.00,
      "collected": 0.00,
      "outstanding": 1496.00,
    },


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CustomAppBar(
          leadingIcon: Icons.payment_outlined,
          title:  "Payment History",
          subtitle: "Customer Payment History",
        showAdd: true,
        actionIcon1Color: AppColors.primary,
        addIcon: Icons.add,
        onAddTap: ()  {
          Navigator.push(
            context, MaterialPageRoute(
            builder: (context)=>PaymentAddOrder(),
          ),
          );
        },
        showAction1: true,
        actionIcon1: Icons.search,
      ),
      body: SingleChildScrollView(
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
                     itemCount: customers.length,
                     itemBuilder: (context, index){
                       var customer = customers[index];
                       return  GestureDetector(
                         onTap: (){
                           Navigator.push(
                               context,MaterialPageRoute(
                               builder: (context)=>PaymentHistory(),
                           ),
                           );
                         },
                         child: Container(
                           margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                           padding: EdgeInsets.only(bottom:10 ),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(12),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.shade200,
                                 blurRadius: 4,
                                 offset: Offset(0, 2),
                                 spreadRadius: 3,
                               ),
                             ],
                           ),
                           child: Column(
                             children: [
                               Container(
                                 padding: EdgeInsets.all(10),
                                 margin: EdgeInsets.only(bottom: 10),
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
                                       padding: EdgeInsets.fromLTRB(8,3,8,3),
                                       margin: EdgeInsets.only(right: 10),
                                       decoration: BoxDecoration(
                                         color: AppColors.primary,
                                         borderRadius: BorderRadius.circular(10),
                                       ),
                                       child: Text(
                                         customer["name"][0].toUpperCase(),
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 20,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                     ),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           customer["name"],
                                           style: TextStyle(
                                             color:AppColors.primary,
                                             fontSize: 16,
                                             fontWeight: FontWeight.w600,
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
                                               customer["phone"],
                                               style: TextStyle(
                                                 color: AppColors.primary,
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 12,
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
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                   Text(
                                     "Total Amount",
                                     style: TextStyle(
                                       color: Colors.black38,
                                       fontSize: 12,
                                       fontWeight: FontWeight.w600
                                     ),
                                   ),
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
                                         fontWeight: FontWeight.w600,
                                         fontSize: 12,
                                       ),
                                     ),
                                   ),
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
                                         fontWeight: FontWeight.w600,
                                         fontSize: 13,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 5,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                   Row(
                                     children: [
                                       Icon(
                                         Icons.currency_rupee,
                                         size: 14,
                                       ),
                                       Text(
                                        customer["total"].toString(),
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Icon(
                                         Icons.currency_rupee,
                                         size: 14,
                                         color: Colors.green,
                                       ),
                                       Text(
                                         customer["collected"].toString(),
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           color: Colors.green,
                                         ),
                                       ),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Icon(
                                         Icons.currency_rupee,
                                         size: 14,
                                         color: Colors.red,
                                       ),
                                       Text(
                                         customer["outstanding"].toString(),
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
                       );
                   },
                 ),
          ],
        ),
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

