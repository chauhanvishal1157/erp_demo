import 'package:carousel_slider/carousel_slider.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/add_agreement_screens/agreement_employee_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/check_in_out_screens/check_in_out_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/details_screen/employee_edit_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/add_extra_funds_screens/extra_fund_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/deduction_screen/deduction_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/month_salary_calculation/month_salary_calculation.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';

import '../insurance_screens/insurance_employee_screen.dart';

  class EmployeeDetailsScreen extends StatefulWidget {
    const EmployeeDetailsScreen({super.key});

    @override
    State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
  }

  class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {

    final List<Map<String, String>> actions = const [
      {"icon": "asset/employee/payment.png", "title": "Add Payment"},
      {"icon": "asset/employee/attendance.png", "title": "Attendance"},
      {"icon": "asset/employee/overtime.png", "title": "Overtime"},
      {"icon": "asset/employee/allowance.png", "title": "Allowance/…"},
      {"icon": "asset/employee/deduction.png", "title": "Deduction"},
      {"icon": "asset/employee/salary_slip.png", "title": "Salary Slip"},
      {"icon": "asset/employee/edit_salary.png", "title": "Edit Salary"},
      {"icon": "asset/employee/check_in.png", "title": "Check In/Out"},
    ];


    final List<Map<String, String>> actions1 = const [
      {"icon": "asset/employee/agreement.png", "title": "Agreement"},
      {"icon": "asset/employee/award.png", "title": "Award"},
      {"icon": "asset/employee/education.png", "title": "Education"},
      {"icon": "asset/employee/experience.png", "title": "Experience"},
      {"icon": "asset/employee/insurance.png", "title": "Insurance"},
      {"icon": "asset/employee/kyc.png", "title": "KYC"},
      {"icon": "asset/employee/document.png", "title": "Document"},
      {"icon": "asset/employee/extra_fund.png", "title": "Extra Funds"},
    ];

    Widget buildGrid(List<Map<String, String>> items) {
      return GridView.builder(
       padding: EdgeInsets.only(left: 15,right: 15,top: 10),
        itemCount: items.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 per row
          mainAxisSpacing: 10,
          crossAxisSpacing: 20,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (items[index]["title"] == "Check In/Out") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckInOut(),
                      ),
                    );
                  } else if(items[index]["title"] == "Agreement"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgreementEmployee(),
                      ),
                    );
                  }else if(items[index]["title"] == "Insurance"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InsuranceEmployee(),
                      ),
                    );
                  }else if(items[index]["title"] == "Extra Funds"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>ExtraFund(),
                      ),
                    );
                  }else if(items[index]["title"] == "Deduction"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>DeductionScreen(),
                      ),
                    );
                  }
                },
                child: Container(
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
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      items[index]["icon"]!,
                      fit: BoxFit.contain,
                      height: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                items[index]["title"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          );
        },
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor:  AppColors.screenBg,
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
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.arrow,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue.shade100,
                child: Icon(
                  Icons.person_outline,
                  size: 30,
                  color: AppColors.arrow,
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Harsh",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Employee Code:#ts315",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<int>(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => EmployeeEditScreen(),
                    ),
                );
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                          color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text("Edit Employee"),
                    ],
                  ),
                ),
              ],
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                    Icons.more_vert_outlined,
                  size: 20,
                ),
              ),
            ),
          ],

        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade100)
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Pending Salary",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "₹800.00",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Quick Actions",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                ),
                items: [
                  buildGrid(actions),
                  buildGrid(actions1),
                ],
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=>MonthSalaryCalculation(),
                  ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: CommonDecorations.card(),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.error_outline_sharp,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                "Current month salary calculation",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: AppColors.primary,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.payments_outlined,
                                color: Colors.green,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                child: Text(
                                  "sep,2025 Salary",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee_sharp,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                Text(
                                  "0.00",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Closing Balance",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                margin: EdgeInsets.all(15),
                decoration: CommonDecorations.card(),
                child: Column(
                  children: [
                   GestureDetector(
                     onTap: (){
                       Navigator.push(
                           context, MaterialPageRoute(
                           builder: (context)=>MonthSalaryCalculation(),
                       ),
                       );
                     },
                     child: Padding(
                       padding:  EdgeInsets.all(10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             "Aug,2025 ",
                             style: TextStyle(
                               fontWeight: FontWeight.w500,
                             ),
                           ),
                           Row(
                             children: [
                               Icon(
                                 Icons.currency_rupee_sharp,
                                 size: 14,
                               ),
                               Text(
                                 "0.00",
                                 style: TextStyle(
                                   fontSize: 16,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                               SizedBox(width: 5,),
                               Icon(
                                 Icons.arrow_forward_ios_sharp,
                                 color: Colors.grey,
                                 size: 16,
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                   ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade400,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>MonthSalaryCalculation(),
                        ),
                        );
                      },
                      child: Padding(
                        padding:  EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "jul,2025 ",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee_sharp,
                                  size: 14,
                                ),
                                Text(
                                  "0.00",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade400,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>MonthSalaryCalculation(),
                        ),
                        );
                      },
                      child: Padding(
                        padding:  EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "jun,2025 ",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee_sharp,
                                  size: 14,
                                ),
                                Text(
                                  "0.00",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
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
