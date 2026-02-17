import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../../base_url/base_url.dart';
import 'create_edit_delete_unit_event.dart';
import 'create_edit_delete_unit_state.dart';

class CreateEditDeleteUnitBloc extends Bloc<CreateEditDeleteUnitEvent, CreateEditDeleteUnitState> {
  CreateEditDeleteUnitBloc() : super(InitialCreateUnitState()) {

    on<CreateUnitEvent>((event, emit) async {
     emit(LoadingCreateUnitState());
     try{
       Map data = {
         'db_connection': "erp_tata_steel_demo",
         'user_id': "1",
         'name': event.unitName,
         'status':event.status,
       };
       final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createUnit");
       final response = await http.post(url,body: data);
       Map<String,dynamic> decode = json.decode(response.body);
       if(response.statusCode == 200) {
         if(decode['status'] == 200) {
           emit(LoadedCreateUnitState(message: decode['message']));
         }
         else {
           emit(FailureCreateUnitState(error: decode['message']));
         }
       }
     }
     catch(error){
       emit(FailureCreateUnitState(error: "An error occurred"));
       throw Exception(error);
     }
    });

    on<EditUnitEvent>((event, emit) async {
      emit(LoadingEditUnitState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'unit_id': event.unitId,
          'name': event.unitName,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editUnit");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditUnitState(message: decode['message']));
          }
          else {
            emit(FailureEditUnitState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditUnitState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteUnitEvent>((event, emit) async {
      emit(LoadingDeleteUnitState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "unit_id": event.unitId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteUnit");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteUnitState(message: decode['message']));
          }
          else {
            emit(FailureDeleteUnitState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteUnitState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
