import 'dart:convert';

import 'package:erp_demo/vendor_module/vendor_screen/bloc/vendor_list_bloc/vendor_list_event.dart';
import 'package:erp_demo/vendor_module/vendor_screen/bloc/vendor_list_bloc/vendor_list_state.dart';
import 'package:erp_demo/vendor_module/vendor_screen/model/vendor_list_model/vendor_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';

class VendorListBloc extends Bloc<VendorListEvent, VendorListState> {
  VendorListBloc() : super(InitialVendorListState()) {
    on<FetchVendorListEvent>((event, emit) async{
      emit(LoadingVendorListState());
      try{
        final list = await fetchVendorListState();
        emit(LoadedVendorListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureVendorListState(error: "An error occurred"));
      }

    });
  }

  fetchVendorListState()async{
    List<VendorListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'page_number': "1",
      'page_size': "50",
      'search_text' : "",
      'vendor_level_id' : "",
      'product_id' : "",
      'start_date' : "",
      'end_date' : "",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}vendorList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        VendorListModel model = VendorListModel(
            id: index['id'],
            createdBy: index['created_by'],
            updatedBy: index['updated_by'],
            branchId: index['branch_id'],
            productId: index['product_id'],
            vendorName: index['vendor_name'],
            vendorEmail: index['vendor_email'],
            mobileNumber: index['mobile_number'],
            whatsappNo: index['whatsapp_no'],
            vendorCompanyName: index['vendor_company_name'],
            gstNo: index['gst_no'],
            vendorLevelId: index['vendor_level_id'],
            countryId: index['country_id'],
            stateId: index['state_id'],
            cityId: index['city_id'],
            address: index['address'],
            latitude: index['latitude'],
            longitude: index['longitude'],
            createdAt: index['created_at'],
            updatedAt: index['updated_at'],
            deletedAt: index['deleted_at'],
            vendorLevelName: index['vendor_level_name'],
            branchName: index['branch_name'],
            vendorTransactionDate: index['vendor_transaction_date'],
            countryName: index['country_name'],
            stateName: index['state_name'],
            cityName: index['city_name'],
            products: (index['products'] as List? ?? [])
                .map((e) => ProductModel.fromJson(e))
                .toList(),
            totalVendorPayment: index['totalVendorPayment'],
            totalGivenPayment: index['totalGivenPayment'],
            totalOutstandingPayment: index['totalOutstandingPayment']
        );
        list.add(model);
      }
      return list;
    }
  }


}
