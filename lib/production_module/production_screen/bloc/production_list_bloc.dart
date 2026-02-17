import 'dart:convert';
import 'package:erp_demo/production_module/production_screen/bloc/production_list_event.dart';
import 'package:erp_demo/production_module/production_screen/bloc/production_list_state.dart';
import 'package:erp_demo/production_module/production_screen/model/production_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../base_url/base_url.dart';

class ProductionListBloc extends Bloc<ProductionListEvent, ProductionListState> {

  ProductionListBloc() : super(InitialProductionListState()) {

    on<FetchProductionListEvent>((event, emit) async{
      emit(LoadingProductionListState());
      try{
        final list = await fetchProductionListState();
        emit(LoadedProductionListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureProductionListState(error: "An error occurred"));
      }
    });
  }

  fetchProductionListState()async{
    List<ProductionListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'page_number': "1",
      'page_size': "10",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getProductionList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        ProductionListModel model = ProductionListModel(
          id: index['id'],
          branchId: index['branch_id'],
          branchName:index['branch_name'],
          orderNo: index['order_no'],
          stockStatus: index['stock_status'],
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
          statusName: index['status_name'],
          moduleStatus: index['module_status'],
          statusTextColor: index['status_text_color'],
          statusBgcolor: index['status_bgcolor'],
          createdByStatus: index['created_by_status'],
          description: index['description'],
          status: index['status'],
          createdAt: index['created_at'],
          createdBy: index['created_by'],
        );
        list.add(model);
      }
      return list;
    }
  }
  }
  
