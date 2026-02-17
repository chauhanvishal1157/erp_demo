import 'dart:convert';
import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/create_edit_customer_level_bloc/create_edit_customer_level_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'create_edit_customer_level_state.dart';

class CreateEditCustomerLevelBloc  extends Bloc<CreateEditCustomerLevelEvent,CreateEditCustomerLevelState> {
  CreateEditCustomerLevelBloc() : super(InitialCreateCustomerLevelState()) {

    on<CreateCustomerLevelEvent>((event, emit) async {
      emit(LoadingCreateCustomerLevelState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'name': event.customerLevelName,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createCustomerLevel");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateCustomerLevelState(message: decode['message']));
          }
          else {
            emit(FailureCreateCustomerLevelState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateCustomerLevelState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditCustomerLevelEvent>((event, emit) async {
      emit(LoadingEditCustomerLevelState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "customer_level_id": event.customerLevelId,
          'name': event.customerLevelName,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editCustomerLevel");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditCustomerLevelState(message: decode['message']));
          }
          else {
            emit(FailureEditCustomerLevelState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditCustomerLevelState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}