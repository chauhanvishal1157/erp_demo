import 'dart:io';

import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../common/common_action_button.dart';

class AddInsurance extends StatefulWidget {
  const AddInsurance({super.key});

  @override
  State<AddInsurance> createState() => _AddInsuranceState();
}

class _AddInsuranceState extends State<AddInsurance> {

  TextEditingController identityController = TextEditingController();
  TextEditingController policyController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    startDateController.text = today;
    endDateController.text = today;
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      controller.text = formattedDate;
    }
  }
  File? selectedFile;

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar:CommonAppBar(
          title: "Add Insurance"
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonTextField(
                controller: identityController,
                horizontalMargin: 15,
                label: "Identity No",
                hint: "Write Identity No...",
            ),
            CommonTextField(
              controller: policyController,
              horizontalMargin: 15,
              label: "Policy No",
              hint: "Write policy No...",
            ),
            CommonTextField(
              controller: companyController,
              horizontalMargin: 15,
              label: "Company Name",
              hint: "Write company name...",
            ),
            CommonDateField(
              label: "Start Date(From)",
              horizontalMargin: 15,
              controller: startDateController,
              onTap: () => _selectDate(context, startDateController),
            ),
            CommonDateField(
              label: "end Date(To)",
              horizontalMargin: 15,
              controller: endDateController,
              onTap: () => _selectDate(context, endDateController),
            ),
            GestureDetector(
              onTap: pickDocument,
              child: Container(
                margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                padding: EdgeInsets.all(12),
                decoration: CommonDecorations.card(),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:  Icon(
                        Icons.upload_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Upload Agreement",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CommonActionButton(
        title: "Save",
        horizontalMargin: 15,
        onTap: () {
          Navigator.pop(context, {
            "identityNo": identityController.text,
            "policyNo": policyController.text,
            "companyName": companyController.text,
            "startDate": startDateController.text,
            "endDate": endDateController.text,
            "file": selectedFile,
          });

        },
      )
    );
  }
}

