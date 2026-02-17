import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({super.key});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {

  TextEditingController checkInController = TextEditingController();

  TimeOfDay? selectedTime;


  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        checkInController.text = formatTime(picked); // 🔥 IMPORTANT LINE
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
                icon: Icons.update,
                title: "Check In",
                subtitle: "Fill in the details to Check In Time",
            ),

            CommonTextField(
                controller: checkInController,
                label:  "Select check in time",
                readOnly: true,
                suffixIconBoxed: false,
                suffixIcon: Icons.arrow_forward_ios,
                onTap: _pickTime,
                hint: "Not selected",
            ),

            CommonActionButton(
                title:  "Check In",
                onTap:  () {
                  if (selectedTime != null) {
                    Navigator.pop(context, formatTime(selectedTime!));

                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please select time first",
                        ),
                      ),
                    );
                  }
                },
            ),
          ],
        )
    );
  }
}
