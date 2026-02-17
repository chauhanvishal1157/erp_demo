import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';

class TotalEarning extends StatefulWidget {
  const TotalEarning({super.key});

  @override
  State<TotalEarning> createState() => _TotalEarningState();
}

class _TotalEarningState extends State<TotalEarning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Total Earning",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.5),
                    AppColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade200,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.arrow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Earning",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Monthly Salary Overview",
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.arrow,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.white60
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Net Payable Amount",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.currency_rupee_sharp,
                              size: 25,
                              color: Colors.white,
                            ),
                            Text(
                              "0.00",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
              child: Text(
                "Salary Breakdown",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            InfoCard(
              icon: Icons.calendar_today,
              title: 'Base Monthly Salary',
              amount: "0.00",
              color: AppColors.primary,
              subtitle: "According to month attendance",
            ),
            InfoCard(
              icon: Icons.add_circle_outline,
              title: 'Extra Payment',
              amount: "0.00",
              color: Colors.green,
              subtitle: "Overtime,Allowance,Bonus, etc.",
            ),
            InfoCard(
              icon: Icons.remove_circle_outline,
              title: 'Deduction',
              amount: "0.00",
              color: Colors.orange,
              amountText: "(-)",
              subtitle: "Fine,Deduction,Advance Salary,etc.",
            ),
            InfoCard(
              icon: Icons.payment,
              title: 'Salary Already Paid',
              amount: "0.00",
              color: Colors.red,
              amountText: "(-)",
              subtitle: "Previously paid amount",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.black12,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                  ),
                ],
              ),
            ),
            Container(
              padding:  EdgeInsets.all(20),
              margin:  EdgeInsets.only(left: 15, right: 15, top: 20,bottom: 50),
             decoration: CommonDecorations.card(),
              child: Row(
                children: [
                  Container(
                    padding:  EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.account_balance_wallet,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Final Payable Amount",
                          style:  TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Net Amount to be paid",
                          style:  TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200 ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                            Icons.currency_rupee_sharp,
                            size: 20,
                            color: Colors.blue
                        ),
                        Text(
                          "0.00",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final Color color;
  final String subtitle;
  final String? amountText;


  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.color,
    required this.subtitle,
    this.amountText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(20),
      margin:  EdgeInsets.only(left: 15, right: 15, top: 15),
      decoration: CommonDecorations.card(),
      child: Row(
        children: [
          Container(
            padding:  EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:  TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                  Text(
                    subtitle,
                    style:  TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.2), ),
            ),
            child: Row(
              children: [
                if (amountText != null)
                  Text(
                    amountText!,
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                Icon(
                  Icons.currency_rupee_sharp,
                  size: 18,
                  color: color,
                ),
                Text(
                  amount,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}