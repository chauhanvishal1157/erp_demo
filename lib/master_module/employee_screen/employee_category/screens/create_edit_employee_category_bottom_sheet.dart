import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/bloc/create_edit_delete_employee_category_bloc/create_edit_delete_employee_category_bloc.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/bloc/create_edit_delete_employee_category_bloc/create_edit_delete_employee_category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;

import '../../../../common/common_toast.dart';
import '../bloc/create_edit_delete_employee_category_bloc/create_edit_delete_employee_category_state.dart';

class CreateEditEmployeeCategoryBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String employeeCategoryId;
  final String employeeCategoryName;
  final String status;

  const CreateEditEmployeeCategoryBottomSheet({
    required this.isEdit,
    required this.employeeCategoryId,
    required this.employeeCategoryName,
    required this.status,
    super.key});

  @override
  State<CreateEditEmployeeCategoryBottomSheet> createState() => _CreateEditEmployeeCategoryBottomSheetState();
}

class _CreateEditEmployeeCategoryBottomSheetState extends State<CreateEditEmployeeCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteEmployeeCategoryBloc(),
      child: CreateEditEmployeeCategoryBottomSheetWidget(
          isEdit: widget.isEdit,
          employeeCategoryId: widget.employeeCategoryId,
          employeeCategoryName: widget.employeeCategoryName,
          status: widget.status
      ),
    );
  }
}


class CreateEditEmployeeCategoryBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String employeeCategoryId;
  final String employeeCategoryName;
  final String status;

  const CreateEditEmployeeCategoryBottomSheetWidget({
    required this.isEdit,
    required this.employeeCategoryId,
    required this.employeeCategoryName,
    required this.status,
    super.key
  });

  @override
  State<CreateEditEmployeeCategoryBottomSheetWidget> createState() => _CreateEditEmployeeCategoryBottomSheetWidgetState();
}

class _CreateEditEmployeeCategoryBottomSheetWidgetState extends State<CreateEditEmployeeCategoryBottomSheetWidget> {

  TextEditingController employeeCategoryController = TextEditingController();
  String selectedStatus = "";

  @override
  void initState() {
    employeeCategoryController.text = widget.employeeCategoryName;
    if (widget.isEdit) {
      selectedStatus = widget.status == "1" ? "Active" : "Inactive";
    } else {
      selectedStatus = "Active";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteEmployeeCategoryBloc, CreateEditDeleteEmployeeCategoryState>(
      listener: (context, state){
        if (state is LoadedCreateEmployeeCategoryState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateEmployeeCategoryState) {
          CommonToast.show(context,state.error);
        }
        else if (state is LoadedEditEmployeeCategoryState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditEmployeeCategoryState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context, state){
        if (state is LoadingCreateEmployeeCategoryState) {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadingEditEmployeeCategoryState) {
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
                    icon:  widget.isEdit == true
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
                    controller: employeeCategoryController,
                    label: "Category Name",
                    hint: "Enter Category Name..",
                  headerText:  "Category Name",
                  headerIcon: Icons.file_copy_outlined,
                  showHeader: true,
                ),
                CommonStatusDropdown(
                    value: selectedStatus,
                    onChanged: (val){
                      setState(() {
                        selectedStatus = val;
                      });
                    },
                    headerText: "Status",
                    headerIcon: Icons.toggle_on,
                    showHeader: true,
                ),
                CommonBottomActionButtons(
                    onTap: (){
                      final mappedStatus =
                      selectedStatus == "Active" ? "1" : "0";

                      if (widget.isEdit == true) {
                        BlocProvider.of<CreateEditDeleteEmployeeCategoryBloc>(context).add(
                            EditEmployeeCategoryEvent(
                                employeeCategoryId: widget.employeeCategoryId,
                                employeeCategoryName: employeeCategoryController.text,
                                status: mappedStatus
                            )
                        );
                      }
                      else {
                        BlocProvider.of<CreateEditDeleteEmployeeCategoryBloc>(context).add(
                            CreateEmployeeCategoryEvent(
                                employeeCategoryName: employeeCategoryController.text,
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
                        :  Icons.add
                )
              ],
            )
        );
      },
    );
  }
}