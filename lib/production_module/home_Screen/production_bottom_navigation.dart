import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erp_demo/production_module/home_Screen/production_home_screen.dart';
import 'package:erp_demo/production_module/production_screen/screen/production_screen.dart';
import 'package:erp_demo/production_module/report_screen/production_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/app_color.dart';

class ProductionBottomNavigation extends StatefulWidget {
  const ProductionBottomNavigation({super.key});

  @override
  State<ProductionBottomNavigation> createState() => _ProductionBottomNavigationState();
}

class _ProductionBottomNavigationState extends State<ProductionBottomNavigation> {

  int _selectIndex = 0;

  final List<Widget> _screens = [
    ProductionHomeScreen(),
    ProductionScreen(),
    ProductionReportScreen(),
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
        color:  AppColors.bottomNavBg,
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
