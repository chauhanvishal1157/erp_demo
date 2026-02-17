import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../common/app_color.dart';
import '../../common/common_date_range_filter.dart';
import '../../common/common_decoration.dart';
import '../../common/common_home_app_bar.dart';

class LeadHomeScreen extends StatefulWidget {
  const LeadHomeScreen({super.key});

  @override
  State<LeadHomeScreen> createState() => _LeadHomeScreenState();
}

class _LeadHomeScreenState extends State<LeadHomeScreen> {

  final List<Map<String, dynamic>> items =  [
    {"title":"Total Lead",
      "count":0,
      "icon":Icons.sticky_note_2_rounded,
      "color":Colors.orange
    },
    {
      "title":"Pending Lead",
      "count":0,
      "icon":Icons.message_outlined,
      "color":Colors.orange,
    },
    {
      "title":"Completed Lead",
      "count":0,
      "icon":Icons.note_add_sharp,
      "color":Colors.green,
    },
    {
      "title":"In-Progress Lead",
      "count":0,
      "icon":Icons.assignment_outlined,
      "color":Colors.purple
    },
    {
      "title":"Rejected Lead",
      "count":0,
      "icon":Icons.message_sharp,
      "color":Colors.red
    },
    {
      "title":"Scheduled Lead",
      "count":0,
      "icon":Icons.note_add_sharp,
      "color":Colors.blue
    },

  ];

  DateTime? startDate = DateTime.now();
  DateTime? endDate   = DateTime.now();

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (startDate ?? DateTime.now())
          : (endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonHomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonDateRangeFilter(
              startDate: startDate!,
              endDate: endDate!,
              onStartDateTap: () => _selectDate(context, true),
              onEndDateTap:() => _selectDate(context, false),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(left: 15,top: 20,right: 15,),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF009688),
                          Color(0xFF00BCD4)
                        ],
                      ),
                      borderRadius:BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pie_chart,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Lead Dashboard",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                    itemCount: items.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 1,
                      childAspectRatio: 2,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = items[index];
                      return
                        Container(
                          margin: EdgeInsets.all(6),
                          padding: EdgeInsets.only(top: 5,left: 10,right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${item["count"]}",
                                    style: TextStyle(
                                      fontSize: 16,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: (item["color"].shade50),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Icon(
                                      item["icon"],
                                      color: item["color"],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                item["title"],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        );
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10,),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 50),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade400,
                          Color(0xFF00BCD4)
                        ],
                      ),
                      borderRadius:BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pie_chart,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Lead Overview",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 130.0,
                          lineWidth: 10.0,
                          percent: 0.0,
                          progressColor: Colors.blue,
                          backgroundColor: Colors.grey.shade300,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        CircularPercentIndicator(
                          radius: 110.0,
                          lineWidth: 10.0,
                          percent: 0.0,
                          progressColor: Colors.blue,
                          backgroundColor:Colors.grey.shade300,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        CircularPercentIndicator(
                          radius: 90.0,
                          lineWidth: 10.0,
                          percent: 0.0,
                          progressColor: Colors.blue,
                          backgroundColor: Colors.grey.shade300,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        CircularPercentIndicator(
                          radius: 70.0,
                          lineWidth: 10.0,
                          percent: 0.0,
                          progressColor: Colors.blue,
                          backgroundColor: Colors.grey.shade300,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        Column(
                          children: [
                            Text(
                              "Pending:0.0%",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "Complete:0.0%",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "In-Progress:0.0%",
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "Rejected:0.0%",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "Schedule:0.0%",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ]
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
