import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'create_edit_delete_rejection_reason_event.dart';
import 'create_edit_delete_rejection_reason_state.dart';

class CreateEditDeleteRejectionReasonBloc extends Bloc<CreateEditDeleteRejectionReasonEvent, CreateEditDeleteRejectionReasonState> {
  CreateEditDeleteRejectionReasonBloc() : super(InitialCreateRejectionReasonState()) {

    on<CreateRejectionReasonEvent>((event, emit) async{
      emit(LoadingCreateRejectionReasonState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'reason': event.reason,
          'status':event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createReason");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateRejectionReasonState(message: decode['message']));
          }
          else {
            emit(FailureCreateRejectionReasonState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateRejectionReasonState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditRejectionReasonEvent>((event, emit) async {
      emit(LoadingEditRejectionReasonState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'reason_id': event.reasonId,
          'reason': event.reason,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editReason");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditRejectionReasonState(message: decode['message']));
          }
          else {
            emit(FailureEditRejectionReasonState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditRejectionReasonState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteRejectionReasonEvent>((event, emit) async {
      emit(LoadingDeleteRejectionReasonState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "reason_id": event.reasonId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteReason");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteRejectionReasonState(message: decode['message']));
          }
          else {
            emit(FailureDeleteRejectionReasonState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteRejectionReasonState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
