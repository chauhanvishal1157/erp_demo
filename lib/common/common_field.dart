import 'package:erp_demo/common/common_decoration.dart';
import 'package:flutter/material.dart';
import 'app_color.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool showHeader;
  final IconData? headerIcon;
  final String? headerText;
  final int? maxLines;
  final String? prefixText;
  final String? suffixText;
  final TextInputType? keyboardType;
  final bool suffixIconBoxed;
  final bool prefixIconBoxed;
  final String? Function(String?)? validator;
  final double horizontalMargin;


  const CommonTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.showHeader = false,
    this.headerIcon,
    this.headerText,
    this.maxLines,
    this.prefixText,
    this.suffixText,
    this.keyboardType,
    this.suffixIconBoxed = true,
    this.prefixIconBoxed = true,
    this.validator,
    this.horizontalMargin = 0,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showHeader && headerText != null)
          Padding(
            padding:  EdgeInsets.only(
              left: horizontalMargin,
              right: horizontalMargin,
              top: 15,
            ),
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
          padding: prefixIcon == null
              ? const EdgeInsets.only(left: 10)
              : EdgeInsets.zero,
          margin: EdgeInsets.only(
            left: horizontalMargin,
            right: horizontalMargin,
            top: showHeader ? 5 : 15,
          ),
          decoration: CommonDecorations.card(),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            validator: validator,
            showCursor: !readOnly,
            cursorColor: AppColors.primary,
            keyboardType: keyboardType ?? TextInputType.text,
            maxLines: maxLines ?? 1,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
              fontSize: 12
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: label,
              hintText: hint,
              prefixText: prefixText,
              suffixText: suffixText,
              labelStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                // fontWeight: FontWeight.w600,
              ),
              hintStyle: const TextStyle(
                fontSize: 12,
                // fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
              prefixStyle:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
              prefixIcon: prefixIcon == null
                  ? null
                  : prefixIconBoxed
                  ? Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Icon(
                    prefixIcon,
                    size: 18,
                    color: AppColors.primary
                ),
              )
                  : Icon(
                prefixIcon,
                size: 16,
                color: Colors.black26,
              ),
              suffixIcon: suffixIcon == null
                  ? null
                  : suffixIconBoxed
                  ? Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  suffixIcon,
                  size: 18,
                  color: AppColors.primary,
                ),
              )
                  : Icon(
                suffixIcon,
                size: 16,
                color: Colors.black26,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonStatusDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final bool showHeader;
  final IconData? headerIcon;
  final String? headerText;

  const CommonStatusDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.showHeader = false,
    this.headerIcon,
    this.headerText,
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
            top: showHeader ? 5 : 15,
          ),
          decoration: CommonDecorations.card(),
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            icon: const SizedBox.shrink(),
            decoration: InputDecoration(
              labelText: "Status",
              hintText: "Select Status",
              labelStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              hintStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black26,
              ),
              border: InputBorder.none,
              prefixIcon: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.toggle_on_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            items: const ["Active", "Inactive"].map((e) {
              return DropdownMenuItem(
                value: e,
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: e == "Active"
                            ? Colors.green
                            : Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      e,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) onChanged(val);
            },
          ),
        ),
      ],
    );
  }
}

class CommonDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;
  final IconData? suffixIcon;
  final bool readOnly;
  final bool enabled;
  final String? Function(String?)? validator;
  final double horizontalMargin;

  const CommonDateField({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
    this.suffixIcon,
    this.readOnly = true,
    this.enabled = true,
    this.validator,
    this.horizontalMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(
        left: horizontalMargin,
        right: horizontalMargin,
        top: 15,
      ),
      decoration: CommonDecorations.card(),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        enabled: enabled,
        onTap: onTap,

        validator: validator,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        decoration: InputDecoration(
          isDense: false,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              suffixIcon ?? Icons.calendar_today,
              size: 20,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}




