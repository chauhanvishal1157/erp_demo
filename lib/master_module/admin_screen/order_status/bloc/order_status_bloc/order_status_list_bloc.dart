import 'dart:convert';
import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/order_status_bloc/order_status_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/order_status_bloc/order_status_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/model/order_status_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class OrderStatusListBlocs extends Bloc<OrderStatusListEvents,OrderStatusListStates>{

  OrderStatusListBlocs (): super(InitialOrderStatusListStates()){

    on<FetchOrderStatusListEvents>((event, emit) async {
      emit(LoadingOrderStatusListStates());
      try{
        final list = await fetchOrderStatusListStates();
        emit(LoadedOrderStatusListStates(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureOrderStatusListStates(error: "An error occurred"));
      }
    });

  }

  fetchOrderStatusListStates() async {
    List<OrderStatusListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getOrderStatusList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        OrderStatusListModel model = OrderStatusListModel(
          orderStatusId: index['id'],
          orderStatusName: index['name'],
          textColor:index ['text_color'],
          textBgColor:index ['text_bgcolor'],
          orderBy: index ['order_by'],
          moduleStatus: index ['module_status'],
          status: index ['status'],
        );
        list.add(model);
      }
      return list;
    }
  }
}
