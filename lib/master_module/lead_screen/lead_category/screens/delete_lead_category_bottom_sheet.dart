import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/create_edit_delete_lead_category_bloc/create_edit_delete_lead_category_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/create_edit_delete_lead_category_bloc/create_edit_delete_lead_category_event.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/create_edit_delete_lead_category_bloc/create_edit_delete_lead_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/common_toast.dart';

class DeleteLeadCategoryBottomSheet extends StatefulWidget {
  final String leadCategoryId;

  const DeleteLeadCategoryBottomSheet({
    required this.leadCategoryId,
    super.key
  });

  @override
  State<DeleteLeadCategoryBottomSheet> createState() => _DeleteLeadCategoryBottomSheetState();
}

class _DeleteLeadCategoryBottomSheetState extends State<DeleteLeadCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteLeadCategoryBloc(),
      child: DeleteLeadCategoryBottomSheetWidget(
          leadCategoryId: widget.leadCategoryId
      ),
    );
  }
}

class DeleteLeadCategoryBottomSheetWidget extends StatefulWidget {
  final String leadCategoryId;

  const DeleteLeadCategoryBottomSheetWidget({
    required this.leadCategoryId,
    super.key
  });

  @override
  State<DeleteLeadCategoryBottomSheetWidget> createState() => _DeleteLeadCategoryBottomSheetWidgetState();
}

class _DeleteLeadCategoryBottomSheetWidgetState extends State<DeleteLeadCategoryBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteLeadCategoryBloc,CreateEditDeleteLeadCategoryState>(
      listener: (context,state){
        if (state is LoadedDeleteLeadCategoryState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureDeleteLeadCategoryState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context,state){
        if (state is LoadingDeleteLeadCategoryState) {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        return CommonDeleteBottomSheet(
            title: "Delete Category",
            message:   "Are you sure you want to delete this"
                "product Category? All associated data will be"
                " permanently removed from the system.",
            onDelete: (){
              BlocProvider.of<CreateEditDeleteLeadCategoryBloc>(context).add(
                  DeleteLeadCategoryEvent(
                      leadCategoryId: widget.leadCategoryId
                  )
              );
            }
        );
      },
    );
  }
}

