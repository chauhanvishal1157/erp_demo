import 'dart:convert';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'delete_category_master_event.dart';
import 'delete_category_master_state.dart';


class DeleteCategoryMasterBloc extends Bloc<DeleteCategoryMasterEvent, DeleteCategoryMasterState> {
  DeleteCategoryMasterBloc() : super(InitialDeleteCategoryMasterState()) {

    on<DeleteCategoryMasterEvents>((event, emit) async {
      emit(LoadingDeleteCategoryMasterState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "category_id": event.categoryId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteCategory");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteCategoryMasterState(message: decode['message']));
          }
          else {
            emit(FailureDeleteCategoryMasterState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteCategoryMasterState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
