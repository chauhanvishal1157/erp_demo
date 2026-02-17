import 'dart:convert';
import 'package:erp_demo/master_module/lead_screen/visit_area/bloc/visit_area_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/bloc/visit_area_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/model/visit_area_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../base_url/base_url.dart';

class VisitAreaListBlocs extends Bloc<VisitAreaListEvents, VisitAreaListStates> {

  String searchValue = "";
  String branchId = '';
  int page = 1;


  int totalCount = 0;
  bool hasNextPage = false;

  VisitAreaListBlocs() : super(InitialVisitAreaListStates()) {
    on<FetchVisitAreaListEvents>((event, emit) async {
      emit(LoadingVisitAreaListStates());
      try{
        searchValue = event.searchValue;
        branchId = event.branchId;
        page = 1;
        final list = await fetchVisitAreaList(
          pageNumber: page,
          branchId: event.branchId,
          searchValue: searchValue,
        );
        emit(LoadedVisitAreaListStates(
            list: list,
            hasNextPage:hasNextPage,
            totalCount: totalCount,
        ));
      }catch(error){
        debugPrint("Error :: $error");
        emit(FailureVisitAreaListStates(error: "An error occurred"));
      }
    });
  }

  fetchVisitAreaList({
    required int pageNumber,
    required String branchId,
    required String searchValue,
})async {
    List<VisitAreaListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'search_text': searchValue,
      'page_number': pageNumber.toString(),
      'page_size': "20",
      'branch_id': branchId,
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}visitAreaList?");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];
      hasNextPage = decode['hasNextPage'];
      totalCount = decode['totalCount'];

      for (var index in resultList) {
        VisitAreaListModel model = VisitAreaListModel(
            id: index['id'],
            name: index['name'],
            branchName: index['branch_name'],
        );
        list.add(model);
      }
      return list;
    }
  }
}
