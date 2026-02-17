import 'dart:convert';

import 'package:erp_demo/product_module/bloc/product_details_bloc/product_details_event.dart';
import 'package:erp_demo/product_module/bloc/product_details_bloc/product_details_state.dart';
import 'package:erp_demo/product_module/model/product_details_model/product_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../base_url/base_url.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {

  ProductDetailsBloc() : super(InitialProductDetailsState()) {
    on<FetchProductDetailsEvent>((event, emit) async {
      emit(LoadingProductDetailsState());
      try {
        final list =
        await fetchProductDetailsState(event.productId);
        emit(LoadedProductDetailsState(list: list));
      } catch (error) {
        debugPrint("Error :: $error");
        emit(FailureProductDetailsState(
            error: "An error occurred"));
      }
    });
  }

  Future<List<ProductDetailsModel>> fetchProductDetailsState(
      String productId) async {

    List<ProductDetailsModel> list = [];

    Map<String, dynamic> data = {
      'db_connection': "erp_tata_steel_demo",
      'product_id': productId,
    };

    final Uri url = Uri.parse(
        "${CrmBaseAppUrl.crmBaseAppUrl}productDetails");

    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decode =
      json.decode(response.body);


      final Map<String, dynamic> result = decode['data'];

      final List resultList = [result];

      for (var index in resultList) {
        ProductDetailsModel model = ProductDetailsModel(
          id: index['id'] ?? 0,
          jobNumber: index['job_number'] ?? '',
          name: index['name'] ?? '',
          description: index['description'] ?? '',
          hsnCode: index['hsn_code'] ?? '',
          categoryId: index['category_id'] ?? 0,
          categoryName: index['category_name'] ?? '',
          subCategoryId: index['sub_category_id'] ?? 0,
          subCategoryName: index['subCategory_name'] ?? '',
          brandId: index['brand_id'] ?? 0,
          brandName: index['brand_name'] ?? '',
          unitId: index['unit_id'] ?? 0,
          unitName: index['unit_name'] ?? '',
          tax1Id: index['tax1_id'] ?? 0,
          tax1Rate: index['tax1_rate'] ?? '',
          tax1Name: index['tax1_name'] ?? '',
          tax2Id: index['tax2_id'] ?? 0,
          tax2Rate: index['tax2_rate'] ?? '',
          tax2Name: index['tax2_name'] ?? '',
          tax3Id: index['tax3_id'] ?? 0,
          tax3Rate: index['tax3_rate'] ?? '',
          tax3Name: index['tax3_name'] ?? '',
          cessTax: index['cess_tax'] ?? '',
          productTypeId: index['product_type_id'] ?? 0,
          productTypeName:
          index['product_type_name'] ?? '',
          status: index['status'] ?? '',
          qty: index['qty'] is int
              ? index['qty']
              : int.tryParse(
              index['qty'].toString()) ??
              0,
          productPrice: index['product_price'] ?? '',
          maxPurchasePrice:
          index['max_purchase_price'] ?? '',
          productItemList:
          (index['productItemList'] as List? ??
              [])
              .map((e) =>
              SubProductModel.fromJson(e))
              .toList(),
        );

        list.add(model);
      }
    }

    return list;
  }
}

