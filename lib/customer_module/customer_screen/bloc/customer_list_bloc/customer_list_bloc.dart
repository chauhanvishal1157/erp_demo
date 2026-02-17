import 'dart:convert';

import 'package:erp_demo/customer_module/customer_screen/model/customer_list_model/customer_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';
import 'customer_list_event.dart';
import 'customer_list_state.dart';

class CustomerListBloc extends Bloc<CustomerListEvent, CustomerListState> {
  CustomerListBloc() : super(InitialCustomerListState()) {
    on<FetchCustomerListEvent>((event, emit)async {
      emit(LoadingCustomerListState());
      try{
        final list = await fetchCustomerListState();
        emit(LoadedCustomerListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureCustomerListState(error: "An error occurred"));
      }

    });
  }

  fetchCustomerListState()async{
    List<CustomerListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'page_number': "1",
      'page_size': "50",
      'user_id': "1",
      'status' : "",
      'search_text' : "",
      'customer_level_id' : "",
      'visit_area_id' : "",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}customerList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        CustomerListModel model = CustomerListModel(
            id: index['id'],
            branchId: index['branch_id'],
            productId: index['product_id'],
            visitAreaId: index['visit_area_id'],
            customerName: index['customer_name'],
            email: index['email'],
            mobileNo:index['mobile_no'],
            whatsappNo: index['whatsapp_no'],
            customerCompanyName: index['customer_company_name'],
            gstNo: index['gst_no'],
            address: index['address'],
            latitude: index['latitude'],
            longitude: index['longitude'],
            customerLevelId:index['customer_level_id'],
           status: index['status'],
           checkInCheckOutStatus: index['check_in_check_out_status'],
           customerLevelName: index['customer_level_name'],
           products:(index['products'] as List? ?? [])
               .map((e) => CustomerProduct.fromJson(e))
               .toList(),

        );
        list.add(model);
      }
      return list;
    }
  }

}
