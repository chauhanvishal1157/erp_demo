import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/employee_screen/working_shift/screens/salary_update_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/common_decoration.dart';
import '../../../../common/common_field.dart';


class CreateEditWorkingShiftScreen extends StatefulWidget {
  const CreateEditWorkingShiftScreen({super.key});

  @override
  State<CreateEditWorkingShiftScreen> createState() => _CreateEditWorkingShiftScreenState();
}

class _CreateEditWorkingShiftScreenState extends State<CreateEditWorkingShiftScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class CreateEditWorkingShiftScreenWidget extends StatefulWidget {
  const CreateEditWorkingShiftScreenWidget({super.key});

  @override
  State<CreateEditWorkingShiftScreenWidget> createState() => _CreateEditWorkingShiftScreenWidgetState();
}

class _CreateEditWorkingShiftScreenWidgetState extends State<CreateEditWorkingShiftScreenWidget> {

  TextEditingController shiftNameController = TextEditingController();
  TextEditingController shiftCodeController = TextEditingController();
  TextEditingController hoursController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController breakTimeController = TextEditingController();
  TextEditingController breakOverTimeController = TextEditingController();
  TextEditingController minimumOverTimeController = TextEditingController();
  TextEditingController variationOverTimeController = TextEditingController();

  String shiftType = 'Day';
  String salaryType = '1.00✕Salary';
  String weekSalaryType = '1.00✕Salary';
  String? selectedOvertimeOption;
  String status = 'Active';

  String? startTime;
  String? endTime;
  String? breakTime;
  String? breakOverTime;
  String? minimumOverTime;
  String? variationOverTime;

  bool isSwitchCheckIn = true;
  bool isSwitchOverTime = false;
  bool isSwitchAutoBreak = true;

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  Future<String?> pickTime(BuildContext context) async {
    final TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      return formatTime(picked);
    }
    return null;
  }

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
                  color:AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Done",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
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

  String? selectedSalaryOption;
  int? selectedSalaryIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(title: "Create Working Shift"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: CommonDecorations.card(),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Basic Information",
                          style: TextStyle(
                              color:AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),

                        CommonTextField(
                            controller:  shiftNameController,
                            label:  "Shift Name",
                            hint: "Enter Shift Name",
                        ),
                        CommonTextField(
                          controller:  shiftCodeController,
                          label:  "Shift Code",
                          hint:  "Enter shift code",
                        ),
                        buildDropdown(
                          "Select Status",
                          shiftType,
                          ['Day', 'Night'],
                          onChanged: (val) {
                            if (val != null) setState(() => shiftType = val);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:15),
                    padding: EdgeInsets.all(15),
                    decoration: CommonDecorations.card(),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time Settings",
                          style: TextStyle(
                              color:AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextField(
                                controller: startTimeController,
                                label: "start Time",
                                hint: "select start time",
                                readOnly: true,
                                onTap: () async {
                                  String? picked = await pickTime(context);
                                  if (picked != null) {
                                    setState(() {
                                      startTimeController.text = picked;
                                      startTime = picked;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CommonTextField(
                                controller: endTimeController,
                                label: "End Time",
                                hint: "select end time",
                                readOnly: true,
                                onTap:  () async {
                                  String? picked = await pickTime(context);
                                  if (picked != null) {
                                    setState(() {
                                      endTimeController.text = picked;
                                      endTime = picked;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        CommonTextField(
                            controller: breakTimeController,
                            label: "Break Time",
                            hint: "select Break Duration",
                          readOnly: true,
                          onTap: ()async{
                            String? picked = await showTimePickerBottomSheet(
                              context,
                              initial: breakTime != null
                                  ? breakTime!.replaceAll(RegExp('[^0-9:]'), '')
                                  : "00:00",
                            );
                            if (picked != null) {
                              setState(() {
                                breakTimeController.text = picked;
                                breakTime = picked;
                              });
                            }
                          },
                        ),
                        CommonTextField(
                            controller:  hoursController,
                            label: "Hours for Half Day",
                            hint:  "Enter half day hours",
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(15),
                    decoration: CommonDecorations.card(),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Settings",
                          style: TextStyle(
                              color:AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        toggle(
                          "Early Check-In",
                          "Allow employee to check in early",
                          switchValue: isSwitchCheckIn,
                          onChanged: (val) {
                            setState(() {
                              isSwitchCheckIn = val;
                            });
                          },
                        ),
                        toggle(
                          "Overtime Type",
                          "Enable OverTime Calculate",
                          switchValue: isSwitchOverTime,
                          onChanged: (val) {
                            setState(() {
                              isSwitchOverTime = val;
                            });
                          },
                        ),
                        toggle(
                          "Auto Break",
                          "Allow auto break calculate",
                          switchValue: isSwitchAutoBreak,
                          onChanged: (val) {
                            setState(() {
                              isSwitchAutoBreak = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  if (isSwitchOverTime)...[
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(15),
                      decoration: CommonDecorations.card(),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "OverTime Settings",
                            style: TextStyle(
                                color:AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.all(10),
                            decoration: CommonDecorations.card(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "OverTime starts:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                overTimeSelect(
                                  "Right after shift end time",
                                ),
                                overTimeSelect(
                                  "After working hours completion",
                                ),
                              ],
                            ),
                          ),
                          buildDropdown(
                            "OverTime Salary Type",
                            salaryType,
                            ['1.00✕Salary','1.50✕Salary','2.00✕Salary','Other'],
                            onChanged: (val){
                              if (val != null) setState(() => salaryType = val);
                            },
                          ),

                          CommonTextField(
                              controller: breakOverTimeController,
                              label: "Break Time For Overtime",
                              hint: "Set the time for your overtime break",
                            readOnly: true,
                            onTap: ()async{
                              String? picked = await showTimePickerBottomSheet(
                                context,
                                initial: breakOverTime != null
                                    ? breakOverTime!.replaceAll(RegExp('[^0-9:]'), '')
                                    : "00:00",
                              );
                              if (picked != null) {
                                setState(() {
                                  breakOverTimeController.text = picked;
                                  breakOverTime = picked;
                                });
                              }
                            },
                          ),
                          CommonTextField(
                            controller: minimumOverTimeController,
                            label: "Minimum Overtime for Break Eligibility",
                            hint: "Select minimum overtime duration time",
                            readOnly: true,
                            onTap: ()async{
                              String? picked = await showTimePickerBottomSheet(
                                context,
                                initial: breakOverTime != null
                                    ? breakOverTime!.replaceAll(RegExp('[^0-9:]'), '')
                                    : "00:00",
                              );
                              if (picked != null) {
                                setState(() {
                                  minimumOverTimeController.text = picked;
                                  breakOverTime = picked;
                                });
                              }
                            },
                          ),
                          CommonTextField(
                            controller: variationOverTimeController,
                            label:  "Overtime Variation Time",
                            hint: "Select variation time",
                            readOnly: true,
                            onTap: ()async{
                              String? picked = await showTimePickerBottomSheet(
                                context,
                                initial: breakOverTime != null
                                    ? breakOverTime!.replaceAll(RegExp('[^0-9:]'), '')
                                    : "00:00",
                              );
                              if (picked != null) {
                                setState(() {
                                  variationOverTimeController.text = picked;
                                  breakOverTime = picked;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(15),
                    decoration: CommonDecorations.card(),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WeekOff/Festival Settings",
                          style: TextStyle(
                              color:AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        buildDropdown(
                          "WeekOff/Festival Salary Type",
                          weekSalaryType,
                          ['1.00✕Salary','1.50✕Salary','2.00✕Salary','Other'],
                          onChanged: (val){
                            if (val != null) setState(() => weekSalaryType = val);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(15),
                    decoration: CommonDecorations.card(),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Salary Calculation",
                          style: TextStyle(
                              color:AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        salaryCalculation(
                          Icons.grid_on_rounded,
                          "30 Days Every Month",
                          "Fixed 30 days calculation",
                          "February - 30 days,March - 30 days",
                          0,
                        ),
                        salaryCalculation(
                          Icons.calendar_today_outlined,
                          "Calendar Month",
                          "Actual Calendar days",
                          "February - 28 days,March - 31 days",
                          1,
                        ),
                        salaryCalculation(
                          Icons.work_outline,
                          "Exclude Week-offs",
                          "Working days only",
                          "28 days with 4 week-offs = 24 working days",
                          2,
                        )

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 100),
                    padding: EdgeInsets.all(15),
                    decoration: CommonDecorations.card(),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                              color:AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),

                        CommonStatusDropdown(
                            value: status,
                            onChanged: (val){
                              setState(() {
                                status = val;
                              });
                            }
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:  Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
              decoration: BoxDecoration(
                  color: AppColors.screenBg
              ),
              child: GestureDetector(
                onTap: () {
                  if (shiftNameController.text.trim().isEmpty || shiftCodeController.text.trim().isEmpty) {
                    return;
                  }
                  Navigator.pop(context, {
                    'name': shiftNameController.text.trim(),
                    'code': shiftCodeController.text.trim(),
                    'status': status,
                    'startTime': startTime,
                    'endTime': endTime,
                  });
                },
                child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:  AppColors.action,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          "Create Working shift",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ),
        ],
      )

    );
  }
  Widget textFormField(
      String title,
      String subtitle,
      TextEditingController controller,
      ){
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: TextFormField(
        style: TextStyle(
            fontWeight: FontWeight.w500
        ),
        controller: controller,
        cursorColor:AppColors.primary,
        decoration: InputDecoration(
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText:title,
          labelStyle: TextStyle(
            color:AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          hintText:subtitle,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(
      String label,
      String value,
      List<String> items,
      {required ValueChanged<String?> onChanged}
      ) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding:  EdgeInsets.symmetric(horizontal: 10,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        icon: const SizedBox.shrink(),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle:  TextStyle(
            color:AppColors.primary,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          suffixIcon: Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: Colors.black26,
          ),
        ),
        onChanged:onChanged,
        items: items.map((e) => DropdownMenuItem(
          value: e,
          child: Row(
            children: [
              Text(
                e,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget toggle(
      String title,
      String subtitle,{
        required bool switchValue,
        required ValueChanged<bool> onChanged,
      }
      ){
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  subtitle,
                  style: TextStyle(
                      color:Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),
          ),
          Icon(
            Icons.error_outline_sharp,
            color:AppColors.primary,
            size: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Transform.scale(
              scale: 0.8,
              child: Switch(
                  activeTrackColor:AppColors.primary,
                  inactiveThumbColor: Colors.white,
                  splashRadius: 20,
                  value: switchValue,
                  onChanged: onChanged
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget overTimeSelect(
      String title
      ){
    bool isSelected = (selectedOvertimeOption == title);
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedOvertimeOption = title; // user selects this option
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.shade50
              : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected
                ?AppColors.primary
                : Colors.black12,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ?AppColors.primary : Colors.black54,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:AppColors.primary,
                  ),
                ),
              )
                  : null,
            ),
            SizedBox(width: 10,),
            Text(
              title,
              style: TextStyle(
                  fontSize: 13,
                  color: isSelected
                      ?AppColors.primary
                      : Colors.black,
                  fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget salaryCalculation(
      IconData icon,
      String title,
      String subtitle,
      String subtitle2,
      int index,
      ){
    bool isSelected = (selectedSalaryIndex == index);
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => Padding(
            padding:  EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Wrap(
              children: [
                SalaryUpdate(
                  onConfirm: (String selected) {
                    // 👇 update selected option
                    setState(() {
                      selectedSalaryOption = selected;
                      selectedSalaryIndex = index;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.shade50
              : Colors.grey.shade50,
          border: Border.all(
            color: isSelected
                ?AppColors.primary
              : Colors.grey.shade50,),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:  isSelected
                    ? Colors.blue.shade50
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color:  isSelected
                    ?AppColors.primary
                    : Colors.grey,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ?AppColors.primary
                          : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    decoration: BoxDecoration(
                      color:  isSelected
                          ? Colors.blue.shade50
                          : Colors.grey.shade200,
                      border: Border.all(
                        color:  isSelected
                            ? Colors.blue.shade200
                          : Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      subtitle2,
                      style: TextStyle(
                        color:  isSelected
                            ?AppColors.primary
                            : Colors.black45,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
             height: 20,
             width: 20,
             margin: EdgeInsets.only(left: 10),
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               color:  isSelected
                   ?AppColors.primary
                   : Colors.white,
               border: Border.all( color:  isSelected
                   ?AppColors.primary
                   : Colors.black26,width: 2 )
             ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
