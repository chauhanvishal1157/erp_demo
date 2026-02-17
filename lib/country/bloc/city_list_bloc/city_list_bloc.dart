import 'dart:convert' show json;
import 'package:erp_demo/base_url/base_url.dart' show CrmBaseAppUrl;
import 'package:erp_demo/country/model/city_model/city_model.dart';
import 'package:flutter/cupertino.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http show post;
import 'city_list_event.dart';
import 'city_list_state.dart';

class CityListBloc extends Bloc<CityListEvent, CityListState> {
  CityListBloc() : super(InitialCityListState()) {
    on<FetchCityListEvent>((event, emit) async{

      emit(LoadingCityListState());
      try{
        final list = await fetchStateListState(event.stateId);
        emit(LoadedCityListState(list: list,));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureCityListState(error: "An error occurred"));
      }

    });
  }

  fetchStateListState(
      String stateId
      )async{
    List<CityModel> list = [];
    Map data = {
      'state_id': stateId,
      'search_text' : "",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}cityList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for(var index in resultList) {
        CityModel model = CityModel(
            id: index['id'],
            name:  index['name'],
            stateId:  index['state_id'],
            stateCode:  index['state_code'],
            countryCode:  index['country_code']
        );
        list.add(model);
      }
      return list;
    }
  }

}
