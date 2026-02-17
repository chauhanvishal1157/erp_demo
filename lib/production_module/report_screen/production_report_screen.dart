import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/common_action_button.dart';
import '../../common/common_drop_down.dart';
import '../../common/common_field.dart';

class ProductionReportScreen extends StatefulWidget {
  const ProductionReportScreen({super.key});

  @override
  State<ProductionReportScreen> createState() => _ProductionReportScreenState();
}

class _ProductionReportScreenState extends State<ProductionReportScreen> {

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String? stockStatusValue;
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

    stockStatusValue = 'All';
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
          subtitle: "Production reports",
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
            label: "Stock Status",
            value: stockStatusValue,
            horizontalMargin: 15,
            items: [
              'All',
              'Out Of Stock',
              'In Stock',
            ],
            onChanged: (val) {
              setState(() => stockStatusValue = val);
            },
          ),
          CommonDropdown(
            label: "Order Status",
            value: orderStatusValue,
            horizontalMargin: 15,
            items: [
              'All',
              'Production',
              'Dispatch',
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
