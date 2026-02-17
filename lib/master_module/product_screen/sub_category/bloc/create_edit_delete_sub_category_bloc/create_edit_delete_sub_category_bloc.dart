import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'create_edit_delete_sub_category_event.dart';
import 'create_edit_delete_sub_category_state.dart';

class CreateEditDeleteSubCategoryBloc extends Bloc<CreateEditDeleteSubCategoryEvent, CreateEditDeleteSubCategoryState> {
  CreateEditDeleteSubCategoryBloc() : super(InitialCreateSubCategoryState()) {

    on<CreateSubCategoryEvent>((event, emit) async{
      emit(LoadingCreateSubCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'category_id': event.categoryId,
          'subCategory_name': event.subCategoryName,
          'status':event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createSubCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateSubCategoryState(message: decode['message']));
          }
          else {
            emit(FailureCreateSubCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateSubCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditSubCategoryEvent>((event, emit) async {
      emit(LoadingEditSubCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'subcategory_id': event.subCategoryId,
          'category_id': event.categoryId,
          'subCategory_name': event.subCategoryName,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editSubCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditSubCategoryState(message: decode['message']));
          }
          else {
            emit(FailureEditSubCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditSubCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteSubCategoryEvent>((event, emit) async {
      emit(LoadingDeleteSubCategoryState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "subcategory_id": event.subCategoryId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteSubCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteSubCategoryState(message: decode['message']));
          }
          else {
            emit(FailureDeleteSubCategoryState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteSubCategoryState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}
