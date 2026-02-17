import 'dart:typed_data';
import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/order_module/order_screen/screen/signature_pad_bottom_sheet.dart';
import 'package:flutter/material.dart';


class OrderProformaInvoice extends StatefulWidget {
  final String orderAmount;
  const OrderProformaInvoice({
    required this.orderAmount,
    super.key});

  @override
  State<OrderProformaInvoice> createState() => _OrderProformaInvoiceState();
}

class _OrderProformaInvoiceState extends State<OrderProformaInvoice> {

  bool isSwitch = false;
  Uint8List? exportedImage;
  bool? isPercentage;
  TextEditingController percentageController = TextEditingController();
  TextEditingController calcAmountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController deliveryNoteController = TextEditingController();
  TextEditingController orderAmountController = TextEditingController();


  @override
  void initState() {
    super.initState();
    orderAmountController.text = widget.orderAmount;
    isPercentage = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar:CommonAppBar(
          title: "Proforma Invoice"
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(
              controller: orderAmountController,
              label: "Order Amount",
              hint: "Enter order amount...",
              showHeader: true,
              headerText: "order Amount",
              headerIcon: Icons.currency_rupee,
              readOnly: true,
              horizontalMargin: 15,
            ),
            Padding(
              padding:  EdgeInsets.only(left: 15,top: 15,bottom: 10),
              child: Text(
                "Advance Payment Method",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary
                ),
              ),
            ),
            Row(
            children: [
              Expanded(
                child: CommonSelectCard(
                  isSelected: isPercentage == true,
                  onTap: () {
                    setState(() => isPercentage = true);
                  },
                  title: "Percentage (%)",
                  icon: Icons.percent,
                  activeColor: Colors.blue,
                  margin: const EdgeInsets.only(left: 15, right: 5),
                ),
              ),
              Expanded(
                child: CommonSelectCard(
                  isSelected: isPercentage == false,
                  onTap: () {
                    setState(() => isPercentage = false);
                  },
                  title: "Amount (₹)",
                  icon: Icons.currency_rupee,
                  activeColor: Colors.blue,
                  margin: const EdgeInsets.only(left: 5, right: 15),
                ),
              ),
            ],
          ),
          if (isPercentage == true) ...[
              CommonTextField(
                  controller: percentageController,
                  label: "Advance Percentage",
                  hint: "Enter advance percentage...",
                showHeader: true,
                headerText: "Advance Percentage",
                headerIcon: Icons.percent,
                horizontalMargin: 15,
              ),
            ] else ...[
              CommonTextField(
                controller: amountController,
                label: "Advance Amount",
                hint: "Enter advance amount...",
                showHeader: true,
                headerText: "Advance Amount",
                headerIcon: Icons.currency_rupee,
                horizontalMargin: 15,
              ),
            ],
            CommonTextField(
              controller: calcAmountController,
              label: "Advance Amount",
              hint: "Calculated advance amount...",
              showHeader: true,
              headerText: "Calculated Advance Amount",
              headerIcon: Icons.currency_rupee,
              horizontalMargin: 15,
            ),
            CommonTextField(
              controller: deliveryNoteController,
              label: "Delivery Note",
              hint: "Enter delivery note...",
              showHeader: true,
              headerText: "Delivery Note",
              headerIcon: Icons.read_more_sharp,
              maxLines: 3,
              horizontalMargin: 15,
            ),
            Container(
              padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Digital Signature",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            "Add your signature to the invoice",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                              activeTrackColor: AppColors.primary,
                              focusColor: Colors.white,
                              inactiveThumbColor: Colors.white,
                              splashRadius: 30,
                              value: isSwitch,
                              onChanged: (value){
                                setState(() {
                                  isSwitch = value;
                                });
                                if(isSwitch){
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context){
                                      return SignaturePadBottomSheet();
                                    },
                                  );
                                }
                              }
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
            CommonActionButton(
              icon: Icons.download_outlined,
                title: "Generate & Download PDF ",
                onTap: (){},
              horizontalMargin: 15,
            )
          ],
        ),
      ),
    );
  }
}


class CommonSelectCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  final String title;
  final IconData icon;

  final Color activeColor;

  final EdgeInsets margin;

  const CommonSelectCard({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.title,
    required this.icon,
    this.activeColor = Colors.blue,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.all(20),
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? activeColor.withValues(alpha: 0.2)
              : Colors.white,
          border: Border.all(
            color:
            isSelected
                ? activeColor.withValues(alpha: 0.5)
                : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected
                    ? activeColor.withValues(alpha: 0.5)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? activeColor
                    : Colors.grey,
                size: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: isSelected
                    ? activeColor
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

