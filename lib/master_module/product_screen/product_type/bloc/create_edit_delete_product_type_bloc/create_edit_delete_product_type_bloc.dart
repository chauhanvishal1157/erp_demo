import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';
import 'create_edit_delete_product_type_event.dart';
import 'create_edit_delete_product_type_state.dart';

class CreateEditDeleteProductTypeBloc extends Bloc<CreateEditDeleteProductTypeEvent, CreateEditDeleteProductTypeState> {
  CreateEditDeleteProductTypeBloc() : super(InitialCreateProductTypeState()) {

    on<CreateProductTypeEvent>((event, emit) async{
     emit(LoadingCreateProductTypeState());
     try{
       Map data = {
         'db_connection': "erp_tata_steel_demo",
         'user_id': "1",
         'name': event.productName,
         'status':event.status,
       };
       final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createProductType");
       final response = await http.post(url,body: data);
       Map<String,dynamic> decode = json.decode(response.body);
       if(response.statusCode == 200) {
         if(decode['status'] == 200) {
           emit(LoadedCreateProductTypeState(message: decode['message']));
         }
         else {
           emit(FailureCreateProductTypeState(error: decode['message']));
         }
       }
     }
     catch(error){
       emit(FailureCreateProductTypeState(error: "An error occurred"));
       throw Exception(error);
     }
    });

    on<EditProductTypeEvent>((event, emit) async {
      emit(LoadingEditProductTypeState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'product_type_id': event.productId,
          'name': event.productName,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editProductType");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditProductTypeState(message: decode['message']));
          }
          else {
            emit(FailureEditProductTypeState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditProductTypeState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteProductTypeEvent>((event, emit) async {
      emit(LoadingDeleteProductTypeState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "product_type_id": event.productId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteProductType");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteProductTypeState(message: decode['message']));
          }
          else {
            emit(FailureDeleteProductTypeState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteProductTypeState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}
