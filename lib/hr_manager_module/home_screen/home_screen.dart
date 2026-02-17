import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../common/common_home_app_bar.dart';
import 'filter_date_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Map<String, dynamic>> items = const [
    {
      "title":"Pending Salary",
      "count":300,
      "icon":Icons.description,
      "color":Colors.orange
    },
    {
      "title":"Total Employee",
      "count":7,
      "icon":Icons.more_horiz_outlined,
      "color":Colors.green,
    },
    {
      "title":"Present",
      "count":0,
      "icon":Icons.note_add,
      "color":Colors.green,
    },
    {
      "title":"Absent",
      "count":7,
      "icon":Icons.description,
      "color":Colors.red,
    },
    {
      "title":"Half-Day",
      "count":0,
      "icon":Icons.more_horiz_outlined,
      "color":Colors.orange,
    },
    {
      "title":"Paid Leave",
      "count":0,
      "icon":Icons.more_horiz_outlined,
      "color":Colors.blue,
    },
  ];


  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  String formatRange(DateTime start, DateTime end) {
    if (start.year == end.year && start.month == end.month) {
      return "${_monthName(start.month)} ${start.day.toString().padLeft(2, '0')} "
              "- ${end.day.toString().padLeft(2, '0')}, ${start.year}";
    } else if (start.year == end.year) {
      return "${_monthName(start.month)} ${start.day.toString().padLeft(2, '0')} "
             "- ${_monthName(end.month)} ${end.day.toString().padLeft(2, '0')}, ${start.year}";
    } else {
      return "${_monthName(start.month)} ${start.day.toString().padLeft(2, '0')}, ${start.year} "
              "- ${_monthName(end.month)} ${end.day.toString().padLeft(2, '0')}, ${end.year}";
    }
  }

  String? selectedFilter;
  DateTime? startDate;
  DateTime? endDate;

  void _openFilter() async {
    final result = await Navigator.push(
      context, ModalBottomSheetRoute(
          builder: (context) =>  FilterDate(),
          isScrollControlled: false,
    ),
    );

    if (result != null) {
      setState(() {
        selectedFilter = result["filter"];
        startDate = result["start"];
        endDate = result["end"];
        selectedDate = null;
        selectedDateRange = null;
      });
    }
  }

  String formatDate(DateTime d) {
    return "${d.day}-${d.month}-${d.year}";
  }

  DateTime? selectedDate;
  DateTimeRange? selectedDateRange;
  final DateTime _today = DateTime.now();

  void _openDateTypeDialog() {
    showDialog(
        context: context,
        builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
          ),
    title: Text(
        'Select Date Type',
    ),
    content: Column(
    mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
    leading:Icon(
        Icons.calendar_today,
        color: Colors.blue,
    ),
        title:Text(
          'Single Date',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle:  Text(
          'Select one specific date',
          style: TextStyle(
              fontSize: 12,
          ),
        ),
      onTap: () async {
        Navigator.pop(context);
        final now = DateTime.now();
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(now.year, now.month, 1),
          lastDate: now,
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
            selectedDateRange = null;   // clear range
            startDate = null;           // clear filter selection
            endDate = null;
            selectedFilter = null;
            }
          );
        }
      },
    ),
          Divider(
            height: 1,
            color: Colors.black,
            thickness: 1,
            indent: 10,
            endIndent: 10,

          ),
          ListTile(
            leading:Icon(
                Icons.date_range,
                color: Colors.orange,
            ),
            title:Text(
              'Date Range',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle:Text(
              'Select start and end dates',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            onTap: () async {
              final now = DateTime.now();
              final startOfMonth = DateTime(now.year, now.month, 1);
              final today = DateTime(now.year, now.month, now.day);
              Navigator.pop(context);
              final pickedRange = await showDateRangePicker(
                context: context,
                firstDate: startOfMonth, // start of month
                lastDate: today,         // current date
                initialDateRange: DateTimeRange(start: startOfMonth, end: today),
              );
              if (pickedRange != null) {
                setState(() {
                  selectedDateRange = pickedRange;
                });
              }
            },
          ),
        ],
       ),
      );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(
      _today.year,
      _today.month,
      _today.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonHomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade500,
                          Colors.blue.shade900,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Select Date",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(12),
                          decoration: CommonDecorations.card(),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                size: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10,),
                              if (selectedDate != null)
                                Expanded(
                                  child: Text(
                                    "${_monthName(selectedDate!.month)} "
                                        "${selectedDate!.day.toString().padLeft(2, '0')}, "
                                        "${selectedDate!.year}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              else if (selectedDateRange != null)
                                Expanded(
                                  child: Text(
                                    "${_monthName(selectedDateRange!.start.month)} "
                                        "${selectedDateRange!.start.day.toString().padLeft(2, '0')} - "
                                        "${_monthName(selectedDateRange!.end.month)} "
                                        "${selectedDateRange!.end.day.toString().padLeft(2, '0')}, "
                                        "${selectedDateRange!.end.year}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              else if (selectedFilter != null && startDate != null && endDate != null)
                                  Expanded(
                                    child: Text(
                                      selectedFilter == "Today"
                                          ? "${_monthName(startDate!.month)} "
                                          "${startDate!.day.toString().padLeft(2, '0')}, "
                                          "${startDate!.year}"
                                          : "${_monthName(startDate!.month)} "
                                          "${startDate!.day.toString().padLeft(2, '0')} - "
                                          "${_monthName(endDate!.month)} "
                                          "${endDate!.day.toString().padLeft(2, '0')}, "
                                          "${endDate!.year}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                              GestureDetector(
                                onTap: _openDateTypeDialog,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _openFilter,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.tune,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(left: 15,right: 15,),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
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
                          size: 18,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Order Dashboard",
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
                        Expanded(
                          child: Container(
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
                                        color: (
                                            item["color"].shade50),
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
                          ),
                        );
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15),
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
                          size: 18,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Attendance Overview",
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
                          backgroundColor: Colors.red,
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
                              "Present:0.0%",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "Absent:100.0%",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "Half Day:0.0%",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "Paid Leave:0.0%",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ]
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,),
                    child: Text(
                      "Graph is based on 30 working days.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 30),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.shade600,
                          Colors.purple.shade500,
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
                          Icons.cake,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Birthday Alert",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30,bottom: 10),
                        child: Icon(
                          Icons.cake_outlined,
                          color: Colors.grey.shade400,
                          size: 40,
                        ),
                      ),
                      Text(
                        "No Upcoming Birthdays",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "No Birthdays to celebrate this month",
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 30),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade600,
                          Colors.yellow.shade700,
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
                          Icons.event_busy_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Upcoming Leave",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30,bottom: 10),
                        child: Icon(
                          Icons.event_available,
                          color: Colors.grey.shade400,
                          size: 40,
                        ),
                      ),
                      Text(
                        "No Leave Found",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "No Upcoming Leaves scheduled at the moment.",
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15,),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade900,
                          Colors.green.shade400
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
                          size: 18,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Attendance Fill-up Methods",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 15,right: 15,top: 30),
                          padding: EdgeInsets.all(35),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade300)
                          ),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300)
                            ),
                          )
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Entries:0",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.blue,
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.blue,
                                  size: 15,
                                ),
                                SizedBox(width: 5,),
                                Text("Lens App"),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text(
                                          "0(0%)",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.green,
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  Icons.person,
                                  color: Colors.green,
                                  size: 15,
                                ),
                                SizedBox(width: 5,),
                                Text("HR Entry"),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text(
                                          "0(0%)",
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.purple,
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  Icons.web,
                                  color: Colors.purple,
                                  size: 15,
                                ),
                                SizedBox(width: 5,),
                                Text("Web"),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text(
                                          "0(0%)",
                                          style: TextStyle(
                                            color: Colors.purple,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 15,top: 20,),
                        child: Text(
                          "Attendance Status",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10),
                          value: 0,
                          minHeight: 10,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.green,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  "On Time:0(0%)",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.red,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  "Late:0(0%)",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 15,left: 15),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.green.shade100
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    "On Time",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "0 entries",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    "0%",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 15,top: 15),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.red.shade100,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Late Entry",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "0 entries",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    "0%",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 50),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade900,
                          Colors.blue.shade300,
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
                          Icons.trending_up,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Yesterday's Attendance",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        StatusItem(
                            color: Colors.green,
                            label: "Present",
                            value: "0"
                        ),
                        StatusItem(
                            color: Colors.red,
                            label: "Absent",
                            value: "7",
                        ),
                        StatusItem(
                            color: Colors.orange,
                            label: "Half Day",
                            value: "0",
                        ),
                        StatusItem(
                            color: Colors.blue,
                            label: "Paid Leave",
                            value: "0",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Attendance Breakdown",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 12),
                        BreakdownItem(
                          label: "Present",
                          value: "0 (0.0%)",
                          color: Colors.green,
                        ),
                        BreakdownItem(
                          label: "Absent",
                          value: "7 (100.0%)",
                          color: Colors.red,
                          progress: 1.0,
                        ),
                        BreakdownItem(
                          label: "Half Day",
                          value: "0 (0.0%)",
                          color: Colors.orange,
                        ),
                        BreakdownItem(
                          label: "Paid Leave",
                          value: "0 (0.0%)",
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.blue.shade100,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Attendance Rate",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 18,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "0",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.percent,
                                size: 18,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        )
                      ],
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

class StatusItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const StatusItem({
    super.key,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: color,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }
}

class BreakdownItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final double progress;

  const BreakdownItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      label, style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                  ),
                  ),
                  Text(
                      value,
                      style: TextStyle(
                          color: color,
                      ),
                  ),
                ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(10),
                value: progress,
                color: color,
                backgroundColor: Colors.grey.shade200,
                minHeight: 8,
              ),
            ),
          ],
        ),
    );
  }
}


