import 'dart:convert';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/bloc/visit_area_customer_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/bloc/visit_area_customer_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/model/visit_area_customer_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../../base_url/base_url.dart';

class VisitAreaCustomerListBloc extends Bloc<VisitAreaCustomerListEvents, VisitAreaCustomerListStates> {

  int page = 1;
  int totalCount = 0;
  bool hasNextPage = false;
  String branchId = "";
  String visitAreaId = "";

  VisitAreaCustomerListBloc() : super(InitialVisitAreaCustomerListStates()) {

    on<FetchVisitAreaCustomerListEvents>((event, emit) async {

      emit(LoadingVisitAreaCustomerListStates());
      try{
        page = 1;
        branchId = event.branchId;
        visitAreaId = event.visitAreaId;
        final list = await fetchVisitAreaCustomerList(
          pageNumber: page,
          branchId: branchId,
          visitAreaId: visitAreaId,
        );
        emit(LoadedVisitAreaCustomerListStates(
            list: list,
            hasNextPage: hasNextPage,
            totalCount: totalCount,
        ));

      }catch(error){
        debugPrint("Error :: $error");
        emit(FailureVisitAreaCustomerListStates(error: "An error occurred"));
      }
    });

    on<CreateMasterBranchEvent>((event, emit) async {
      emit(LoadingCreateMasterBranchState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'name': event.branchName,
          'customer_id': event.multipleCustomerId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createBranch");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateMasterBranchState(message: decode['message']));
          }
          else {
            emit(FailureCreateMasterBranchState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateMasterBranchState(error: "An error occurred"));
        throw Exception(error);
      }
    });

  }

  fetchVisitAreaCustomerList({
    required int pageNumber,
    required String branchId,
    required String visitAreaId,
}) async {
    List<VisitAreaCustomerListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'branch_id': branchId,
      'visit_area_id': visitAreaId,
      'user_id': "1",
      'latitudeFrom': "23.0786037",
      'longitudeFrom': "72.5011455",
    };
    debugPrint("VISIT AREA -> $data");
    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}visitAreaCustomerList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];
      hasNextPage = decode['hasNextPage'];
      totalCount = decode['totalCount'];

      for (var index in resultList) {
        VisitAreaCustomerListModel model = VisitAreaCustomerListModel(
          id: index['id'],
          branchId: index['branch_id'],
          visitAreaId: index['visit_area_id'],
          customerName: index['customer_name'],
          email: index['email'],
          mobileNo: index['mobile_no'],
          branchName: index['branch_name'],
        );
        list.add(model);
      }
      return list;
    }
  }
}
