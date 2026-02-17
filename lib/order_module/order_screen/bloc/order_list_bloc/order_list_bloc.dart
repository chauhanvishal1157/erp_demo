import 'dart:convert';

import 'package:erp_demo/order_module/order_screen/model/order_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';
import 'order_list_event.dart';
import 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListBloc() : super(InitialOrderListState()) {

    on<FetchOrderListEvent>((event, emit) async{
      emit(LoadingOrderListState());
      try{
        final list = await fetchOrderListState();
        emit(LoadedOrderListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureOrderListState(error: "An error occurred"));
      }
    });
  }

  fetchOrderListState()async{
    List<OrderListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'page_number': "1",
      'page_size': "10",
      'user_id': "1",
      'status': "",
      'search_text': "",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}orderList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        OrderListModel model = OrderListModel(
            id: index['id'],
            branchId: index['branch_id'],
            branchName: index['branch_name'],
            status: index['status'],
            orderNo: index['order_no'],
            stockStatus: index['stock_status'],
            billingAddress: index['billing_address'],
            shippingAddress: index['shipping_address'],
            createdAt: index['created_at'],
            grandTotal: index['grand_total'],
            pendingAmount: index['pending_amount'],
            receivedAmount: index['received_amount'],
            productSerialNumber: index['product_serial_number'],
            customerName: index['customer_name'],
            email: index['email'],
            mobileNo: index['mobile_no'],
            statusName: index['status_name'],
            moduleStatus: index['module_status'],
            statusTextColor: index['status_text_color'],
            statusBgColor: index['status_bgcolor'],
            newTotalMrp: index['new_total_mrp']
        );
        list.add(model);
      }
      return list;
    }
  }
}
