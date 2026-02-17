import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:flutter/material.dart';

class MonthAttendance extends StatefulWidget {
  const MonthAttendance({super.key});

  @override
  State<MonthAttendance> createState() => _MonthAttendanceState();
}

class _MonthAttendanceState extends State<MonthAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar:CommonAppBar(
          title: "Monthly Attendance",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.8),
                    AppColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.arrow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.calendar_month,
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
                              "Monthly Overview",
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
                    ],
                  ),
                  Row(
                    children: [
                      OverView(
                        icon: Icons.watch_later_outlined,
                        title: '0.00 hr',
                        subtitle: 'hours',
                      ),
                      OverView(
                        icon: Icons.watch_later,
                        title: '0.00 hr',
                        subtitle: 'Overtime',
                      ),
                      OverView(
                        icon: Icons.check_circle,
                        title: '0',
                        subtitle: 'Present',
                      ),
                      OverView(
                        icon: Icons.cancel_outlined,
                        title: '0',
                        subtitle: 'Absent',
                      ),
        
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black45,
                    Colors.purple.shade900,
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
                  Text(
                    "Monthly Salary Summary",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.work_outline,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Work Hours Salary",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "0.00 hr Worked",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                           ),
                          ),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee_sharp,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              "0.00",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overtime Salary",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "0.00 hr overtime",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee_sharp,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              "0.00",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white60,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Monthly Salary",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Work Salary + Overtime Salary",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee_sharp,
                              color: Colors.white,
                              size: 18,
                            ),
                            Text(
                              "0.00",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.blue,
                    size: 16,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "Daily Attendance",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Attendance(
                title: "01-09-2025 Monday",
            ),
            Attendance(
              title: "02-09-2025 Tuesday",
            ),
            Attendance(
              title: "03-09-2025 Wednesday",
            ),
            Attendance(
              title: "04-09-2025 Thursday",
            ),
            Attendance(
              title: "05-09-2025 Friday",
            ),
            Attendance(
              title: "06-09-2025 Saturday",
            ),
            Attendance(
              title: "07-09-2025 Sunday",
            ),
          ],
        ),
      ),
    );
  }
}

class OverView extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;

  const OverView({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.only(top: 20,left: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.arrow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              Text(
               title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                ),
              ),
            ],
          )
      ),
    );
  }
}

class Attendance extends StatelessWidget {
  final String title;
  
  const Attendance({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 15,right: 15,top: 10),
      decoration: CommonDecorations.card(),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 15,
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Text(
                 title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,

                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Absent",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(
              height: 1,
              color: Colors.black26,
              thickness: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.money_off,
                  color: Colors.red,
                  size: 14,
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    "No Salary",
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
                      size: 12,
                      color: Colors.red,
                    ),
                    Text(
                      "0.00",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



