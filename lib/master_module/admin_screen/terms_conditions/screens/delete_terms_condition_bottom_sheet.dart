import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/common/common_toast.dart' show CommonToast;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;
import '../bloc/delete_terms_condition_bloc/delete_terms_condition_bloc.dart';
import '../bloc/delete_terms_condition_bloc/delete_terms_condition_event.dart';
import '../bloc/delete_terms_condition_bloc/delete_terms_condition_state.dart';

class DeleteTermsConditionBottomSheet extends StatefulWidget {
  final String termsConditionId;

  const DeleteTermsConditionBottomSheet({
    required this.termsConditionId,
    super.key
  });

  @override
  State<DeleteTermsConditionBottomSheet> createState() => _DeleteTermsConditionBottomSheetState();
}

class _DeleteTermsConditionBottomSheetState extends State<DeleteTermsConditionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteTermsConditionBloc(),
      child: DeleteTermsConditionBottomSheetWidget(
        termsConditionId: widget.termsConditionId,
      ),
    );
  }
}

class DeleteTermsConditionBottomSheetWidget extends StatefulWidget {
  final String termsConditionId;

  const DeleteTermsConditionBottomSheetWidget({
    required this.termsConditionId,
    super.key
  });

  @override
  State<DeleteTermsConditionBottomSheetWidget> createState() => _DeleteTermsConditionBottomSheetWidgetState();
}

class _DeleteTermsConditionBottomSheetWidgetState extends State<DeleteTermsConditionBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteTermsConditionBloc,DeleteTermsConditionState>(
      listener:  (context, state){
        if (state is LoadedDeleteTermsConditionState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureDeleteTermsConditionState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context, state){
        if (state is LoadingDeleteTermsConditionState) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        return CommonDeleteBottomSheet(
            title: "Delete Terms And Condition",
            message: "Are you sure you want to delete this"
                " Terms And Condition? All associated data will be"
                " permanently removed from the system.",
            onDelete: (){
              BlocProvider.of<DeleteTermsConditionBloc>(context).add(
                  DeleteTermsConditionEvents(
                    termsConditionId: widget.termsConditionId,
                  )
              );
            }
        );
      },
    );
  }
}

