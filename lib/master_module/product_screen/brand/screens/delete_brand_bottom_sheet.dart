import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/delete_brand_bloc/delete_brand_bloc.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/delete_brand_bloc/delete_brand_event.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/delete_brand_bloc/delete_brand_state.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteBrandBottomSheet extends StatefulWidget {
  final String brandId;

  const DeleteBrandBottomSheet({
    required this.brandId,
    super.key
  });

  @override
  State<DeleteBrandBottomSheet> createState() => _DeleteBrandBottomSheetState();
}

class _DeleteBrandBottomSheetState extends State<DeleteBrandBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteBrandBloc(),
      child: DeleteBrandBottomSheetWidget(
        brandId: widget.brandId,
      ),
    );
  }
}

class DeleteBrandBottomSheetWidget extends StatefulWidget {
  final String brandId;

  const DeleteBrandBottomSheetWidget({
    required this.brandId,
    super.key
  });

  @override
  State<DeleteBrandBottomSheetWidget> createState() => _DeleteBrandBottomSheetWidgetState();
}

class _DeleteBrandBottomSheetWidgetState extends State<DeleteBrandBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteBrandBloc,DeleteBrandState>(
        builder: (context,state){
          if(state is LoadingDeleteBrandState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CommonDeleteBottomSheet(
              title:  "Delete Brand",
              message:  "Are you sure you want to delete this"
                  "product Brand? All associated data will be"
                  " permanently removed from the system.",
              onDelete: ()  {
                BlocProvider.of<DeleteBrandBloc>(context).add(
                    DeleteBrandEvents(
                        brandId: widget.brandId
                    )
                );
              },
          );
        },
        listener: (context,state){
          if(state is LoadedDeleteBrandState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          else if(state is FailureDeleteBrandState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error),
              )
            );
          }
        });
  }
}

