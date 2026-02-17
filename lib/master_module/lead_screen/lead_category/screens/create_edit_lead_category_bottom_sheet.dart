import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/create_edit_delete_lead_category_bloc/create_edit_delete_lead_category_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/create_edit_delete_lead_category_bloc/create_edit_delete_lead_category_event.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/create_edit_delete_lead_category_bloc/create_edit_delete_lead_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/common_toast.dart';

class CreateEditLeadCategoryBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String leadCategoryId;
  final String leadCategoryName;
  final String status;

  const CreateEditLeadCategoryBottomSheet({
    required this.isEdit,
    required this.leadCategoryId,
    required this.leadCategoryName,
    required this.status,
    super.key
  });

  @override
  State<CreateEditLeadCategoryBottomSheet> createState() => _CreateEditLeadCategoryBottomSheetState();
}

class _CreateEditLeadCategoryBottomSheetState extends State<CreateEditLeadCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (
        context) => CreateEditDeleteLeadCategoryBloc(),
      child: CreateEditLeadCategoryBottomSheetWidget(
          isEdit: widget.isEdit,
          leadCategoryId: widget.leadCategoryId,
          leadCategoryName: widget.leadCategoryName,
          status: widget.status
      ),
    );
  }
}


class CreateEditLeadCategoryBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String leadCategoryId;
  final String leadCategoryName;
  final String status;

  const CreateEditLeadCategoryBottomSheetWidget({
    required this.isEdit,
    required this.leadCategoryId,
    required this.leadCategoryName,
    required this.status,
    super.key
  });

  @override
  State<CreateEditLeadCategoryBottomSheetWidget> createState() => _CreateEditLeadCategoryBottomSheetWidgetState();
}

class _CreateEditLeadCategoryBottomSheetWidgetState extends State<CreateEditLeadCategoryBottomSheetWidget> {

  TextEditingController leadCategoryController = TextEditingController();
  String selectedStatus = "";

  @override
  void initState() {
    leadCategoryController.text = widget.leadCategoryName;
    if (widget.isEdit) {
      selectedStatus = widget.status == "1" ? "Active" : "Inactive";
    } else {
      selectedStatus = "Active";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteLeadCategoryBloc, CreateEditDeleteLeadCategoryState>(
      listener: (context, state){
        if (state is LoadedCreateLeadCategoryState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateLeadCategoryState) {
          CommonToast.show(context,state.error);
        }
        else if (state is LoadedEditLeadCategoryState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditLeadCategoryState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context, state){
        if (state is LoadingCreateLeadCategoryState) {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadingEditLeadCategoryState) {
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
                        ? "Update Category"
                        : "Create New Category",
                    subtitle: widget.isEdit == true
                        ?"Modify category details below"
                        :"Fill in the details to create a new category",
                ),
                CommonTextField(
                    controller: leadCategoryController,
                    label: "Category Name",
                    hint: "Enter Category Name..",
                  showHeader: true,
                  headerText: "Category Name",
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

                      if (widget.isEdit == true) {
                        BlocProvider.of<CreateEditDeleteLeadCategoryBloc>(context).add(
                            EditLeadCategoryEvent(
                                leadCategoryId: widget.leadCategoryId,
                                leadCategoryName: leadCategoryController.text,
                                status: mappedStatus
                            )
                        );
                      }
                      else {
                        BlocProvider.of<CreateEditDeleteLeadCategoryBloc>(context).add(
                            CreateLeadCategoryEvent(
                                leadCategoryName: leadCategoryController.text,
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
      },
    );
  }
}
