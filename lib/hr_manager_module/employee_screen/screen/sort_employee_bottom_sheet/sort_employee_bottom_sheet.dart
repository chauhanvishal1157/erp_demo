import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';

class SortEmployeeBottomSheet extends StatefulWidget {
  const SortEmployeeBottomSheet({super.key});

  @override
  State<SortEmployeeBottomSheet> createState() => _SortEmployeeBottomSheetState();
}

class _SortEmployeeBottomSheetState extends State<SortEmployeeBottomSheet> {

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
                icon: Icons.tune_outlined,
                title:  "Sort Employee",
                subtitle:  "Filter employee with different filter option",
            ),
            Padding(
              padding:  EdgeInsets.only(top: 15,bottom: 5),
              child: Row(
                children: [
                  SizedBox(width: 5,),
                  Text(
                    "Sort by Name",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: _buildSortOption(
                    title: "A to Z",
                    subtitle: "Ascending order",
                    code: "AZ",
                    value: "asc",
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: _buildSortOption(
                    title: "Z to A",
                    subtitle: "Descending order",
                    code: "ZA",
                    value: "desc",
                  ),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:5,top: 15,),
              child: Row(
                children: [
                  SizedBox(width: 5,),
                  Text(
                    "Sort by Employee Code",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            _buildCodeOption(
              title: "Ascending Employee Code",
              subtitle: "Lowest to Highest code",
              value: "code_asc",
            ),
            SizedBox(height: 15,),
            _buildCodeOption(
              title: "Descending Employee Code",
              subtitle: "Highest to Lowest code",
              value: "code_desc",
            ),

           CommonActionButton(
               title: "Apply Filter",
               icon: Icons.check,
               onTap: (){},
           )

          ],
        ),
    );
  }
  Widget _buildSortOption({
    required String title,
    required String subtitle,
    required String code,
    required String value,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selectedCategory == value
              ? Colors.blue.shade50
              :Colors.grey.shade50,
          border: Border.all(
            color: selectedCategory == value
                ? Colors.blue
                : Colors.grey.shade400,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  code,
                  style: TextStyle(
                    color:  selectedCategory == value
                        ? Colors.blue
                        : Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    shape: const CircleBorder(),
                    side: const BorderSide(color: Colors.grey),
                    activeColor: AppColors.primary,
                    value: selectedCategory == value,
                    onChanged: (_) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Text(
              title,
              style:  TextStyle(
                color: selectedCategory == value
                    ? Colors.blue
                    :  Colors.black,
                  fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeOption({
    required String title,
    required String subtitle,
    required String value,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selectedCategory == value
              ? Colors.blue.shade50
              :Colors.grey.shade50,
          border: Border.all(
            color: selectedCategory == value
                ? Colors.blue
                : Colors.grey.shade400,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Icon(
                 Icons.arrow_upward,
                 color:  selectedCategory == value
                     ? Colors.blue
                     : Colors.grey,
             ),
             SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      title,
                      style: TextStyle(
                        color: selectedCategory == value
                            ? Colors.blue
                            : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                      ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                shape: const CircleBorder(),
                side: const BorderSide(color: Colors.grey),
                activeColor: AppColors.primary,
                value: selectedCategory == value,
                onChanged: (_) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
