import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/create_edit_delete_rejection_reason_bloc/create_edit_delete_rejection_reason_event.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/create_edit_delete_rejection_reason_bloc/create_edit_delete_rejection_reason_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;
import '../../../../common/common_delete_bottom_sheet.dart';
import '../../../../common/common_toast.dart';
import '../bloc/create_edit_delete_rejection_reason_bloc/create_edit_delete_rejection_reason_bloc.dart';

class DeleteRejectionReasonBottomSheet extends StatefulWidget {
  final String reasonId;

  const DeleteRejectionReasonBottomSheet({
    required this.reasonId,
    super.key});

  @override
  State<DeleteRejectionReasonBottomSheet> createState() => _DeleteRejectionReasonBottomSheetState();
}

class _DeleteRejectionReasonBottomSheetState extends State<DeleteRejectionReasonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteRejectionReasonBloc(),
      child: DeleteRejectionReasonBottomSheetWidget(
        reasonId: widget.reasonId,
      )
    );
  }
}

class DeleteRejectionReasonBottomSheetWidget extends StatefulWidget {
  final String reasonId;

  const DeleteRejectionReasonBottomSheetWidget({
    required this.reasonId,
    super.key});

  @override
  State<DeleteRejectionReasonBottomSheetWidget> createState() => _DeleteRejectionReasonBottomSheetWidgetState();
}

class _DeleteRejectionReasonBottomSheetWidgetState extends State<DeleteRejectionReasonBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteRejectionReasonBloc,CreateEditDeleteRejectionReasonState>(
      listener: (context,state){
        if (state is LoadedDeleteRejectionReasonState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureDeleteRejectionReasonState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context,state){
        if (state is LoadingDeleteRejectionReasonState) {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        return CommonDeleteBottomSheet(
            title: "Delete Reason",
            message: "Are you sure you want to delete this"
                "product Reason? All associated data will be"
                " permanently removed from the system.",
            onDelete: (){
              BlocProvider.of<CreateEditDeleteRejectionReasonBloc>(context).add(
                  DeleteRejectionReasonEvent(
                      reasonId: widget.reasonId
                  )
              );
            }
        );
      },
    );
  }
}
