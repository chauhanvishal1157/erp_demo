import 'dart:convert';

import 'package:erp_demo/master_module/employee_screen/working_shift/bloc/working_shift_list_bloc/working_shift_list_event.dart';
import 'package:erp_demo/master_module/employee_screen/working_shift/bloc/working_shift_list_bloc/working_shift_list_state.dart';
import 'package:erp_demo/master_module/employee_screen/working_shift/model/working_shift_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../../base_url/base_url.dart';

class WorkingShiftListBlocs extends Bloc<WorkingShiftListEvents, WorkingShiftListStates> {

  WorkingShiftListBlocs() : super(InitialWorkingShiftListStates()) {

    on<FetchWorkingShiftListEvents>((event, emit) async{
     emit(LoadingWorkingShiftListStates());
     try{
       final list = await fetchWorkingShiftList();

       emit(LoadedWorkingShiftListStates(list: list,));
     }catch(error){
       debugPrint("Error :: $error");
       emit(FailureWorkingShiftListStates(error: "An error occurred"));
     }
    });
  }

  fetchWorkingShiftList() async{

    List<WorkingShiftListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}workingShiftList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for (var index in resultList) {
        WorkingShiftListModel model = WorkingShiftListModel(
            id: index['id'],
            shiftCode: index['shift_code'],
            name: index['name'],
            startTime: index['start_time'],
            endTime: index['end_time'],
            status: index['status'],
        );
        list.add(model);
      }
      return list;
    }
  }
}
