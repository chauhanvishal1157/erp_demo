import 'package:flutter/material.dart';
import 'app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;

  /// Actions visibility
  final bool showAction1;
  final bool showAction2;
  final bool showAdd;

  /// Action icons
  final IconData actionIcon1;
  final IconData actionIcon2;
  final IconData addIcon;

  /// Callbacks
  final VoidCallback? onAction1Tap;
  final VoidCallback? onAction2Tap;
  final VoidCallback? onAddTap;

  /// Icons color

  final Color? leadingIconColor;
  final Color? actionIcon1Color;
  final Color? actionIcon2Color;
  final Color? addIconColor;


  const CustomAppBar({
    super.key,

    /// Title
    required this.leadingIcon,
    required this.title,
    required this.subtitle,

    /// Optional actions (ALL optional now)
    this.showAction1 = false,
    this.showAction2 = false,
    this.showAdd = false,

    /// Default icons
    this.actionIcon1 = Icons.search,
    this.actionIcon2 = Icons.error_outline,
    this.addIcon = Icons.add,

    /// Callbacks
    this.onAction1Tap,
    this.onAction2Tap,
    this.onAddTap,

    /// Icon colors (optional)
    this.leadingIconColor,
    this.actionIcon1Color,
    this.actionIcon2Color,
    this.addIconColor,


  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),

      /// TITLE AREA
      title: Row(
        children: [

          _iconContainer(
            icon: leadingIcon,
            iconColor: leadingIconColor ?? AppColors.primary,
            bgColor: Colors.white,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),

      /// ACTIONS
      actions: [
        if (showAction1)
          _actionButton(
            icon: actionIcon1,
            iconColor: actionIcon1Color ?? Colors.black,
            onTap: onAction1Tap,
          ),

        if (showAction2)
          _actionButton(
            icon: actionIcon2,
            iconColor: actionIcon2Color ?? Colors.black,
            onTap: onAction2Tap,
          ),

        if (showAdd)
          _actionButton(
            icon: addIcon,
            iconColor: addIconColor ?? Colors.black,
            margin: const EdgeInsets.only(right: 15, left: 5),
            onTap: onAddTap,
          ),
      ],
    );
  }

  /// Action Button UI
  Widget _actionButton({
    required IconData icon,
    EdgeInsets margin = const EdgeInsets.all(5),
    VoidCallback? onTap,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
      ),
    );
  }

  /// Leading Icon
  Widget _iconContainer({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        icon,
        size: 20,
        color: iconColor,
      ),
    );
  }
}
