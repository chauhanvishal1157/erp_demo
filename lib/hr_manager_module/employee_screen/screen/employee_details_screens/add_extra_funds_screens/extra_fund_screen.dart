import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/add_extra_funds_screens/add_extra_fund_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';

class ExtraFund extends StatefulWidget {
  const ExtraFund({super.key});

  @override
  State<ExtraFund> createState() => _ExtraFundState();
}

class _ExtraFundState extends State<ExtraFund> {

  List<Map<String, dynamic>> extraFunds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          ),
        ),
        backgroundColor: AppColors.primary,
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context,);

              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.arrow,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Extra Funds",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "#ts5 Vishal",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
           onTap: () async {
           final result = await  showModalBottomSheet(
               context: context,
               isScrollControlled: true,
               builder: (context) {
                 return AddExtraFund();
               },
             );
           if (result != null && result is Map<String, dynamic>) {
             setState(() {
               extraFunds.add(result);
             });
           }
           },
            child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.add,
                  size: 20,
                )
            ),
          ),
        ],
      ),
      body:  extraFunds.isEmpty
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 100),
            child: Image.asset("asset/employee/data.png"),
          ),
          Text(
            "Data Not Found!",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      )
          : ListView.builder(
        itemCount: extraFunds.length,
        padding: EdgeInsets.all(15),
        itemBuilder: (context, index) {
          final extraFund = extraFunds[index];
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.all(15),
               decoration: CommonDecorations.card(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         padding: EdgeInsets.all(6),
                         decoration: BoxDecoration(
                           color: Colors.green.shade50,
                           borderRadius: BorderRadius.circular(8),
                         ),
                         child: Icon(
                           Icons.account_balance_wallet_outlined,
                           color: Colors.green,
                         ),
                       ),
                       SizedBox(width: 10),
                       Expanded(
                         child: Text(
                           "Current Balance",
                           style: TextStyle(
                             color: Colors.green,
                             fontWeight: FontWeight.w600,
                             fontSize: 14,
                           ),
                         ),
                       ),
                       Row(
                         children: [
                           Text(
                             "₹",
                             style: TextStyle(
                               color: Colors.green,
                               fontWeight: FontWeight.w600,
                               fontSize: 20,
                             ),
                           ),
                           Text(
                             (double.tryParse(
                                 extraFund["amount"].toString()) ?? 0)
                                 .toStringAsFixed(2),
                             style: TextStyle(
                               color: Colors.green,
                               fontWeight: FontWeight.w700,
                               fontSize: 20,
                             ),
                           ),

                         ],
                       )
                     ],
                   ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Available Funds",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: Colors.green,
                                size: 12,
                              ),
                              SizedBox(width: 2,),
                              Text(
                                "Balance",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                decoration: CommonDecorations.card(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Company Payment History",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addExtraFund(
                            "sr no."
                          ),
                          addExtraFund(
                              "Date"
                          ),
                          addExtraFund(
                              "Amount"
                          ),
                          addExtraFund(
                              "Remark"
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        color: Colors.black45,
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 5,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addExtraFund(
                              "1"
                          ),
                          addExtraFund(
                              extraFund["paymentDate"]
                          ),
                          addExtraFund(
                            (double.tryParse(
                                extraFund["amount"].toString()) ?? 0)
                                .toStringAsFixed(2),
                          ),
                          addExtraFund(
                              extraFund["remark"]
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        color: Colors.black45,
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Row(

                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "₹",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            (double.tryParse(
                                extraFund["amount"].toString()) ?? 0)
                                .toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget addExtraFund(
      String label
      ){
    return  Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
