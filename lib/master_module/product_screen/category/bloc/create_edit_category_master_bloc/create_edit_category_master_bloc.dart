import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'create_edit_category_master_event.dart';
import 'create_edit_category_master_state.dart';

class CreateEditCategoryMasterBloc extends Bloc<CreateEditCategoryMasterEvent, CreateEditCategoryMasterState> {
  CreateEditCategoryMasterBloc() : super(InitialCreateCategoryMasterState()) {

    on<CreateCategoryMasterEvent>((event, emit) async {
    emit(LoadingCreateCategoryMasterState());
    try{
      Map data = {
        'db_connection': "erp_tata_steel_demo",
        'user_id': "1",
        'name': event.categoryName,
        'status':event.status,
      };
      final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createCategory");
      final response = await http.post(url,body: data);
      Map<String,dynamic> decode = json.decode(response.body);
      if(response.statusCode == 200) {
        if(decode['status'] == 200) {
          emit(LoadedCreateCategoryMasterState(message: decode['message']));
        }
        else {
          emit(FailureCreateCategoryMasterState(error: decode['message']));
        }
      }
    }
    catch(error){
      emit(FailureCreateCategoryMasterState(error: "An error occurred"));
      throw Exception(error);
    }
    });

    on<EditCategoryMasterEvent>((event, emit) async {
      emit(LoadingEditCategoryMasterState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'category_id': event.categoryId,
          'name': event.categoryName,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditCategoryMasterState(message: decode['message']));
          }
          else {
            emit(FailureEditCategoryMasterState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditCategoryMasterState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}
