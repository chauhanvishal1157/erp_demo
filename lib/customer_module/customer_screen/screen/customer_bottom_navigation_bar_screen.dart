import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erp_demo/customer_module/customer_screen/screen/customer_screen.dart';
import 'package:erp_demo/customer_module/payment_history/customer_payment_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_color.dart';

class CustomerBottomNavigationBarScreen extends StatefulWidget {
  const CustomerBottomNavigationBarScreen({super.key});

  @override
  State<CustomerBottomNavigationBarScreen> createState() => _CustomerBottomNavigationBarScreenState();
}

class _CustomerBottomNavigationBarScreenState extends State<CustomerBottomNavigationBarScreen> {

  int _selectIndex = 0;

  final List<Widget> _screens = [
    CustomerScreen(),
    CustomerPaymentHistoryScreen(),
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
          _navItem(Icons.person_2_outlined, "Customer"),
          _navItem(Icons.currency_rupee_outlined, "Payment History"),
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