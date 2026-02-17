import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/add_extra_funds_screens/extra_fund_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';

import '../../../common/common_decoration.dart';

class EmployeeFunds extends StatefulWidget {
  const EmployeeFunds({super.key});

  @override
  State<EmployeeFunds> createState() => _EmployeeFundsState();
}

class _EmployeeFundsState extends State<EmployeeFunds> {

  List<Map<String, dynamic>> employee = [
    {
      "name": "Narendra Chauhan",
      "amount": "0.00"
    },
    {
      "name": "Milan Face Test",
      "amount": "0.00"
    },
    {
      "name": "Shivang Face Test",
      "amount": "100.00"
    },
    {
      "name": "Harsh",
      "amount": "1000.00"
    },
    {
      "name": "Hitesh",
      "amount": "0.00"
    },
    {
      "name": "Vishal",
      "amount": "100.00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Employee Funds"
      ),
      body: Padding(
        padding:  EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
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
                      hintText: "Enter Employee Name..",
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
                  String empAmount = emp['amount'];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>ExtraFund(),
                          ),
                      );
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  empName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                 padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    border: Border.all(
                                      color:Colors.red.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.currency_rupee_rounded,
                                        size: 14,
                                        color:Colors.red,
                                      ),
                                      Text(
                                        empAmount,
                                        style: TextStyle(
                                          color:Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
