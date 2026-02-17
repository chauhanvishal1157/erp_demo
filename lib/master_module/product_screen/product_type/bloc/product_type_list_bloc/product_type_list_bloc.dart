import 'dart:convert';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_event.dart';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_state.dart';
import 'package:erp_demo/master_module/product_screen/product_type/model/product_type_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../../base_url/base_url.dart';

class ProductTypeListBlocs extends Bloc<ProductTypeListEvents,ProductTypeListStates>{

  ProductTypeListBlocs() : super(InitialProductTypeListStates()){
    on<FetchProductTypeListEvents>((event, emit)async{
      emit(LoadingProductTypeListStates());
      try{
        final list = await fetchProductTypeList();
        emit(LoadedProductTypeListStates(list: list));
      }catch(error){
        debugPrint("Error :: $error");
        emit(FailureProductTypeListStates(error: "An error occurred"));
      }
    });
  }

  fetchProductTypeList()async{
    List<ProductTypeListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getUnitAndProductTypeList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data']["getProductTypeList"];

      for (var index in resultList){
        ProductTypeListModel model = ProductTypeListModel(
            productId: index['id'],
            productName:  index['name'],
            status:  index['status'],
        );
        list.add(model);
      }
      return list;
    }
  }
}