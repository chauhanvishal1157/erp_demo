import 'dart:convert';

import 'package:erp_demo/task_module/task_screen/bloc/task_details_bloc/task_details_event.dart';
import 'package:erp_demo/task_module/task_screen/bloc/task_details_bloc/task_details_state.dart';
import 'package:erp_demo/task_module/task_screen/model/task_details_model/task_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {

  TaskDetailsBloc() : super(InitialTaskDetailsState()) {
    on<FetchTaskDetailsEvent>(_onFetchTaskDetails);
  }

  Future<void> _onFetchTaskDetails(
      FetchTaskDetailsEvent event,
      Emitter<TaskDetailsState> emit,
      ) async {
    emit(LoadingTaskDetailsState());
    try {
      final vendor = await fetchTaskDetailsState(event.taskId);

      emit(LoadedTaskDetailsState(list: [vendor]));
    } catch (error) {
      debugPrint("Error :: $error");
      emit(FailureTaskDetailsState(error: "An error occurred"));
    }
  }

  Future<TaskDetailsModel> fetchTaskDetailsState(
      String taskId) async {

    final Map<String, String> data = {
      'db_connection': "erp_tata_steel_demo",
      'task_id': taskId,
    };


    final Uri url = Uri.parse(
      "${CrmBaseAppUrl.crmBaseAppUrl}taskDetails",
    );

    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decode =
      json.decode(response.body);

      return TaskDetailsModel.fromJson(decode['data']);
    } else {
      throw Exception("Server error");
    }
  }
}
