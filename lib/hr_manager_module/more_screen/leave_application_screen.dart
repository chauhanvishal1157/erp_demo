import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({super.key});

  @override
  State<LeaveApplication> createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication>
    with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Leave Management",
        showAdd: true,
        addIcon: Icons.tune_outlined,
        addIconColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
            child: Row(
              children: [
                Expanded(
                  child: leaveInfo(
                    Icons.account_balance_wallet,
                    Colors.blue,
                    "Upcoming Leave",
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: leaveInfo(
                    Icons.check_circle,
                    Colors.green,
                    "Approved",
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
            child: Row(
              children: [
                Expanded(
                  child: leaveInfo(
                    Icons.watch_later_outlined,
                    Colors.orange,
                    "Pending",
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: leaveInfo(
                    Icons.cancel,
                    Colors.red,
                    "Cancelled",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget leaveInfo(
      IconData icon,
      Color color,
      String title,
      ){
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


