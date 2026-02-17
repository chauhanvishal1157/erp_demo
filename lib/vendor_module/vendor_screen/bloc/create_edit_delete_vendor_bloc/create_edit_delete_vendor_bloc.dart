import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';
import 'create_edit_delete_vendor_event.dart';
import 'create_edit_delete_vendor_state.dart';

class CreateEditDeleteVendorBloc extends Bloc<CreateEditDeleteVendorEvent, CreateEditDeleteVendorState> {
  CreateEditDeleteVendorBloc() : super(InitialCreateVendorState()) {

    on<CreateVendorEvent>((event, emit) async{
      emit(LoadingCreateVendorState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'vendor_name': event.vendorName,
          'vendor_email': event.vendorEmail,
          'mobile_number':event.mobileNumber,
          'address': event.address,
          'user_id': "1",
          'vendor_level_id': event.vendorLevelId,
          'product_id':event.productId,
          'country_id':event.countryId,
          'state_id':event.stateId,
          'city_id':event.cityId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createVendor");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateVendorState(message: decode['message']));
          }
          else {
            emit(FailureCreateVendorState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateVendorState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditVendorEvent>((event, emit) async {
      emit(LoadingEditVendorState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'vendor_id': event.vendorId,
          'vendor_name': event.vendorName,
          'vendor_email':event.vendorEmail,
          'mobile_number': event.mobileNumber,
          'whatsapp_no':event.whatsAppNo,
          'address': event.address,
          'vendor_level_id':event.vendorLevelId,
          'product_id':event.productId,
          'branch_id':event.branchId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editVendor");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditVendorState(message: decode['message']));
          }
          else {
            emit(FailureEditVendorState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditVendorState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeleteVendorEvent>((event, emit) async {
      emit(LoadingDeleteVendorState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'vendor_id': event.vendorId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deleteVendor");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteVendorState(message: decode['message']));
          }
          else {
            emit(FailureDeleteVendorState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteVendorState(error: "An error occurred"));
        throw Exception(error);
      }
    });


  }
}
