import 'dart:convert';

import 'package:erp_demo/master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_event.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_state.dart';
import 'package:erp_demo/master_module/product_screen/unit/model/unit_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class UnitListBlocs extends Bloc<UnitListEvents,UnitListStates>{

  UnitListBlocs() : super(InitialUnitListStates()){
    on<FetchUnitListEvents>((event, emit)async{
      emit(LoadingUnitListStates());
      try{
        final list = await fetchUnitList();
        emit(LoadedUnitListStates(list: list));
      }catch(error){
        debugPrint("Error :: $error");
        emit(FailureUnitListStates(error: "An error occurred"));
      }
    });
  }

  fetchUnitList()async{
    List<UnitListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getUnitAndProductTypeList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data']["getUnitsList"];

      for (var index in resultList){
        UnitListModel model = UnitListModel(
          unitId: index['id'],
          unitName:  index['name'],
          status:  index['status'],
        );
        list.add(model);
      }
      return list;
    }
  }

}