import 'dart:convert';

import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/brand_list_bloc/brand_list_event.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/brand_list_bloc/brand_list_state.dart';
import 'package:erp_demo/master_module/product_screen/brand/model/brand_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class BrandListBlocs extends Bloc<BrandListEvents,BrandListStates>{

  BrandListBlocs() : super(InitialBrandListStates()){
    on<FetchBrandListEvents>((event, emit) async{
      emit(LoadingBrandListStates());
      try {
        final list = await fetchBrandList();

        emit(LoadedBrandListStates(list: list));

      } catch (error) {
        debugPrint("Error :: $error");
        emit(FailureBrandListStates(error: "An error occurred"));
      }
    });
  }

  fetchBrandList() async {
    List<BrandListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getBrandsList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for (var index in resultList){
        BrandListModel model = BrandListModel(
            brandId: index['id'],
            brandName: index['name'],
            status: index ['status'],
        );
        list.add(model);
      }
      return list;
    }
  }

}