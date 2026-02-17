import 'dart:convert';
import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/delete_customer_level_bloc/delete_customer_level_event.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/delete_customer_level_bloc/delete_customer_level_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class DeleteCustomerLevelBloc  extends Bloc<DeleteCustomerLevelEvents, DeleteCustomerLevelState> {

  DeleteCustomerLevelBloc() : super(InitialDeleteCustomerLevelState()) {
    on<DeleteCustomerLevelEvent>((event, emit) async {
      emit(LoadingDeleteCustomerLevelState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "customer_level_id": event.customerLevelId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteCustomerLevel");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteCustomerLevelState(message: decode['message']));
          }
          else {
            emit(FailureDeleteCustomerLevelState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteCustomerLevelState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}