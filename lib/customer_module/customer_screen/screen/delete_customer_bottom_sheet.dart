import 'package:erp_demo/customer_module/customer_screen/bloc/create_edit_delete_customer_bloc/create_edit_delete_customer_bloc.dart';
import 'package:erp_demo/customer_module/customer_screen/bloc/create_edit_delete_customer_bloc/create_edit_delete_customer_event.dart';
import 'package:erp_demo/customer_module/customer_screen/bloc/create_edit_delete_customer_bloc/create_edit_delete_customer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common_delete_bottom_sheet.dart';

class DeleteCustomerBottomSheet extends StatefulWidget {
  final String customerId;
  const DeleteCustomerBottomSheet({
    required this.customerId,
    super.key});

  @override
  State<DeleteCustomerBottomSheet> createState() => _DeleteCustomerBottomSheetState();
}

class _DeleteCustomerBottomSheetState extends State<DeleteCustomerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => CreateEditDeleteCustomerBloc(),
      child: DeleteCustomerBottomSheetWidget(
        customerId: widget.customerId,
      ),
    );
  }
}


class DeleteCustomerBottomSheetWidget extends StatefulWidget {
  final String customerId;
  const DeleteCustomerBottomSheetWidget({
    required this.customerId,
    super.key});

  @override
  State<DeleteCustomerBottomSheetWidget> createState() => _DeleteCustomerBottomSheetWidgetState();
}

class _DeleteCustomerBottomSheetWidgetState extends State<DeleteCustomerBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CreateEditDeleteCustomerBloc,CreateEditDeleteCustomerState>(
      listener: (context,state){
        if (state is LoadedDeleteCustomerState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureDeleteCustomerState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context,state){
        if (state is LoadingDeleteCustomerState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return CommonDeleteBottomSheet(
          title: 'Delete Customer',
          message:  "Are you sure you want to delete this"
              "  Customer ?? All associated data will be"
              " permanently removed from the system.",
          onDelete: () {
            BlocProvider.of<CreateEditDeleteCustomerBloc>(context).add(
               DeleteCustomerEvent(
                   customerId:
                   widget.customerId
               )
            );
          },
        );
      },
    );
  }
}
