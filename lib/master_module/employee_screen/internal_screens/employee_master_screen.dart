import 'package:erp_demo/common/common_list_tile_screen.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:erp_demo/master_module/employee_screen/working_shift/screens/working_shift_employee_screen.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/screens/employee_category_screen.dart';
import 'package:erp_demo/master_module/employee_screen/module/module_employee_screen.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class EmployeeMasterScreen extends StatefulWidget {
  const EmployeeMasterScreen({super.key});

  @override
  State<EmployeeMasterScreen> createState() => _EmployeeMasterScreenState();
}

class _EmployeeMasterScreenState extends State<EmployeeMasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.screenBg,
        appBar: CustomAppBar(
            leadingIcon: Icons.badge_outlined,
            title:  "Employee Master",
            subtitle:  "Manage your workforce",
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding:  EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  CommonListTile(
                      title:  "Module",
                      subTitle:"Manage system modules and permissions",
                      icon: Icons.view_module_rounded,
                      color:  Colors.green,
                      onTap:  (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>ModuleEmployeeScreen(),
                        ),);
                      },
                  ),
                  CommonListTile(
                      title:  "Employee Category",
                      subTitle: "Organize employee by category",
                      icon: Icons.group,
                      color:  Colors.blue,
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>EmployeeCategoryScreen(),
                        ),);
                      },
                  ),
                  CommonListTile(
                      title: "Working Shift",
                      subTitle: "Configure working shift and schedule",
                      icon:  Icons.watch_later_outlined,
                      color:  Colors.orange,
                      onTap:  (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>WorkingShiftEmployeeScreen(),
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
                        "Configure your Employee settings",
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
