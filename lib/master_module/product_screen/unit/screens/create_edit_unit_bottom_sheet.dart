import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/create_edit_delete_unit_bloc/create_edit_delete_unit_bloc.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/create_edit_delete_unit_bloc/create_edit_delete_unit_event.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/create_edit_delete_unit_bloc/create_edit_delete_unit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_color.dart';

class CreateEditUnitBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String unitName;
  final String unitId;
  final String status;

  const CreateEditUnitBottomSheet({
    required this.isEdit,
    required this.unitName,
    required this.unitId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditUnitBottomSheet> createState() => _CreateEditUnitBottomSheetState();
}

class _CreateEditUnitBottomSheetState extends State<CreateEditUnitBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteUnitBloc(),
      child: CreateEditUnitBottomSheetWidget(
        isEdit: widget.isEdit,
        unitName: widget.unitName,
        unitId: widget.unitId,
        status: widget.status,
      ),
    );
  }
}


class CreateEditUnitBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String unitName;
  final String unitId;
  final String status;

  const CreateEditUnitBottomSheetWidget({
    required this.isEdit,
    required this.unitName,
    required this.unitId,
    required this.status,
    super.key
  });

  @override
  State<CreateEditUnitBottomSheetWidget> createState() => _CreateEditUnitBottomSheetWidgetState();
}

class _CreateEditUnitBottomSheetWidgetState extends State<CreateEditUnitBottomSheetWidget> {

  TextEditingController unitController = TextEditingController();
  String selectedStatus = "";

  @override
  void initState() {
    unitController.text = widget.unitName;

    if (widget.isEdit) {
      selectedStatus = widget.status == "1" ? "Active" : "Inactive";
    } else {
      selectedStatus = "Active";
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteUnitBloc, CreateEditDeleteUnitState>(
      listener: (context, state){
        if (state is LoadedCreateUnitState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateUnitState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        else if (state is LoadedEditUnitState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditUnitState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state){
        if (state is LoadingCreateUnitState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is LoadingEditUnitState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return CommonBottomSheetContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonBottomSheetHeader(
                    icon: widget.isEdit == true
                        ? Icons.edit_outlined
                        :Icons.add_circle_outline,
                    title:  widget.isEdit == true
                        ? "Update Unit"
                        : "Add New Unit",
                    subtitle: widget.isEdit == true
                        ?"Modify Unit details below"
                        :"Fill in the details to create a new Unit",
                ),
                CommonTextField(
                    controller: unitController,
                    label: 'Unit Name',
                    hint: 'Enter unit Name(e.g.,kg,Liter,piece)'
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
                    onTap: () {
                      final mappedStatus =
                      selectedStatus == "Active" ? "1" : "0";

                      if (widget.isEdit == true){
                        BlocProvider.of<CreateEditDeleteUnitBloc>(context).add(
                            EditUnitEvent(
                              unitName: unitController.text,
                              status: mappedStatus,
                              unitId: widget.unitId,
                            )
                        );
                      }
                      else{
                        BlocProvider.of<CreateEditDeleteUnitBloc>(context).add(
                            CreateUnitEvent(
                              unitName: unitController.text,
                              status: mappedStatus,
                            )
                        );
                      }
                    },
                  submitText:  widget.isEdit == true
                      ?"Update Unit"
                      :"Save Unit",
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