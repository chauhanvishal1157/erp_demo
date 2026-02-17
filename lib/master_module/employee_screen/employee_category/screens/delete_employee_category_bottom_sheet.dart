import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/common/common_toast.dart' show CommonToast;
import 'package:erp_demo/master_module/employee_screen/employee_category/bloc/create_edit_delete_employee_category_bloc/create_edit_delete_employee_category_bloc.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/bloc/create_edit_delete_employee_category_bloc/create_edit_delete_employee_category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;

import '../bloc/create_edit_delete_employee_category_bloc/create_edit_delete_employee_category_state.dart';

class DeleteEmployeeCategoryBottomSheet extends StatefulWidget {
  final String employeeCategoryId;

  const DeleteEmployeeCategoryBottomSheet({
    required this.employeeCategoryId,
    super.key
  });

  @override
  State<DeleteEmployeeCategoryBottomSheet> createState() => _DeleteEmployeeCategoryBottomSheetState();
}

class _DeleteEmployeeCategoryBottomSheetState extends State<DeleteEmployeeCategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditDeleteEmployeeCategoryBloc(),
      child: DeleteEmployeeCategoryBottomSheetWidget(
          employeeCategoryId: widget.employeeCategoryId
      ),
    );
  }
}

class DeleteEmployeeCategoryBottomSheetWidget extends StatefulWidget {
  final String employeeCategoryId;

  const DeleteEmployeeCategoryBottomSheetWidget({
    required this.employeeCategoryId,
    super.key
  });

  @override
  State<DeleteEmployeeCategoryBottomSheetWidget> createState() => _DeleteEmployeeCategoryBottomSheetWidgetState();
}

class _DeleteEmployeeCategoryBottomSheetWidgetState extends State<DeleteEmployeeCategoryBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteEmployeeCategoryBloc,CreateEditDeleteEmployeeCategoryState>(
      listener: (context,state){
        if (state is LoadedDeleteEmployeeCategoryState) {
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureDeleteEmployeeCategoryState) {
          CommonToast.show(context,state.error);
        }
      },
      builder: (context,state){
        if (state is LoadingDeleteEmployeeCategoryState) {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        return CommonDeleteBottomSheet(
            title:  "Delete Category",
            message:  "Are you sure you want to delete this"
                "product Category? All associated data will be"
                " permanently removed from the system.",
            onDelete: (){
              BlocProvider.of<CreateEditDeleteEmployeeCategoryBloc>(context).add(
                  DeleteEmployeeCategoryEvent(
                      employeeCategoryId: widget.employeeCategoryId
                  )
              );
            }
        );
      },
    );
  }
}
