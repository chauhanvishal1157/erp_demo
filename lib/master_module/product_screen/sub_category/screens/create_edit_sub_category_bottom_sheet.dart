import 'package:erp_demo/master_module/product_screen/sub_category/bloc/create_edit_delete_sub_category_bloc/create_edit_delete_sub_category_bloc.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/create_edit_delete_sub_category_bloc/create_edit_delete_sub_category_event.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/create_edit_delete_sub_category_bloc/create_edit_delete_sub_category_state.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/screens/select_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_color.dart';
import '../../../../common/common_field.dart';
import '../../../../common/create_edit_screen.dart';

class CreateEditSubCategoryBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String subCategoryName;
  final String subCategoryId;
  final String categoryName;
  final String categoryId;
  final String status;


  const CreateEditSubCategoryBottomSheet({
    required this.isEdit,
    required this.subCategoryName,
    required this.subCategoryId,
    required this.categoryName,
    required this.categoryId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditSubCategoryBottomSheet> createState() => _CreateEditSubCategoryBottomSheetState();
}

class _CreateEditSubCategoryBottomSheetState extends State<CreateEditSubCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteSubCategoryBloc(),
      child: CreateEditSubCategoryBottomSheetWidget(
        isEdit: widget.isEdit,
        subCategoryName: widget.subCategoryName,
        subCategoryId: widget.subCategoryId,
        categoryId: widget.categoryId,
        categoryName: widget.categoryName,
        status: widget.status,
      ),
    );
  }
}


class CreateEditSubCategoryBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String subCategoryName;
  final String subCategoryId;
  final String categoryName;
  final String categoryId;
  final String status;

  const CreateEditSubCategoryBottomSheetWidget({
    required this.isEdit,
    required this.subCategoryName,
    required this.subCategoryId,
    required this.categoryName,
    required this.categoryId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditSubCategoryBottomSheetWidget> createState() => _CreateEditSubCategoryBottomSheetWidgetState();
}

class _CreateEditSubCategoryBottomSheetWidgetState extends State<CreateEditSubCategoryBottomSheetWidget> {

  TextEditingController subCategoryController = TextEditingController();
  TextEditingController selectCategoryController = TextEditingController();

  String selectedStatus = "";
  String selectedCategoryId = "";
  String selectedCategoryName = "";

  @override
  void initState() {
    subCategoryController.text = widget.subCategoryName;
    selectCategoryController.text = widget.categoryName;

    selectedCategoryName = widget.categoryName;
    selectedCategoryId = widget.categoryId;


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
    return BlocConsumer<CreateEditDeleteSubCategoryBloc,CreateEditDeleteSubCategoryState>(
        listener: (context,state){
          if (state is LoadedCreateSubCategoryState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureCreateSubCategoryState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is LoadedEditSubCategoryState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureEditSubCategoryState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
            Navigator.of(context).pop(true);
          }
        },
        builder: (context,state){
          if (state is LoadingCreateSubCategoryState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is LoadingEditSubCategoryState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return  CommonBottomSheetContainer(
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonBottomSheetHeader(
                  icon:  widget.isEdit == true
                      ?Icons.edit_outlined
                      :Icons.add_circle_outline,
                  title:  widget.isEdit == true
                      ?"Update Sub Category"
                      : "Add  New Sub Category",
                  subtitle:  widget.isEdit == true
                      ? "Modify Sub Category details below"
                      :"Fill in the details to create a new Sub Category",
                ),
                CommonTextField(
                  controller: subCategoryController,
                  label: 'Sub Category',
                  hint: 'Enter sub category Name..',
                  prefixIcon: Icons.piano,
                ),
                CommonTextField(
                    controller: selectCategoryController,
                    label:  "Category",
                    hint: "select category",
                    prefixIcon: Icons.folder_outlined,
                  readOnly: true,
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectCategoryScreen()
                        )
                    ).then(
                          (value) {
                        selectedCategoryId = value[0];
                        selectedCategoryName = value[1];
                        selectCategoryController.text = value[1];
                        setState(() {});
                      },
                    );
                  },
                ),
                CommonStatusDropdown(
                  value: selectedStatus,
                  onChanged: (val) {
                    setState(() {
                      selectedStatus = val;
                    });
                  },
                ),
                CommonBottomActionButtons(
                  onTap: () {
                    final mappedStatus =
                    selectedStatus == "Active" ? "1" : "0";

                    if(widget.isEdit == true){
                      BlocProvider.of<CreateEditDeleteSubCategoryBloc>(context).add(
                          EditSubCategoryEvent(
                            subCategoryId: widget.subCategoryId,
                            categoryId:selectedCategoryId,
                            subCategoryName: subCategoryController.text,
                            status: mappedStatus,
                            categoryName: selectCategoryController.text,
                          )
                      );
                    }
                    else{
                      BlocProvider.of<CreateEditDeleteSubCategoryBloc>(context).add(
                          CreateSubCategoryEvent(
                            categoryId: selectedCategoryId,
                            subCategoryName: subCategoryController.text,
                            status: mappedStatus,
                            categoryName: selectCategoryController.text,
                          )
                      );
                    }
                  },
                  submitText:  widget.isEdit == true
                      ? "Update Sub Category"
                      : "Save Sub Category",
                  submitIcon:  widget.isEdit == true
                      ?Icons.update
                      :Icons.save_outlined,
                ),
              ],
            ),
          );
        }
    );
  }

}