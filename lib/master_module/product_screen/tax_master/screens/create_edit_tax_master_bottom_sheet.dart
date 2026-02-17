import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/bloc/create_edit_tax_master_bloc/create_edit_tax_master_bloc.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/bloc/create_edit_tax_master_bloc/create_edit_tax_master_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/create_edit_tax_master_bloc/create_edit_tax_master_state.dart';

class CreateEditTaxMasterBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String taxId;
  final String taxType;
  final String taxName;
  final String taxRate;
  final String status;

  const CreateEditTaxMasterBottomSheet({
    required this.isEdit,
    required this.taxId,
    required this.taxType,
    required this.taxName,
    required this.taxRate,
    required this.status,
    super.key
  });

  @override
  State<CreateEditTaxMasterBottomSheet> createState() => _CreateEditTaxMasterBottomSheetState();
}

class _CreateEditTaxMasterBottomSheetState extends State<CreateEditTaxMasterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditTaxMasterBloc(),
      child: CreateEditTaxMasterBottomSheetWidget(
        isEdit: widget.isEdit,
        taxId: widget.taxId,
        taxType: widget.taxType,
        taxName: widget.taxName,
        taxRate: widget.taxRate,
        status: widget.status,
      ),
    );
  }
}


class CreateEditTaxMasterBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String taxId;
  final String taxType;
  final String taxName;
  final String taxRate;
  final String status;

  const CreateEditTaxMasterBottomSheetWidget({
    required this.isEdit,
    required this.taxId,
    required this.taxType,
    required this.taxName,
    required this.taxRate,
    required this.status,
    super.key
});

  @override
  State<CreateEditTaxMasterBottomSheetWidget> createState() => _CreateEditTaxMasterBottomSheetWidgetState();
}

class _CreateEditTaxMasterBottomSheetWidgetState extends State<CreateEditTaxMasterBottomSheetWidget> {

  TextEditingController taxTypeController = TextEditingController();
  TextEditingController taxNameController = TextEditingController();
  TextEditingController taxRateController = TextEditingController();

  String selectedStatus = "";

  @override
  void initState() {
    taxTypeController.text = widget.taxType;
    taxNameController.text = widget.taxName;
    taxRateController.text = widget.taxRate;
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
    return BlocConsumer<CreateEditTaxMasterBloc,CreateEditTaxMasterState>(
        listener: (context, state){
          if(state is LoadedCreateTaxMasterState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureCreateTaxMasterState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is LoadedEditTaxMasterState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureEditTaxMasterState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          Navigator.of(context).pop(true);
        },
        builder: (context, state){
          if(state is LoadingCreateTaxMasterState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is LoadingEditTaxMasterState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return  CommonBottomSheetContainer(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonBottomSheetHeader(
                      icon:  widget.isEdit == true
                          ? Icons.edit_outlined
                          : Icons.add_circle_outline,
                      title:  widget.isEdit == true
                          ? "Update Tax"
                          : "Add New Tax",
                      subtitle:  widget.isEdit == true
                          ? "Modify tax details below"
                          :"Fill in the details to create a new tax",
                    ),
                    CommonTextField(
                      controller: taxTypeController,
                      label: 'Tax Type',
                      hint: 'Ex.SGST',
                      prefixIcon: Icons.category_outlined,
                    ),
                    CommonTextField(
                      controller: taxNameController,
                      label: 'Tax TyNamee',
                      hint: 'Ex.SGST@2.5',
                      prefixIcon: Icons.sailing,
                    ),
                    CommonTextField(
                      controller: taxRateController,
                      label: 'Tax Rate',
                      hint: 'Ex.2.50',
                      prefixIcon: Icons.percent,
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
                
                          if (widget.isEdit == true) {
                            BlocProvider.of<CreateEditTaxMasterBloc>(context).add(
                              EditTaxMasterEvent(
                                  taxId: widget.taxId,
                                  taxType: taxTypeController.text,
                                  taxName: taxNameController.text,
                                  taxRate: taxRateController.text,
                                  status: mappedStatus
                              ),
                            );
                          }
                          else{
                            BlocProvider.of<CreateEditTaxMasterBloc>(context).add(
                                CreateTaxMasterEvent(
                                    taxType: taxTypeController.text,
                                    taxName: taxNameController.text,
                                    taxRate: taxRateController.text,
                                    status: mappedStatus
                                )
                            );
                          }
                        },
                        submitText:  widget.isEdit == true
                            ?"Update Tax"
                            : "Save Tax",
                        submitIcon:  widget.isEdit == true
                            ? Icons.update
                            :Icons.save_outlined,
                    )
                  ],
                ),
              )
          );
        }
    );
  }


}
