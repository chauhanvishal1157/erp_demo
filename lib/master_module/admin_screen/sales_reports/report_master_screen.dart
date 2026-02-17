import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportMasterScreen extends StatefulWidget {
  final String employeeName;
  const ReportMasterScreen({super.key, required this.employeeName});

  @override
  State<ReportMasterScreen> createState() => _ReportMasterScreenState();
}

class _ReportMasterScreenState extends State<ReportMasterScreen> {

  bool isCustomerExpanded = false;
  bool isLeadExpanded = false;
  bool isOrderExpanded = false;
  bool isTaskExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.arrow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "Report",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.info_outline,
                  size: 20,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),),
                child: Icon(
                  Icons.tune_rounded,
                  size: 20,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.share,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade200,
                      AppColors.action
                    ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 15),
                    child: Text(
                      "Employee Tracking Reports",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 15),
                    child: Text(
                        widget.employeeName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                        DateFormat('dd-MMM-yyyy').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 10),
                          child: Card(
                            elevation: 0,
                           shape: null,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Icon(
                                    Icons.group,
                                    size: 20,
                                    color: Colors.black
                                ),
                                 SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                        "New Customer",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (isCustomerExpanded) ...[
                                         SizedBox(height: 5),
                                        buildText("Level 1"),
                                        buildText("Level 2"),
                                        buildText("Level 3"),
                                        buildText("Others"),
                                      ],
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isCustomerExpanded =
                                          !isCustomerExpanded;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                           Text(
                                            "0",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            isCustomerExpanded
                                                ? Icons
                                                .keyboard_arrow_down_rounded
                                                : Icons
                                                .keyboard_arrow_up_rounded,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isCustomerExpanded) ...[
                                      buildValue("0"),
                                      buildValue("0"),
                                      buildValue("0"),
                                      buildValue("0"),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        Card(
                         color: Colors.white,
                          elevation: 0,
                          shape:null,
                          child: Padding(
                            padding:  EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Icon(
                                         Icons.group,
                                        size: 20,
                                        color: Colors.black,
                                     ),
                                     SizedBox(width: 15),
                                    Expanded(
                                      child: Text(
                                        "New Lead",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isLeadExpanded = !isLeadExpanded;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "0",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            isLeadExpanded
                                                ? Icons.keyboard_arrow_down_rounded
                                                : Icons
                                                .keyboard_arrow_up,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (isLeadExpanded) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35,top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        buildLead("Customer Name"),
                                        buildLead("Employee Name"),
                                        buildLead("Price"),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 0,
                          shape:null,
                          child: Padding(
                            padding:  EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                        Icons.shopping_cart_outlined,
                                        size: 20,
                                        color: Colors.black,
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: Text(
                                        "New Order",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isOrderExpanded = !isOrderExpanded;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "0",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            isOrderExpanded
                                                ? Icons.keyboard_arrow_down_rounded
                                                : Icons
                                                .keyboard_arrow_up,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (isOrderExpanded)
                                Padding(
                                  padding:  EdgeInsets.only(left: 35,top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                     buildLead("Total"),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee_rounded,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                          buildValue("0.00")
                                        ],
                                      )

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        Padding(
                          padding:  EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.call,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  "Total Call",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        Padding(
                          padding:  EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  "Total Visit",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 10),
                          child: Card(
                            elevation: 0,
                            shape: null,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  size: 20,
                                    Icons.assignment_turned_in_outlined,
                                    color: Colors.black
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Task",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (isTaskExpanded) ...[
                                        SizedBox(height: 10),
                                        buildLead("Status"),
                                        buildText("Pending"),
                                        buildText("In Progress"),
                                        buildText("Rejected"),
                                        buildText("Complete"),
                                      ],
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isTaskExpanded =
                                          !isTaskExpanded;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "0",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            isTaskExpanded
                                                ? Icons
                                                .keyboard_arrow_down_rounded
                                                : Icons
                                                .keyboard_arrow_up_rounded,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isTaskExpanded) ...[
                                      SizedBox(height: 10),
                                      buildLead("Count"),
                                      buildValue("0"),
                                      buildValue("0"),
                                      buildValue("0"),
                                      buildValue("0"),
                                    ],
                                  ],
                                ),
                              ],
                            ),
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
    );
  }

  Widget buildText(
      String title,
      ){
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildValue(
      String title,
      ){
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildLead(
      String title,
      ){
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }


}





