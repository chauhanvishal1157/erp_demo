import 'package:erp_demo/common/common_decoration.dart';
import 'package:flutter/material.dart';
import 'app_color.dart';

class CommonDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double horizontalMargin;
  final bool showHeader;
  final IconData? headerIcon;
  final String? headerText;
  final String? hint;



  const CommonDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
   required this.value,
    this.horizontalMargin = 0,
    this.showHeader = false,
    this.headerIcon,
    this.headerText,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showHeader && headerText != null)
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                if (headerIcon != null)
                  Icon(
                    headerIcon,
                    color: AppColors.primary,
                    size: 16,
                  ),
                if (headerIcon != null)
                  const SizedBox(width: 5),
                Text(
                  headerText!,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        Container(
          margin: EdgeInsets.only(
            left: horizontalMargin,
            right: horizontalMargin,
            top: showHeader ? 5 : 15,
          ),
          padding: EdgeInsets.only(left: 10),
          decoration: CommonDecorations.card(),
          child: DropdownButtonFormField<String>(
            value: value,
            icon: const SizedBox.shrink(),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black12,
              ),
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.grey,
              ),
            ),
            items: items
                .map(
                  (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12
                  ),
                ),
              ),
            )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
