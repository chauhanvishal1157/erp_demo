import 'package:erp_demo/common/common_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';
import '../../../../common/common_action_button.dart';

class WorkingShiftListScreen extends StatefulWidget {
  const WorkingShiftListScreen({super.key});

  @override
  State<WorkingShiftListScreen> createState() => _WorkingShiftListScreenState();
}

class _WorkingShiftListScreenState extends State<WorkingShiftListScreen> {

  List<String> selectedShifts = [];
  final List<Map<String, dynamic>> workingShift = [
    {
      "name" : "Regular",
      "Time" : "(10:00AM - 7:00PM)"
    },
    {
      "name" : "b 1",
      "Time" : "(1:00AM - 8:00PM)"
    },
    {
      "name" : "Noon shift",
      "Time" : "(1:00PM - 8:00AM)"
    },
    {
      "name" : "Night shift",
      "Time" : "(7:15PM - 5:00AM)"
    },
    {
      "name" : "Test",
      "Time" : "(10:10AM - 7:30PM)"
    },
    {
      "name" : "Test 2",
      "Time" : "(10:15AM - 8:00PM)"
    },
    {
      "name" : "Morning shift",
      "Time" : "(8:00AM - 12:30PM)"
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Working Shift List",
      ),
      body: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: workingShift.length,
          itemBuilder: (context,index){
            String name = workingShift[index]["name"];
            String time = workingShift[index]["Time"];
            bool isSelected = selectedShifts.contains(name);
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 15,right: 15,top: 10),
              decoration: BoxDecoration(
                color:  isSelected
                       ? Colors.blue[50]
                       : Colors.white,
                border: Border.all(
                  color: isSelected
                      ? Colors.blue.shade200
                      : Colors.white,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                        shape: CircleBorder(),
                        side: BorderSide(color: Colors.grey),
                        activeColor: AppColors.primary,
                        value: isSelected,
                        onChanged: (value){
                          setState(() {
                            if (value == true) {
                              selectedShifts.add(name);
                            } else {
                              selectedShifts.remove(name);
                            }

                          });
                        }
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  if (isSelected)
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
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
                    ),
                ],
              ),
            );
          }
          ),
      bottomNavigationBar: SafeArea(
          child: CommonActionButton(
            title: "Save",
            icon: Icons.save,
            onTap: (){
              Navigator.pop(context,selectedShifts);
            },
          )
      ),
    );
  }
}


