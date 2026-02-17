import 'dart:convert';

import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/lead_category_list_bloc/lead_category_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/lead_category_list_bloc/lead_category_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/model/lead_category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class LeadCategoryListBlocs extends Bloc<LeadCategoryListEvents,LeadCategoryListStates>{

  LeadCategoryListBlocs (): super(InitialLeadCategoryListStates()){

    on<FetchLeadCategoryListEvents>((event, emit) async {
      emit(LoadingLeadCategoryListStates());
      try{
        final list = await fetchLeadCategoryList();

        emit(LoadedLeadCategoryListStates(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureLeadCategoryListStates(error: "An error occurred"));
      }
    });
  }


  fetchLeadCategoryList()async{

    List<LeadCategoryListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}leadCategoryList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for (var index in resultList) {
        LeadCategoryListModel model = LeadCategoryListModel(
          leadCategoryId: index['id'],
          leadCategoryName: index['name'],
          status: index ['status'],
        );
        list.add(model);
      }
      return list;
    }
  }
}