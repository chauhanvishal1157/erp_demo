import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/delete_customer_level_bloc/delete_customer_level_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/delete_customer_level_bloc/delete_customer_level_event.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/delete_customer_level_bloc/delete_customer_level_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../common/common_toast.dart';

class DeleteCustomerLevelBottomSheet extends StatefulWidget {

  final String customerLevelId;

  const DeleteCustomerLevelBottomSheet({
  required  this.customerLevelId,
    super.key,
  });

  @override
  State<DeleteCustomerLevelBottomSheet> createState() => _DeleteCustomerLevelBottomSheetState();
}

class _DeleteCustomerLevelBottomSheetState extends State<DeleteCustomerLevelBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteCustomerLevelBloc(),
      child: DeleteCustomerLevelBottomSheetWidget(
        customerLevelId: widget.customerLevelId,
      ),
    );
  }
}


class DeleteCustomerLevelBottomSheetWidget extends StatefulWidget {
  final String customerLevelId;

  const DeleteCustomerLevelBottomSheetWidget({
    required  this.customerLevelId,
    super.key,
  });

  @override
  State<DeleteCustomerLevelBottomSheetWidget> createState() => _DeleteCustomerLevelBottomSheetWidgetState();
}

class _DeleteCustomerLevelBottomSheetWidgetState extends State<DeleteCustomerLevelBottomSheetWidget> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCustomerLevelBloc,DeleteCustomerLevelState>(
      listener:  (context, state){
        if (state is LoadedDeleteCustomerLevelState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureDeleteCustomerLevelState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context, state){
        if (state is LoadingDeleteCustomerLevelState) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        return CommonDeleteBottomSheet(
            title:  "Delete Customer Level",
            message:  "Are you sure you want to delete this"
                " Customer Level? All associated data will be"
                " permanently removed from the system.",
            onDelete: ()  {
              BlocProvider.of<DeleteCustomerLevelBloc>(context).add(
                  DeleteCustomerLevelEvent(
                    customerLevelId: widget.customerLevelId,
                  )
              );
            },
        );

      },
    );
  }
}
