import 'package:erp_demo/common/common_list_tile_screen.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/screens/lead_category_screen.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/screens/lead_sub_category_screen.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/screens/rejection_reason_screen.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/screens/visit_area_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';

import '../../../common/custom_app_bar.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  AppColors.screenBg,
        appBar:  CustomAppBar(
          leadingIcon: Icons.leaderboard_outlined,
          title:  "Lead Master",
          subtitle:  "Manage your lead efficiently",
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding:  EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  CommonListTile(
                      title:  "Lead Category",
                      subTitle:  "Manage lead categories",
                      icon: Icons.view_module_rounded,
                      color:Colors.blue,
                      onTap:  (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>LeadCategoryScreen(),
                        ),);
                      },
                  ),
                  CommonListTile(
                    title:  "Lead Sub Category",
                    subTitle:  "Manage lead sub categories",
                    icon: Icons.subdirectory_arrow_right,
                    color:  Colors.green,
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>LeadSubCategoryScreen(),
                      ),);
                    },
                  ),
                  CommonListTile(
                    title:  "Visit Area",
                    subTitle:  "Manage visit area",
                    icon:  Icons.location_on_outlined,
                    color:  Colors.orange,
                    onTap:(){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>VisitAreaScreen(),
                      ),);
                    },
                  ),
                  CommonListTile(
                    title: "Rejection Reason",
                    subTitle: "Manage rejection reason",
                    icon:  Icons.close_rounded,
                    color: Colors.red,
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>RejectionReasonScreen(),
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
                        "Configure your Lead Management settings",
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
  Widget report(
      String title,
      String subTitle,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ){
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: Offset(2, 2),
              )
            ]
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color:color,
                size: 22,
              ),
            ),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                color: color,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}