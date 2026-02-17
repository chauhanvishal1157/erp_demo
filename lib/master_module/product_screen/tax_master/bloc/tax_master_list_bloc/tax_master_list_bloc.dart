import 'dart:convert';

import 'package:erp_demo/master_module/product_screen/tax_master/bloc/tax_master_list_bloc/tax_master_list_event.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/bloc/tax_master_list_bloc/tax_master_list_state.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/model/tax_master_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class TaxMasterListBlocs extends Bloc<TaxMasterListEvents,TaxMasterListStates>{

  TaxMasterListBlocs() : super(InitialTaxMasterListStates()){
    on<FetchTaxMasterListEvents>((event, emit) async{
      emit(LoadingTaxMasterListStates());
      try {
        final list = await fetchTaxMasterList();

        emit(LoadedTaxMasterListStates(list: list));

      } catch (error) {
        debugPrint("Error :: $error");
        emit(FailureTaxMasterListStates(error: "An error occurred"));
      }
    });
  }

  fetchTaxMasterList() async{
    List<TaxMasterListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getTaxList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for (var index in resultList){
        TaxMasterListModel model = TaxMasterListModel(
            taxId:  index['id'],
            taxType:  index['tax_type'],
            taxName:  index['tax_name'],
            taxRate:  index['tax_rate'],
            status:  index['status'],
        );
        list.add(model);
      }
      return list;
    }
  }
}