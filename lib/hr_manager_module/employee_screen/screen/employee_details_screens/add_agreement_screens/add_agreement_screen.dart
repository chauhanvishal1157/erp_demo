import 'dart:io';
import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAgreement extends StatefulWidget {
  const AddAgreement({super.key});

  @override
  State<AddAgreement> createState() => _AddAgreementState();
}

class _AddAgreementState extends State<AddAgreement> {


  TextEditingController associationController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController appraisalDudeDateController = TextEditingController();

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
  void initState() {
    super.initState();

    // 👉 ADD THIS (DEFAULT CURRENT DATE)
    String today = DateFormat('dd-MM-yyyy').format(DateTime.now());

    startDateController.text = today;
    endDateController.text = today;
    appraisalDudeDateController.text = today;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Add Agreement"
      ),
      body: Column(
        children: [
          CommonTextField(
              controller: associationController,
              horizontalMargin: 15,
              label: " Association Type",
              hint:  "Write association type..",
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
          CommonDateField(
            label: "appraisalDude Date" ,
            horizontalMargin: 15,
            controller: appraisalDudeDateController,
            onTap: () => _selectDate(context, appraisalDudeDateController),
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
      bottomNavigationBar: CommonActionButton(
          title: "Save",
          horizontalMargin: 15,
          onTap: () {
          Navigator.pop(context, {
            "startDate": startDateController.text,
            "endDate": endDateController.text,
            "appraisalDate": appraisalDudeDateController.text,
            "file": selectedFile,
          });
        },
      )
    );
  }
}

