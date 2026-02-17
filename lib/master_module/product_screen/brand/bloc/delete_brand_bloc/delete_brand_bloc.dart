

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'delete_brand_event.dart';
import 'delete_brand_state.dart';

class DeleteBrandBloc extends Bloc<DeleteBrandEvent, DeleteBrandState> {
  DeleteBrandBloc() : super(InitialDeleteBrandState()) {
    on<DeleteBrandEvents>((event, emit)async {
      emit(LoadingDeleteBrandState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "brand_id": event.brandId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteBrand");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteBrandState(message: decode['message']));
          }
          else {
            emit(FailureDeleteBrandState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteBrandState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
