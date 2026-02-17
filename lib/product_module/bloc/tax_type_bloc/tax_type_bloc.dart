import 'dart:convert';

import 'package:erp_demo/product_module/bloc/tax_type_bloc/tax_type_event.dart';
import 'package:erp_demo/product_module/bloc/tax_type_bloc/tax_type_state.dart';
import 'package:erp_demo/product_module/model/tax_type_model/tax_type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../base_url/base_url.dart';

class TaxTypeBloc extends Bloc<TaxTypeEvent, TaxTypeState> {
  TaxTypeBloc() : super(InitialTaxTypeState()) {
    on<FetchTaxTypeEvents>((event, emit)async {
      emit(LoadingTaxTypeState());
      try{
        final list = await fetchTaxTypeState(event.taxType);
        emit(LoadedTaxTypeState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureTaxTypeState(error: "An error occurred"));
      }
    });
  }

  fetchTaxTypeState(
      String taxType
      )async{
    List<TaxTypeModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'tax_type': taxType,
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getTaxTypeList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        TaxTypeModel model = TaxTypeModel(
            id: index['id'],
            taxType: index['tax_type'],
            taxName: index['tax_name'],
            taxRate: index['tax_rate'],
        );
        list.add(model);
      }
      return list;
    }
  }

}
