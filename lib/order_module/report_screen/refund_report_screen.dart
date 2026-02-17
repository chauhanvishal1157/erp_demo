import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/app_color.dart';
import '../../common/common_action_button.dart';
import '../../common/common_app_bar.dart';
import '../../common/common_field.dart';

class RefundReport extends StatefulWidget {
  const RefundReport({super.key});

  @override
  State<RefundReport> createState() => _RefundReportState();
}

class _RefundReportState extends State<RefundReport> {

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
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
  void initState() {

    startDate = DateTime.now();
    endDate = DateTime.now();

    startDateController.text = formatter.format(startDate!);
    endDateController.text = formatter.format(endDate!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar:CommonAppBar(
        title: "Refund Report",
      ),
      body: Column(
        children: [
          CommonDateField(
            label:  "Start Date(From)",
            controller:startDateController,
            horizontalMargin: 15,
            onTap: () async {
              await _selectDate(context, true);

              if (startDate != null) {
                startDateController.text = formatter.format(startDate!);
              }
            },
          ),
          CommonDateField(
            label: "End Date(To)",
            controller: endDateController,
            onTap: () async {
              await _selectDate(context, true);

              if (endDate != null) {
                endDateController.text = formatter.format(endDate!);
              }
            },
            horizontalMargin: 15,
          ),
          CommonActionButton(
              title: "Download",
              icon: Icons.download,
              horizontalMargin: 15,
              onTap: (){}
          )
        ],
      ),
    );
  }
}
