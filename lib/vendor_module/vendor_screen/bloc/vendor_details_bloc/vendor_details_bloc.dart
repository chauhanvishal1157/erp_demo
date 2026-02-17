import 'dart:convert';

import 'package:erp_demo/vendor_module/vendor_screen/bloc/vendor_details_bloc/vendor_details_event.dart';
import 'package:erp_demo/vendor_module/vendor_screen/bloc/vendor_details_bloc/vendor_details_state.dart';
import 'package:erp_demo/vendor_module/vendor_screen/model/vendor_details_model/vendor_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';

class VendorDetailsBloc extends Bloc<VendorDetailsEvent, VendorDetailsState> {

  VendorDetailsBloc() : super(InitialVendorDetailsState()) {
    on<FetchVendorDetailsEvent>(_onFetchVendorDetails);
  }

  Future<void> _onFetchVendorDetails(
      FetchVendorDetailsEvent event,
      Emitter<VendorDetailsState> emit,
      ) async {
    emit(LoadingVendorDetailsState());
    try {
      final vendor = await fetchVendorDetailsState(event.vendorId);

      emit(LoadedVendorDetailsState(list: [vendor]));
    } catch (error) {
      debugPrint("Error :: $error");
      emit(FailureVendorDetailsState(error: "An error occurred"));
    }
  }

  Future<VendorDetailsModel> fetchVendorDetailsState(
      String vendorId) async {

    final Map<String, String> data = {
      'db_connection': "erp_tata_steel_demo",
      'vendor_id': vendorId,
    };


    final Uri url = Uri.parse(
      "${CrmBaseAppUrl.crmBaseAppUrl}vendorDetails",
    );

    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decode =
      json.decode(response.body);

      return VendorDetailsModel.fromJson(decode['data']);
    } else {
      throw Exception("Server error");
    }
  }
}

