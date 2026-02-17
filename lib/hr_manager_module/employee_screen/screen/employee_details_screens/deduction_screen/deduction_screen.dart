import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../common/common_decoration.dart';

class DeductionScreen extends StatefulWidget {
  const DeductionScreen({super.key});

  @override
  State<DeductionScreen> createState() => _DeductionScreenState();
}

class _DeductionScreenState extends State<DeductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Sep Deduction"
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.5)
                  ]
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.arrow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sep Summary",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade100,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "0 Deduction 3 Types",
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.arrow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Deduction Amount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.currency_rupee_sharp,
                            size: 25,
                            color: Colors.white,
                          ),
                          Text(
                            "0.00",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          DeductionTile(
              title: "PT",
              amount: "200.00",
          ),
          DeductionTile(
            title: "PF",
            amount: "0.00",
            tag: "2% Based",
          ),
          DeductionTile(
            title: "ESI",
            amount: "80.00",
          ),
        ],
      ),
    );
  }
}
class DeductionTile extends StatelessWidget {
  final String title;
  final String amount;
  final String? tag;

  const DeductionTile({
    super.key,
    required this.title,
    required this.amount,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 15,left: 15,right: 15),
      decoration: CommonDecorations.card(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding:  EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.remove_circle_outline,
              size: 20,
              color:Colors.red
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (tag != null)
                  Container(
                    margin:  EdgeInsets.only(top: 4),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                        tag!,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                        ),
                    ),
                  )

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.currency_rupee_sharp,
                  size: 18,
                  color: Colors.red,
                ),
                Text(
                  amount,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
