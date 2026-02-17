import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/order_module/payment_screen/payment_add_order.dart';
import 'package:flutter/material.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Payment History",
        showAdd: true,
        onAddTap: (){
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context)=> PaymentAddOrder()
          ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 20,left: 15,right: 15,),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2)
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius:BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Payment Summary",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.blue.shade100,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                           Expanded(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 Icon(
                                   Icons.currency_rupee,
                                   color: Colors.blue,
                                   size: 14,
                                 ),
                                 Text(
                                   "1,050.00",
                                   style: TextStyle(
                                     color: Colors.blue,
                                     fontSize: 14,
                                     fontWeight: FontWeight.w500,
                                   ),
                                 ),
                               ],
                             ),
                           )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.green.shade100,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.payment,
                                color: Colors.green,
                                size: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Collected Payment",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Colors.green,
                                    size: 14,
                                  ),
                                  Text(
                                    "0.00",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.red.shade100,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.note_alt_rounded,
                                color: Colors.red,
                                size: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Outstanding Payment",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Colors.red,
                                    size: 14,
                                  ),
                                  Text(
                                    "1,050.00",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 15,right: 15,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2)
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.arrow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:Icon(
                            Icons.apartment,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Company Bill Payment History",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20,left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Sr nc",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            "Order nc",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          "Amount",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                    indent: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10,left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "0026",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "19/08/2025",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "1,050.00",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                    indent: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(top: 10,bottom: 20,right: 10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              color: Colors.white,
                              size: 14,
                            ),
                            Text(
                              "1,050.00",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20,top: 20),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color:AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_download,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "Download",
                        style: TextStyle(
                            color: Colors.white,
                           fontWeight: FontWeight.w500,
                          fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
