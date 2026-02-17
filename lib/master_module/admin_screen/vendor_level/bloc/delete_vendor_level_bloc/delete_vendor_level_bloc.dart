import 'dart:convert';
import 'package:erp_demo/base_url/base_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'delete_vendor_level_event.dart';
import 'delete_vendor_level_state.dart';


class DeleteVendorLevelBloc  extends Bloc<DeleteVendorLevelEvent, DeleteVendorLevelState> {
  DeleteVendorLevelBloc() : super(InitialDeleteVendorLevelState()) {


    on<DeleteVendorLevelEvent>((event, emit) async {
      emit(LoadingDeleteVendorLevelState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "vendor_level_id": event.vendorLevelId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteVendorLevel");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteVendorLevelState(message: decode['message']));
          }
          else {
            emit(FailureDeleteVendorLevelState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteVendorLevelState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}