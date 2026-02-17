import 'dart:convert';

import 'package:erp_demo/master_module/admin_screen/order_status/bloc/delete_order_status_bloc/delete_order_status_event.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/delete_order_status_bloc/delete_order_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class DeleteOrderStatusBloc extends Bloc<DeleteOrderStatusEvents ,DeleteOrderStatusState>{
  DeleteOrderStatusBloc() : super(InitialDeleteOrderStatusState()){

    on<DeleteOrderStatusEvent>((event, emit) async {
    emit(LoadingDeleteOrderStatusState());
    try{
      Map data = {
        'db_connection': "erp_tata_steel_demo",
        'user_id': "1",
        "order_status_id": event.orderStatusId,
      };
      final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteOrderStatus");
      final response = await http.post(url,body: data);
      Map<String,dynamic> decode = json.decode(response.body);
      if(response.statusCode == 200) {
        if(decode['status'] == 200) {
          emit(LoadedDeleteOrderStatusState(message: decode['message']));
        }
        else {
          emit(FailureDeleteOrderStatusState(error: decode['message']));
        }
      }
    }
    catch(error){
      emit(FailureDeleteOrderStatusState(error: "An error occurred"));
      throw Exception(error);
    }
    });
  }
}