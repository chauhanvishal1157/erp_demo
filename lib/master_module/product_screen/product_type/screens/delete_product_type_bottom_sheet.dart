import 'package:erp_demo/master_module/product_screen/product_type/bloc/create_edit_delete_product_type_bloc/create_edit_delete_product_type_bloc.dart';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/create_edit_delete_product_type_bloc/create_edit_delete_product_type_event.dart';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/create_edit_delete_product_type_bloc/create_edit_delete_product_type_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/common_delete_bottom_sheet.dart';

class DeleteProductTypeBottomSheet extends StatefulWidget {
  final String productId;

  const DeleteProductTypeBottomSheet({
    required this.productId,
    super.key
  });

  @override
  State<DeleteProductTypeBottomSheet> createState() => _DeleteProductTypeBottomSheetState();
}

class _DeleteProductTypeBottomSheetState extends State<DeleteProductTypeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteProductTypeBloc(),
      child: DeleteProductTypeBottomSheetWidget(
        productId: widget.productId,
      ),
    );
  }
}

class DeleteProductTypeBottomSheetWidget extends StatefulWidget {
  final String productId;

  const DeleteProductTypeBottomSheetWidget({
    required this.productId,
    super.key
  });

  @override
  State<DeleteProductTypeBottomSheetWidget> createState() => _DeleteProductTypeBottomSheetWidgetState();
}

class _DeleteProductTypeBottomSheetWidgetState extends State<DeleteProductTypeBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteProductTypeBloc,CreateEditDeleteProductTypeState>(
        listener: (context,state){
          if(state is LoadedDeleteProductTypeState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureDeleteProductTypeState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context,state){
          if(state is LoadingDeleteProductTypeState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CommonDeleteBottomSheet(
            title: 'Delete Type',
            message:  "Are you sure you want to delete this"
                " product type ?? All associated data will be"
                " permanently removed from the system.",
            onDelete: () {
              BlocProvider.of<CreateEditDeleteProductTypeBloc>(context).add(
                  DeleteProductTypeEvent(
                    productId: widget.productId,
                  )
              );
            },
          );
        });
  }
}
