import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';

class SalaryUpdate extends StatefulWidget {
  final Function(String selectedOption)? onConfirm;
  const SalaryUpdate({super.key, this.onConfirm});

  @override
  State<SalaryUpdate> createState() => _SalaryUpdateState();
}

class _SalaryUpdateState extends State<SalaryUpdate> {

  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:15,bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.note_alt_outlined,
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirm Salary Update",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Choose the period for salary calculation changes",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: Icon(
                    Icons.close_sharp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          salaryCalculation(
              Icons.calendar_today,
              "Current Month only",
              "Apply changes to oct only",
              "oct",
             "current",
             Colors.blue,
          ),
          salaryCalculation(
            Icons.calendar_month_rounded,
            "Previous Month to Current Date",
            "Apply changes previous month to current date",
            "Sep to 15-oct",
            "previous",
            Colors.green,
          ),
          Divider(
            color: Colors.black12,
            thickness: 1,
          ),
          Padding(
            padding:  EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black38
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (selectedOption != null) {
                        widget.onConfirm?.call(selectedOption!); // ⬅️ send result
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color:AppColors.action,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.action,
                            blurRadius: 4,
                            offset: Offset(1, 1),
                          )
                        ]
                      ),
                      child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            size: 18,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            "Confirm",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget salaryCalculation(
      IconData icon,
      String title,
      String subtitle,
      String subtitle2,
      String id,
      Color color,
      ){
    bool isSelected = (selectedOption == id);
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedOption = id;
        });
      },
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.3)
              : Colors.grey.shade50,
          border: Border.all(
            color: isSelected
              ? color.withValues(alpha: 0.8)
              : Colors.grey.shade300,),
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
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.2)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? color.withValues(alpha: 0.5)
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
                          ? color.withValues(alpha: 0.8)
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
                      color: isSelected
                          ? color.withValues(alpha: 0.2)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      subtitle2,
                      style: TextStyle(
                        color: isSelected
                            ? color.withValues(alpha: 0.8)
                            : Colors.black45,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                activeColor: color,
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedOption = id; // ⬅️ select current
                    } else {
                      selectedOption = null; // ⬅️ unselect if tapped again
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
