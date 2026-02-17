import 'package:erp_demo/common/common_delete_bottom_sheet.dart';
import 'package:erp_demo/task_module/task_screen/bloc/create_edit_delete_task_bloc/create_edit_delete_task_bloc.dart';
import 'package:erp_demo/task_module/task_screen/bloc/create_edit_delete_task_bloc/create_edit_delete_task_event.dart';
import 'package:erp_demo/task_module/task_screen/bloc/create_edit_delete_task_bloc/create_edit_delete_task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../common/common_toast.dart';

class DeleteTaskBottomSheet extends StatefulWidget {
  final String taskId;

  const DeleteTaskBottomSheet({
    required this.taskId,
    super.key});

  @override
  State<DeleteTaskBottomSheet> createState() => _DeleteTaskBottomSheetState();
}

class _DeleteTaskBottomSheetState extends State<DeleteTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreateEditDeleteTaskBloc(),
      child: DeleteTaskBottomSheetWidget(
          taskId: widget.taskId
      ),
    );
  }
}


class DeleteTaskBottomSheetWidget extends StatefulWidget {
  final String taskId;
  const DeleteTaskBottomSheetWidget({
    required this.taskId,
    super.key});

  @override
  State<DeleteTaskBottomSheetWidget> createState() => _DeleteTaskBottomSheetWidgetState();
}

class _DeleteTaskBottomSheetWidgetState extends State<DeleteTaskBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditDeleteTaskBloc,CreateEditDeleteTaskState>(
        listener: (context,state){
          if(state is LoadedDeleteTaskState){
            CommonToast.show(context,state.message);
            Navigator.of(context).pop(true);
          }
          else if(state is FailureDeleteTaskState){
            CommonToast.show(context,state.error);
          }
        },
        builder: (context,state){
          if(state is LoadingDeleteTaskState){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          return CommonDeleteBottomSheet(
              title: "Delete Task",
              message:  "Are you sure you want to delete this"
                  "product Task? All associated data will be"
                  " permanently removed from the system.",
              onDelete: ()  {
                BlocProvider.of<CreateEditDeleteTaskBloc>(context).add(
                    DeleteTaskEvent(
                        taskId: widget.taskId
                    )
                );
              },
          );
        }
    );
  }
}
