import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'create_edit_delete_lead_sub_category_event.dart';
import 'create_edit_delete_lead_sub_category_state.dart';

class CreateEditDeleteLeadSubCategoryBloc extends Bloc<CreateEditDeleteLeadSubCategoryEvent, CreateEditDeleteLeadSubCategoryState> {
  CreateEditDeleteLeadSubCategoryBloc() : super(InitialCreateLeadSubCategoryState()) {

    on<CreateLeadSubCategoryEvent>((event, emit) async{
      emit(LoadingCreateLeadSubCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'lead_category_id': event.leadCategoryId,
          'name': event.leadSubCategoryName,
          'status':event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createLeadSubCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateLeadSubCategoryState(message: decode['message']));
          }
          else {
            emit(FailureCreateLeadSubCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateLeadSubCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditLeadSubCategoryEvent>((event, emit) async {
      emit(LoadingEditLeadSubCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'lead_sub_category_id': event.leadSubCategoryId,
          'lead_category_id': event.leadCategoryId,
          'name': event.leadSubCategoryName,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editLeadSubCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditLeadSubCategoryState(message: decode['message']));
          }
          else {
            emit(FailureEditLeadSubCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditLeadSubCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteLeadSubCategoryEvent>((event, emit) async {
      emit(LoadingDeleteLeadSubCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "lead_sub_category_id": event.leadSubCategoryId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteLeadSubCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteLeadSubCategoryState(message: decode['message']));
          }
          else {
            emit(FailureDeleteLeadSubCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteLeadSubCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
