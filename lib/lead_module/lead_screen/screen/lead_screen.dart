import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/custom_app_bar.dart';
import 'filter_lead_bottom_sheet.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {

  int selectedTab = 0;

  String formatDate(String apiDate) {
    try {
      final DateTime parsedDate = DateTime.parse(apiDate);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return apiDate;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar:CustomAppBar(
        leadingIcon: Icons.task_outlined,
        title: "Lead",
        subtitle: "Lead Management",
        showAction1: true,
        actionIcon1Color: AppColors.primary,
        showAdd: true,
        actionIcon1: Icons.search,
        addIcon: Icons.add,
        onAddTap: () async {},
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.screenBg
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          _buildTab("All", 0),
                          _buildTab("Upcoming Schedule", 1),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      decoration: CommonDecorations.card(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.list_alt,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "All Lead",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Showing all Lead statuses",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context){
                                      return FilterLeadBottomSheet();
                                    },
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.tune,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                              offset:  Offset(0, 2),
                            ),
                          ],
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child:  Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              DateFormat('MMM dd, yyyy').format(DateTime.now()),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
  Widget _buildTab(String label, int index) {
    final bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedTab = index);
        },
        child: Container(
          padding:  EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.shade300
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
