import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/customer_module/customer_screen/screen/customer_bottom_navigation_bar_screen.dart';
import 'package:erp_demo/dispatch_module/home_screen/dispatch_bottom_navigation.dart';
import 'package:erp_demo/hr_manager_module/home_screen/hr_bottom_navigation.dart';
import 'package:erp_demo/lead_module/home_screen/lead_bottom_navigation_bar.dart';
import 'package:erp_demo/order_module/screens/order_bottom_navigation.dart';
import 'package:erp_demo/product_module/screen/product_list_screen.dart';
import 'package:erp_demo/production_module/home_Screen/production_bottom_navigation.dart';
import 'package:erp_demo/task_module/home_screen/task_bottom_navigation.dart';
import 'package:erp_demo/vendor_module/internal_screen/vendor_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../common/common_decoration.dart';
import '../login/login_screen.dart';
import '../master_module/home_screen/master_bottom_navigation.dart';

class ModuleScreen extends StatefulWidget {
  const ModuleScreen({super.key});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {



  final List<Map<String, String>> actions = const [
    {"icon": "asset/module/master.png", "title": "Master"},
    {"icon": "asset/module/task.png", "title": "Task"},
    {"icon": "asset/module/hr.png", "title": "HR Manager"},
    {"icon": "asset/module/customer.png", "title": "Customer"},
    {"icon": "asset/module/vendor.png", "title": "Vendor"},
    {"icon": "asset/module/product.png", "title": "Product"},
    {"icon": "asset/module/lead.png", "title": "Lead"},
    {"icon": "asset/module/order.png", "title": "Orders"},
    {"icon": "asset/module/production.png", "title": "Production"},
    {"icon": "asset/module/dispatch.png", "title": "Dispatch"},
    {"icon": "asset/module/inventory.png", "title": "Inventory"},
    {"icon": "asset/module/purchase.png", "title": "Purchase"},
    {"icon": "asset/module/reminders.png", "title": "Reminder"},
    {"icon": "asset/module/setting.png", "title": "Setting"},
    {"icon": "asset/module/file.png", "title": "File"},
    {"icon": "asset/module/notes.png", "title": "Notes"},
    {"icon": "asset/module/notification.png", "title": "Notification"},
    {"icon": "asset/module/support.png", "title": "Support"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      body:Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 200,bottom: 20),
                  itemCount: actions.length,
                  shrinkWrap: true,
                  physics:  NeverScrollableScrollPhysics(),
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (actions[index]["title"] == "HR Manager") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HrBottomNavigation(),
                                ),
                              );
                            } else if(actions[index]["title"] == "Orders"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderBottomNavigation(),
                                ),
                              );
                            } else if(actions[index]["title"] == "Master"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MasterBottomNavigation(),
                                ),
                              );
                            }else if(actions[index]["title"] == "Task"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskBottomNavigation(),
                                ),
                              );
                            }else if(actions[index]["title"] == "Production"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductionBottomNavigation(),
                                ),
                              );
                            }else if(actions[index]["title"] == "Dispatch"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DispatchBottomNavigation(),
                                ),
                              );
                            }else if(actions[index]["title"] == "Lead"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LeadBottomNavigationBar(),
                                ),
                              );
                            }else if(actions[index]["title"] == "Customer"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerBottomNavigationBarScreen(),
                                ),
                              );
                            }
                            else if(actions[index]["title"] == "Product"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductListScreen(),
                                ),
                              );
                            }
                            else if(actions[index]["title"] == "Vendor"){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VendorBottomNavigationBar(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: CommonDecorations.card(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Image.asset(
                                    actions[index]["icon"]!,
                                    fit: BoxFit.contain,
                                    height: 40,width: 40,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  actions[index]["title"]!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF6FAFF),
                ),
                child:  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Module",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow:  [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.mic_none,
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow:  [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.qr_code_scanner,
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow:  [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.brightness_2_rounded,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow:  [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.power_settings_new,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.handshake_rounded,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Welcome back,Vish Chauhan!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
