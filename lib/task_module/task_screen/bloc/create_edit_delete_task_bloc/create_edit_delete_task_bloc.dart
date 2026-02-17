import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../base_url/base_url.dart';
import 'create_edit_delete_task_event.dart';
import 'create_edit_delete_task_state.dart';

class CreateEditDeleteTaskBloc extends Bloc<CreateEditDeleteTaskEvent, CreateEditDeleteTaskState> {
  CreateEditDeleteTaskBloc() : super(InitialCreateTaskState()) {

    on<CreateTaskEvent>((event, emit) async {
      emit(LoadingCreateTaskState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'status': event.status,
          'name': event.taskName,
          'description': event.description,
          'start_date': event.startDate,
          'end_date': event.endDate,
          'employee_id': event.employeeId,
          'task_priority': event.taskPriority,
          'remark': event.remark,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createTask");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateTaskState(message: decode['message']));
          }
          else {
            emit(FailureCreateTaskState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateTaskState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditTaskEvent>((event, emit) async {
      emit(LoadingEditTaskState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'status': event.status,
          'task_id': event.taskId,
          'name': event.taskName,
          'description': event.description,
          'start_date': event.startDate,
          'end_date': event.endDate,
          'employee_id': event.employeeId,
          'task_priority': event.taskPriority,
          'remark': event.remark,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}changeTaskStatus");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditTaskState(message: decode['message']));
          }
          else {
            emit(FailureEditTaskState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditTaskState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      emit(LoadingDeleteTaskState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "task_id": event.taskId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteTask");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteTaskState(message: decode['message']));
          }
          else {
            emit(FailureDeleteTaskState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteTaskState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
