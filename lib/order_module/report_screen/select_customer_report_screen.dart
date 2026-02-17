import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class SelectCustomerReport extends StatefulWidget {
  const SelectCustomerReport({super.key});

  @override
  State<SelectCustomerReport> createState() => _SelectCustomerReportState();
}

class _SelectCustomerReportState extends State<SelectCustomerReport> {

  String selectedCustomer = "";

  final List<Map<String, dynamic>> customers = const [
    {
      "name": "Harsh",
      "mail":"harshpatel@gmail.com",
      "phone": "9054457039",
    },
    {
      "name": "Shivang",
      "mail":"shisshivang@gmail.com",
      "phone": "8140211211",
    },
    {
      "name": "Shis",
      "mail":"shis@gmail.com",
      "phone": "8855223366",
    },
    {
      "name": "Shivam patel Milan Patel Jay Nimavat Narendra Chauhan",
      "mail":"flutter@gmail.com",
      "phone": "9874563210",
    },
    {
      "name": "Patel",
      "mail":"khatarwale@gmail.com",
      "phone": "3579512460",
    },
    {
      "name": "Parth",
      "mail":"khatarwale@gmail.com",
      "phone": "3579512460",
    },
    {
      "name": "Branch ID",
      "mail":"branch@gmail.com",
      "phone": "3124659780",
    },
    {
      "name": "Dhruv Kumar",
      "mail":"dhruv@gmail.com",
      "phone": "2589645687",
    },
    {
      "name": "Jatin",
      "mail":"jatin@gmail.com",
      "phone": "4613795484",
    }, {
      "name": "Manthan",
      "mail":"manthan@gmail.com",
      "phone": "1643495444",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Select Customer",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: customers.length,
                  itemBuilder: (context,index){
                    String name = customers[index]["name"];
                    bool isSelected = selectedCustomer.contains(name);
                    return  GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedCustomer = "";
                          } else {
                            selectedCustomer = name;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                        decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue[50]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(
                                color: Colors.blue,
                                width: 1
                            )
                                : Border.all(
                              color: Colors.transparent,
                                width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 4,
                                offset: Offset(1,1),
                              )
                            ]
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    customers[index]["name"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                      shape: CircleBorder(),
                                      side: BorderSide(color: Colors.grey),
                                      activeColor: Colors.blue,
                                      value: isSelected,
                                      onChanged: (value){
                                        setState(() {
                                          if (value == true) {
                                            selectedCustomer = name;
                                          } else {
                                            selectedCustomer = "";
                                          }
                                        }
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    Icons.mail_outline,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      customers[index]["mail"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mobile",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      customers[index]["phone"],
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.screenBg
              ),
              child: CommonActionButton(
                  title: "Save Changes",
                  onTap:  (){
                    Navigator.pop(context,selectedCustomer);
                  },
              ),
            ),

          ),
        ],
      )
    );
  }
}
