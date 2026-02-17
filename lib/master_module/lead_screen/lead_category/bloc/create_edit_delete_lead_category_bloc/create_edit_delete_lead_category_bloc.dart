import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'create_edit_delete_lead_category_event.dart';
import 'create_edit_delete_lead_category_state.dart';

class CreateEditDeleteLeadCategoryBloc extends Bloc<CreateEditDeleteLeadCategoryEvent, CreateEditDeleteLeadCategoryState> {
  CreateEditDeleteLeadCategoryBloc() : super(InitialCreateLeadCategoryState()) {

    on<CreateLeadCategoryEvent>((event, emit) async{
      emit(LoadingCreateLeadCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'name': event.leadCategoryName,
          'status':event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createLeadCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateLeadCategoryState(message: decode['message']));
          }
          else {
            emit(FailureCreateLeadCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateLeadCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditLeadCategoryEvent>((event, emit) async {
      emit(LoadingEditLeadCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'lead_category_id': event.leadCategoryId,
          'name': event.leadCategoryName,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editLeadCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditLeadCategoryState(message: decode['message']));
          }
          else {
            emit(FailureEditLeadCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditLeadCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteLeadCategoryEvent>((event, emit) async {
      emit(LoadingDeleteLeadCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "lead_category_id": event.leadCategoryId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteLeadCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteLeadCategoryState(message: decode['message']));
          }
          else {
            emit(FailureDeleteLeadCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteLeadCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
