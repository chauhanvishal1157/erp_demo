import 'dart:convert';

import 'package:erp_demo/country/model/country_model/country_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../base_url/base_url.dart';
import 'country_list_event.dart';
import 'country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  String searchValue = "";

  CountryListBloc() : super(InitialCountryListState()) {
    on<FetchCountryListEvent>((event, emit) async{

      emit(LoadingCountryListState());
      try{
        searchValue = event.searchValue;
        final list = await fetchCountryListState(
          searchValue: searchValue,
        );
        emit(LoadedCountryListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureCountryListState(error: "An error occurred"));
      }

    });
  }

  fetchCountryListState({
    required String searchValue,
})async{
    List<CountryModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'search_text' : searchValue,
      'user_id' : "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}countryList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        CountryModel model = CountryModel(
            id: index['id'],
            name: index['name'],
            iso2: index['iso2'],
            phoneCode: index['phonecode'],
            currencySymbol: index['currency_symbol'],
            emojiU: index['emojiU'],
            emoji: index['emoji']
        );
        list.add(model);
      }
      return list;
    }
  }

}
