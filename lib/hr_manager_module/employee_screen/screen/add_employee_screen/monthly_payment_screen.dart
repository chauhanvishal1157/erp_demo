import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:flutter/material.dart';

import '../../../../common/common_app_bar.dart';
import '../../../../common/app_color.dart';

class MonthlyPayment extends StatefulWidget {
  const MonthlyPayment({super.key});

  @override
  State<MonthlyPayment> createState() => _MonthlyPaymentState();
}

class _MonthlyPaymentState extends State<MonthlyPayment> {

  DateTime? selectedDate;
  final TextEditingController paymentCycleController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        paymentCycleController.text = _formatDate(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
    paymentCycleController.text = _formatDate(selectedDate!);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar:CommonAppBar(
          title: "Add Employee"
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    "Employee Detail",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    "Payment Type",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color:AppColors.primary,
                    ),
                  ),
                  Text(
                    "Salary Payment",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color:AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
              child: LinearProgressIndicator(
                value: 0.85,
                color: AppColors.primary,
                backgroundColor: Colors.grey[300],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.5)
                    ]
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Employee Salary Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Set up amount and payment cycle",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CommonDateField(
                label: "Payment Cycle",
                horizontalMargin: 15,
                controller: paymentCycleController,
                onTap: _pickDate
            ),
            CommonTextField(
                controller: salaryController,
                horizontalMargin: 15,
                label: "Monthly Salary",
                keyboardType: TextInputType.number,
                hint: "Enter monthly salary amount",
              prefixIcon: Icons.currency_rupee,
            ),
            CommonActionButton(
                title: "Create Employee",
                horizontalMargin: 15,
                icon: Icons.person_add,
                onTap: (){},
            )
          ],
        ),
      ),
    );
  }
}
