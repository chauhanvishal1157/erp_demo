import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/create_edit_customer_level_bloc/create_edit_customer_level_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/create_edit_customer_level_bloc/create_edit_customer_level_event.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/create_edit_customer_level_bloc/create_edit_customer_level_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/common_toast.dart';

class CreateEditCustomerLevelBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String customerLevelName;
  final String customerLevelId;

  const CreateEditCustomerLevelBottomSheet({
    required this.isEdit,
    this.customerLevelName = "",
    this.customerLevelId = "",
    super.key,
  });

  @override
  State<CreateEditCustomerLevelBottomSheet> createState() => _CreateEditCustomerLevelBottomSheetState();
}

class _CreateEditCustomerLevelBottomSheetState extends State<CreateEditCustomerLevelBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditCustomerLevelBloc(),
      child: CreateEditCustomerLevelBottomSheetWidget(
        isEdit: widget.isEdit,
        customerLevelName: widget.customerLevelName,
        customerLevelId: widget.customerLevelId,
      ),
    );
  }
}


class CreateEditCustomerLevelBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String customerLevelName;
  final String customerLevelId;

  const CreateEditCustomerLevelBottomSheetWidget({
    required this.isEdit,
    this.customerLevelName = "",
    this.customerLevelId = "",
    super.key,
  });

  @override
  State<CreateEditCustomerLevelBottomSheetWidget> createState() => _CreateEditCustomerLevelBottomSheetWidgetState();
}

class _CreateEditCustomerLevelBottomSheetWidgetState extends State<CreateEditCustomerLevelBottomSheetWidget> {

  TextEditingController customerLevelController = TextEditingController();

  @override
  void initState() {
    customerLevelController.text = widget.customerLevelName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditCustomerLevelBloc, CreateEditCustomerLevelState>(
      listener: (context, state) {
        if (state is LoadedCreateCustomerLevelState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureCreateCustomerLevelState) {
          CommonToast.show(context,state.error);
        }
        else if (state is LoadedEditCustomerLevelState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureEditCustomerLevelState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context, state) {
        if (state is LoadingCreateCustomerLevelState)
        {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadingEditCustomerLevelState) {
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
                        : Icons.person_add_outlined,
                    title:   widget.isEdit == true
                        ? "Update Customer Level"
                        : "Create Customer Level",
                    subtitle:   widget.isEdit == true
                        ? "Update a new Customer Level"
                        : "Add a new Customer Level"
                ),
                CommonTextField(
                    controller: customerLevelController,
                    label: "Customer Level Name",
                    hint: "Enter Customer Level Name..",
                  showHeader: true,
                  headerText: "Customer Level Name",
                  headerIcon: Icons.star_border_outlined,
                ),
                CommonBottomActionButtons(
                    onTap:  () {
                      if(widget.isEdit == true) {
                        BlocProvider.of<CreateEditCustomerLevelBloc>(context).add(
                          EditCustomerLevelEvent(
                            customerLevelName: customerLevelController.text,
                            customerLevelId: widget.customerLevelId,
                          ),
                        );
                      }
                      else {
                        BlocProvider.of<CreateEditCustomerLevelBloc>(context).add(
                          CreateCustomerLevelEvent(
                            customerLevelName: customerLevelController.text,
                          ),
                        );
                      }
                    },
                    submitText:   widget.isEdit == true
                        ? "Update"
                        : "Create",
                    submitIcon: widget.isEdit == true
                        ? Icons.update
                        : Icons.add,
                )
              ],
            ));
        },
    );
  }
}
