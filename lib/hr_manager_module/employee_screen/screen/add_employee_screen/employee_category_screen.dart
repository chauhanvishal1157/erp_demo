import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import '../../../../common/common_action_button.dart';

class EmployeeCategory extends StatefulWidget {
  const EmployeeCategory({super.key});

  @override
  State<EmployeeCategory> createState() => _EmployeeCategoryState();
}

class _EmployeeCategoryState extends State<EmployeeCategory> {

  String? selectedCategory;
  final List<String> categories = [
    "Sales",
    "Purchase",
    "Production",
    "Dispatch",
    "Flutter Developer",
    "Laravel Developer",
    "HR",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Employee Category",
        showAdd: true,
        onAddTap: ()async {

        },
      ),
      body: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context,index){
            String name = categories[index];
            bool isSelected = selectedCategory == name;
            return Container(
              margin: EdgeInsets.only(top: 15,left: 15,right: 15),
              decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue[50]
                      : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? Colors.blue.shade200
                        : Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ]
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                            shape: CircleBorder(),
                            side: BorderSide(color: Colors.grey),
                            activeColor:AppColors.primary,
                            value: isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedCategory = name;
                              } else {
                                selectedCategory = null;
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Selected",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }
      ),
      bottomNavigationBar: SafeArea(
          child: CommonActionButton(
            title: "Save",
            icon: Icons.save,
            onTap: (){
              Navigator.pop(context,selectedCategory);
            },
          )
      ),
    );
  }
}
