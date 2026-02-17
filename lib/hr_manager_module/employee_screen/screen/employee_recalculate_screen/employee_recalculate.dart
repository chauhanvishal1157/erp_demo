import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/app_color.dart';
import '../../../../common/common_field.dart';

class EmployeeRecalculate extends StatefulWidget {
  const EmployeeRecalculate({super.key});

  @override
  State<EmployeeRecalculate> createState() => _EmployeeRecalculateState();
}

class _EmployeeRecalculateState extends State<EmployeeRecalculate> {



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
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
                icon: Icons.tune_outlined,
                title: "Employees Recalculate Salary",
                subtitle:  "Recalculate employee salaries for selected date range",
            ),
            CommonDateField(
              label:  "Start Date(From)",
              controller:startDateController,
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
            ),
            CommonActionButton(
                title: "Recalculate",
                icon: Icons.check,
                onTap: (){},
            )
          ],
        )
    );




      Container(
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 15),
            child: Text(
              "Start date",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              _selectDate(context, true);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(left: 15,right: 15,top: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start Date(From)",
                        style: TextStyle(
                          color:AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        startDate == null
                            ? formatter.format(DateTime.now())
                            : formatter.format(startDate!),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color:Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      size: 18,
                      color:AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 15),
            child: Text(
              "End date",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              _selectDate(context, true);
            },
            child: Container(
             padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top: 5,left: 15,right: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End Date(To)",
                        style: TextStyle(
                          color:AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        endDate == null
                            ? formatter.format(DateTime.now())
                            : formatter.format(endDate!),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color:Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      size: 18,
                      color:AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 30),
              decoration: BoxDecoration(
                color:AppColors.action,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Recalculate",
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
    );
  }
}