import 'dart:convert';

import 'package:erp_demo/task_module/task_screen/bloc/task_list_bloc/task_list_event.dart';
import 'package:erp_demo/task_module/task_screen/bloc/task_list_bloc/task_list_state.dart';
import 'package:erp_demo/task_module/task_screen/model/task_list_model/task_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc() : super(InitialTaskListState())  {

    on<FetchTaskListEvent>((event, emit) async{
      emit(LoadingTaskListState());
      try{
        final list = await fetchTaskListState();
        emit(LoadedTaskListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureTaskListState(error: "An error occurred"));
      }
    });
  }

  fetchTaskListState()async{
    List<TaskListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
      'task_status': "",
      'status': "",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}taskList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        TaskListModel model = TaskListModel(
            taskId: index['id'],
            adminId: index['admin_id'],
            createdBy: index['created_by'],
            taskName: index['task_name'],
            description: index['description'],
            remark:index['remark'],
            status: index['status'],
            startDate: index['start_date'],
            endDate: index['end_date'],
            createdAt: index['created_at'],
            employeeId: index['employee_id'],
            employeeName: index['employee_name'],
            taskPriority: index['task_priority'],
        );
        list.add(model);
      }
      return list;
    }
  }

}
