import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/create_edit_delete_unit_bloc/create_edit_delete_unit_bloc.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/create_edit_delete_unit_bloc/create_edit_delete_unit_event.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_edit_delete_unit_bloc/create_edit_delete_unit_state.dart';

class DeleteUnitBottomSheet extends StatefulWidget {
  final String unitId;

  const DeleteUnitBottomSheet({
    required this.unitId,
    super.key
  });

  @override
  State<DeleteUnitBottomSheet> createState() => _DeleteUnitBottomSheetState();
}

class _DeleteUnitBottomSheetState extends State<DeleteUnitBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteUnitBloc(),
      child: DeleteUnitBottomSheetWidget(
        unitId: widget.unitId,
      ),
    );
  }
}

class DeleteUnitBottomSheetWidget extends StatefulWidget {
  final String unitId;
  const DeleteUnitBottomSheetWidget({
    required this.unitId,
    super.key});

  @override
  State<DeleteUnitBottomSheetWidget> createState() => _DeleteUnitBottomSheetWidgetState();
}

class _DeleteUnitBottomSheetWidgetState extends State<DeleteUnitBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteUnitBloc,CreateEditDeleteUnitState>(
        listener: (context,state){
          if(state is LoadedDeleteUnitState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureDeleteUnitState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
            Navigator.of(context).pop(true);
          }
        },
        builder: (context,state){
          if(state is LoadingDeleteUnitState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CommonDeleteBottomSheet(
              title:  "Delete Unit",
              message:  "Are you sure you want to delete this"
                  "product Unit? All associated data will be"
                  " permanently removed from the system.",
              onDelete: (){
                BlocProvider.of<CreateEditDeleteUnitBloc>(context).add(
                  DeleteUnitEvent(
                      unitId: widget.unitId
                  ),
                );
              }
          );
        }
    );
  }
}
