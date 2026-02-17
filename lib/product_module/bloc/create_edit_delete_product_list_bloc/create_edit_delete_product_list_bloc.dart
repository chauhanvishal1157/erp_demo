import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../base_url/base_url.dart';
import 'create_edit_delete_product_list_event.dart';
import 'create_edit_delete_product_list_state.dart';

class CreateEditDeleteProductListBloc extends Bloc<CreateEditDeleteProductListEvent, CreateEditDeleteProductListState> {
  CreateEditDeleteProductListBloc() : super(InitialCreateProductListState()) {

    on<CreateProductListEvent>((event, emit) async{
      emit(LoadingCreateProductListState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'category_id': event.categoryId,
          'sub_category_id':event.subCategoryId,
          'brand_id': event.brandId,
          'unit_id':event.unitId,
          'name': event.name,
          'product_type_id':event.productTypeId,
          'product_price': event.productPrice,
          'qty':event.qty,
          'tax1': event.tax1Name,
          'tax1_rate':event.tax1Rate,
          'tax2': event.tax2Name,
          'tax2_rate':event.tax2Rate,
          'tax3': event.tax3Name,
          'tax3_rate':event.tax3Rate,
          'product_data':event.productData,
          'description':event.description,
          'job_number':event.jobNumber,
          'hsn_code': event.hsnCode,
          'previous_purchase_price': "",
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}addProduct");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateProductListState(message: decode['message']));
          }
          else {
            emit(FailureCreateProductListState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateProductListState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditProductListEvent>((event, emit) async {
      emit(LoadingEditProductListState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'product_id': event.productId,
          'category_id': event.categoryId,
          'sub_category_id':event.subCategoryId,
          'brand_id': event.brandId,
          'unit_id':event.unitId,
          'name': event.name,
          'product_type_id':event.productTypeId,
          'product_price': event.productPrice,
          'product_data':event.productData,
          'tax1': event.tax1Name,
          'tax1_rate':event.tax1Rate,
          'tax2': event.tax2Name,
          'tax2_rate':event.tax2Rate,
          'tax3': event.tax3Name,
          'tax3_rate':event.tax3Rate,
          'qty':event.qty,
          'hsn_code': event.hsnCode,
          'job_number':event.jobNumber,
          'description':event.description,
          'max_purchase_price': event.maxPurchasePrice,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}updateProduct");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditProductListState(message: decode['message']));
          }
          else {
            emit(FailureEditProductListState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditProductListState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteProductListEvent>((event, emit) async {
      emit(LoadingDeleteProductListState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          "product_item_id": event.productItemId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteProductItem");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteProductListState(message: decode['message']));
          }
          else {
            emit(FailureDeleteProductListState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteProductListState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}
