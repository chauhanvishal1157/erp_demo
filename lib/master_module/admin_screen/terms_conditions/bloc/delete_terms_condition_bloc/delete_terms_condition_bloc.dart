import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../../base_url/base_url.dart';
import 'delete_terms_condition_event.dart';
import 'delete_terms_condition_state.dart';

class DeleteTermsConditionBloc extends Bloc<DeleteTermsConditionEvent, DeleteTermsConditionState> {
  DeleteTermsConditionBloc() : super(InitialDeleteTermsConditionState()) {
    on<DeleteTermsConditionEvents>((event, emit) async {
      emit(LoadingDeleteTermsConditionState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          "id": event.termsConditionId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}termConditionDelete");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedDeleteTermsConditionState(message: decode['message']));
          }
          else {
            emit(FailureDeleteTermsConditionState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureDeleteTermsConditionState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
