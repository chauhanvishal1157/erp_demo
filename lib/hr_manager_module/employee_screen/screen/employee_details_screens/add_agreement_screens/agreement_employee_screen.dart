import 'dart:io';

import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/add_agreement_screens/add_agreement_screen.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import '../../../../../common/app_color.dart';

class AgreementEmployee extends StatefulWidget {
  const AgreementEmployee({super.key,});

  @override
  State<AgreementEmployee> createState() => _AgreementEmployeeState();
}

class _AgreementEmployeeState extends State<AgreementEmployee> {
  List<Map<String, dynamic>> agreements = [];

  bool isImage(String path) {
    final ext = path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png'].contains(ext);
  }


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
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:AppColors.arrow,
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
                  "Agreement",
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
                MaterialPageRoute(builder: (context) => AddAgreement()),
              );

              if (result != null && result is Map<String, dynamic>) {
                setState(() {
                  agreements.add(result);
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
      body: agreements.isEmpty
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
        itemCount: agreements.length,
        padding: EdgeInsets.all(15),
        itemBuilder: (context, index) {
          final agreement = agreements[index];
          final file = agreement["file"] as File?;
          return Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.all(15),
            decoration: CommonDecorations.card(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.view_column_rounded,
                        color:AppColors.primary,
                      ),
                      CommonPopMenuButton(
                          value1: (){
                            Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context)=>AddAgreement(),
                            ),
                            );
                          },
                          value2: (){
                            setState(() {
                              agreements.removeAt(index);
                            });
                          },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateCard(
                          "Start Date",
                          agreement["startDate"],
                          Colors.blue,
                        Icons.not_started_outlined,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildDateCard(
                          "End Date",
                          agreement["endDate"],
                        Colors.orange,
                        Icons.gif_box
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    border: Border.all(color: Colors.purple.shade100),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 16,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Appraisal Due Date",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.purple,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            agreement["appraisalDate"] ?? "--/--/----",
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
                Divider(
                 thickness: 1,
                 color: Colors.black26,
                 height: 1,
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
                    margin: EdgeInsets.only(top: 15),
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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.2)),
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