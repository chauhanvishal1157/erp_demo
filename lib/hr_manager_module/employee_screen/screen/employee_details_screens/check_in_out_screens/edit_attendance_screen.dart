import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/check_in_out_screens/check_in_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/check_in_out_screens/check_out_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/add_employee_screen/working_shift_list_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditAttendance extends StatefulWidget {
  const EditAttendance({super.key});

  @override
  State<EditAttendance> createState() => _EditAttendanceState();
}

class _EditAttendanceState extends State<EditAttendance> {

  String selectedStatus = "Present";
  List<String> selectedShiftNames = [];

  late TextEditingController dateController;
  final TextEditingController shiftController = TextEditingController();
  final TextEditingController checkInController = TextEditingController();
  final TextEditingController checkOutController = TextEditingController();



  @override
  void initState() {
    super.initState();

    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dateController = TextEditingController(text: currentDate);
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  String? checkInTime;
  String? checkOutTime;
  String? workingHours;
  String? breakTime;

  Future<String?> showTimePickerBottomSheet(
      BuildContext context, {
        String initial = "00:00",
      }) async {
    Duration selectedDuration = Duration(
      hours: int.tryParse(initial.split(":")[0]) ?? 0,
      minutes: int.tryParse(initial.split(":")[1]) ?? 0,
    );
    return await showModalBottomSheet<String>(
      context: context,
      builder: (context) => Container(
        height: 300,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: selectedDuration,
                onTimerDurationChanged: (Duration newDuration) {
                  selectedDuration = newDuration;
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context,
                    "${selectedDuration.inHours
                        .toString().padLeft(2,'0')}:"
                        "${(selectedDuration.inMinutes % 60)
                        .toString().padLeft(2,'0')}");
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade500,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Done",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar:CommonAppBar(
          title: "Edit Attendance",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildStatusButton(
                    "Absent",
                    Colors.red,
                  ),
                  buildStatusButton(
                    "Present",
                    Colors.green,
                  ),
                  buildStatusButton(
                    "Half Day",
                    Colors.orange,
                  ),
                  buildStatusButton(
                    "Leave",
                    AppColors.primary,
                  ),
                ],
              ),
            ),
            if (selectedStatus == "Absent" || selectedStatus == "Leave")...[
              datePicker(),
              regularShiftInfo(),
            ],
            if (selectedStatus == "Present" || selectedStatus == "Half Day")...[
              attendanceInfo(),
              regularShiftInfo()
            ],
           CommonActionButton(
               title: "Update Attendance",
               horizontalMargin: 15,
               onTap: (){},
           )
          ],
        ),
      ),
    );
  }

  Widget buildStatusButton(String text,
      Color color,) {
    final isSelected = selectedStatus == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? color
              : Colors.grey.shade200,
          border: Border.all(
            color: isSelected
                ? color
                : Colors.grey.shade300,),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? color.withValues(alpha: 0.6)
                  : Colors.grey.shade50,
              blurRadius: 8,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget regularShiftInfo() {
    return Container(
      margin: EdgeInsets.fromLTRB(15,15,15,0),
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:Colors.blue.shade100,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.error_outline_sharp,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Regular Shift Information",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          _infoRow(
            Icons.work_outline,
            "Shift Name",
            "Regular",
            Icons.code,
            "Shift Code",
            "-",
            AppColors.primary,
            AppColors.primary,

          ),
          _infoRow(
            Icons.category_outlined,
            "Shift Type",
            "Day",
            Icons.access_time,
            "Hours for Half Day",
            "4:30",
            AppColors.primary,
            AppColors.primary,
          ),
          _infoRow(
            Icons.watch_later_outlined,
            "Start Time",
            "10:00 AM",
            Icons.watch_later_outlined,
            "End Time",
            "07:00 PM",
            Colors.green,
            Colors.orange,
          ),
          _infoRow(
            Icons.coffee,
            "Break Time",
            "1:00",
            Icons.calculate_outlined,
            "Attendance Decision Time",
            "9:00",
            Colors.brown,
            AppColors.primary,
          ),
          _infoRow(
            Icons.settings_outlined,
            "Over Time Setting",
            "After Working Hours completion",
            Icons.local_cafe,
            "Break Time for Overtime",
            "1:00",
            AppColors.primary,
            Colors.yellow,
          ),
          _infoRow(
            Icons.timer,
            "Minimum Overtime for Break Eligibility",
            "5:00",
            Icons.timelapse,
            "Overtime Variation Time",
            "0:20",
            Colors.red,
            Colors.purple,
          ),

        ],
      ),
    );
  }

  Widget datePicker() {
    return CommonDateField(
        label: "Attendance Date",
        horizontalMargin: 15,
        controller: dateController,
        onTap: (){},
    );

  }

  Widget attendanceInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade100,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.error_outline_sharp,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Attendance Information",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          datePicker(),
          CommonTextField(
              controller: shiftController,
              label: "shift Time",
              readOnly: true,
              horizontalMargin: 15,
              hint: "Tap to add shift time..",
              suffixIconBoxed: false,
              suffixIcon: Icons.arrow_forward_ios,
             onTap: () async {
              final result = await Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => WorkingShiftListScreen(),
              ),
              );
              if (result != null && result is List<String>) {
                setState(() {
                  selectedShiftNames = result;
                });
              }
            },
          ),
          Padding(
            padding:  EdgeInsets.fromLTRB(15,15,15,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _infoTile2(
                      "Check in Time",
                    checkInTime ?? "Enter Check In...",
                    () async {
                        final result = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: false,
                          builder: (context) {
                            return  CheckIn();
                          },
                        );
                        if (result != null && mounted) {
                          setState(() {
                            checkInTime = result; // save selected time
                          });
                        }
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: _infoTile2(
                    "Check Out Time",
                     checkOutTime ?? "Select check Out..",
                        () async {
                      final result = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: false,
                        builder: (context) {
                          return CheckOut();
                        },
                      );
                      if (result != null && mounted && result is String) {
                        setState(() {
                          checkOutTime = result;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
            child: Row(
              children: [
                Expanded(
                  child: _infoTile2(
                    "Working Hours",
                    workingHours ?? "Enter Working..",
                        () async {
                      final result = await showTimePickerBottomSheet(
                          context, initial: workingHours ?? "00:00");
                      if (result != null) setState(() => workingHours = result);
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: _infoTile2(
                    "Regular Break Time",
                    breakTime ?? "Enter Regular..",
                        () async {
                      final result = await showTimePickerBottomSheet(
                          context, initial: breakTime ?? "00:00");
                      if (result != null) setState(() => breakTime = result);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData leftIcon,
      String leftTitle,
      String leftValue,
      IconData rightIcon,
      String rightTitle,
      String rightValue,
      Color color,
      Color color1,) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 5),
      child: Row(
        children: [
          Expanded(
            child: _infoTile(
                leftIcon,
                leftTitle,
                leftValue,
                color
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _infoTile1(
              rightIcon,
              rightTitle,
              rightValue,
              color1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon,
      String title,
      String value,
      Color color,) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: color,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoTile1(IconData icon,
      String title,
      String value,
      Color color1,) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color1.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: color1,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoTile2(
      String title,
      String value,
      VoidCallback onTap,
      ) {
    final bool isSelected = value.isNotEmpty
        && value != "Enter Check In..."
        && value != "Enter Working.."
        && value != "Enter Regular.."
        && value != "Select check Out..";
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: CommonDecorations.card(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.black
                    : Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}







