
import 'dart:convert';

import 'package:erp_demo/country/bloc/state_list_bloc/state_list_event.dart';
import 'package:erp_demo/country/bloc/state_list_bloc/state_list_state.dart';
import 'package:erp_demo/country/model/state_model/state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../base_url/base_url.dart';

class StateListBloc extends Bloc<StateListEvent, StateListState> {
  StateListBloc() : super(InitialStateListState()) {
    on<FetchStateListEvent>((event, emit) async{

      emit(LoadingStateListState());
      try{
        final list = await fetchStateListState(event.countryId);
        emit(LoadedStateListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureStateListState(error: "An error occurred"));
      }

    });
  }

  fetchStateListState(
      String countryId
      )async{
    List<StateModel> list = [];
    Map data = {
      'country_id': countryId,
      'search_text' : "",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}stateList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        StateModel model = StateModel(
            id: index['id'],
            name: index['name'],
            countryId: index['country_id'],
            countryCode: index['country_code'],
        );
        list.add(model);
      }
      return list;
    }
  }

}
