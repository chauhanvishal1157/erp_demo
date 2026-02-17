import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/product_screen/category/bloc/create_edit_category_master_bloc/create_edit_category_master_bloc.dart';
import 'package:erp_demo/master_module/product_screen/category/bloc/create_edit_category_master_bloc/create_edit_category_master_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/create_edit_category_master_bloc/create_edit_category_master_state.dart';

class CreateEditCategoryMasterBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String categoryName;
  final String categoryId;
  final String status;

  const CreateEditCategoryMasterBottomSheet({
    required this.isEdit,
    required this.categoryName,
    required this.categoryId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditCategoryMasterBottomSheet> createState() => _CreateEditCategoryMasterBottomSheetState();
}

class _CreateEditCategoryMasterBottomSheetState extends State<CreateEditCategoryMasterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditCategoryMasterBloc(),
      child: CreateEditCategoryMasterBottomSheetWidget(
        isEdit: widget.isEdit,
        categoryName: widget.categoryName,
        categoryId: widget.categoryId,
        status: widget.status,
      ),
    );
  }
}

class CreateEditCategoryMasterBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String categoryName;
  final String categoryId;
  final String status;

  const CreateEditCategoryMasterBottomSheetWidget({
    required this.isEdit,
    required this.categoryName,
    required this.categoryId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditCategoryMasterBottomSheetWidget> createState() => _CreateEditCategoryMasterBottomSheetWidgetState();
}

class _CreateEditCategoryMasterBottomSheetWidgetState extends State<CreateEditCategoryMasterBottomSheetWidget> {

  TextEditingController categoryNameController = TextEditingController();

  String selectedStatus = "";

  @override
  void initState() {
    categoryNameController.text = widget.categoryName;
    if (widget.isEdit) {
      selectedStatus = widget.status == "1" ? "Active" : "Inactive";
    } else {
      selectedStatus = "Active";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditCategoryMasterBloc, CreateEditCategoryMasterState>(
      listener: (context, state){
        if (state is LoadedCreateCategoryMasterState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateCategoryMasterState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        else if (state is LoadedEditCategoryMasterState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditCategoryMasterState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
        builder: (context, state){
          if (state is LoadingCreateCategoryMasterState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is LoadingEditCategoryMasterState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return  CommonBottomSheetContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonBottomSheetHeader(
                      icon:  widget.isEdit == true
                          ?Icons.edit_outlined
                          :Icons.add_circle_outline,
                      title:  widget.isEdit == true
                          ? "Update Category"
                          : "Add New Category",
                      subtitle:  widget.isEdit == true
                          ?"Modify category details below"
                          :"Fill in the details to create a new category",
                  ),
                  CommonTextField(
                      controller: categoryNameController,
                      label: 'Category',
                      hint: 'Enter category Name..',
                    prefixIcon: Icons.piano,
                  ),
                  CommonStatusDropdown(
                      value: selectedStatus,
                    onChanged: (String val) {
                      selectedStatus = val;
                    },
                  ),
                  CommonBottomActionButtons(
                      onTap: (){
                        final mappedStatus =
                        selectedStatus == "Active" ? "1" : "0";

                        if (widget.isEdit == true) {
                          BlocProvider.of<CreateEditCategoryMasterBloc>(context).add(
                              EditCategoryMasterEvent(
                                categoryName: categoryNameController.text,
                                categoryId: widget.categoryId,
                                status:mappedStatus,
                              )
                          );
                        }
                        else {
                          BlocProvider.of<CreateEditCategoryMasterBloc>(context).add(
                              CreateCategoryMasterEvent(
                                categoryName: categoryNameController.text,
                                status: mappedStatus,
                              )
                          );
                        }
                      },
                      submitText:  widget.isEdit == true
                          ?"Update Category"
                          :"Save Category",
                      submitIcon:  widget.isEdit == true
                          ? Icons.update
                          :  Icons.save_outlined,
                  )
                ],
              )
          );
        },
    );
  }
}
