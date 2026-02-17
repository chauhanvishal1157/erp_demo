import 'package:flutter/material.dart';
import 'app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final bool showBack;
  final VoidCallback? onBackTap;
  final bool showAdd;
  final VoidCallback? onAddTap;
  final IconData? addIcon;

  /// ID Badge (NEW)
  final bool showIdBadge;
  final String? idText;

  final Color? addIconColor;

  final IconData? firstActionIcon;
  final VoidCallback? onFirstActionTap;
  final Color? firstActionColor;
  final bool showFirstAction;

  final IconData? secondActionIcon;
  final VoidCallback? onSecondActionTap;
  final Color? secondActionColor;
  final bool showSecondAction;


  const CommonAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBackTap,
    this.showAdd = false,

    this.onAddTap,
    this.addIcon,

    /// ID badge
    this.showIdBadge = false,
    this.idText,

    this.addIconColor,

    this.firstActionIcon,
    this.onFirstActionTap,
    this.firstActionColor,
    this.showFirstAction = false,

    this.showSecondAction = false,
    this.secondActionIcon,
    this.onSecondActionTap,
    this.secondActionColor,

  });

  @override
  Size get preferredSize =>  Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      leading: showBack
          ? InkWell(
            onTap: onBackTap ?? () => Navigator.pop(context),
            child:Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.arrow,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ) : null,
      title: Text(
        title,
        style:  TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (showFirstAction)
          InkWell(
            onTap: onFirstActionTap,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                firstActionIcon,
                size: 20,
                color: firstActionColor ?? Colors.black,
              ),
            ),
          ),

        /// SECOND CUSTOM ACTION
        if (showSecondAction)
          InkWell(
            onTap: onSecondActionTap,
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                secondActionIcon,
                size: 20,
                color: secondActionColor ?? Colors.black,
              ),
            ),
          ),

        if (showIdBadge && idText != null)
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              idText!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        if (showAdd)
          InkWell(
            onTap: onAddTap,
            child:  Container(
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                addIcon ?? Icons.add,
                color: addIconColor ?? Colors.black,
                size: 20,
              ),
            ),
          ),
      ],
    );
  }
}


