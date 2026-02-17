import 'dart:convert';
import 'package:erp_demo/master_module/admin_screen/lead_status/bloc/lead_status_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/lead_status/bloc/lead_status_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/lead_status/model/lead_status_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../base_url/base_url.dart';

class LeadStatusListBlocs extends Bloc<LeadStatusListEvents,LeadStatusListStates>{

  LeadStatusListBlocs (): super(InitialLeadStatusListStates()){

    on<FetchLeadStatusListEvents>((event, emit) async {
      emit(LoadingLeadStatusListStates());
      try{
        final list = await fetchOrderStatusList(
        );
        emit(LoadedLeadStatusListStates(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureLeadStatusListStates(error: "An error occurred"));
      }
    });

  }

  fetchOrderStatusList() async {
    List<LeadStatusListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getLeadStatusList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        LeadStatusListModel model = LeadStatusListModel(
          id: index['id'],
          name: index['name'],
          textColor:index ['text_color'],
          textBgColor:index ['text_bgcolor'],
          orderBy: index ['order_by'],
          status: index ['status'],
        );
        list.add(model);
      }
      return list;
    }
  }

}
