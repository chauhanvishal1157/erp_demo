import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erp_demo/task_module/home_screen/home_task_screen.dart';
import 'package:erp_demo/task_module/report_screen/screen/report_task_screen.dart';
import 'package:erp_demo/task_module/task_screen/screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/app_color.dart';

class TaskBottomNavigation extends StatefulWidget {
  const TaskBottomNavigation({super.key});

  @override
  State<TaskBottomNavigation> createState() => _TaskBottomNavigationState();
}

class _TaskBottomNavigationState extends State<TaskBottomNavigation> {

  int _selectIndex = 0;

  final List<Widget> _screens = const [
   HomeTaskScreen(),
    TaskScreen(),
    ReportTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body:  IndexedStack(
        index: _selectIndex,
        children: _screens,
      ),

      bottomNavigationBar: CurvedNavigationBar(
        index: _selectIndex,
        height: 70,
        backgroundColor: AppColors.screenBg,
        color:  AppColors.bottomNavBg,
        buttonBackgroundColor: AppColors.primary,
        animationDuration:  Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        items: [
          _navItem(Icons.home_outlined, "Home"),
          _navItem(Icons.checklist, "Task"),
          _navItem(Icons.person_outline, "Report"),
        ],

        onTap: (index) {
          HapticFeedback.lightImpact();
          setState(() {
            _selectIndex = index;
          });
        },
      ),
    );
  }
  Widget _navItem(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24,

          color: Colors.white,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,

            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

