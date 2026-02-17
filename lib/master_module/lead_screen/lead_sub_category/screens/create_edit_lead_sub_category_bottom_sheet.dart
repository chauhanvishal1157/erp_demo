import 'package:erp_demo/master_module/lead_screen/lead_sub_category/bloc/create_edit_delete_lead_sub_category_bloc/create_edit_delete_lead_sub_category_event.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/screens/select_lead_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../common/common_field.dart';
import '../../../../common/common_toast.dart';
import '../../../../common/create_edit_screen.dart';
import '../bloc/create_edit_delete_lead_sub_category_bloc/create_edit_delete_lead_sub_category_bloc.dart';
import '../bloc/create_edit_delete_lead_sub_category_bloc/create_edit_delete_lead_sub_category_state.dart';

class CreateEditLeadSubCategoryBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String subLeadCategoryName;
  final String subLeadCategoryId;
  final String leadCategoryName;
  final String leadCategoryId;
  final String status;

  const CreateEditLeadSubCategoryBottomSheet({
    required this.isEdit,
    required this.subLeadCategoryName,
    required this.subLeadCategoryId,
    required this.leadCategoryName,
    required this.leadCategoryId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditLeadSubCategoryBottomSheet> createState() => _CreateEditLeadSubCategoryBottomSheetState();
}

class _CreateEditLeadSubCategoryBottomSheetState extends State<CreateEditLeadSubCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteLeadSubCategoryBloc(),
      child: CreateEditLeadSubCategoryBottomSheetWidget(
          isEdit: widget.isEdit,
          subLeadCategoryName: widget.subLeadCategoryName,
          subLeadCategoryId: widget.subLeadCategoryId,
          leadCategoryName:widget.leadCategoryName,
          leadCategoryId: widget.leadCategoryId,
          status: widget.status,
      ),
    );
  }
}



class CreateEditLeadSubCategoryBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String subLeadCategoryName;
  final String subLeadCategoryId;
  final String leadCategoryName;
  final String leadCategoryId;
  final String status;

  const CreateEditLeadSubCategoryBottomSheetWidget({
    required this.isEdit,
    required this.subLeadCategoryName,
    required this.subLeadCategoryId,
    required this.leadCategoryName,
    required this.leadCategoryId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditLeadSubCategoryBottomSheetWidget> createState() => _CreateEditLeadSubCategoryBottomSheetWidgetState();
}

class _CreateEditLeadSubCategoryBottomSheetWidgetState extends State<CreateEditLeadSubCategoryBottomSheetWidget> {

  TextEditingController leadSubCategoryController = TextEditingController();
  TextEditingController leadCategoryController = TextEditingController();
  String selectedStatus = "";

  String selectedLeadCategoryName = "";
  String selectedLeadCategoryId = "";


  @override
  void initState() {

    leadSubCategoryController.text = widget.subLeadCategoryName;
    leadCategoryController.text = widget.leadCategoryName;
    selectedLeadCategoryId = widget.leadCategoryId;
    selectedLeadCategoryName = widget.leadCategoryName;

    if (widget.isEdit) {
      selectedStatus = widget.status == "1" ? "Active" : "Inactive";
    }
    else {
      selectedStatus = "Active";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteLeadSubCategoryBloc,CreateEditDeleteLeadSubCategoryState>(
        listener: (context,state){
          if (state is LoadedCreateLeadSubCategoryState) {
            CommonToast.show(context,state.message);
            Navigator.of(context).pop(true);
          }
          else if(state is FailureCreateLeadSubCategoryState){
            CommonToast.show(context,state.error);
          }
          else if(state is LoadedEditLeadSubCategoryState){
            CommonToast.show(context,state.message);
            Navigator.of(context).pop(true);
          }
          else if(state is FailureEditLeadSubCategoryState){
            CommonToast.show(context,state.error);
            Navigator.of(context).pop(true);
          }
        },
        builder: (context,state){
          if (state is LoadingCreateLeadSubCategoryState) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if (state is LoadingEditLeadSubCategoryState) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          return  CommonBottomSheetContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonBottomSheetHeader(
                    icon: widget.isEdit == true
                        ? Icons.edit_outlined
                        :Icons.add_circle_outline,
                    title:  widget.isEdit == true
                        ? "Update Sub Category"
                        : "Create  New Sub Category",
                    subtitle:  widget.isEdit == true
                        ? "Modify Sub Category details below"
                        : "Fill in the details to create a new Sub Category",
                  ),
                  CommonTextField(
                      controller: leadCategoryController,
                      label: "Category",
                      hint:  "Enter category Name..",
                    readOnly: true,
                    showHeader: true,
                    headerText: "Sub Category Name",
                    headerIcon: Icons.file_copy_outlined,
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectLeadCategoryScreen()
                          )
                      ).then(
                            (value) {
                          selectedLeadCategoryId = value[0];
                          selectedLeadCategoryName = value[1];
                          leadCategoryController.text = value[1];
                          setState(() {});
                        },
                      );
                    },
                    suffixIconBoxed: false,
                    suffixIcon: Icons.arrow_forward_ios,
                  ),
                  CommonTextField(
                    controller: leadSubCategoryController,
                    label: "Sub Category Name",
                    hint: "Enter Sub Category Name..",
                    showHeader: true,
                    headerText: "Sub Category Name",
                    headerIcon: Icons.file_copy_outlined,

                  ),
                  CommonStatusDropdown(
                    value: selectedStatus,
                    onChanged: (val){
                      setState(() {
                        selectedStatus = val;
                      });
                    },
                    showHeader: true,
                    headerText: "status",
                    headerIcon: Icons.toggle_off_sharp,

                  ),
                  CommonBottomActionButtons(
                    onTap: (){
                      final mappedStatus =
                      selectedStatus == "Active" ? "1" : "0";

                      if(widget.isEdit == true){
                        BlocProvider.of<CreateEditDeleteLeadSubCategoryBloc>(context).add(
                            EditLeadSubCategoryEvent(
                                leadSubCategoryId: widget.subLeadCategoryId,
                                leadCategoryId: selectedLeadCategoryId,
                                leadCategoryName: leadCategoryController.text,
                                leadSubCategoryName: leadSubCategoryController.text,
                                status: mappedStatus
                            )
                        );
                      }
                      else{
                        BlocProvider.of<CreateEditDeleteLeadSubCategoryBloc>(context).add(
                            CreateLeadSubCategoryEvent(
                                leadCategoryId: selectedLeadCategoryId,
                                leadCategoryName: leadCategoryController.text,
                                leadSubCategoryName: leadSubCategoryController.text,
                                status: mappedStatus
                            )
                        );
                      }
                    },
                    submitText:  widget.isEdit == true
                        ?"Update "
                        :"Create",
                    submitIcon:  widget.isEdit == true
                        ? Icons.update
                        :  Icons.add,
                  )
                ],
              )
          );
        }
    );
  }
}