import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'create_edit_delete_employee_category_event.dart';
import 'create_edit_delete_employee_category_state.dart';

class CreateEditDeleteEmployeeCategoryBloc extends Bloc<CreateEditDeleteEmployeeCategoryEvent, CreateEditDeleteEmployeeCategoryState> {
  CreateEditDeleteEmployeeCategoryBloc() : super(InitialCreateEmployeeCategoryState()) {

    on<CreateEmployeeCategoryEvent>((event, emit) async{
      emit(LoadingCreateEmployeeCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'name': event.employeeCategoryName,
          'status':event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createEmployeeCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateEmployeeCategoryState(message: decode['message']));
          }
          else {
            emit(FailureCreateEmployeeCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateEmployeeCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditEmployeeCategoryEvent>((event, emit) async {
      emit(LoadingEditEmployeeCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'employee_category_id': event.employeeCategoryId,
          'name': event.employeeCategoryName,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editEmployeeCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditEmployeeCategoryState(message: decode['message']));
          }
          else {
            emit(FailureEditEmployeeCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditEmployeeCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteEmployeeCategoryEvent>((event, emit) async {
      emit(LoadingDeleteEmployeeCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "employee_category_id": event.employeeCategoryId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteEmployeeCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteEmployeeCategoryState(message: decode['message']));
          }
          else {
            emit(FailureDeleteEmployeeCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteEmployeeCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}
