import 'dart:convert';

import 'package:erp_demo/master_module/product_screen/category/bloc/category_master_bloc/category_list_event.dart';
import 'package:erp_demo/master_module/product_screen/category/bloc/category_master_bloc/category_list_state.dart';
import 'package:erp_demo/master_module/product_screen/category/model/category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class CategoryListBlocs extends Bloc<CategoryListEvents,CategoryListStates>{

  CategoryListBlocs() : super(InitialCategoryListStates()){

    on<FetchCategoryListEvents>((event, emit) async {
      emit(LoadingCategoryListStates());
      try{
        final list = await fetchCategoryList();

        emit(LoadedCategoryListStates(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureCategoryListStates(error: "An error occurred"));
      }
    });
  }

  fetchCategoryList()async {
    List<CategoryListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };


    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getCategoryList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for (var index in resultList) {
        CategoryListModel model = CategoryListModel(
          categoryId: index['id'],
          categoryName: index['name'],
          status: index ['status'],
        );
        list.add(model);
      }
      return list;
    }
  }
}