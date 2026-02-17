import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erp_demo/order_module/payment_screen/payment_screen.dart';
import 'package:erp_demo/order_module/report_screen/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/app_color.dart';
import 'order_dashboard_screen.dart';
import '../order_screen/screen/order_list_screen.dart';

class OrderBottomNavigation extends StatefulWidget {
  const OrderBottomNavigation({super.key});

  @override
  State<OrderBottomNavigation> createState() => _OrderBottomNavigationState();
}

class _OrderBottomNavigationState extends State<OrderBottomNavigation> {

  int _selectIndex = 0;

  final List<Widget> _screens = [
    OrderDashboardScreen(),
    OrderListScreen(),
    PaymentList(),
    ReportScreen(),
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
        color:  AppColors.bottomNavBg,
        buttonBackgroundColor: AppColors.primary,
        animationDuration:  Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        items: [
          _navItem(Icons.home_outlined, "Home"),
          _navItem(Icons.checklist, "Orders"),
          _navItem(Icons.currency_rupee, "Payments"),
          _navItem(Icons.person_outline, "Reports"),
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
