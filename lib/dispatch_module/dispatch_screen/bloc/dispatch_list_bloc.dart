
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../base_url/base_url.dart';
import '../model/dispatch_list_model.dart';
import 'dispatch_list_event.dart';
import 'dispatch_list_state.dart';

class DispatchListBloc extends Bloc<DispatchListEvent, DispatchListState> {
  DispatchListBloc() : super(InitialDispatchListState()){
    on<FetchDispatchListEvent>((event, emit) async{
      emit(LoadingDispatchListState());
      try{
        final list = await fetchDispatchListState();
        emit(LoadedDispatchListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureDispatchListState(error: "An error occurred"));
      }
    });
  }

  fetchDispatchListState()async{
    List<DispatchListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'page_number': "1",
      'page_size': "10",
      'user_id': "1",
      'status' : ""
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getDispatchList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        DispatchListModel model = DispatchListModel(
            id: index['id'],
            description: index['description'],
            branchId: index['branch_id'],
            branchName: index['branch_name'],
            status: index['status'],
            orderNo: index['order_no'],
            stockStatus: index['stock_status'],
            createdAt: index['created_at'],
            billingAddress: index['billing_address'],
            shippingAddress: index['shipping_address'],
            customerName: index['customer_name'],
            email: index['email'],
            mobileNo: index['mobile_no'],
            whatsappNo: index['whatsapp_no'],
            address: index['address'],
            grandTotal: index['grand_total'],
            pendingAmount: index['pending_amount'],
            receivedAmount: index['received_amount'],
            productSerialNumber: index['product_serial_number'],
            exclusiveOrInclusive: index['exclusive_or_inclusive'],
            statusName: index['status_name'],
            moduleStatus: index['module_status'],
            statusTextColor: index['status_text_color'],
            statusBgColor: index['status_bgcolor'],
            createdBy: index['created_by'],
          createdByStatus: index['created_by_status'],
        );
        list.add(model);
      }
      return list;
    }
  }

}

