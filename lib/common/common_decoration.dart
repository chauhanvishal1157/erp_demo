import 'package:flutter/material.dart';

class CommonDecorations {
  static BoxDecoration card({
    Color bgColor = Colors.white,
    double radius = 12,
    Color? borderColor,
    Color? shadowColor,
  }) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor ?? Colors.grey.shade200,
      ),
      boxShadow: [
        BoxShadow(
          color: shadowColor ?? Colors.grey.shade200,
          blurRadius: 4,
          offset: const Offset(1, 1),
        ),
      ],
    );
  }
}
