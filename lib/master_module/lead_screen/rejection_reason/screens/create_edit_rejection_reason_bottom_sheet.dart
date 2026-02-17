import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/create_edit_delete_rejection_reason_bloc/create_edit_delete_rejection_reason_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/create_edit_delete_rejection_reason_bloc/create_edit_delete_rejection_reason_event.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/create_edit_delete_rejection_reason_bloc/create_edit_delete_rejection_reason_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../common/common_field.dart';
import '../../../../common/common_toast.dart';
import '../../../../common/create_edit_screen.dart';

class CreateEditRejectionReasonBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String reasonId;
  final String reason;
  final String status;

  const CreateEditRejectionReasonBottomSheet({
    required this.isEdit,
    required this.reasonId,
    required this.reason,
    required this.status,
    super.key
  });

  @override
  State<CreateEditRejectionReasonBottomSheet> createState() => _CreateEditRejectionReasonBottomSheetState();
}

class _CreateEditRejectionReasonBottomSheetState extends State<CreateEditRejectionReasonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreateEditDeleteRejectionReasonBloc(),
      child: CreateEditRejectionReasonBottomSheetWidget(
          isEdit: widget.isEdit,
          reasonId: widget.reasonId,
          reason: widget.reason,
          status: widget.status
      ),
    );
  }
}


class CreateEditRejectionReasonBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String reasonId;
  final String reason;
  final String status;

  const CreateEditRejectionReasonBottomSheetWidget({
    required this.isEdit,
    required this.reasonId,
    required this.reason,
    required this.status,
    super.key
  });

  @override
  State<CreateEditRejectionReasonBottomSheetWidget> createState() => _CreateEditRejectionReasonBottomSheetWidgetState();
}

class _CreateEditRejectionReasonBottomSheetWidgetState extends State<CreateEditRejectionReasonBottomSheetWidget> {

  TextEditingController rejectionReasonController = TextEditingController();
  String selectedStatus = "";

  @override
  void initState() {
    rejectionReasonController.text = widget.reason;
    if (widget.isEdit) {
      selectedStatus = widget.status == "1" ? "Active" : "Inactive";
    } else {
      selectedStatus = "Active";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteRejectionReasonBloc, CreateEditDeleteRejectionReasonState>(
      listener: (context, state){
        if (state is LoadedCreateRejectionReasonState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateRejectionReasonState) {
          CommonToast.show(context,state.error);
        }
        else if (state is LoadedEditRejectionReasonState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditRejectionReasonState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context, state){
        if (state is LoadingCreateRejectionReasonState) {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadingEditRejectionReasonState) {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
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
                      ? "Update Reason"
                      : "Create New Reason",
                  subtitle: widget.isEdit == true
                      ?"Modify Reason details below"
                      :"Fill in the details to create a new Reason",
                ),
                CommonTextField(
                  controller: rejectionReasonController,
                  label: "Reason",
                  hint: "Enter lead Reason..",
                  showHeader: true,
                  headerText: "Reason",
                  headerIcon: Icons.accessibility_rounded,

                ),
                CommonStatusDropdown(
                  value: selectedStatus,
                  onChanged: (val){
                    setState(() {
                      selectedStatus = val;
                    });
                  },
                  showHeader: true,
                  headerText: "status",
                  headerIcon: Icons.toggle_off_sharp,

                ),
                CommonBottomActionButtons(
                  onTap: (){
                    final mappedStatus =
                    selectedStatus == "Active" ? "1" : "0";

                    if (widget.isEdit == true) {
                      BlocProvider.of<CreateEditDeleteRejectionReasonBloc>(context).add(
                          EditRejectionReasonEvent(
                              reasonId: widget.reasonId,
                              reason: rejectionReasonController.text,
                              status: mappedStatus
                          )
                      );
                    }
                    else {
                      BlocProvider.of<CreateEditDeleteRejectionReasonBloc>(context).add(
                          CreateRejectionReasonEvent(
                              reason: rejectionReasonController.text,
                              status: mappedStatus
                          )
                      );
                    }
                  },
                  submitText:  widget.isEdit == true
                      ?"Update "
                      :"Create",
                  submitIcon:  widget.isEdit == true
                      ? Icons.update
                      :  Icons.add,
                )
              ],
            )
        );
      },
    );
  }
}