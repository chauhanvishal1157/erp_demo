import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/create_edit_delete_payment_term_bloc/create_edit_delete_payment_term_bloc.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/create_edit_delete_payment_term_bloc/create_edit_delete_payment_term_event.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/create_edit_delete_payment_term_bloc/create_edit_delete_payment_term_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletePaymentTermsBottomSheet extends StatefulWidget {
  final String paymentTermsId;

  const DeletePaymentTermsBottomSheet({
    required this.paymentTermsId,
    super.key
  });

  @override
  State<DeletePaymentTermsBottomSheet> createState() => _DeletePaymentTermsBottomSheetState();
}

class _DeletePaymentTermsBottomSheetState extends State<DeletePaymentTermsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeletePaymentTermBloc(),
      child: DeletePaymentTermsBottomSheetWidget(
          paymentTermsId: widget.paymentTermsId,
      ),
    );
  }
}

class DeletePaymentTermsBottomSheetWidget extends StatefulWidget {
  final String paymentTermsId;

  const DeletePaymentTermsBottomSheetWidget({
    required this.paymentTermsId,
    super.key});

  @override
  State<DeletePaymentTermsBottomSheetWidget> createState() => _DeletePaymentTermsBottomSheetWidgetState();
}

class _DeletePaymentTermsBottomSheetWidgetState extends State<DeletePaymentTermsBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeletePaymentTermBloc,CreateEditDeletePaymentTermState>(
        listener: (context,state){
          if(state is LoadedDeletePaymentTermState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureDeletePaymentTermState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
            Navigator.of(context).pop(true);
          }
        },
        builder: (context,state){
          if(state is LoadingDeletePaymentTermState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CommonDeleteBottomSheet(
              title: 'Delete Payment Terms',
              message:  "Are you sure you want to delete this"
                  "product Payment Term? All associated data will be"
                  " permanently removed from the system.",
              onDelete: (){
                BlocProvider.of<CreateEditDeletePaymentTermBloc>(context).add(
                    DeletePaymentTermEvent(
                        paymentTermsId: widget.paymentTermsId
                    )
                );
              }
          );
        }
    );
  }
}
