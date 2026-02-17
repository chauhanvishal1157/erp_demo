import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExtraFund extends StatefulWidget {
  const AddExtraFund({super.key});

  @override
  State<AddExtraFund> createState() => _AddExtraFundState();
}

class _AddExtraFundState extends State<AddExtraFund> {

  TextEditingController paymentDateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    paymentDateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
  }


  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // default
      firstDate: DateTime(2000),   // minimum date
      lastDate: DateTime(2100),    // maximum date
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
                icon: Icons.add_business_outlined,
                title: "Add Extra Funds",
                subtitle: "Fill in the details to create a new extra fund"
            ),
            CommonDateField(
              label:  "Payment Date",
              controller: paymentDateController,
              onTap: () => _selectDate(context, paymentDateController),
            ),
            CommonTextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                label: "Amount",
                hint:  "Write Amount...",
            ),
            CommonTextField(
              controller: remarkController,
              label: "Remark",
              hint: "Write Remark...",
            ),
            CommonActionButton(
                title: "Save",
                icon: Icons.save,
                onTap: (){
                  Navigator.pop(context, {
                    "paymentDate": paymentDateController.text,
                    "amount": amountController.text,
                    "remark": remarkController.text,
                  });
                },
            )

          ],
        ),
    );
  }
}
