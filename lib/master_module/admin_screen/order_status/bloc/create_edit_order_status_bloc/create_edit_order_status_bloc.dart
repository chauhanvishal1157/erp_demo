import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'create_edit_order_status_event.dart';
import 'create_edit_order_status_state.dart';

class CreateEditOrderStatusBloc extends Bloc<CreateEditOrderStatusEvent,CreateEditOrderStatusState>{

  CreateEditOrderStatusBloc() : super(InitialCreateOrderStatusState()){

    on<CreateOrderStatusEvent>((event, emit) async {
    emit(LoadingCreateOrderStatusState());
    try{
      Map data = {
        'db_connection': "erp_tata_steel_demo",
        'user_id': "1",
        'name': event.orderStatusName,
        'status': event.status,
        'text_color': event.textColor,
        'text_bg_color': event.textBgColor,
        'module_status': event.moduleStatus,
      };
      final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createOrderStatus");
      final response = await http.post(url,body: data);
      Map<String,dynamic> decode = json.decode(response.body);
      if(response.statusCode == 200) {
        if(decode['status'] == 200) {
          emit(LoadedCreateOrderStatusState(message: decode['message']));
        }
        else {
          emit(FailureCreateOrderStatusState(error: decode['message']));
        }
      }
    }
    catch(error){
      emit(FailureCreateOrderStatusState(error: "An error occurred"));
      throw Exception(error);
    }
    });

    on<EditOrderStatusEvent>((event, emit) async {
      emit(LoadingEditOrderStatusState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "customer_level_id": event.orderStatusId,
          'name': event.orderStatusName,
          'status': event.status,
          'text_color': event.textColor,
          'text_bg_color': event.textBgColor,
          'module_status': event.moduleStatus,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editOrderStatus");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditOrderStatusState(message: decode['message']));
          }
          else {
            emit(FailureEditOrderStatusState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditOrderStatusState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}