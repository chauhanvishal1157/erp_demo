import 'dart:convert';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/terms_conditions_list_bloc/terms_conditions_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/terms_conditions_list_bloc/terms_conditions_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/model/terms_conditions_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class TermsConditionsListBlocs extends Bloc<TermsConditionsListEvents,TermsConditionsListStates>{

  int page = 1;
  int totalCount = 0;
  bool hasNextPage = false;
  List<TermsConditionsListModel> combineList = [];

  TermsConditionsListBlocs() : super(InitialTermsConditionsListStates()){


    on<FetchTermsConditionsListEvents>((event, emit) async {
      emit( LoadingTermsConditionsListStates());
      try{
        page = 1;
        final list = await fetchTermsConditionsList(
          pageNumber: page,
        );
        emit(LoadedTermsConditionsListStates(
          list: list,
          hasNextPage: hasNextPage,
          totalCount: totalCount,
        ));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit( FailureTermsConditionsListStates(error: "An error occurred"));
      }
    });
  }

  fetchTermsConditionsList({
    required int pageNumber,
}) async {

    List<TermsConditionsListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "2",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}termConditionList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        TermsConditionsListModel model = TermsConditionsListModel(
          termsConditionId: index['id'],
          title: index['title'],
          text:index ['text'],
          type:index ['type'],
        );
        list.add(model);
      }
      return list;
    }
  }

}
