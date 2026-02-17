import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import '../../../../../common/common_action_button.dart';
import '../../../../../common/common_decoration.dart';
import '../../../../../common/common_field.dart';
import '../../add_employee_screen/add_branch_screen.dart';
import '../../add_employee_screen/add_module_screen.dart';
import '../../add_employee_screen/add_new_employee_screen.dart';


class EmployeeUpdateScreen extends StatefulWidget {
  const EmployeeUpdateScreen({super.key});

  @override
  State<EmployeeUpdateScreen> createState() => _EmployeeUpdateScreenState();
}

class _EmployeeUpdateScreenState extends State<EmployeeUpdateScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  final TextEditingController pfNumberController = TextEditingController();
  final TextEditingController paidLeaveController = TextEditingController();
  final TextEditingController attendanceController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController shiftTimeController = TextEditingController();
  final TextEditingController employeeCategoryController = TextEditingController();
  final TextEditingController checkInOutLocationController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  DateTime? birthDate;
  DateTime? joiningDate;
  Future<void> pickDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text =
      "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    }
  }
  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
  String? selectedGender;
  List<String> selectedShiftNames = [];
  String? selectedCategory;
  List<String> selectedLocations = [];
  bool isChecked = false;
  String? selectedCountry;
  String? selectedPayment;
  final List<Map<String, dynamic>> payment = [
    {
      "title" : "Monthly",
      "subtitle" : "Per Month Salary"
    },
    {
      "title" : "Daily",
      "subtitle" : "Daily Payment"
    },
  ];
  List<String> selectedBranchIds = [];
  List<String> selectedBranchNames = [];

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.day.toString().padLeft(2, '0')}/"
        "${now.month.toString().padLeft(2, '0')}/"
        "${now.year}";
    birthDateController.text = formattedDate;
    joiningDateController.text = formattedDate;
    birthDate = now;
    joiningDate = now;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(title: "Update Details"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color:Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ) ,
                      SizedBox(width: 10,),
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  CommonTextField(
                    controller: nameController,
                    label:  "Employee Name",
                    hint: "Write Employee Name",
                  ),
                  CommonTextField(
                    controller: codeController,
                    keyboardType: TextInputType.phone,
                    label: "Employee Code",
                    hint:  "Write Employee Code..",
                  ),
                  CommonTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    label:  "Phone Number",
                    hint: "Write Phone Number...",
                  ),
                  CommonTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: "Email Address",
                    hint: "Write Email Address...",
                  ),
                  CommonDateField(
                    label:  "Birth Date",
                    controller: birthDateController,
                    onTap:  ()=> pickDate(context, birthDateController),
                  ),
                  CommonTextField(
                      controller: designationController,
                      label: "Designation",
                      hint:  "Write Designation..."
                  ),
                  CommonDateField(
                      label: "Joining Date",
                      controller: joiningDateController,
                      onTap: ()=> pickDate(context, joiningDateController)
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(top: 10),
                    decoration: CommonDecorations.card(),
                    child:
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.group_rounded,
                              color:AppColors.primary,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Gender",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            GenderOptionCard(
                              value: "Male",
                              selectedValue: selectedGender,
                              onTap: () {
                                setState(() {
                                  selectedGender = "Male";
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            GenderOptionCard(
                              value: "Female",
                              selectedValue: selectedGender,
                              onTap: () {
                                setState(() {
                                  selectedGender = "Female";
                                });
                              },
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                  CommonTextField(
                    controller: pfNumberController,
                    keyboardType: TextInputType.phone,
                    label: "PF Number",
                    hint: "Write PF Number...",
                  ),
                ],
              ),
            ),
            Container(
             padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15,),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: AppColors.primary,
                        ),
                      ) ,
                      SizedBox(width: 10,),
                      Text(
                        "Salary Payment Type",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: payment.length,
                      itemBuilder: (context,index){
                        String title = payment[index]["title"];
                        String subtitle = payment[index]["subtitle"];
                        bool isSelected = selectedPayment == title;
                        return InkWell(
                          onTap: (){
                            setState(() {
                              selectedPayment = title;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color:  isSelected
                                  ? Colors.blue[50]
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.blue.shade100
                                    : Colors.grey.shade200,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(
                                    Icons.payment,
                                    color: Colors.grey,
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
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        subtitle,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade400,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                      shape: CircleBorder(),
                                      side: BorderSide(color: Colors.grey),
                                      activeColor: AppColors.primary,
                                      value: isSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            selectedPayment = title;
                                          } else {
                                            selectedPayment = null;
                                          }
                                        });
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                  CommonTextField(
                      controller: salaryController,
                      label: "Salary",
                      hint: "Enter employee salary...",
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius:BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.error_outline_sharp,
                            size: 20,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Salary Update Notice",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                ),
                              ),
                              Text(
                                "Salary will be updated from "
                                    "current month(september).",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
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
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.work_outline,
                          size: 16,
                          color:AppColors.primary,
                        ),
                      ) ,
                      SizedBox(width: 10,),
                      Text(
                        "Work Details",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  CommonTextField(
                    controller: paidLeaveController,
                    keyboardType: TextInputType.phone,
                    label: "Paid Leave",
                    hint: "Write Paid Leave...",
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10),
                    decoration: CommonDecorations.card(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.view_module_outlined,
                              size: 20,
                              color:AppColors.primary,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Select Module To Assign",
                              style: TextStyle(
                                color:AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddModuleScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                            decoration: BoxDecoration(
                              color:AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Add Module",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10),
                    decoration: CommonDecorations.card(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.business,
                              size: 20,
                              color:AppColors.primary,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Select Branch To Assign",
                              style: TextStyle(
                                color:AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddBranchScreen(),
                              ),
                            ).then(
                                  (value) {
                                selectedBranchIds = value[0];
                                selectedBranchNames = value[1];
                                setState(() {});
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                            decoration: BoxDecoration(
                              color:AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Add Branch",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CommonTextField(
                    controller: shiftTimeController,
                    label: "shift Time",
                    hint:"Tap to add shift time..",
                    readOnly: true,
                    suffixIconBoxed: false,
                    suffixIcon: Icons.arrow_forward_ios,
                    onTap: (){},
                  ),
                  CommonTextField(
                    controller: employeeCategoryController,
                    label: "Employee Category",
                    hint:"Tap to add Employee Category..",
                    readOnly: true,
                    suffixIconBoxed: false,
                    suffixIcon: Icons.arrow_forward_ios,
                    onTap: (){},
                  ),
                  CommonTextField(
                    controller: checkInOutLocationController,
                    label: "Check-In/Out Location",
                    hint:"Tap to Check-In/Out Location..",
                    readOnly: true,
                    suffixIconBoxed: false,
                    suffixIcon: Icons.arrow_forward_ios,
                    onTap: (){},
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    margin: EdgeInsets.only(top: 10),
                    decoration: CommonDecorations.card(),
                    child:Row(
                      children: [
                        Checkbox(
                          activeColor:AppColors.primary,
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Text(
                          "Allow employee self check in & out",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.business,
                          size: 16,
                          color:AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Address Details",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  CommonTextField(
                    controller: countryController,
                    label: "Country",
                    hint:"Tap to Choose Country..",
                    readOnly: true,
                    suffixIconBoxed: false,
                    suffixIcon: Icons.arrow_forward_ios,
                    onTap: (){},
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.security,
                          size: 16,
                          color:AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Security & Media",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  CommonTextField(
                      controller: attendanceController,
                      keyboardType: TextInputType.phone,
                      label: "Attendance Password",
                      hint: "Attendance Password"
                  )
                ],
              ),
            ),

            CommonActionButton(
              title:"Update",
              icon: Icons.update,
              horizontalMargin: 15,
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.validator,
  }
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child:  TextFormField(
        controller: controller,
        style:  TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        validator: validator,
      ),
    );
  }
}

class CustomDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;

  const CustomDateField({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child:  TextFormField(
        controller: controller,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        onTap: onTap,
        readOnly: true,
        decoration: InputDecoration(

          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child:  Icon(
              Icons.calendar_today,
              size: 20,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
