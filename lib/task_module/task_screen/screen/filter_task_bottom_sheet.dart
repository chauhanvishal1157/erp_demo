import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/material.dart';

class FilterTaskBottomSheet extends StatefulWidget {
  const FilterTaskBottomSheet({super.key});

  @override
  State<FilterTaskBottomSheet> createState() => _FilterTaskBottomSheetState();
}

class _FilterTaskBottomSheetState extends State<FilterTaskBottomSheet> {

  bool isAllSelected = true;

  Map<String, bool> statusMap = {
    "Pending": false,
    "In Progress": false,
    "Rejected": false,
    "Completed": false,
    "Re-open": false,
    "Closed": false,
  };

  void onAllTap() {
    setState(() {
      isAllSelected = true;
      statusMap.updateAll((key, value) => false);
    });
  }

  void onStatusTap(String key) {
    setState(() {
      statusMap[key] = !(statusMap[key] ?? false);

      if (statusMap.containsValue(true)) {
        isAllSelected = false;
      }

      if (!statusMap.containsValue(true)) {
        isAllSelected = true;
      }
    });
  }

  int selectedCount() {
    if (isAllSelected) return 1;
    return statusMap.values.where((e) => e).length;
  }


  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
                icon:  Icons.filter_alt_outlined,
                title: "Filter Task",
                subtitle: "Select task statuses to filter",
              themeColor: Colors.black,
            ),
            SizedBox(height: 10,),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildChip(
                  title: "All",
                  isSelected: isAllSelected,
                  onTap: onAllTap,
                ),
                ...statusMap.keys.map((status) {
                  return _buildChip(
                    title: status,
                    isSelected: statusMap[status] ?? false,
                    onTap: () => onStatusTap(status),
                  );
                }).toList(),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    "${selectedCount()} statuses selected",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      setState(() {
                        isAllSelected = true;
                        statusMap.updateAll((key, value) => false);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            Icons.format_list_bulleted
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Clear All",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Apply Filters",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
  Widget _buildChip({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10
        ),
        decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.shade50
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? Colors.blue.shade100
                  : Colors.white,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 10,
                offset: Offset(2, 2),
              )
            ]
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Icon(
                  Icons.check_box,
                  size: 18,
                  color: AppColors.primary
              ),
            if (isSelected)
              SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppColors.primary
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
