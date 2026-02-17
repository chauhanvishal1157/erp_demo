import 'package:erp_demo/common/common_list_tile_screen.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:erp_demo/master_module/admin_screen/branch/screens/branch_master_screen.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/screens/customer_level_screen.dart';
import 'package:erp_demo/master_module/admin_screen/employee_funds/employee_funds_screen.dart';
import 'package:erp_demo/master_module/admin_screen/lead_status/screens/lead_status_screen.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/screens/order_status_screen.dart';
import 'package:erp_demo/master_module/admin_screen/sales_reports/sales_report_screen.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/screens/terms_conditions_screen.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/screens/vendor_level_screen.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CustomAppBar(
          leadingIcon: Icons.admin_panel_settings_outlined,
          title:  "Admin Master",
          subtitle:  "Administration Panel",
        showAdd: true,
        showAction1: true,
        showAction2: true,
        actionIcon1: Icons.error,
        actionIcon2: Icons.notifications,
        addIcon: Icons.person,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 70,bottom: 30),
            child: Column(
              children: [
                CommonListTile(
                    title:  "Branch",
                    subTitle: "Manage branch locations and details",
                    icon:  Icons.business,
                    color: Colors.blue,
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=> BranchMasterScreen(),
                      ),);
                    },
                ),
                CommonListTile(
                   title: "Customer Level",
                   subTitle:  "Configure customer level settings",
                   icon: Icons.group_outlined,
                   color:  Colors.green,
                   onTap: (){
                     Navigator.push(
                       context, MaterialPageRoute(
                       builder: (context)=>CustomerLevelScreen(),
                     ),);
                   },
               ),
                CommonListTile(
                    title:"Vendor Level",
                    subTitle:  "Manage vendor level configurations",
                    icon: Icons.store_outlined,
                    color:  Colors.orange,
                    onTap:  (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>VendorLevelScreen(),
                      ),);
                    },
                ),
                CommonListTile(
                    title: "Order Status",
                    subTitle: "Configure order status options",
                    icon: Icons.assignment_outlined,
                    color: Colors.purple,
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>OrderStatusScreen(),
                      ),);
                    },
                ),
                CommonListTile(
                    title: "Lead Status",
                    subTitle:  "Manage lead status configurations",
                    icon: Icons.track_changes,
                    color:Colors.red,
                    onTap:(){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>LeadStatusScreen(),
                      ),);
                    },
                ),
                CommonListTile(
                    title:  "Terms And Conditions",
                    subTitle: "Update terms and conditions",
                    icon:  Icons.sticky_note_2_outlined,
                    color: Colors.deepPurple.shade600,
                    onTap:(){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>TermsConditionsScreen(),
                      ),);
                    },
                ),
                CommonListTile(
                    title:  "Employee Daily Sales Reports",
                    subTitle: "View employee daily sales report",
                    icon:  Icons.assessment_outlined,
                    color:  Colors.greenAccent.shade700,
                    onTap:  (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>SalesReport(),
                      ),);
                    },
                ),
                CommonListTile(
                    title:  "Employee Funds",
                    subTitle:  "Manage employee funds and payment",
                    icon:  Icons.account_balance_wallet_outlined,
                    color:  Colors.brown,
                    onTap:(){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>EmployeeFunds(),
                      ),);
                    },
                ),
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.screenBg,
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Configure your system setting and manage"
                          " administrative functions.",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black54
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primary,
                            Colors.cyan,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}
