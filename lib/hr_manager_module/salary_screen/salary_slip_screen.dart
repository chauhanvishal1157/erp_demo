import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/month_salary_calculation/month_salary_calculation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalarySlip extends StatefulWidget {
  const SalarySlip({super.key});

  @override
  State<SalarySlip> createState() => _SalarySlipState();
}

class _SalarySlipState extends State<SalarySlip> {

  TextEditingController startMonthController = TextEditingController();
  TextEditingController endMonthController = TextEditingController();

  DateTime? startMonth;
  DateTime? endMonth;

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (startMonth ?? DateTime.now()) : (endMonth ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        String formatted = DateFormat("MMMM yyyy").format(picked);
        if (isStart) {
          startMonth = picked;
          startMonthController.text = formatted;
        } else {
          endMonth = picked;
          endMonthController.text = formatted;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final DateTime now = DateTime.now();
    final String formatted = DateFormat("MMMM yyyy").format(now);

    startMonth = now;
    endMonth = now;

    startMonthController.text = formatted;
    endMonthController.text = formatted;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CustomAppBar(
          leadingIcon:  Icons.payments_outlined,
          title: "Salary",
          subtitle: "Month Pay Details",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonDateField(
              label: "Start Month (From)",
              horizontalMargin: 15,
              controller: startMonthController,
              onTap: () => _pickDate(context, true),
            ),
            CommonDateField(
              label: "End Month (To)",
              horizontalMargin: 15,
              controller: endMonthController,
              onTap: () => _pickDate(context, false),
            ),
            MonthSalaryDetails(
              label: "January,2025",
              value: "0.00",
            ),
            MonthSalaryDetails(
              label: "February,2025",
              value: "0.00",
            ),
            MonthSalaryDetails(
              label: "March,2025",
              value: "0.00",
            ),
            MonthSalaryDetails(
              label: "April,2025",
              value: "0.00",
            ),
            MonthSalaryDetails(
              label: "May,2025",
              value: "18,401.00",
            ),
            MonthSalaryDetails(
              label: "june,2025",
              value: "0.00",
            ),
            MonthSalaryDetails(
              label: "july,2025",
              value: "14,496.00",
            ),
            MonthSalaryDetails(
              label: "August,2025",
              value: "0.00",
            ),
            MonthSalaryDetails(
              label: "September,2025",
              value: "0.00",
            )
          ],
        ),
      ),
    );
  }
}




class MonthSalaryDetails extends StatelessWidget {

  final String label;
  final String value;

  const MonthSalaryDetails({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(
            builder: (context)=>MonthSalaryCalculation(),
        ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 15,left: 15,right: 15),
        padding: EdgeInsets.all(15),
        decoration: CommonDecorations.card(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.calendar_month_outlined,
                size: 20,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.currency_rupee,
                  size: 16,
                ),
                Text(
                 value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(width: 5,),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
