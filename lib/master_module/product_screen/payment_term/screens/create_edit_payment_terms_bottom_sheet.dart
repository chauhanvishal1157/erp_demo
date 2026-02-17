import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/create_edit_delete_payment_term_bloc/create_edit_delete_payment_term_bloc.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/create_edit_delete_payment_term_bloc/create_edit_delete_payment_term_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/create_edit_delete_payment_term_bloc/create_edit_delete_payment_term_event.dart';

class CreateEditPaymentTermsBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String paymentTermsName;
  final String paymentTermsId;
  final String status;

  const CreateEditPaymentTermsBottomSheet({
    required this.isEdit,
    required this.paymentTermsName,
    required this.paymentTermsId,
    required this.status,
    super.key,

  });

  @override
  State<CreateEditPaymentTermsBottomSheet> createState() => _CreateEditPaymentTermsBottomSheetState();
}

class _CreateEditPaymentTermsBottomSheetState extends State<CreateEditPaymentTermsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeletePaymentTermBloc(),
      child: CreateEditPaymentTermsBottomSheetWidget(
          isEdit: widget.isEdit,
          paymentTermsName: widget.paymentTermsName,
          paymentTermsId: widget.paymentTermsId,
          status: widget.status
      ),
    );
  }
}

class CreateEditPaymentTermsBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String paymentTermsName;
  final String paymentTermsId;
  final String status;


  const CreateEditPaymentTermsBottomSheetWidget({
    required this.isEdit,
    required this.paymentTermsName,
    required this.paymentTermsId,
    required this.status,
    super.key,
  });

  @override
  State<CreateEditPaymentTermsBottomSheetWidget> createState() => _CreateEditPaymentTermsBottomSheetWidgetState();
}

class _CreateEditPaymentTermsBottomSheetWidgetState extends State<CreateEditPaymentTermsBottomSheetWidget> {

  TextEditingController paymentController = TextEditingController();

  String selectedStatus = "";

  @override
  void initState() {
    paymentController.text = widget.paymentTermsName;

    if (widget.isEdit) {
      selectedStatus = widget.status == "1" ? "Active" : "Inactive";
    } else {
      selectedStatus = "Active";
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeletePaymentTermBloc, CreateEditDeletePaymentTermState>(
      listener: (context, state){
        if (state is LoadedCreatePaymentTermState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreatePaymentTermState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        else if (state is LoadedEditPaymentTermState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditPaymentTermState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state){
        if (state is LoadingCreatePaymentTermState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is LoadingEditPaymentTermState) {
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
                        ? Icons.edit_outlined
                        :Icons.add_circle_outline,
                    title:  widget.isEdit == true
                        ? "Update Payment Term"
                        : "Add New Payment Term",
                    subtitle: widget.isEdit == true
                        ?"Modify payment term details below"
                        :"Fill in the details to create a new payment term"
                ),
                CommonTextField(
                    controller: paymentController,
                    label: "Payment Terms",
                    hint: "Enter Payment Terms..",
                  prefixIcon: Icons.payment_outlined,
                ),
                CommonStatusDropdown(
                    value: selectedStatus,
                    onChanged: (val){
                      setState(() {
                        selectedStatus = val;
                      });
                    }
                ),
                CommonBottomActionButtons(
                    onTap: (){
                      final mappedStatus =
                      selectedStatus == "Active" ? "1" : "0";

                      if (widget.isEdit == true){
                        BlocProvider.of<CreateEditDeletePaymentTermBloc>(context).add(
                            EditPaymentTermEvent(
                              paymentTermsName: paymentController.text,
                              status: mappedStatus,
                              paymentTermsId: widget.paymentTermsId,
                            )
                        );
                      }
                      else{
                        BlocProvider.of<CreateEditDeletePaymentTermBloc>(context).add(
                            CreatePaymentTermEvent(
                              paymentTermsName: paymentController.text,
                              status: mappedStatus,
                            )
                        );
                      }
                    },
                    submitText: widget.isEdit == true
                        ?"Update Payment Term"
                        :"Save Payment Term",
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
