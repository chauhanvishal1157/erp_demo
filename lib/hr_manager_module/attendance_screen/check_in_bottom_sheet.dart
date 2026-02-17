import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckInBottomSheet extends StatefulWidget {
  final int index;
  final String status;
  final Color color;
  final Function(int, String, Color, String) onCheckInComplete;

  const CheckInBottomSheet({
    super.key,
    required this.index,
    required this.status,
    required this.color,
    required this.onCheckInComplete,
  });

  @override
  State<CheckInBottomSheet> createState() => _CheckInBottomSheetState();
}

class _CheckInBottomSheetState extends State<CheckInBottomSheet> {

  TextEditingController checkInController = TextEditingController();

  String selectedType = "Current";
  TimeOfDay? customTime;
  bool isSwitch = false;
  String gValue = '';
  String currentTime = DateFormat("h:mma").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.status == "Present" || widget.status == "Half Day") ...[
              CommonBottomSheetHeader(
                  icon: Icons.update,
                  title: "Check In",
                  subtitle: "Select check in time"
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = "Current";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: selectedType == "Current"
                              ? Colors.white
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Current",
                          style: TextStyle(
                            color: selectedType == "Current"
                                ? AppColors.primary
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = "Custom";
                        });
                      },
                      child: Container(
                        padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: selectedType == "Custom"
                              ? Colors.white
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Custom",
                          style: TextStyle(
                            color: selectedType == "Custom"
                                ? AppColors.primary
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (selectedType == "Current") ...[
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: double.infinity,
                  padding:  EdgeInsets.all(10),
                 decoration: CommonDecorations.card(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "By selecting current type"
                            " check in time will be",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        DateFormat("h:mma").format(DateTime.now()),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ]
              else ...[
                CommonTextField(
                    controller: checkInController,
                    suffixIconBoxed: false,
                    suffixIcon: Icons.arrow_forward_ios,
                    label: "Select Check In Time:",
                    hint: "Pick Time",
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          customTime = picked;
                          checkInController.text = picked.format(context);
                        });
                      }
                    },
                ),
              ],
              CommonActionButton(
                  title:  "Check In",
                  onTap:  () {
                    String selectedTime = selectedType == "Current"
                        ? currentTime
                        : (customTime?.format(context) ?? currentTime);

                    widget.onCheckInComplete(
                        widget.index, widget.status, widget.color, selectedTime);

                    Navigator.pop(context);
                  },
              ),
            ]
            else if (widget.status == "Leave") ...[

              CommonBottomSheetContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonBottomSheetHeader(
                          icon:  Icons.sticky_note_2_outlined,
                          title:  "Leave Status",
                          subtitle:  "Please select the types of leave"
                              " to proceed with approval",
                      )
                    ],
                  )
              ),
              leaveOptionTile(
                value: 'Paid Leave',
                title: 'Paid Leave',
                subtitle: 'Employee will receive full salary',
                activeColor: Colors.blue,
                icon: Icons.payments_outlined,
                groupValue: gValue,
                onChanged: (val) {
                  setState(() {
                    gValue = val;
                  });
                },
              ),

              leaveOptionTile(
                value: 'Unpaid Leave',
                title: 'Unpaid Leave',
                subtitle: 'No salary will be provided',
                activeColor: Colors.purple,
                icon: Icons.currency_exchange_outlined,
                groupValue: gValue,
                onChanged: (val) {
                  setState(() {
                    gValue = val;
                  });
                },
              ),

              CommonActionButton(
                  title: "Save Changes",
                  icon: Icons.check_circle_outline,
                  onTap: () {
                    String selectedLeave = gValue;
                    Color leaveColor = gValue == 'Paid Leave' ? Colors.blue : Colors.purple;
                    widget.onCheckInComplete(
                      widget.index,
                      selectedLeave,
                      leaveColor,
                      '',
                    );

                    Navigator.pop(context);
                  },
              ),
            ]
          ],
        )
    );
  }
  Widget leaveOptionTile({
    required String value,
    required String title,
    required String subtitle,
    required Color activeColor,
    required IconData icon,
    required String groupValue,
    required ValueChanged<String> onChanged,
  }) {
    final bool isSelected = groupValue == value;

    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withValues(alpha: 0.2)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? activeColor.withValues(alpha: 0.6)
                : Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected
                    ? activeColor.withValues(alpha: 0.3)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? activeColor : Colors.black45,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? activeColor : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              activeColor: activeColor,
              value: value,
              groupValue: groupValue,
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ],
        ),
      ),
    );
  }

}
