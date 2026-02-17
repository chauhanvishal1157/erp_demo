import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:flutter/material.dart';

class OrderCreate extends StatefulWidget {
  const OrderCreate({super.key});

  @override
  State<OrderCreate> createState() => _OrderCreateState();
}

class _OrderCreateState extends State<OrderCreate> {

  bool isChecked = false;
  bool isChecked1 = false;
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController country1Controller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: CommonAppBar(
        title:"Create Order",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextField(
                  controller: clientNameController,
                  label: "Client Name",
                  hint: "Write Client Name..",
              ),
              CommonTextField(
                controller: companyController,
                label: "Client Company Name",
                hint: "Write Client Company Name..",
              ),
              CommonTextField(
                controller: phoneController,
                label: "Client Phone Number",
                hint: "Write Client Phone Number..",
                prefixText: "+91",
                keyboardType: TextInputType.number,
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 15,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.messenger_outline_sharp,
                        color: Colors.green,
                        size: 12,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WhatsApp number is same as",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "phone number",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),

                          Text(
                            "Auto-fill WhatsApp number from phone",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                          value: isChecked,
                          activeColor: AppColors.primary,
                          shape: CircleBorder(),
                          side: BorderSide(color: Colors.grey),
                          onChanged: (newBool)
                          {
                            setState(() {
                              isChecked = newBool!;
                            });
                          }
                      ),
                    ),
                  ],
                ),
              ),
              CommonTextField(
                controller: whatsController,
                label: "WhatsApp Number",
                hint: "Write WhatsApp Number..",
                prefixText: "+91",
                keyboardType: TextInputType.number,
              ),
              CommonTextField(
                controller: emailController,
                label: "Email Address ",
                hint: "Write Email Address..",
                keyboardType: TextInputType.emailAddress,
              ),
              CommonTextField(
                controller: gstController,
                label: "GST Number",
                hint: "Write GST Number..",
              ),
              CommonTextField(
                controller: branchController,
                readOnly: true,
                label: "Branch",
                hint: "Write Branch..",
                suffixIconBoxed: false,
                suffixIcon: Icons.arrow_forward_ios_rounded,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "Billing Address :-",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Container (
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                      spreadRadius: 3,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    CommonTextField(
                      controller: addressController,
                      label: "Address",
                      hint: "Enter Address..",
                      maxLines: 3,
                    ),
                    CommonTextField(
                      controller: countryController,
                      readOnly: true,
                      label: "Country",
                      hint: "Tap to select Country..",
                      suffixIconBoxed: false,
                      suffixIcon: Icons.arrow_forward_ios_rounded,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Checkbox(value: isChecked1,
                        activeColor: AppColors.primary,
                        side: BorderSide(color: Colors.black),
                        onChanged: (newBool)
                        {
                          setState(() {
                            isChecked1 = newBool!;
                          });
                        }
                    ),
                  ),
                  Text(
                    "shipping address is same as billing Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Text(
                "Shipping Address :-",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                      spreadRadius: 3,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    CommonTextField(
                      controller: address1Controller,
                      label: "Address",
                      hint: "Enter Address..",
                      maxLines: 3,
                    ),
                    CommonTextField(
                      controller: country1Controller,
                      label: "Country",
                      readOnly: true,
                      hint: "Tap to select Country..",
                      suffixIconBoxed: false,
                      suffixIcon: Icons.arrow_forward_ios_rounded,
                    ),

                  ],
                ),
              ),
              CommonTextField(
                controller: descriptionController,
                label: "Description",
                hint: "Enter Description..",
                maxLines: 5,
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.file_upload_outlined,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    SizedBox(width: 10,),
                    Text(
                        "Upload Document",
                      style: TextStyle(
                        color:AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
               padding:  EdgeInsets.all(15),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Text(
                     "Add Product",
                     style: TextStyle(
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   SizedBox(width: 10,),
                   Container(
                     padding: EdgeInsets.all(4),
                     decoration: BoxDecoration(
                       color: AppColors.primary,
                       borderRadius: BorderRadius.circular(6),
                     ),
                     child: Icon(
                       Icons.add,
                       size: 16,
                       color: Colors.white,
                     ),
                   ),
                 ],
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}

