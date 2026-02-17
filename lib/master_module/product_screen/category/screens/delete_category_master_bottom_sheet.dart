import 'package:erp_demo/master_module/product_screen/category/bloc/delete_category_master_bloc/delete_category_master_bloc.dart';
import 'package:erp_demo/master_module/product_screen/category/bloc/delete_category_master_bloc/delete_category_master_state.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common_delete_bottom_sheet.dart';
import '../bloc/delete_category_master_bloc/delete_category_master_event.dart';

class DeleteCategoryMasterBottomSheet extends StatefulWidget {
  final String categoryId;

  const DeleteCategoryMasterBottomSheet({
    required this.categoryId,
    super.key
  });

  @override
  State<DeleteCategoryMasterBottomSheet> createState() => _DeleteCategoryMasterBottomSheetState();
}

class _DeleteCategoryMasterBottomSheetState extends State<DeleteCategoryMasterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteCategoryMasterBloc(),
      child: DeleteCategoryMasterBottomSheetWidget(
        categoryId: widget.categoryId,
      ),
    );
  }
}


class DeleteCategoryMasterBottomSheetWidget extends StatefulWidget {
  final String categoryId;

  const DeleteCategoryMasterBottomSheetWidget({
    required this.categoryId,
    super.key
  });

  @override
  State<DeleteCategoryMasterBottomSheetWidget> createState() => _DeleteCategoryMasterBottomSheetWidgetState();
}

class _DeleteCategoryMasterBottomSheetWidgetState extends State<DeleteCategoryMasterBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCategoryMasterBloc,DeleteCategoryMasterState>(
      listener: (context,state){
        if (state is LoadedDeleteCategoryMasterState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureDeleteCategoryMasterState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
        builder: (context,state){
          if (state is LoadingDeleteCategoryMasterState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CommonDeleteBottomSheet(
            title: 'Delete Category',
            message:  "Are you sure you want to delete this"
                " product Category ?? All associated data will be"
                " permanently removed from the system.",
            onDelete: () {
              BlocProvider.of<DeleteCategoryMasterBloc>(context).add(
                  DeleteCategoryMasterEvents(
                    categoryId: widget.categoryId,
                  )
              );
            },
          );
        },
    );
  }
}

