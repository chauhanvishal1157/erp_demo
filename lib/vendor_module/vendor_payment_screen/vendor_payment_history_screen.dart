import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/vendor_module/vendor_payment_screen/add_vendor_payment_screen.dart';
import 'package:flutter/material.dart';

import '../../common/app_color.dart';
import '../../common/common_app_bar.dart';

class VendorPaymentHistoryScreen extends StatefulWidget {
  final String totalAmount;
  final String collectedAmount;
  final String outstandingAmount;
  final String transactionDate;


  const VendorPaymentHistoryScreen({
    required this.totalAmount,
    required this.collectedAmount,
    required this.outstandingAmount,
    required this.transactionDate,
    super.key});

  @override
  State<VendorPaymentHistoryScreen> createState() => _VendorPaymentHistoryScreenState();
}

class _VendorPaymentHistoryScreenState extends State<VendorPaymentHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
        title: "Vendor Payment History",
        showAdd: true,
        onAddTap: (){
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context)=> AddVendorPaymentScreen()
          ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20,left: 15,right: 15,),
              padding: EdgeInsets.only(bottom: 15),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
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
                  amountWidget(
                    Icons.account_balance_wallet_outlined,
                    "Total Amount",
                    "${widget.totalAmount}.00",
                    Colors.blue,
                  ),
                  amountWidget(
                    Icons.payment,
                    "Collected Payment",
                    "${widget.collectedAmount}.00",
                    Colors.green,
                  ),
                  amountWidget(
                    Icons.note_alt_rounded,
                    "Outstanding Payment",
                    "${widget.outstandingAmount}.00",
                    Colors.red,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 15,right: 15,),
              padding: EdgeInsets.only(bottom: 15),
              decoration:CommonDecorations.card(),
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
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.arrow,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child:Icon(
                            Icons.update,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Vendor Bill Payment History",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns:  [
                        DataColumn(label: Text("Sr no.")),
                        DataColumn(label: Text("Order no.")),
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Amount")),
                      ],
                      rows:  [
                        DataRow(cells: [
                          DataCell(Text("1")),
                          DataCell(Text("000001")),
                          DataCell(Text(widget.transactionDate)),
                          DataCell(
                              Row(
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    size: 14,
                                  ),
                                  Text("${widget.totalAmount}.00"),
                                ],
                              )),
                        ]),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black26,
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "₹0.00",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20,20,20,40),
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
    );
  }

  Widget amountWidget(
      IconData icon,
      String title,
      String amount,
      Color color,
      ){
    return  Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(left: 15,right: 15,top: 15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              color: color,
              size: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
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
                  color: color,
                  size: 14,
                ),
                Text(
                  amount,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
