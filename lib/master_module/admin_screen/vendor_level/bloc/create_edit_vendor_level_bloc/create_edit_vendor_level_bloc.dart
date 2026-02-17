import 'dart:convert';
import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/create_edit_vendor_level_bloc/create_edit_vendor_level_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'create_edit_vendor_level_state.dart';

class CreateEditVendorLevelBloc  extends Bloc<CreateEditVendorLevelEvent,CreateEditVendorLevelState> {
  CreateEditVendorLevelBloc() : super(InitialCreateVendorLevelState()) {

    on<CreateVendorLevelEvent>((event, emit) async {
      emit(LoadingCreateVendorLevelState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'name': event.vendorLevelName,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createVendorLevel");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateVendorLevelState(message: decode['message']));
          }
          else {
            emit(FailureCreateVendorLevelState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateVendorLevelState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditVendorLevelEvent>((event, emit) async {
      emit(LoadingEditVendorLevelState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "vendor_level_id": event.vendorLevelId,
          'name': event.vendorLevelName,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editVendorLevel");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditVendorLevelState(message: decode['message']));
          }
          else {
            emit(FailureEditVendorLevelState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditVendorLevelState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}