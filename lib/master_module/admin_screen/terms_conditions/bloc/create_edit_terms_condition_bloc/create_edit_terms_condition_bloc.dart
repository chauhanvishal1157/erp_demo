import 'dart:convert';

import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/create_edit_terms_condition_bloc/create_edit_terms_condition_event.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/create_edit_terms_condition_bloc/create_edit_terms_condition_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class CreateEditTermsConditionBloc extends Bloc<CreateEditTermsConditionEvent, CreateEditTermsConditionState> {
  CreateEditTermsConditionBloc() : super(InitialCreateTermsConditionState()) {

    on<CreateTermsConditionEvent>((event, emit)async {
      emit(LoadingCreateTermsConditionState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'title': event.title,
          'text': event.text,
          'type': event.type,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}termConditionCreate");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateTermsConditionState(message: decode['message']));
          }
          else {
            emit(FailureCreateTermsConditionState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateTermsConditionState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditTermsConditionEvent>((event, emit)async {
      emit(LoadingEditTermsConditionState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'title': event.title,
          'text': event.text,
          'type': event.type,
          'id': event.termsConditionId
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}termConditionEdit");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditTermsConditionState(message: decode['message']));
          }
          else {
            emit(FailureEditTermsConditionState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditTermsConditionState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}
