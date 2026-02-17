import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/vendor_module/vendor_payment_screen/select_vendor_screen.dart';
import 'package:flutter/material.dart';

import '../../common/common_action_button.dart';
import '../../common/common_app_bar.dart';
import '../../common/common_drop_down.dart';
import '../../common/common_field.dart';


class AddVendorPaymentScreen extends StatefulWidget {
  const AddVendorPaymentScreen({super.key});

  @override
  State<AddVendorPaymentScreen> createState() => _AddVendorPaymentScreenState();
}

class _AddVendorPaymentScreenState extends State<AddVendorPaymentScreen> {

  TextEditingController selectVendorController = TextEditingController();
  TextEditingController dateTransactionController = TextEditingController();
  TextEditingController outstandingAmountController = TextEditingController();
  TextEditingController addAmountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  String selectedVendorId = "";
  DateTime? selectedDate;
  String? paymentMethodValue;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );// latest date
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateTransactionController.text =
        "${picked.day.toString().padLeft(2, '0')}""/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    dateTransactionController.text =
    "${selectedDate!.day.toString().padLeft(2, '0')}"
        "/${selectedDate!.month.toString().padLeft(2, '0')}"
        "/${selectedDate!.year}";

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Add Vendor Payment"
      ),
      body: Column(
        children: [
          CommonTextField(
            controller: selectVendorController,
            label: "Select Vendor",
            hint: "Tap to select vendor..",
            horizontalMargin: 15,
            readOnly: true,
            suffixIconBoxed: false,
            suffixIcon: Icons.arrow_forward_ios,
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => SelectVendorScreen(),
              ),
              ).then((value) {
                selectedVendorId = value[0];
                selectVendorController.text = value[1];
                setState(() {});
              },);
            },
          ),
          if(selectVendorController.text.isNotEmpty) ...[
            CommonDateField(
              label: "Transaction Date",
              controller: dateTransactionController,
              horizontalMargin: 15,
              onTap:  () => _pickDate(context),
            ),
            CommonTextField(
                controller: outstandingAmountController,
                label: "OutStanding Amount",
                hint: "OutStanding Amount..",
                readOnly: true,
                prefixText: "₹ ",
                horizontalMargin: 15
            ),
            CommonTextField(
              controller: addAmountController,
              label: "Add Amount",
              horizontalMargin: 15,
              hint: "Add Amount..",
            ),
            CommonDropdown(
              label: "Select Payment Method",
              hint: "Select Payment Method",
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
              controller: remarkController,
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
          ]

        ],
      ),
    );
  }
}
