import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';
import 'create_edit_delete_customer_event.dart';
import 'create_edit_delete_customer_state.dart';

class CreateEditDeleteCustomerBloc extends Bloc<CreateEditDeleteCustomerEvent, CreateEditDeleteCustomerState> {
  CreateEditDeleteCustomerBloc() : super(InitialCreateCustomerState()) {

    on<CreateCustomerEvent>((event, emit) async{
      emit(LoadingCreateCustomerState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "2",
          'customer_name': event.customerName,
          'email':event.email,
          'mobile_no': event.mobileNo,
          'whatsapp_no':event.whatsappNo,
          'gst_no': event.gstNo,
          'address':event.address,
          'customer_level_id': event.customerLevelId,
          'product_id':event.productId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createCustomer");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateCustomerState(message: decode['message']));
          }
          else {
            emit(FailureCreateCustomerState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateCustomerState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditCustomerEvent>((event, emit) async {
      emit(LoadingEditCustomerState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'customer_id': event.customerId,
          'customer_name': event.customerName,
          'email':event.email,
          'mobile_no': event.mobileNo,
          'whatsapp_no':event.whatsappNo,
          'gst_no': event.gstNo,
          'address':event.address,
          'product_id':event.productId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editCustomer");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditCustomerState(message: decode['message']));
          }
          else {
            emit(FailureEditCustomerState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditCustomerState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteCustomerEvent>((event, emit) async {
      emit(LoadingDeleteCustomerState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'customer_id': event.customerId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteCustomer");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteCustomerState(message: decode['message']));
          }
          else {
            emit(FailureDeleteCustomerState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteCustomerState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}
