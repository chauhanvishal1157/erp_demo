

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'delete_tax_master_event.dart';
import 'delete_tax_master_state.dart';

class DeleteTaxMasterBloc extends Bloc<DeleteTaxMasterEvent, DeleteTaxMasterState> {
  DeleteTaxMasterBloc() : super(InitialDeleteTaxMasterState()) {
    on<DeleteTaxMasterEvents>((event, emit)async {
      emit(LoadingDeleteTaxMasterState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "tax_id": event.taxId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteTax");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteTaxMasterState(message: decode['message']));
          }
          else {
            emit(FailureDeleteTaxMasterState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteTaxMasterState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
