import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/deduction_screen/deduction_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/month_salary_calculation/month_attendance_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/month_salary_calculation/total_earning_screen.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';

class MonthSalaryCalculation extends StatefulWidget {
  const MonthSalaryCalculation({super.key});

  @override
  State<MonthSalaryCalculation> createState() => _MonthSalaryCalculationState();
}

class _MonthSalaryCalculationState extends State<MonthSalaryCalculation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Sep Salary",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>TotalEarning(),
                ),
                );
              },
              child: Container(
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
                      color: AppColors.primary.withValues(alpha: 0.5),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color:AppColors.arrow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payable Salary",
                            style: TextStyle(
                              color: Colors.grey.shade100,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "sep 2025",
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                          Icon(
                            Icons.currency_rupee_sharp,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            "0.00",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                             ),
                           ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context)=>MonthAttendance(),
                            ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.arrow,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
              child: Row(
                children: [
                Icon(
                  Icons.add_chart,
                  color: AppColors.primary,
                ),
                SizedBox(width: 10,),
                Text(
                  "Salary Breakdown",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                  ),
                ),
                ],
              ),
            ),
            InfoCard(
              icon: Icons.add_chart,
              title: 'Monthly Salary',
              amount: "50,000.00",
              color: Colors.green,
               ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color:AppColors.primary,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Attendance Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 10,left: 15,right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                        Icons.check_circle_outline,
                        size: 20,
                        color: Colors.green
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Present Days/Week Off",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "0 Days Present",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "8 Week Off",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "0 Week Off Present",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_sharp,
                        size: 16,
                      ),
                      Text(
                        "0.00",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InfoCard(
             icon: Icons.cancel_outlined,
             title: 'Absent Days',
             subtitle: '13 Days Absent',
             amount: "0.00",
             color: Colors.red,
           ),
            InfoCard(
              icon: Icons.beach_access,
              title: 'Paid Holidays',
              subtitle: '0 Days',
              amount: "0.00",
              color: Colors.blue,
            ),
            InfoCard(
              icon: Icons.watch_later_outlined,
              title: 'Half Days',
              subtitle: '0 Days ',
              amount: "0.00",
              color: Colors.orange,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Earnings & Deductions",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            InfoCard(
              icon: Icons.watch_later_outlined,
              title: 'Overtime',
              subtitle: '00:00 hours ',
              amount: "0.00",
              color: Colors.purple,
            ),
            InfoCard(
              icon: Icons.star_border_outlined,
              title: 'Bonus',
              amount: "00.00",
              color: Colors.yellow,
            ),
            InfoCard(
              icon: Icons.add_circle_outline,
              title: 'Allowances',
              amount: "00.00",
              color: Colors.greenAccent,
            ),
            InfoCard(
              icon: Icons.remove_circle_outline,
              title: 'Fines',
              amount: "0.00",
              amountText: "(-)",
              color: Colors.red,
            ),
            InfoCard(
              icon: Icons.trending_down,
              title: 'Advance Payment',
              amount: "0.00",
              color: Colors.orange,
            ),
            InfoCard(
              icon: Icons.wallet_rounded,
              title: 'Salary Paid',
              amount: "0.00",
              color: Colors.deepPurple,
            ),
            InfoCard(
              icon: Icons.money_off,
              title: 'Deductions',
              amount: "0.00",
              color: Colors.red,
              amountText: "(-)",
              extraIcon: Icons.arrow_forward_ios_rounded,
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)=>DeductionScreen(),
                ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 50),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.5),
                    AppColors.primary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.download_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Download Salary Slip",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
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
  final String? subtitle;
  final IconData? extraIcon;
  final VoidCallback? onTap;
  final String? amountText;


  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.color,
    this.subtitle,
    this.extraIcon,
    this.onTap,
    this.amountText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.all(15),
        margin:  EdgeInsets.only(left: 15, right: 15, top: 15),
        decoration: CommonDecorations.card(),
        child: Row(
          children: [
            Container(
              padding:  EdgeInsets.all(8),
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
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style:  TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            Row(
              children: [
                if (amountText != null)
                  Text(
                    amountText!,
                    style: TextStyle(
                    ),
                  ),
                 Icon(
                    Icons.currency_rupee_sharp,
                    size: 16,
                ),
                Text(
                  amount,
                  style:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (extraIcon != null) ...[
                  SizedBox(width: 5),
                  Icon(
                      extraIcon,
                      size: 16,
                      color: Colors.grey,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}





