import 'dart:convert';
import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/vendor_level_list_bloc/vendor_level_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/vendor_level_list_bloc/vendor_level_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../model/vendor_level_list_model.dart';

class VendorLevelListBloc extends Bloc<VendorLevelListEvents, VendorLevelListStates> {

  VendorLevelListBloc() : super(InitialVendorLevelListStates()) {

    on<FetchVendorLevelListEvent>((event, emit) async{
      emit(LoadingVendorLevelListStates());
      try{
        final list = await fetchVendorLevelList();

        emit(LoadedVendorLevelListStates(list: list,));
      }catch(error){
        debugPrint("Error :: $error");
        emit(FailureVendorLevelListStates(error: "An error occurred"));
      }
    });
  }

  fetchVendorLevelList()async{

    final List<VendorLevelListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}vendorLevelList");
    final response = await http.post(url, body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for (var index in resultList){
        VendorLevelListModel model = VendorLevelListModel(
          vendorLevelId: index['id'],
          status: index['status'],
          vendorLevelName: index['name'],
        );
        list.add(model);
      }
      return list;
    }
  }
}
