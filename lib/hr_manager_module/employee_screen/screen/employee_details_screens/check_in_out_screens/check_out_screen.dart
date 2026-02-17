import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../common/common_action_button.dart';
import '../../../../../common/common_field.dart';
import '../../../../../common/create_edit_screen.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  TextEditingController checkOutController = TextEditingController();
  TextEditingController selectDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
    selectDateController.text =
        DateFormat('dd/MM/yyyy').format(selectedDate!);
  }


  TimeOfDay? selectedTime;
  DateTime? selectedDate;

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
        checkOutController.text = formatTime(picked);
      });
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectDateController.text =
            DateFormat('dd/MM/yyyy').format(picked);
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
              title: "Check Out",
              subtitle: "Fill in the details to Check Out Time",
            ),
            CommonDateField(
                label: "Selected Date",
                controller: selectDateController,
                onTap: () => _pickDate(),
            ),
            CommonTextField(
              controller: checkOutController,
              label:  "Select check in time",
              readOnly: true,
              suffixIconBoxed: false,
              suffixIcon: Icons.arrow_forward_ios,
              onTap: _pickTime,
              hint: "Not selected",
            ),

            CommonActionButton(
              title:  "Check Out",
              onTap:  () {
                if (selectedTime != null) {
                  Navigator.pop(context, formatTime(selectedTime!));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
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

