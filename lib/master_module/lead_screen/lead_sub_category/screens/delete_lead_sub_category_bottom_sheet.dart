import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/bloc/create_edit_delete_lead_sub_category_bloc/create_edit_delete_lead_sub_category_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/bloc/create_edit_delete_lead_sub_category_bloc/create_edit_delete_lead_sub_category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../common/common_toast.dart';
import '../bloc/create_edit_delete_lead_sub_category_bloc/create_edit_delete_lead_sub_category_state.dart';

class DeleteLeadSubCategoryBottomSheet extends StatefulWidget {
  final String leadSubCategoryId;
  const DeleteLeadSubCategoryBottomSheet({
    required this.leadSubCategoryId,
    super.key});

  @override
  State<DeleteLeadSubCategoryBottomSheet> createState() => _DeleteLeadSubCategoryBottomSheetState();
}

class _DeleteLeadSubCategoryBottomSheetState extends State<DeleteLeadSubCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteLeadSubCategoryBloc(),
      child: DeleteLeadSubCategoryBottomSheetWidget(
          leadSubCategoryId: widget.leadSubCategoryId
      ),
    );
  }
}

class DeleteLeadSubCategoryBottomSheetWidget extends StatefulWidget {
  final String leadSubCategoryId;
  const DeleteLeadSubCategoryBottomSheetWidget({
    required this.leadSubCategoryId,
    super.key});

  @override
  State<DeleteLeadSubCategoryBottomSheetWidget> createState() => _DeleteLeadSubCategoryBottomSheetWidgetState();
}

class _DeleteLeadSubCategoryBottomSheetWidgetState extends State<DeleteLeadSubCategoryBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteLeadSubCategoryBloc,CreateEditDeleteLeadSubCategoryState>(
        listener: (context,state){
          if(state is LoadedDeleteLeadSubCategoryState){
            CommonToast.show(context,state.message);
            Navigator.of(context).pop(true);
          }
          else if(state is FailureDeleteLeadSubCategoryState){
            CommonToast.show(context,state.error);
            Navigator.of(context).pop(true);
          }
        },
        builder: (context,state){
          if(state is LoadingDeleteLeadSubCategoryState){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          return CommonDeleteBottomSheet(
              title: "Delete Sub Category",
              message: "Are you sure you want to delete this"
                  "product sub Category? All associated data will be"
                  " permanently removed from the system.",
              onDelete: ()  {
                BlocProvider.of<CreateEditDeleteLeadSubCategoryBloc>(context).add(
                    DeleteLeadSubCategoryEvent(
                        leadSubCategoryId: widget.leadSubCategoryId
                    )
                );
              },
          );
        }
    );
  }
}

