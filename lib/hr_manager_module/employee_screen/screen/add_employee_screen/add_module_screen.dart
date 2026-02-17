import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';

class AddModuleScreen extends StatefulWidget {
  const AddModuleScreen({super.key});

  @override
  State<AddModuleScreen> createState() => _AddModuleScreenState();
}

class _AddModuleScreenState extends State<AddModuleScreen> {

  String selectedCustomer = "";

  Map<String, bool> selections = {
    "HR Manager": false,
    "Task": true,
    "Customer": false,
    "Vendor": false,
    "Product": false,
    "Lead": false,
    "Orders": false,
    "Production": false,
    "Dispatch": false,
    "Inventory": false,
    "Purchase":false,
    "Reminders":true,
    "Setting":true,
    "File":false,
    "Notes":false,
    "Notification":false,
    "Support":false,
  };

  bool isTaskManager = false;
  bool isLeadManager = false;
  bool isOrderManager = false;
  bool isPurchaseManager = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Select Module",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 120),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: selections.length,
                itemBuilder: (context,index){
                  String name = selections.keys.elementAt(index);
                  bool selected = selections[name]!;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selections[name] = !selected;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                      decoration: BoxDecoration(
                          color: selected
                              ? Colors.blue[50]
                              : Colors.white,
                          border: Border.all(
                            color: selected
                                ? Colors.blue.shade200
                                : Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 4,
                              offset: const Offset(1, 1),
                            )
                          ]
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                  shape: CircleBorder(),
                                  side: BorderSide(color: Colors.grey),
                                  activeColor: AppColors.primary,
                                  value: selected,
                                  onChanged: (value){
                                    setState(() {
                                      selections[name] = value ?? false;
                                    }
                                    );
                                  }
                              ),
                              Expanded(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    color: selected
                                        ?  AppColors.primary
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              if (selected)
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color:  AppColors.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "Selected",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (name == "Task" && selected)
                            Column(
                              children: [
                                Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                  height: 1,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(color: Colors.blue.shade200),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Task Manager",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Switch(
                                                  activeTrackColor:  Colors.blue,
                                                  inactiveThumbColor: Colors.white,
                                                  inactiveTrackColor: Colors.grey.shade200,
                                                  activeColor:  AppColors.primary.withValues(alpha: 0.2),
                                                  value: isTaskManager,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      isTaskManager = val;
                                                    });
                                                  },

                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "By selecting task manager this particular"
                                                  " employee can create task and assign "
                                                  "to other employee otherwise admin only "
                                                  "have functionality of assign task",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
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
                          if (name == "Lead" && selected)
                            Column(
                              children: [
                                Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                  height: 1,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(color: Colors.blue.shade200),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Lead Manager",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Switch(
                                                  activeTrackColor: Colors.blue[200], // track color
                                                  inactiveThumbColor: Colors.white,
                                                  inactiveTrackColor: Colors.grey.shade200,
                                                  activeColor: Colors.blue,
                                                  value: isLeadManager,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      isLeadManager = val;
                                                    });
                                                  },

                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "By selecting lead manager this particular "
                                                  "employee can able to see all the leads"
                                                  " created by other employees.By default"
                                                  " it will be regular employee.",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
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
                          if (name == "Orders" && selected)
                            Column(
                              children: [
                                Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                  height: 1,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(color: Colors.blue.shade200),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Order Manager",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Switch(
                                                  activeTrackColor: Colors.blue[200], // track color
                                                  inactiveThumbColor: Colors.white,
                                                  inactiveTrackColor: Colors.grey.shade200,
                                                  activeColor: Colors.blue,
                                                  value: isOrderManager,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      isOrderManager = val;
                                                    });
                                                  },

                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "By selecting order manager this particular"
                                                  " employee can able to see all the"
                                                  " orders created by other employees.By"
                                                  " default it will be regular employee.",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
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
                          if (name == "Purchase" && selected)
                            Column(
                              children: [
                                Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                  height: 1,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(color: Colors.blue.shade200),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Purchase Manager",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Switch(
                                                  activeTrackColor: Colors.blue[200], // track color
                                                  inactiveThumbColor: Colors.white,
                                                  inactiveTrackColor: Colors.grey.shade200,
                                                  activeColor: Colors.blue,
                                                  value: isPurchaseManager,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      isPurchaseManager = val;
                                                    });
                                                  },

                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              "By selecting Purchase manager this particular "
                                                  "employee can able to approve purchase"
                                                  " order and requisition or else admin"
                                                  " have to approved all PU.",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
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
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CommonActionButton(
                title: "Save Selection",
                horizontalMargin: 15,
                icon: Icons.save,
                onTap: (){
                  Navigator.pop(context);
                }
            ),
          )
        ],
      ),
    );
  }
}
