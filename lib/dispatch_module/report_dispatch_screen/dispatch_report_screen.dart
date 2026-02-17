import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/app_color.dart';
import '../../common/common_action_button.dart';
import '../../common/common_drop_down.dart';
import '../../common/common_field.dart';
import '../../common/custom_app_bar.dart';

class DispatchReportScreen extends StatefulWidget {
  const DispatchReportScreen({super.key});

  @override
  State<DispatchReportScreen> createState() => _DispatchReportScreenState();
}

class _DispatchReportScreenState extends State<DispatchReportScreen> {

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String? orderStatusValue;

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

    orderStatusValue = 'All';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CustomAppBar(
        leadingIcon: Icons.receipt_outlined,
        title: "Report",
        subtitle: "Dispatch reports",
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
          CommonDropdown(
            label: "Order Status",
            value: orderStatusValue,
            horizontalMargin: 15,
            items: [
              'All',
              'Order Dispatched',
              'Order Completed',
              'Return Order',
              'Cancel Order',
            ],
            onChanged: (val) {
              setState(() => orderStatusValue = val);
            },
          ),
          CommonActionButton(
              icon: Icons.download_outlined,
              horizontalMargin: 15,
              title: "Download",
              onTap: (){}
          )
        ],
      ),
    );
  }
}
