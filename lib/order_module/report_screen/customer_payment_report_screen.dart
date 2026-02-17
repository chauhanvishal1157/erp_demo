import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/order_module/report_screen/select_customer_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/common_action_button.dart';

class CustomerPaymentReport extends StatefulWidget {
  const CustomerPaymentReport({super.key});

  @override
  State<CustomerPaymentReport> createState() => _CustomerPaymentReportState();
}

class _CustomerPaymentReportState extends State<CustomerPaymentReport> {

  TextEditingController selectCustomer = TextEditingController();
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
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Customer Payment History Report"
      ),
      body: Column(
        children: [
          CommonTextField(
              controller: selectCustomer,
              label: "Select Customer",
              hint: "Enter Customer Name..",
            suffixIconBoxed: false,
            suffixIcon: Icons.arrow_forward_ios,
            readOnly: true,
            horizontalMargin: 15,
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectCustomerReport(),
                ),
              ).then((value) {
                selectCustomer.text = value[0];
                setState(() {});
              },);
            },
          ),
          if(selectCustomer.text.isNotEmpty) ...[
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
                horizontalMargin: 15,
                icon: Icons.download,
                onTap: (){}
            )
          ]
        ],
      ),
    );
  }
}
