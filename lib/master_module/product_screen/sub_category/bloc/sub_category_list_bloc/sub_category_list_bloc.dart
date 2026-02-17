import 'dart:convert';
import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/sub_category_list_bloc/sub_category_list_event.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/sub_category_list_bloc/sub_category_list_state.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/model/sub_category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SubCategoryListBloc extends Bloc<SubCategoryListEvents, SubCategoryListStates> {
  SubCategoryListBloc() : super(InitialSubCategoryListStates()) {

    on<FetchSubCategoryListEvent>((event, emit) async{
      emit(LoadingSubCategoryListStates());
      try{
        final list = await fetchSubCategoryList();
        emit(LoadedSubCategoryListStates(list: list));
      }catch(error){
        debugPrint("Error :: $error");
        emit(FailureSubCategoryListState(error: "An error occurred"));
      }
    });
  }

  fetchSubCategoryList()async{

    List<SubCategoryListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getSubCategoryList");
    final response = await http.post(url, body: data);
    if(response.statusCode == 200){
      Map<String,dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];
      for (var index in resultList){
        SubCategoryListModel model = SubCategoryListModel(
            subCategoryId: index['id'],
            subCategoryName: index['subCategory_name'],
            status: index['status'],
            categoryName: index['category_name'],
          categoryId: index['category_id'],
        );
        list.add(model);
      }
      return list;
    }
  }
}


