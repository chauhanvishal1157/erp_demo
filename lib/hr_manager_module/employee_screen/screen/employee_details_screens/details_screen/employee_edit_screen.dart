import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/hr_manager_module/employee_screen/screen/employee_details_screens/details_screen/employee_update_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';

class EmployeeEditScreen extends StatefulWidget {
  const EmployeeEditScreen({super.key});

  @override
  State<EmployeeEditScreen> createState() => _EmployeeEditScreenState();
}

class _EmployeeEditScreenState extends State<EmployeeEditScreen> {

  final List<Map<String, dynamic>> items = const [
    {
      "icon":Icons.phone_outlined,
      "title":"phone",
      "subtitle":"+91 9876543210",
    },
    {
      "icon":Icons.mail,
      "title":"Email",
      "subtitle":"harsh@gmail.com",
    },
    {
      "icon":Icons.cake_outlined,
      "title":"Birth Date",
      "subtitle":"03-06-1995",
    },
    {
      "icon":Icons.work,
      "title":"Joining Date",
      "subtitle":"05-05-2020",
    },
    {
      "icon":Icons.location_on,
      "title":"Location",
      "subtitle":"Ahmedabad,Gujarat",
    },
    {
      "icon":Icons.person,
      "title":"Gender",
      "subtitle":"Male",
    },
  ];


  bool isSwitch = true;
  bool isSwitchPt = true;
  bool isSwitchPf = true;
  bool isSwitchEsi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Employee Details",
        showAdd: true,
        addIcon: Icons.edit_outlined,
        addIconColor: AppColors.primary,
        onAddTap: (){
          Navigator.push(
            context, MaterialPageRoute(
            builder: (context)=>EmployeeUpdateScreen(),
          ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(
                            Icons.person_outline,
                            size: 30,
                            color:AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Harsh",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(color: Colors.blue.shade200),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child:  Row(
                                    children: [
                                      Icon(
                                        Icons.badge_outlined,
                                        color:AppColors.primary,
                                        size: 10,
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        "#ts315",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(color: Colors.blue.shade200),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child:  Row(
                                    children: [
                                      Icon(
                                        Icons.badge_sharp,
                                        color: AppColors.primary,
                                        size: 10,
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        "Developer",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.shade50,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 10,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "Active",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 10),
              child: Text(
                "Personal Information",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.only(left: 15,right: 15,top: 10),
              itemCount: items.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                childAspectRatio: 2.2,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = items[index];
                return
                  Container(
                    margin: EdgeInsets.all(6),
                    padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                    decoration: CommonDecorations.card(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                             item["icon"],
                              size: 16,
                              color:AppColors.primary,
                            ),
                            SizedBox(width: 5,),
                            Text(
                             item["title"],
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text(
                          item["subtitle"].toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                          ),
                        ),
        
                      ],
                    ),
                  );
              },
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 15,right: 15,top: 10),
              decoration: CommonDecorations.card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                   children: [
                     Icon(
                       Icons.account_balance_wallet,
                       size: 18,
                       color: AppColors.primary,
                     ),
                     SizedBox(width: 10,),
                     Text(
                       "Salary Payment",
                       style: TextStyle(
                         fontSize: 12,
                         fontWeight: FontWeight.w500,
                           color: Colors.grey,
                       ),
                     ),
                   ],
                 ),
                  SizedBox(height: 5,),
                  Text(
                    "Monthly",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
              margin: EdgeInsets.all(15),
              decoration: CommonDecorations.card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Icon(
                      Icons.work_history,
                      color: AppColors.primary,
                    ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          "Work Information",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Module Assigned",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                                "HR Manager, Lead, Task, Reminders, Orders, Purchase,"
                                " Product, Inventory, Production, Dispatch,"
                                " Customer, Notes, Setting, Support, "
                                "Files, Vendor, Notification",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10,right: 50,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Branch",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 65),
                          child: Text(
                            "Master,Ahmedabad",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Employee Category",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Laravel Developer",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Working Shift",
                      style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border.all(color: Colors.blue.shade100),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.blue,
                          size: 14,
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                            "Night Shift",
                            style: TextStyle(
                              fontSize: 12,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "7:15 PM-5:00AM",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
              decoration: CommonDecorations.card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          "Location Information",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Assigned Location for Check-In/Out",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border.all(color: Colors.blue.shade100),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.business,
                          color: AppColors.primary,
                          size: 14,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Tata Steel",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
              decoration: CommonDecorations.card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          "Leave Information",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border.all(color: Colors.blue.shade100),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "20",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Total Paid Leave",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            border: Border.all(color: Colors.green.shade100),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "20",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Available Leave ",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          "Status Control",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Active Status",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                            ),
                          ),
                          Text(
                            "Employee Account Status",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 1,
                        child: Switch(
                            activeTrackColor: AppColors.primary,
                            inactiveThumbColor: Colors.white,
                            splashRadius: 20,
                            value: isSwitch,
                            onChanged: (value){
                              setState(() {
                                isSwitch = value;
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade400,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSwitchPt == true ?
                            Colors.blue.shade50
                                : Colors.grey.shade100,
                            border: Border.all(
                                color: isSwitchPt == true ?
                                 Colors.blue.shade100
                                :Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "PT",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSwitchPt == true ?
                                  Colors.blue
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                    activeTrackColor: AppColors.primary,
                                    inactiveThumbColor: Colors.white,
                                    splashRadius: 20,
                                    value: isSwitchPt,
                                    onChanged: (value){
                                      setState(() {
                                        isSwitchPt = value;
                                      });
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSwitchPf == true ?
                            Colors.blue.shade50
                                : Colors.grey.shade100,
                            border: Border.all(
                                color: isSwitchPf == true ?
                                Colors.blue.shade100
                                    :Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "PF",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSwitchPf == true ?
                                  Colors.blue
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                    activeTrackColor: AppColors.primary,
                                    inactiveThumbColor: Colors.white,
                                    splashRadius: 20,
                                    value: isSwitchPf,
                                    onChanged: (value){
                                      setState(() {
                                        isSwitchPf = value;
                                      });
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSwitchEsi == true ?
                            Colors.blue.shade50
                                : Colors.grey.shade100,
                            border: Border.all(
                                color: isSwitchEsi == true ?
                                Colors.blue.shade100
                                    :Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "ESI",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSwitchEsi == true ?
                                  Colors.blue
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                    activeTrackColor: AppColors.primary,
                                    inactiveThumbColor: Colors.white,
                                    splashRadius: 20,
                                    value: isSwitchEsi,
                                    onChanged: (value){
                                      setState(() {
                                        isSwitchEsi = value;
                                      });
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
              decoration: CommonDecorations.card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.face,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          "Employee Face Recognition",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.shade100),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 10,),
                        Flexible(
                          child: Text(
                            "Employee face is already registered."
                                " To update it, please use our"
                                " Shis ERP or Shis ERP Lens app.",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(13),
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 40),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Delete Employee",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
