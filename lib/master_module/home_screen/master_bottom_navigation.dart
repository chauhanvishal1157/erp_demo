import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erp_demo/master_module/admin_screen/internal_screen/admin_master_screen.dart';
import 'package:erp_demo/master_module/employee_screen/internal_screens/employee_master_screen.dart';
import 'package:erp_demo/master_module/lead_screen/internal_screen/lead_master_screen.dart';
import 'package:erp_demo/master_module/product_screen/internal_screen/screens/product_master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/app_color.dart';
import 'home_master_screen.dart';

class MasterBottomNavigation extends StatefulWidget {
  const MasterBottomNavigation({super.key});

  @override
  State<MasterBottomNavigation> createState() => _MasterBottomNavigationState();
}

class _MasterBottomNavigationState extends State<MasterBottomNavigation> {

  int _selectIndex = 0;

  final List<Widget> _screens = const [
    HomeMasterScreen(),
    AdminScreen(),
    ProductMasterScreen(),
    EmployeeMasterScreen(),
    LeadScreen(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.screenBg,
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
          _navItem(Icons.person_outline, "Admin"),
          _navItem(Icons.add_box_outlined, "Product"),
          _navItem(Icons.groups_outlined, "Employee"),
          _navItem(Icons.checklist, "Lead"),
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
