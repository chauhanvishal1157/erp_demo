import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/hr_manager_module/more_screen/account_screen.dart';
import 'package:erp_demo/hr_manager_module/more_screen/leave_application_screen.dart';
import 'package:flutter/material.dart';

import '../../common/custom_app_bar.dart';
class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final List<Map<String, String>> actions = const [
    {"icon": "asset/more/account.png", "title": "Account"},
    {"icon": "asset/more/setting.png", "title": "settings"},
    {"icon": "asset/more/report.png", "title": "report"},
    {"icon": "asset/more/leave_application.png", "title": "Leave Application"},
    {"icon": "asset/more/salary_structure.png", "title": "Salary Structure"},
    {"icon": "asset/more/employee_ride.png", "title": "Employee Ride"},
    {"icon": "asset/more/employee_remark.png", "title": "Employee Remarks"},
    {"icon": "asset/more/festival_holidays.png", "title": "Festival Holidays"},
    {"icon": "asset/more/employee_location.png", "title": "Employee Location"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CustomAppBar(
        leadingIcon: Icons.groups_outlined,
        title:  "HR",
        subtitle: "Human Resource",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              padding: EdgeInsets.only(left: 15,right: 15,top: 30),
              itemCount: actions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,// 4 per row
                crossAxisSpacing: 15,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (actions[index]["title"] == "Account") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountScreen(),
                            ),
                          );
                        }else if(actions[index]["title"] == "Leave Application")
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LeaveApplication(),
                            ));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Image.asset(
                                actions[index]["icon"]!,
                                fit: BoxFit.contain,
                                height: 40,width: 40,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              actions[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
