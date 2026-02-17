import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erp_demo/hr_manager_module/attendance_screen/attendance_screen.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/internal_screen/employee_screen.dart';
import 'package:erp_demo/hr_manager_module/home_screen/home_screen.dart';
import 'package:erp_demo/hr_manager_module/salary_screen/salary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/app_color.dart';
import '../more_screen/more_screen.dart';

class HrBottomNavigation extends StatefulWidget {
  const HrBottomNavigation({super.key});

  @override
  State<HrBottomNavigation> createState() => _HrBottomNavigationState();
}

class _HrBottomNavigationState extends State<HrBottomNavigation> {

  int _selectIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    EmployeeScreen(),
    AttendanceScreen(),
    SalaryScreen(),
    MoreScreen(),
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
          _navItem(Icons.person_outline, "Employee"),
          _navItem(Icons.checklist, "Attendance"),
          _navItem(Icons.payment, "Salary"),
          _navItem(Icons.person_3_rounded, "More"),
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
