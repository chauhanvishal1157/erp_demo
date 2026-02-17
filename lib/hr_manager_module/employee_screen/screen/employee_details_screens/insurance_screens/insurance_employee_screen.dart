import 'dart:io';

import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/insurance_screens/add_insurance_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class InsuranceEmployee extends StatefulWidget {
  const InsuranceEmployee({super.key});

  @override
  State<InsuranceEmployee> createState() => _InsuranceEmployeeState();
}

class _InsuranceEmployeeState extends State<InsuranceEmployee> {

  List<Map<String, dynamic>> insuranceList = [];



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
                Navigator.pop(context,);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Insurance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "#ts5 Vishal",
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
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddInsurance()),
              );
              if (result != null && result is Map<String, dynamic>) {
                setState(() {
                  insuranceList.add(result);
                });
              }
            },

            child: Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.add,
                )
            ),
          ),
        ],
      ),
      body: insuranceList.isEmpty
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 100,),
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
        itemCount: insuranceList.length,
        itemBuilder: (context, index) {
          final insurance = insuranceList[index];
          final file = insurance["file"] as File?;
          return Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            padding: EdgeInsets.only(bottom: 15),
            decoration: CommonDecorations.card(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.arrow.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.business,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                            insurance["companyName"],
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary
                            ),
                          ),
                            Text(
                              "Insurance Policy",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonPopMenuButton(
                          value1: (){
                            Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context)=>AddInsurance(),
                            ),
                            );

                          },
                          value2: (){
                            setState(() {
                              insuranceList.removeAt(index);
                            });
                          },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildDateCard(
                          "Policy No",
                          insurance["policyNo"],
                          Colors.grey,
                          Icons.badge_outlined,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildDateCard(
                            "Identity No",
                            insurance["identityNo"],
                            Colors.grey,
                            Icons.badge_outlined
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    border: Border.all(color: Colors.green.shade100),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month_sharp,
                        size: 18,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Coverage Period",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${insurance["startDate"] ?? "--/--/----"} -"
                                " ${insurance["endDate"] ?? "--/--/----"}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (file != null) {
                      OpenFile.open(file.path);  // <-- This opens the document
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No document available")),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.sticky_note_2_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Document",
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                file != null ? file.path.split('/').last : "No Document",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue,
                                blurRadius: 4,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildDateCard(
      String title,
      String? value,
      Color color,
      IconData icon,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: 5,),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: color,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            value ?? "--/--/----",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

}
