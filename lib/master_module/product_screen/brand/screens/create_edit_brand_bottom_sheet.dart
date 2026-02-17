import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/create_edit_brand_bloc/create_edit_brand_bloc.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/create_edit_brand_bloc/create_edit_brand_event.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/create_edit_brand_bloc/create_edit_brand_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_color.dart';

class CreateEditBrandBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String brandName;
  final String brandId;
  final String status;

  const CreateEditBrandBottomSheet({
    required this.isEdit,
    required this.brandName,
    required this.brandId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditBrandBottomSheet> createState() => _CreateEditBrandBottomSheetState();
}

class _CreateEditBrandBottomSheetState extends State<CreateEditBrandBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> CreateEditBrandBloc(),
      child: CreateEditBrandBottomSheetWidget(
        isEdit: widget.isEdit,
        brandName: widget.brandName,
        brandId: widget.brandId,
        status: widget.status,
      ),
    );
  }
}


class CreateEditBrandBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String brandName;
  final String brandId;
  final String status;

  const CreateEditBrandBottomSheetWidget({
    required this.isEdit,
    required this.brandName,
    required this.brandId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditBrandBottomSheetWidget> createState() => _CreateEditBrandBottomSheetWidgetState();
}

class _CreateEditBrandBottomSheetWidgetState extends State<CreateEditBrandBottomSheetWidget> {

  TextEditingController brandController = TextEditingController();
  String selectedStatus = "";

  @override
  void initState() {
    brandController.text = widget.brandName;
    if (widget.isEdit) {
      selectedStatus = widget.status == "1" ? "Active" : "Inactive";
    } else {
      selectedStatus = "Active";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditBrandBloc, CreateEditBrandState>(
      listener: (context, state){
        if (state is LoadedCreateBrandState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateBrandState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        else if (state is LoadedEditBrandState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditBrandState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state){
        if (state is LoadingCreateBrandState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is LoadingEditBrandState) {
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
                        ? "Update Brand"
                        : "Add New Brand",
                    subtitle:  widget.isEdit == true
                        ?"Modify Brand details below"
                        :"Fill in the details to create a new Brand",
                ),
                CommonTextField(
                    controller: brandController,
                    label: 'Brand',
                    hint: 'Enter Brand Name..',
                  prefixIcon: Icons.straighten,
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
                    onTap: (){
                      final mappedStatus =
                      selectedStatus == "Active" ? "1" : "0";

                      if (widget.isEdit == true) {
                        BlocProvider.of<CreateEditBrandBloc>(context).add(
                            EditBrandEvent(
                                brandId: widget.brandId,
                                brandName: brandController.text,
                                status: mappedStatus
                            )
                        );
                      }
                      else {
                        BlocProvider.of<CreateEditBrandBloc>(context).add(
                            CreateBrandEvent(
                              status: mappedStatus,
                              brandName: brandController.text,
                            )
                        );
                      }
                    },
                    submitText:
                    widget.isEdit == true
                        ?"Update Brand"
                        :"Save Brand",
                    submitIcon:
                    widget.isEdit == true
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
