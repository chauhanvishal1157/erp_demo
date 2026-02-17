import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';
import '../../model/customer_details_model/customer_details_model.dart';
import 'customer_details_event.dart';
import 'customer_details_state.dart';

class CustomerDetailsBloc extends Bloc<CustomerDetailsEvent, CustomerDetailsState> {

  CustomerDetailsBloc() : super(InitialCustomerDetailsState()) {
    on<FetchCustomerDetailsEvent>(_onFetchCustomerDetails);
  }

  Future<void> _onFetchCustomerDetails(
      FetchCustomerDetailsEvent event,
      Emitter<CustomerDetailsState> emit,
      ) async {
    emit(LoadingCustomerDetailsState());
    try {
      final customer =
      await fetchCustomerDetailsState(event.customerId);

      emit(LoadedCustomerDetailsState(list: [customer]));
    } catch (error) {
      debugPrint("Error :: $error");
      emit(FailureCustomerDetailsState(error: "An error occurred"));
    }
  }

  Future<CustomerDetailsModel> fetchCustomerDetailsState(
      String customerId) async {

    final Map<String, String> data = {
      'db_connection': "erp_tata_steel_demo",
      'customer_id': customerId,
    };

    final Uri url =
    Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}detailsCustomer");

    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decode =
      json.decode(response.body);

      return CustomerDetailsModel.fromJson(decode['data']);
    } else {
      throw Exception("Server error");
    }
  }
}

