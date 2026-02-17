import 'dart:convert';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/rejection_reason_list_bloc/rejection_reason_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/bloc/rejection_reason_list_bloc/rejection_reason_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/rejection_reason/model/rejection_reason_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class RejectionReasonListBlocs extends Bloc<RejectionReasonListEvents, RejectionReasonListStates> {
  RejectionReasonListBlocs() : super(InitialRejectionReasonListStates()) {
    on<FetchRejectionReasonListEvents>((event, emit) async {
      emit(LoadingRejectionReasonListStates());
      try{
        final list = await fetchRejectionReasonList();

        emit(LoadedRejectionReasonListStates(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureRejectionReasonListStates(error: "An error occurred"));
      }
    });
  }

  fetchRejectionReasonList() async {
    List<RejectionReasonListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };


    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getReasonList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for (var index in resultList) {
        RejectionReasonListModel model = RejectionReasonListModel(
          reasonId: index['id'],
          reason: index['reason'],
          status: index ['status'],
        );
        list.add(model);
      }
      return list;
    }
  }
}
