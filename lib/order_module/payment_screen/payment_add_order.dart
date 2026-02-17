import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_drop_down.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/order_module/payment_screen/payment_customer_select_screen.dart';
import 'package:flutter/material.dart';

class PaymentAddOrder extends StatefulWidget {
  const PaymentAddOrder({super.key});

  @override
  State<PaymentAddOrder> createState() => _PaymentAddOrderState();
}

class _PaymentAddOrderState extends State<PaymentAddOrder> {

  bool isSwitch = false;
  String gValue = 'General';
  TextEditingController selectCustomer = TextEditingController();
  TextEditingController dateTransaction = TextEditingController();
  TextEditingController outstandingAmount = TextEditingController();
  TextEditingController addAmount = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController selectOrderController = TextEditingController();
  DateTime? selectedDate;
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // earliest date
      lastDate: DateTime(2100)
  );// latest date
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateTransaction.text =
        "${picked.day.toString().padLeft(2, '0')}""/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  List<String> items = <String>[
    'Cash',
    'Cheque',
    'Credit/Debit Card',
    'Internet Banking',
    'Google Pay',
    'Phone Pay',
    'Paytm',
    'RazorPay',
    'Other',
  ];

  String? paymentMethodValue;

  @override
  void initState() {
    selectedDate = DateTime.now();
    dateTransaction.text =
    "${selectedDate!.day.toString().padLeft(2, '0')}"
        "/${selectedDate!.month.toString().padLeft(2, '0')}"
        "/${selectedDate!.year}";

     paymentMethodValue = "Cash";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Add Order Payment"
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonTextField(
                controller: selectCustomer,
                label: "Select Customer",
                hint: "Tap to select customer..",
              horizontalMargin: 15,
              readOnly: true,
              suffixIconBoxed: false,
              suffixIcon: Icons.arrow_forward_ios,
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => PaymentCustomerSelect(),
                ),
                ).then((value) {
                  selectCustomer.text = value[0];
                  outstandingAmount.text = value[1];
                  setState(() {});
                },);
              },
            ),
            if(selectCustomer.text.isNotEmpty) ...[
              CommonDateField(
                  label: "Transaction Date",
                  controller: dateTransaction,
                  horizontalMargin: 15,
                  onTap:  () => _pickDate(context),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: PaymentTypeRadio(
                        title: "General",
                        value: "General",
                        groupValue: gValue,
                        onChanged: (val) {
                          setState(() {
                            gValue = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PaymentTypeRadio(
                        title: "Order wise",
                        value: "Order Wise",
                        groupValue: gValue,
                        onChanged: (val) {
                          setState(() {
                            gValue = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (gValue == 'Order Wise') ...[
               CommonTextField(
                   controller: orderController,
                   label: "Select Order",
                   hint: "Tap to select order..",
                 horizontalMargin: 15,
                 readOnly: true,
                 suffixIconBoxed: false,
                 suffixIcon: Icons.arrow_forward_ios,
                 onTap: (){},
               )
              ],
              CommonTextField(
                controller: outstandingAmount,
                label: "OutStanding Amount",
                hint: "OutStanding Amount..",
                  horizontalMargin: 15
              ),
              CommonTextField(
                controller: addAmount,
                label: "Add Amount",
                horizontalMargin: 15,
                hint: "Add Amount..",
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left:15,right:15,top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Refund Payment",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "Enable to Process refunds for selected orders",
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                          activeTrackColor: AppColors.primary,
                          inactiveThumbColor: Colors.grey,
                          splashRadius: 30,
                          value: isSwitch,
                          onChanged: (value){
                            setState(() {
                              isSwitch = value;
                            });
                          }
                      ),
                    ],
                  )
              ),
              if (isSwitch) ...[
                CommonTextField(
                    controller: selectOrderController,
                    label: "Select Orders",
                    hint: "Tap to Select orders for refund",
                  horizontalMargin: 15,
                  readOnly: true,
                  prefixIcon: Icons.receipt_long,
                  suffixIconBoxed: false,
                  suffixIcon: Icons.arrow_forward_ios,
                  onTap: (){},
                ),
              ],
              CommonDropdown(
                  label: "Select Payment Method",
                  horizontalMargin: 15,
                  value: paymentMethodValue,
                items: [
                  'Cash',
                  'Cheque',
                  'Credit/Debit Card',
                  'Internet Banking',
                  'Google Pay',
                  'Phone Pay',
                  'Paytm',
                  'RazorPay',
                  'Other',
                ],
                onChanged: (val) {
                  setState(() => paymentMethodValue = val);
                },
              ),
              CommonTextField(
                controller: remark,
                label: "Remark",
                hint: "Write Remark..",
                horizontalMargin: 15,
                maxLines: 5,
              ),
              CommonActionButton(
                  title: "submit",
                  horizontalMargin: 15,
                  onTap: (){
                    Navigator.pop(context);
                  },
              )
            ],
          ],
        ),
      ),
    );
  }
}

class PaymentTypeRadio extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const PaymentTypeRadio({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: (){
        onChanged(value);
      },
      child: Container(
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.shade50
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : Colors.black26,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              activeColor: Colors.blue,
              value: value,
              groupValue: groupValue,
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
            Text(
              title,
              style:  TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? AppColors.primary
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

