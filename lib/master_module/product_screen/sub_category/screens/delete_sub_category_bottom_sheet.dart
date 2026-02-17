import 'package:erp_demo/master_module/product_screen/sub_category/bloc/create_edit_delete_sub_category_bloc/create_edit_delete_sub_category_bloc.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/create_edit_delete_sub_category_bloc/create_edit_delete_sub_category_event.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/create_edit_delete_sub_category_bloc/create_edit_delete_sub_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common_delete_bottom_sheet.dart';

class DeleteSubCategoryBottomSheet extends StatefulWidget {
  final String subCategoryId;

  const DeleteSubCategoryBottomSheet({
    required this.subCategoryId,
    super.key});

  @override
  State<DeleteSubCategoryBottomSheet> createState() => _DeleteSubCategoryBottomSheetState();
}

class _DeleteSubCategoryBottomSheetState extends State<DeleteSubCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => CreateEditDeleteSubCategoryBloc(),
      child: DeleteSubCategoryBottomSheetWidget(
          subCategoryId: widget.subCategoryId
      ),
    );
  }
}

class DeleteSubCategoryBottomSheetWidget extends StatefulWidget {
  final String subCategoryId;

  const DeleteSubCategoryBottomSheetWidget({
    required this.subCategoryId,
    super.key});

  @override
  State<DeleteSubCategoryBottomSheetWidget> createState() => _DeleteSubCategoryBottomSheetWidgetState();
}

class _DeleteSubCategoryBottomSheetWidgetState extends State<DeleteSubCategoryBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteSubCategoryBloc,CreateEditDeleteSubCategoryState>(
        listener: (context,state){
          if(state is LoadedDeleteSubCategoryState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureDeleteSubCategoryState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
            Navigator.of(context).pop(true);
          }
        },
        builder: (context,state){
          if(state is LoadingDeleteSubCategoryState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CommonDeleteBottomSheet(
            title: 'Delete Sub Category',
            message:  "Are you sure you want to delete this"
                " product sub Category ?? All associated data will be"
                " permanently removed from the system.",
            onDelete: () {
              BlocProvider.of<CreateEditDeleteSubCategoryBloc>(context).add(
                  DeleteSubCategoryEvent(
                      subCategoryId: widget.subCategoryId
                  )
              );
            },
          );
        }
    );
  }
}
