import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erp_demo/dispatch_module/dispatch_screen/screen/dispatch_screen.dart';
import 'package:erp_demo/dispatch_module/home_screen/dispatch_home_screen.dart';
import 'package:erp_demo/dispatch_module/report_dispatch_screen/dispatch_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/app_color.dart';

class DispatchBottomNavigation extends StatefulWidget {
  const DispatchBottomNavigation({super.key});

  @override
  State<DispatchBottomNavigation> createState() => _DispatchBottomNavigationState();
}

class _DispatchBottomNavigationState extends State<DispatchBottomNavigation> {

  int _selectIndex = 0;

  final List<Widget> _screens = [
    DispatchHomeScreen(),
    DispatchScreen(),
    DispatchReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectIndex,
        children: _screens,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectIndex,
        height: 70,
        backgroundColor: AppColors.screenBg,
        color:   AppColors.bottomNavBg,
        buttonBackgroundColor: AppColors.primary,
        animationDuration:  Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        items: [
          _navItem(Icons.home_outlined, "Home"),
          _navItem(Icons.checklist, "Production"),
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