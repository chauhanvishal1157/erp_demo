import 'package:flutter/material.dart';
import 'app_color.dart';

class CommonBottomSheetContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CommonBottomSheetContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(15),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: padding,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: child,
      ),
    );
  }
}

class CommonBottomSheetHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onClose;
  final Color themeColor;

  const CommonBottomSheetHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onClose,
    this.themeColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: onClose ?? () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.close_sharp,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}

class CommonBottomActionButtons extends StatelessWidget {
  final VoidCallback onTap;
  final String submitText;
  final IconData submitIcon;
  final double horizontalMargin;


  const CommonBottomActionButtons({
    super.key,
    required this.onTap,
    required this.submitText,
    required this.submitIcon,
    this.horizontalMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
          top: 15,
        bottom: 15,
        left: horizontalMargin,
        right: horizontalMargin,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric( vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.action,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      submitIcon,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      submitText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


