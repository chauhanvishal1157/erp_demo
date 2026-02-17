
import 'dart:convert';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/bloc/lead_sub_category_bloc/lead_sub_category_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/bloc/lead_sub_category_bloc/lead_sub_category_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/lead_sub_category/model/lead_sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class LeadSubCategoryListBlocs extends Bloc<LeadSubCategoryListEvents, LeadSubCategoryListStates> {

  LeadSubCategoryListBlocs() : super(InitialLeadSubCategoryListStates()) {

    on<FetchLeadSubCategoryListEvents>((event, emit)async{
      emit(LoadingLeadSubCategoryListStates());
      try{
        final list = await fetchLeadSubCategoryList();
        emit(LoadedLeadSubCategoryListStates(list: list));
      }catch(error){
        debugPrint("Error :: $error");
        emit(FailureLeadSubCategoryListStates(error: "An error occurred"));
      }
    });

  }

  fetchLeadSubCategoryList() async{
    List<LeadSubCategoryListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'lead_category_id' : "6",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}leadSubCategoryList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for (var index in resultList) {
        LeadSubCategoryListModel model = LeadSubCategoryListModel(
          leadSubCategoryId: index['id'],
          leadSubCategoryName: index['name'],
          status: index['status'],
          leadCategoryName: index['lead_category_name'],
          leadCategoryId: index['lead_category_id'],
        );
        list.add(model);
      }
      return list;
    }

  }
}
