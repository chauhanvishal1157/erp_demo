import 'package:flutter/material.dart';
import 'app_color.dart';

class CommonActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData? icon;
  final double horizontalMargin;


  const CommonActionButton({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.horizontalMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(13),
        margin: EdgeInsets.only(
          left: horizontalMargin,
          right: horizontalMargin,
          top: 15,
          bottom: 25
        ),
        decoration: BoxDecoration(
          color: AppColors.action,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
