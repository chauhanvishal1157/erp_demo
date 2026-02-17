import 'dart:async';

import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/check_in_out_screens/edit_attendance_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';

class CheckInOut extends StatefulWidget {
  const CheckInOut({super.key});

  @override
  State<CheckInOut> createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {

  TextEditingController dateController = TextEditingController();


  Future<void> pickDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text =
      "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    }
  }
  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  bool isWorking = false;
  Duration workingDuration = Duration.zero;
  Duration? checkOutDuration;
  Timer? timer;

  void startTimer() {
    setState(() {
      isWorking = true;
      workingDuration = Duration.zero;
      checkOutDuration = null;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        workingDuration = Duration(seconds: workingDuration.inSeconds + 1);
      });
    });
  }

  void stopTimer() {
    setState(() {
      isWorking = false;
      checkOutDuration = workingDuration;
    });
    timer?.cancel();
  }


  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // 👉 ADD THIS (DEFAULT CURRENT DATE)
    DateTime now = DateTime.now();

    dateController.text =
    "${now.day.toString().padLeft(2, '0')}/"
        "${now.month.toString().padLeft(2, '0')}/"
        "${now.year}";
  }



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
                Navigator.pop(context);
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
                  "Check In/Out",
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
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>EditAttendance()
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 5,),
                  Text("Edit Attendance")
                ],
              )
            ),
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonDateField(
                label: "Selected Date",
                horizontalMargin: 15,
                controller: dateController,
                onTap: ()=> pickDate(context, dateController),
            ),
            Container(
                margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                padding: EdgeInsets.all(13),
                decoration: CommonDecorations.card(),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      "Vishal",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8,right: 8,top: 3,bottom: 3),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.badge_sharp,
                          color: AppColors.primary,
                          size: 14,
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "#ts5",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 15,right: 15,top: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.5),
                    AppColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Live Working Time",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        isWorking
                            ? formatDuration(workingDuration)
                            : checkOutDuration != null
                            ? formatDuration(checkOutDuration!)
                            : formatDuration(workingDuration),
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        decoration: BoxDecoration(
                          color: AppColors.arrow,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "Real-time tracking",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if (isWorking) {
                            stopTimer();
                          } else {
                            startTimer();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isWorking ? Colors.red : Colors.green,
                                ),
                                child: Icon(
                                  Icons.logout_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text(
                               isWorking ? "Check Out" : "Check In",
                                style: TextStyle(
                                    color:isWorking ? Colors.red : Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
        
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                Icon(
                  Icons.history,
                  color:AppColors.primary,
                ),
                  SizedBox(width: 5,),
                  Text(
                    "Last Breaks",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "sep17,2025",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "16min",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 15,right: 10,top: 15,bottom:15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.green.shade100),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login,
                                color: Colors.green,
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Check In",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "06:27 AM",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "17/09/2025",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.phone_android,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Mobile",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
        
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,right: 15,top: 15,bottom:15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.red.shade100),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login,
                                color: Colors.red,
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Check Out",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "06:27 AM",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "17/09/2025",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.phone_android,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Mobile",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
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
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
              padding: EdgeInsets.all(10),
              decoration: CommonDecorations.card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Today's Summary",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Summary(
                      icon: Icons.watch_later_outlined,
                      title: "Working Shift",
                      subtitle: "Regular(10:00AM - 7:00PM)",
                      color:AppColors.primary
                  ),
                  Summary(
                    icon: Icons.work_outline,
                    title: "Total Working Time",
                    subtitle: "1 hr 29 min",
                    color:AppColors.primary,
                  ),
                  Summary(
                    icon: Icons.timer_outlined,
                    title: "Shift Hours",
                    subtitle: "9 hr 0 min",
                    color: AppColors.primary,
                  ),
                  Summary(
                    icon: Icons.watch_later_outlined,
                    title: "Shift Working Hours",
                    subtitle: "8 hr 0 min",
                    color:AppColors.primary,
                  ),
                  Summary(
                    icon: Icons.watch_later_outlined,
                    title: "OverTime",
                    subtitle: "0 hr 0 min",
                    color: AppColors.primary,
                  ),
                  Summary(
                    icon: Icons.stop_circle_outlined,
                    title: "Break Time",
                    subtitle: "0 hr 0 min",
                    color: AppColors.primary,
                  ),
                  Summary(
                    icon: Icons.coffee,
                    title: "Allowed Break Time",
                    subtitle: "1 hr",
                    subtitleColor: Colors.orange,
                    color: Colors.orange,
                  ),
                  Summary(
                    icon: Icons.nearby_error,
                    title: "Remaining Time",
                    subtitle: "6 hr 31 min",
                    subtitleColor: Colors.red,
                    color: Colors.red,
                  ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
              padding: EdgeInsets.all(15),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.mark_chat_read_outlined,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          "Remarks",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                         borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade300,
                              blurRadius: 4,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child:Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.note_add,
                              color: Colors.grey,
                              size: 30,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "No Remarks added yet",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Add remarks about your",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "work or important",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "information",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Summary extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? subtitleColor;
  final Color color;

  const Summary({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.subtitleColor,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: color,
          ),
        ),
         SizedBox(width: 10,),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           Text(
             title,
             style: TextStyle(
               color: Colors.grey,
               fontSize: 14,
               fontWeight: FontWeight.w600,
             ),
           ),
           Text(
             subtitle,
             style: TextStyle(
               fontSize: 16,
               color: subtitleColor,
               fontWeight: FontWeight.w700,
             ),
           ),
           ],
         ),
        ],
      ),
    );
  }
}

