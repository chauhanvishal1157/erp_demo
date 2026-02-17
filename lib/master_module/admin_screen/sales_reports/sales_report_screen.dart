import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/master_module/admin_screen/sales_reports/report_master_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  
  List<Map<String, dynamic>> employee = [
    {"name": "All",
    },
    {
      "name": "Narendra Chauhan",
    },
    {
      "name": "Milan Face Test",
    },
    {
      "name": "Shivang Face Test",
    },
    {
      "name": "Harsh",
    },
    {
      "name": "Hitesh",
    },
    {
      "name": "Vishal",
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Sales Reports"
      ),
      body: Padding(
        padding:  EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      hintText: "Enter sub category Name..",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black26,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 20,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(
                        Icons.mic_none,
                        size: 20,
                        color: Colors.grey,
                      )
                  ),
                ),
              ),
              ListView.builder(
                itemCount: employee.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    final emp = employee[index];
                    String empName = emp['name'];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context)=>ReportMasterScreen(employeeName: empName,),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.all(10),
                        decoration: CommonDecorations.card(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              radius: 20,
                              child: Text(
                                empName[0],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text(
                                empName,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 16,
                                color: Colors.black54,
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
