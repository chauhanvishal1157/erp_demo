import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../../base_url/base_url.dart';
import 'create_edit_tax_master_event.dart';
import 'create_edit_tax_master_state.dart';

class CreateEditTaxMasterBloc extends Bloc<CreateEditTaxMasterEvent, CreateEditTaxMasterState> {

  CreateEditTaxMasterBloc() : super(InitialCreateTaxMasterState()) {

    on<CreateTaxMasterEvent>((event, emit) async{
      emit(LoadingCreateTaxMasterState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'tax_type': event.taxType,
          'tax_name': event.taxName,
          'tax_rate': event.taxRate,
          'status':event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createTax");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if (decode['status'] == 200) {
            emit(LoadedCreateTaxMasterState(message: decode['message']));
          }
          else {
            emit(FailureCreateTaxMasterState(error: decode['message']));
          }
        }
      }catch(error){
        emit(FailureCreateTaxMasterState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditTaxMasterEvent>((event, emit) async{
      emit(LoadingEditTaxMasterState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'tax_id': event.taxId,
          'tax_type': event.taxType,
          'tax_name': event.taxName,
          'tax_rate': event.taxRate,
          'status':event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editTax");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if (decode['status'] == 200) {
            emit(LoadedEditTaxMasterState(message: decode['message']));
          }
          else {
            emit(FailureEditTaxMasterState(error: decode['message']));
          }
        }
      }catch(error){
        emit(FailureEditTaxMasterState(error: "An error occurred"));
        throw Exception(error);
      }
    });


  }
}
