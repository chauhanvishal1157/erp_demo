import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../../base_url/base_url.dart';
import 'create_edit_delete_payment_term_event.dart';
import 'create_edit_delete_payment_term_state.dart';

class CreateEditDeletePaymentTermBloc extends Bloc<CreateEditDeletePaymentTermEvent, CreateEditDeletePaymentTermState> {
  CreateEditDeletePaymentTermBloc() : super(InitialCreatePaymentTermState()) {

    on<CreatePaymentTermEvent>((event, emit) async {
      emit(LoadingCreatePaymentTermState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'name': event.paymentTermsName,
          'status':event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createPaymentTerm");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreatePaymentTermState(message: decode['message']));
          }
          else {
            emit(FailureCreatePaymentTermState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreatePaymentTermState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditPaymentTermEvent>((event, emit) async {
      emit(LoadingEditPaymentTermState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'payment_term_id': event.paymentTermsId,
          'name': event.paymentTermsName,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editPaymentTerm");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditPaymentTermState(message: decode['message']));
          }
          else {
            emit(FailureEditPaymentTermState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditPaymentTermState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<DeletePaymentTermEvent>((event, emit) async {
      emit(LoadingDeletePaymentTermState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          "payment_term_id": event.paymentTermsId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}deletePaymentTerm");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeletePaymentTermState(message: decode['message']));
          }
          else {
            emit(FailureDeletePaymentTermState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeletePaymentTermState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }
}
