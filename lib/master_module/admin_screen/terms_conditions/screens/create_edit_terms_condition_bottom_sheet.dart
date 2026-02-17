import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/create_edit_terms_condition_bloc/create_edit_terms_condition_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/create_edit_terms_condition_bloc/create_edit_terms_condition_event.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/create_edit_terms_condition_bloc/create_edit_terms_condition_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/app_color.dart';
import '../../../../common/common_toast.dart';

class CreateEditTermsConditionBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String title;
  final String text;
  final String type;
  final String termConditionId;

  const CreateEditTermsConditionBottomSheet({
    required this.isEdit,
    required this.title,
    required this.text,
    required this.type,
    required this.termConditionId,
    super.key,
  });

  @override
  State<CreateEditTermsConditionBottomSheet> createState() => _CreateEditTermsConditionBottomSheetState();
}

class _CreateEditTermsConditionBottomSheetState extends State<CreateEditTermsConditionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditTermsConditionBloc(),
      child: CreateEditTermsConditionBottomSheetWidget(
        isEdit: widget.isEdit,
        title: widget.title,
        text: widget.text,
        type: widget.type,
        termConditionId: widget.termConditionId,
      ),
    );
  }
}


class CreateEditTermsConditionBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String title;
  final String text;
  final String type;
  final String termConditionId;

  const CreateEditTermsConditionBottomSheetWidget({
    required this.isEdit,
    required this.title,
    required this.text,
    required this.type,
    required this.termConditionId,
    super.key,
  });

  @override
  State<CreateEditTermsConditionBottomSheetWidget> createState() => _CreateEditTermsConditionBottomSheetWidgetState();
}

class _CreateEditTermsConditionBottomSheetWidgetState extends State<CreateEditTermsConditionBottomSheetWidget> {

  Set<String> selectedType = {};

  TextEditingController termConditionTitleController = TextEditingController();
  TextEditingController termConditionTextController = TextEditingController();

  @override
  void initState() {
    termConditionTitleController.text = widget.title;
    termConditionTextController.text = widget.text;

    if (widget.type.contains("1")) selectedType.add("Order");
    if (widget.type.contains("2")) selectedType.add("Lead");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditTermsConditionBloc, CreateEditTermsConditionState>(
      listener: (context, state) {
        if (state is LoadedCreateTermsConditionState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateTermsConditionState) {
          CommonToast.show(context,state.error);
        }
        else if (state is LoadedEditTermsConditionState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditTermsConditionState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context, state) {
        if (state is LoadingCreateTermsConditionState) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadingEditTermsConditionState) {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        return CommonBottomSheetContainer(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonBottomSheetHeader(
                      icon:  widget.isEdit == true
                          ? Icons.edit_note_outlined
                          :Icons.assignment_outlined,
                      title:  widget.isEdit == true
                          ? "Update Terms & Conditions"
                          : "Create Terms & Conditions",
                      subtitle: widget.isEdit == true
                          ? "Modify your terms and conditions"
                          : "Add new terms and conditions for your business",
                  ),
                  CommonTextField(
                      controller: termConditionTitleController,
                      label: "Terms & Conditions Title",
                      hint:  "Enter a clear title for your terms...",
                    showHeader: true,
                    headerText: "Title",
                    headerIcon: Icons.text_fields_sharp,
                  ),
                  CommonTextField(
                    controller: termConditionTextController,
                    label: "Terms & Conditions Content",
                    hint: "Enter your detailed terms and conditions...",
                    showHeader: true,
                    headerText:"Content",
                    headerIcon: Icons.assignment_outlined,
                    maxLines: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 16,
                          color:AppColors.primary,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Application Type",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10,bottom: 15),
                      padding: EdgeInsets.all(15),
                      decoration: CommonDecorations.card(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Application Type",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color:AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedType.contains("Order")) {
                                        selectedType.remove("Order");
                                      } else {
                                        selectedType.add("Order");
                                      }
                                    });
                                  },
              
                                  child: Container(
                                    padding:  EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                      color: selectedType.contains("Order")
                                          ?  Colors.blue.shade50
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color:selectedType.contains("Order")
                                            ?  Colors.blue
                                            : Colors.white,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 4,
                                          offset: const Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.shopping_cart_outlined,
                                          color: selectedType.contains("Order")
                                              ?  AppColors.primary
                                              : Colors.black54,
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "Order",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedType.contains("Lead")) {
                                        selectedType.remove("Lead");
                                      } else {
                                        selectedType.add("Lead");
                                      }
                                    });
                                  },
              
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                      color: selectedType.contains("Lead")
                                          ?  Colors.blue.shade50
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: selectedType.contains("Lead")
                                            ? Colors.blue
                                            : Colors.white,
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 4,
                                          offset: const Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                            Icons.person_outline,
                                            color:  selectedType.contains("Lead")
                                                ? AppColors.primary
                                                : Colors.black54),
                                        SizedBox(height: 6),
                                        Text(
                                          "Lead",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                  Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  CommonBottomActionButtons(
                      onTap: (){
                        String typeForApi = selectedType.contains("Order") && selectedType.contains("Lead")
                            ? "1,2"
                            : selectedType.contains("Order")
                            ? "1"
                            : selectedType.contains("Lead")
                            ? "2"
                            : "";
              
                        if(widget.isEdit == true) {
                          BlocProvider.of<CreateEditTermsConditionBloc>(context).add(
                            EditTermsConditionEvent(
                              title: termConditionTitleController.text,
                              text: termConditionTextController.text,
                              type:typeForApi,
              
                              termsConditionId: widget.termConditionId,
                            ),
                          );
                        }
                        else {
                          BlocProvider.of<CreateEditTermsConditionBloc>(context).add(
                            CreateTermsConditionEvent(
                              title: termConditionTitleController.text,
                              text: termConditionTextController.text,
                              type: typeForApi,
              
                            ),
                          );
                        }
                      },
                      submitText:  widget.isEdit == true
                          ? "Update"
                          : "Create",
                      submitIcon:  widget.isEdit == true
                          ? Icons.update
                          : Icons.add,
                  )
                ],
              ),
            )
        );
      },
    );
  }
}
