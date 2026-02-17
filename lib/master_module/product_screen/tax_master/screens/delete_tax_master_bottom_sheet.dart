import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/bloc/delete_tax_master_bloc/delete_tax_master_bloc.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/bloc/delete_tax_master_bloc/delete_tax_master_event.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/bloc/delete_tax_master_bloc/delete_tax_master_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteTaxMasterBottomSheet extends StatefulWidget {
  final String taxId;

  const DeleteTaxMasterBottomSheet({
    super.key,
    required this.taxId
  });

  @override
  State<DeleteTaxMasterBottomSheet> createState() => _DeleteTaxMasterBottomSheetState();
}

class _DeleteTaxMasterBottomSheetState extends State<DeleteTaxMasterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteTaxMasterBloc(),
      child: DeleteTaxMasterBottomSheetWidget(
        taxId: widget.taxId,
      ),
    );
  }
}


class DeleteTaxMasterBottomSheetWidget extends StatefulWidget {
  final String taxId;

  const DeleteTaxMasterBottomSheetWidget({
    super.key,
    required this.taxId
  });

  @override
  State<DeleteTaxMasterBottomSheetWidget> createState() => _DeleteTaxMasterBottomSheetWidgetState();
}

class _DeleteTaxMasterBottomSheetWidgetState extends State<DeleteTaxMasterBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteTaxMasterBloc,DeleteTaxMasterState>(
      listener: (context,state){
        if (state is LoadedDeleteTaxMasterState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureDeleteTaxMasterState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context,state){
        if (state is LoadingDeleteTaxMasterState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return CommonDeleteBottomSheet(
            title: 'Delete Tax',
            message:  "Are you sure you want to delete this"
                "Tax? All associated data will be"
                " permanently removed from the system.",
            onDelete:  ()  {
              BlocProvider.of<DeleteTaxMasterBloc>(context).add(
                  DeleteTaxMasterEvents(
                      taxId: widget.taxId
                  )
              );
            },
        );
      },
    );
  }
}
