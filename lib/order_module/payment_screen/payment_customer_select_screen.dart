import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class PaymentCustomerSelect extends StatefulWidget {

  const PaymentCustomerSelect({super.key});

  @override
  State<PaymentCustomerSelect> createState() => _PaymentCustomerSelectState();
}

class _PaymentCustomerSelectState extends State<PaymentCustomerSelect> {

  String selectedCustomer = "";
  String outStandingAmount = "";

  final List<Map<String, dynamic>> customers = const [
    {
      "name": "Branch ID",
      "phone": "3124659780",
      "total": 1050.0,
      "collected": 0.0,
      "outstanding": 1050.00,
    },
    {
      "name": "Dhoni",
      "phone": "9999988441",
      "total": 450.00,
      "collected": 450.00,
      "outstanding": 0.00,
    },
    {
      "name": "Harsh",
      "phone": "9054457039",
      "total": 1211962.00,
      "collected": 515456.00,
      "outstanding": 696506.00,
    },
    {
      "name": "Jatin",
      "phone": "4613795484",
      "total": 460.00,
      "collected": 0.00,
      "outstanding": 460.00,
    },
    {
      "name": "Manthan",
      "phone": "1643495444",
      "total": 920.00,
      "collected": 0.00,
      "outstanding": 920.00,
    },
    {
      "name": "Milan",
      "phone": "8200355332",
      "total": 11200.00,
      "collected": 0.00,
      "outstanding": 11200.00,
    },
    {
      "name": "Parth Patel",
      "phone": "8140212111",
      "total": 12378.00,
      "collected": 0.00,
      "outstanding": 4500.00,
    },
    {
      "name": "Shivang Patel",
      "phone": "9874563210",
      "total": 4500.00,
      "collected": 0.00,
      "outstanding": 4500.00,
    },
    {
      "name": "testing demo",
      "phone": "1111122222",
      "total": 1496.00,
      "collected": 0.00,
      "outstanding": 1496.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(title: "Select Customer"),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                        hintText: "Enter search Customer Name..",
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
                  padding: EdgeInsets.only(bottom: 100),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: customers.length,
                    itemBuilder: (context,index){
                      String name = customers[index]["name"];
                      bool isSelected = selectedCustomer == customers[index]["name"];
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedCustomer = customers[index]["name"];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 15,right: 15,top:15),
                          decoration: BoxDecoration(
                            color:  isSelected
                                ? Colors.blue[50]
                                : Colors.white,
                            border: Border.all(
                                color: isSelected
                                    ? Colors.blue.shade200
                                    : Colors.white,
                                width: 1.2
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                    shape: CircleBorder(),
                                    side: BorderSide(color: Colors.grey),
                                    activeColor: AppColors.primary,
                                    value: isSelected,
                                    onChanged: (value){
                                      setState(() {
                                        selectedCustomer = customers[index]["name"];
                                      });
                                    }
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:  isSelected
                                        ? AppColors.primary
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  padding: EdgeInsets.symmetric(vertical:2,horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.action,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Selected",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
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
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.screenBg
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context,[selectedCustomer,outStandingAmount,],);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.action,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Save Selection",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
