import 'package:erp_demo/master_module/product_screen/product_type/bloc/create_edit_delete_product_type_bloc/create_edit_delete_product_type_bloc.dart';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/create_edit_delete_product_type_bloc/create_edit_delete_product_type_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common_field.dart';
import '../../../../common/create_edit_screen.dart';
import '../bloc/create_edit_delete_product_type_bloc/create_edit_delete_product_type_event.dart';

class CreateEditProductTypeBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String productName;
  final String status;
  final String productId;

  const CreateEditProductTypeBottomSheet({
    required this.isEdit,
    required this.productName,
    required this.status,
    required this.productId,
    super.key
  });

  @override
  State<CreateEditProductTypeBottomSheet> createState() => _CreateEditProductTypeBottomSheetState();
}

class _CreateEditProductTypeBottomSheetState extends State<CreateEditProductTypeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> CreateEditDeleteProductTypeBloc(),
      child: CreateEditProductTypeBottomSheetWidget(
          isEdit: widget.isEdit,
          productName: widget.productName,
          status: widget.status,
          productId: widget.productId
      ),
    );
  }
}


class CreateEditProductTypeBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String productName;
  final String status;
  final String productId;

  const CreateEditProductTypeBottomSheetWidget({
    required this.isEdit,
    required this.productName,
    required this.status,
    required this.productId,
    super.key
});

  @override
  State<CreateEditProductTypeBottomSheetWidget> createState() => _CreateEditProductTypeBottomSheetWidgetState();
}

class _CreateEditProductTypeBottomSheetWidgetState extends State<CreateEditProductTypeBottomSheetWidget> {

  TextEditingController productController = TextEditingController();
  String selectedStatus = "";

  @override
  void initState() {
    productController.text = widget.productName;

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
    return BlocConsumer<CreateEditDeleteProductTypeBloc,CreateEditDeleteProductTypeState>(
      listener: (context,state){
        if (state is LoadedCreateProductTypeState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateProductTypeState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is LoadedEditProductTypeState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditProductTypeState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
          Navigator.of(context).pop(true);
        }
        },
        builder: (context,state){
        if (state is LoadingCreateProductTypeState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is LoadingEditProductTypeState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return CommonBottomSheetContainer(
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonBottomSheetHeader(
                  icon:  widget.isEdit == true
                      ?Icons.edit_outlined
                      :Icons.add_circle_outline,
                  title:  widget.isEdit == true
                      ?"Update Product Type"
                      : "Add Product Type",
                  subtitle:  widget.isEdit == true
                      ? "Modify product type details below"
                      :"Fill in the details to create a new product type",
                ),
                CommonTextField(
                  controller: productController,
                  label: 'product Type Name',
                  hint: 'Enter Product Name..',
                  prefixIcon: Icons.piano,
                ),
                CommonStatusDropdown(
                  value: selectedStatus,
                  onChanged: (val) {
                    setState(() {
                      selectedStatus = val;
                    });
                  },
                ),
                CommonBottomActionButtons(
                  onTap: () {
                    final mappedStatus =
                    selectedStatus == "Active" ? "1" : "0";
                    if(widget.isEdit == true){
                      BlocProvider.of<CreateEditDeleteProductTypeBloc>(context).add(
                          EditProductTypeEvent(
                            productId: widget.productId,
                            productName: productController.text,
                            status: mappedStatus,
                          )
                      );
                    }
                    else{
                      BlocProvider.of<CreateEditDeleteProductTypeBloc>(context).add(
                          CreateProductTypeEvent(
                            productName: productController.text,
                            status: mappedStatus,
                          )
                      );
                    }
                  },
                  submitText:  widget.isEdit == true
                      ? "Update Type"
                      : "Save Type",
                  submitIcon:  widget.isEdit == true
                      ?Icons.update
                      :Icons.save_outlined,
                ),
              ],
            ),
        );
      }
    );
  }
}
