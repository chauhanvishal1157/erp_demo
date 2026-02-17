import 'dart:convert';

import 'package:erp_demo/product_module/bloc/product_list_bloc/product_list_event.dart';
import 'package:erp_demo/product_module/bloc/product_list_bloc/product_list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../base_url/base_url.dart';
import '../../model/product_list_model/product_list_model.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(InitialProductListState()) {
    on<FetchProductListEvent>((event, emit)async {
      emit(LoadingProductListState());
      try{
        final list = await fetchProductListState();
        emit(LoadedProductListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureProductListState(error: "An error occurred"));
      }
    });
  }

  fetchProductListState()async{
    List<ProductListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'page_number': "1",
      'page_size': "50",
      'search_text': "",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}productList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        ProductListModel model = ProductListModel(
            id: index['id'],
            jobNumber: index['job_number'],
            productSerialNumber: index['product_serial_number'],
            name: index['name'],
            description: index['description'],
            hsnCode: index['hsn_code'],
            categoryId: index['category_id'],
            categoryName: index['category_name'],
            subCategoryId: index['sub_category_id'],
            subCategoryName: index['subCategory_name'],
            orderId: index['order_id'],
            brandId: index['brand_id'],
            brandName: index['brand_name'],
            unitId: index['unit_id'],
            unitName: index['unit_name'],
            tax1Id: index['tax1_id'],
            tax1Rate: index['tax1_rate'],
            tax1Name: index['tax1_name'],
            tax2Id: index['tax2_id'],
            tax2Rate: index['tax2_rate'],
            tax2Name: index['tax2_name'],
            tax3Id: index['tax3_id'],
            tax3Rate: index['tax3_rate'],
            tax3Name: index['tax3_name'],
            cessTax: index['cess_tax'],
            productTypeId: index['product_type_id'],
            productTypeName: index['product_type_name'],
            status: index['status'],
            qty: index['qty'],
            taxOrNot: index['taxOrNot'],
            productPrice: index['product_price'],
            maxPurchasePrice: index['max_purchase_price'],
            productItemList: (index['productItemList'] as List? ?? [])
                .map((e) => ProductItemList.fromJson(e))
                .toList(),
        );
        list.add(model);
      }
      return list;
    }
  }


}
