import 'package:flutter/material.dart';
import '../common/app_color.dart';

class CommonHomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      automaticallyImplyLeading: false,
      centerTitle: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),

      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.grid_view,
          color: Colors.white,
          size: 30,
        ),
      ),

      title: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.arrow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
            "https://tse4.mm.bing.net/th/id/OIP.CqunqDLPWaM0-tQSM653yQHaE8?pid=Api&P=0&h=180",
          ),
        ),
      ),

      actions: [
        _actionIcon(Icons.notifications),
        _actionIcon(Icons.person_2_sharp, marginRight: 15),
      ],
    );
  }

  static Widget _actionIcon(IconData icon, {double marginRight = 0}) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(right: marginRight, left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        icon,
        size: 20,
        color: Colors.black,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // ✅ NORMAL
}

