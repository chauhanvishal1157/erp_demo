import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erp_demo/lead_module/calls_screen/lead_call_screen.dart';
import 'package:erp_demo/lead_module/home_screen/lead_home_screen.dart';
import 'package:erp_demo/lead_module/lead_screen/screen/lead_screen.dart';
import 'package:erp_demo/lead_module/report_screen/lead_report_screen.dart';
import 'package:erp_demo/lead_module/visits_screen/lead_visit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/app_color.dart';

class LeadBottomNavigationBar extends StatefulWidget {
  const LeadBottomNavigationBar({super.key});

  @override
  State<LeadBottomNavigationBar> createState() => _LeadBottomNavigationBarState();
}

class _LeadBottomNavigationBarState extends State<LeadBottomNavigationBar> {

  int _selectIndex = 0;

  final List<Widget> _screens = [
    LeadHomeScreen(),
    LeadScreen(),
    LeadVisitScreen(),
    LeadCallScreen(),
    LeadReportScreen()
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
          _navItem(Icons.checklist, "Lead"),
          _navItem(Icons.location_on_outlined, "Visits"),
          _navItem(Icons.call_outlined, "Call"),
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