import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/common/common_toast.dart' show CommonToast;
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/delete_vendor_level_bloc/delete_vendor_level_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/delete_vendor_level_bloc/delete_vendor_level_event.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/delete_vendor_level_bloc/delete_vendor_level_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;


class DeleteVendorLevelBottomSheet extends StatefulWidget {
  final String vendorLevelId;

  const DeleteVendorLevelBottomSheet({
    required  this.vendorLevelId,
    super.key
  });

  @override
  State<DeleteVendorLevelBottomSheet> createState() => _DeleteVendorLevelBottomSheetState();
}

class _DeleteVendorLevelBottomSheetState extends State<DeleteVendorLevelBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteVendorLevelBloc(),
      child: DeleteVendorLevelBottomSheetWidget(
        vendorLevelId: widget.vendorLevelId,
      ),
    );
  }
}

class DeleteVendorLevelBottomSheetWidget extends StatefulWidget {
  final String vendorLevelId;

  const DeleteVendorLevelBottomSheetWidget({
    required this.vendorLevelId,
    super.key
  });

  @override
  State<DeleteVendorLevelBottomSheetWidget> createState() => _DeleteVendorLevelBottomSheetWidgetState();
}

class _DeleteVendorLevelBottomSheetWidgetState extends State<DeleteVendorLevelBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteVendorLevelBloc,DeleteVendorLevelState>(
        listener:  (context, state){
          if (state is LoadedDeleteVendorLevelState) {
            CommonToast.show(context,state.message);
            Navigator.of(context).pop(true);
          }
          else if(state is FailureDeleteVendorLevelState) {
            CommonToast.show(context,state.error);
          }
        },
        builder: (context, state){
          if (state is LoadingDeleteVendorLevelState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          return  CommonDeleteBottomSheet(
              title: "Delete Vendor Level",
              message:  "Are you sure you want to delete this"
                  " Vendor Level? All associated data will be"
                  " permanently removed from the system.",
              onDelete: ()  {
                BlocProvider.of<DeleteVendorLevelBloc>(context).add(
                    DeleteVendorLevelEvent(
                      vendorLevelId:widget.vendorLevelId,
                    )
                );
              },
          );
        }
    );
  }
}
