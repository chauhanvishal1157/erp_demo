import 'dart:convert';

import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/payment_terms_list_bloc/payment_term_list_event.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/payment_terms_list_bloc/payment_term_list_state.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/model/payment_term_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PaymentTermListBlocs extends Bloc<PaymentTermListEvents,PaymentTermListStates>{

  PaymentTermListBlocs() : super(InitialPaymentTermListStates()){
    on<FetchPaymentTermListEvents>((event, emit) async {
      emit(LoadingPaymentTermListStates());
      try{
        final list = await fetchPaymentTermList();
        emit(LoadedPaymentTermListStates(list: list));

      }catch(error){
        debugPrint("Error :: $error");
        emit(FailurePaymentTermListStates(error: "{An error occurred"));
      }
    });
  }

  fetchPaymentTermList() async{
    List<PaymentTermListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getPaymentTermList");
    final response = await http.post(url, body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];
      for (var index in resultList){
        PaymentTermListModel model = PaymentTermListModel(
            paymentTermsId: index['id'],
            paymentTermsName: index['name'],
            status: index['status'],
        );
        list.add(model);
      }
      return list;
    }

  }

}