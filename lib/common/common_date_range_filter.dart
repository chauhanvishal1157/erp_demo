import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonDateRangeFilter extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onStartDateTap;
  final VoidCallback onEndDateTap;
  final VoidCallback? onApply;

  const CommonDateRangeFilter({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onStartDateTap,
    required this.onEndDateTap,
    this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy');

    return Container(
      margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
      decoration: CommonDecorations.card(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.4),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "Filter by Date Range",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
            child: Row(
              children: [
                Expanded(
                  child: _dateBox(
                    text: formatter.format(startDate),
                    onTap: onStartDateTap,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.compare_arrows_outlined,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _dateBox(
                    text: formatter.format(endDate),
                    onTap: onEndDateTap,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onApply ?? () {},
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.action,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.filter_list_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Apply Filter",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
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
  static Widget _dateBox({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: 8,horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(
              color: Colors.grey.shade300
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
