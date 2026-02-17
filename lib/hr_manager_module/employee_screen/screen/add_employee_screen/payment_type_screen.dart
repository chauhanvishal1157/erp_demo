
import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/add_employee_screen/monthly_payment_screen.dart';
import 'package:flutter/material.dart';

import '../../../../common/common_app_bar.dart';
import '../../../../common/app_color.dart';
import 'daily_payment_screen.dart';

class PaymentType extends StatefulWidget {
  const PaymentType({super.key});

  @override
  State<PaymentType> createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {

  String? selectedPayment;
  final List<Map<String, dynamic>> payment = [
    {
      "title" : "Monthly",
      "subtitle" : "Per Month Salary"
    },
    {
      "title" : "Daily",
      "subtitle" : "Daily Payment"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar:CommonAppBar(
          title: "Add Employee"
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 10,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  Text(
                    "Employee Detail",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:  AppColors.primary,
                    ),
                  ),
                  Text(
                    "Payment Type",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    "Salary Payment",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: LinearProgressIndicator(
                value: 0.50,
                color: AppColors.primary,
                backgroundColor: Colors.grey[300],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
               gradient: LinearGradient(
                   colors: [
                     AppColors.primary,
                     AppColors.primary.withValues(alpha: 0.5)
                   ]
               ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Payment Type",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Choose your preferred salary payment method",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: payment.length,
                itemBuilder: (context,index){
                  String title = payment[index]["title"];
                  String subtitle = payment[index]["subtitle"];
                  bool isSelected = selectedPayment == title;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedPayment = title;
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
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 4,
                            offset: Offset(1, 1),
                          ),
                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Icon(
                              Icons.payment,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                                shape: CircleBorder(),
                                side: BorderSide(color: Colors.grey),
                                activeColor: AppColors.primary,
                                value: isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedPayment = title;
                                    } else {
                                      selectedPayment = null;
                                    }
                                  });
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
            CommonActionButton(
                title: "Continue",
                horizontalMargin: 15,
                onTap: (){
                  if (selectedPayment == "Monthly") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MonthlyPayment(),
                      ),
                    );
                  } else if (selectedPayment == "Daily") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyPayment(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select a payment type first"),
                      ),
                    );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
