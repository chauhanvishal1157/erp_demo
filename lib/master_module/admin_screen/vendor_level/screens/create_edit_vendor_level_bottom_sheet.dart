import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/common_toast.dart' show CommonToast;
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/create_edit_vendor_level_bloc/create_edit_vendor_level_event.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/create_edit_vendor_level_bloc/create_edit_vendor_level_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bloc/create_edit_vendor_level_bloc/create_edit_vendor_level_bloc.dart';

class CreateEditVendorLevelBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String vendorLevelName;
  final String vendorLevelId;

  const CreateEditVendorLevelBottomSheet({
    required this.isEdit,
    required this.vendorLevelName,
    required this.vendorLevelId,
    super.key,
  });

  @override
  State<CreateEditVendorLevelBottomSheet> createState() => _CreateEditVendorLevelBottomSheetState();
}

class _CreateEditVendorLevelBottomSheetState extends State<CreateEditVendorLevelBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditVendorLevelBloc(),
      child: CreateEditVendorLevelBottomSheetWidget(
        isEdit: widget.isEdit,
        vendorLevelName: widget.vendorLevelName,
        vendorLevelId: widget.vendorLevelId,
      ),
    );
  }
}


class CreateEditVendorLevelBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String vendorLevelName;
  final String vendorLevelId;


  const CreateEditVendorLevelBottomSheetWidget({
    required this.isEdit,
    required this.vendorLevelName,
    required this.vendorLevelId,
    super.key
  });

  @override
  State<CreateEditVendorLevelBottomSheetWidget> createState() => _CreateEditVendorLevelBottomSheetWidgetState();
}

class _CreateEditVendorLevelBottomSheetWidgetState extends State<CreateEditVendorLevelBottomSheetWidget> {

  TextEditingController vendorLevelController = TextEditingController();


  @override
  void initState() {
    vendorLevelController.text = widget.vendorLevelName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditVendorLevelBloc,CreateEditVendorLevelState>(
      listener: (context,state){
        if(state is LoadedCreateVendorLevelState){
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateVendorLevelState){
          CommonToast.show(context,state.error);
        }
        else if(state is LoadedEditVendorLevelState){
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditVendorLevelState){
          CommonToast.show(context,state.error);
        }
      },
      builder: (context,state){
        if(state is LoadingCreateVendorLevelState){
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadingEditVendorLevelState){
          return Center(
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
                        : Icons.add_business_sharp,
                    title:  widget.isEdit == true
                        ? "Update Vendor Level"
                        : "Create Vendor Level",
                    subtitle:  widget.isEdit == true
                        ? "Update a new Vendor Level"
                        : "Add a new Vendor Level",
                ),
                CommonTextField(
                    controller: vendorLevelController,
                    label: "Vendor Level Name",
                    hint: "Enter Vendor Level Name..",
                  showHeader: true,
                  headerText: "Vendor Level Name",
                  headerIcon:  Icons.work_outline,

                ),
                CommonBottomActionButtons(
                    onTap:  ()  {
                      if(widget.isEdit == true){
                        BlocProvider.of<CreateEditVendorLevelBloc>(context).add(
                            EditVendorLevelEvent(
                              vendorLevelName: vendorLevelController.text,
                              vendorLevelId: widget.vendorLevelId,
                            )
                        );
                      }
                      else{
                        BlocProvider.of<CreateEditVendorLevelBloc>(context).add(
                          CreateVendorLevelEvent(
                            vendorLevelName: vendorLevelController.text,
                          ),
                        );
                      }
                    },
                    submitText:  widget.isEdit == true
                        ? "Update"
                        : "Create",
                    submitIcon:  widget.isEdit == true
                        ? Icons.update
                        : Icons.add
                )
              ],
            )
        );
      },
    );
  }
}
