  import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
  import 'package:erp_demo/common/app_color.dart';
  import 'package:flutter/material.dart';

  class AddCountryScreen extends StatefulWidget {
    const AddCountryScreen({super.key});

    @override
    State<AddCountryScreen> createState() => _AddCountryScreenState();
  }

  class _AddCountryScreenState extends State<AddCountryScreen> {

    String? selectedCountry;
    final List<String> country = [
      "India",
      "Nepal",
      "Japan",
      "Dubai",
       "Bhutan",
    ];
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor:  AppColors.screenBg,
        appBar: CommonAppBar(
            title: "Select Country"
        ),
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: TextFormField(
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        hintText: "Enter Search Country..",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black26,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 20,
                          color: Colors.grey,
                        ),
                        suffixIcon: Icon(
                          Icons.mic_none,
                          size: 20,
                          color: Colors.grey,
                        )
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: country.length,
                    itemBuilder: (context,index){
                      String name = country[index];
                      bool isSelected = selectedCountry == name;
                      return GestureDetector(
                        onTap: (){

                        },
                        child: Container(
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
                                      activeColor: AppColors.primary,
                                      value: isSelected,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            selectedCountry = name;
                                          } else {
                                            selectedCountry = null;
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
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: CommonActionButton(
              title: "Save",
              icon: Icons.save,
              onTap: (){
                Navigator.pop(context,selectedCountry);
              },
          )
        ),
      );
    }
  }
