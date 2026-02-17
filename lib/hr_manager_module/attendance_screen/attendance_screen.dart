import 'package:erp_demo/common/common_decoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/app_color.dart';
import '../../common/custom_app_bar.dart';
import 'check_in_bottom_sheet.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  late List<Map<String, String>> attendanceDays;
  int selectedIndex = 0;
  String selectedType = "Current";
  TimeOfDay? customTime;

  @override
  void initState() {
    super.initState();
    generateDaysUpToToday();
  }
  void generateDaysUpToToday() {
    final now = DateTime.now();
    final formatterDay = DateFormat("EEE");
    final formatterDate = DateFormat("dd");


    attendanceDays = List.generate(now.day, (index) {
      final date = DateTime(now.year, now.month, index + 1);
      return {
        "day": formatterDay.format(date),
        "date": formatterDate.format(date),
      };
    });
    selectedIndex = attendanceDays.length - 1;
  }

  final List<Map<String, dynamic>> employee =  [
    {
      "code": "#ts03",
      "name": "Narendra Chauhan",
      "firstLater": "N",
     "status": "Absent",
     "color": Colors.red,
    },
    {
      "code": "#ts5",
      "name": "Vishal",
      "firstLater": "V",
      "status": "Absent",
      "color": Colors.red,
    },
    {
      "code": "#ts27",
      "name": "Milan Face Test",
      "firstLater": "M",
      "status": "Absent",
      "color": Colors.red,
    },
    {
      "code": "#ts31",
      "name": "Jay",
      "firstLater": "J",
      "status": "Absent",
      "color": Colors.red,
    },
    {
      "code": "#ts90",
      "name": "Shivang Face Test",
      "firstLater": "S",
      "status": "Absent",
      "color": Colors.red,
    },
    {
      "code": "#ts315",
      "name": "Harsh",
      "firstLater": "H",
      "status": "Absent",
      "color": Colors.red,
    },
    {
      "code": "#ts1245",
      "name": "Hitesh",
      "firstLater": "H",
      "status": "Absent",
      "color": Colors.red,
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CustomAppBar(
        leadingIcon:  Icons.calendar_today_outlined,
        title:  "Attendance",
        subtitle:  "View and manage attendance",
        showAdd: true,
        addIconColor: AppColors.primary,
        addIcon: Icons.calendar_month_outlined,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  margin: EdgeInsets.only(top: 5),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: attendanceDays.length,
                    itemBuilder: (context, index) {
                      final item = attendanceDays[index];
                      final isSelected = index == selectedIndex;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin:  EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 12
                          ),
                          padding:  EdgeInsets.symmetric(
                              horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 4,
                                  offset: Offset(1, 1)
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item["date"]!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                item["day"]!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.bar_chart,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Text(
                              "Attendance Overview",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.primary,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 15,),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1.8,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          _OverviewItem(
                            "Present",
                            "0",
                          ),
                          _OverviewItem(
                            "Absent",
                            "7",
                          ),
                          _OverviewItem(
                            "Half Day",
                            "0",
                          ),
                          _OverviewItem(
                            "Paid Leave",
                            "0",
                          ),
                          _OverviewItem(
                            "Overtime",
                            "00:00 hrs",
                          ),
                          _OverviewItem(
                            "Fine",
                            "₹0.00",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,),
                  child: Text(
                    "Employee",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15,right: 15,top: 15),
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
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        hintText: "Enter Search Employee Name..",
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: employee.length,
                  itemBuilder: (context,index){
                    final emp = employee[index];
                    bool isAbsent = emp["status"] == "Absent";
                    bool isPaidLeave = emp["status"] == "Paid Leave";
                    bool isUnpaidLeave = emp["status"] == "Unpaid Leave";
                    return  Container(
                      margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                      decoration: CommonDecorations.card(),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: emp["color"].withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: emp["color"],
                                  radius: 25,
                                  child: Text(
                                    emp["firstLater"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding:  EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: emp["color"],
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child:  Text(
                                              emp["code"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Expanded(
                                            child: Text(
                                              emp["name"],
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        padding:  EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: emp["color"],
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child:  Text(
                                          emp["status"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuButton<int>(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  onSelected: (value) async {
                                    String status = "";
                                    Color color = Colors.grey;
                                    switch (value) {
                                      case 1:
                                        status = "Present";
                                        color = Colors.green;
                                        break;
                                      case 2:
                                        status = "Absent";
                                        color = Colors.red;
                                        break;
                                      case 3:
                                        status = "Half Day";
                                        color = Colors.orange;
                                        break;
                                      case 4:
                                        status = "Leave";
                                        color = Colors.blue;
                                        break;
                                    }
                                    if (status != "Absent") {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: false,
                                        builder: (context) {
                                          return CheckInBottomSheet(
                                            index: index,
                                            status: status,
                                            color: color,
                                            onCheckInComplete: (idx,
                                                updatedStatus,
                                                updatedColor,
                                                time) {
                                              setState(() {
                                                employee[idx]["status"] = updatedStatus;
                                                employee[idx]["color"] = updatedColor;
                                                employee[idx]["checkInTime"] = time;
                                              });
                                            },
                                          );
                                        },
                                      );
                                    } else {
                                      setState(() {
                                        employee[index]["status"] = status;
                                        employee[index]["color"] = color;
                                      });
                                    }
                                  },

                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade50,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Icon(
                                              Icons.check_circle,
                                              size: 15,
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text("Present"),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade50,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Icon(
                                              Icons.cancel,
                                              size: 15,
                                              color: Colors.red,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text("Absent"),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 3,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.yellow.shade50,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Icon(
                                              Icons.watch_later_outlined,
                                              size: 15,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text("Half Day"),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 4,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Icon(
                                              Icons.airplane_ticket_outlined,
                                              size: 15,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text("Leave"),
                                        ],
                                      ),
                                    ),
                                  ],
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Icon(
                                      size: 20,
                                      color: Colors.black54,
                                      Icons.more_vert_outlined,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isAbsent || isPaidLeave || isUnpaidLeave)
                            Container(
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: isAbsent
                                    ? Colors.red.withValues(alpha: 0.1)
                                    : isPaidLeave
                                    ? Colors.blue.withValues(alpha: 0.1)
                                    : Colors.purple.withValues(alpha: 0.1),
                                border: Border.all(
                                  color: isAbsent
                                      ? Colors.red.shade100
                                      : isPaidLeave
                                      ? Colors.blue.shade300
                                      : Colors.purple.shade300,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isAbsent
                                          ? Colors.red.withValues(alpha: 0.1)
                                          : isPaidLeave
                                          ? Colors.blue.withValues(alpha: 0.1)
                                          : Colors.purple.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      isAbsent
                                          ? Icons.cancel
                                          : isPaidLeave
                                          ? Icons.payments_outlined
                                          : Icons.currency_exchange_outlined,
                                      color: isAbsent
                                          ? Colors.red
                                          : isPaidLeave
                                          ? Colors.blue
                                          : Colors.purple,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    isAbsent
                                        ? "Employee was absent"
                                        : isPaidLeave
                                        ? "Employee on Paid Leave"
                                        : "Employee on Unpaid Leave",
                                    style: TextStyle(
                                      color: isAbsent
                                          ? Colors.red.shade700
                                          : isPaidLeave
                                          ? Colors.blue.shade700
                                          : Colors.purple.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
        ],
      )
    );
  }
}
class _OverviewItem extends StatelessWidget {
  final String title;
  final String value;
  const _OverviewItem(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,top: 5),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
              ),
          ),
          const SizedBox(height: 4),
          Text(
              value,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
              ),
          ),
        ],
      ),
    );
  }
}
