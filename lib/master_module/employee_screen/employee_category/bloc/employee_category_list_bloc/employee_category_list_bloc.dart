import 'dart:convert';
import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/bloc/employee_category_list_bloc/employee_category_list_event.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/bloc/employee_category_list_bloc/employee_category_list_state.dart';
import 'package:erp_demo/master_module/employee_screen/employee_category/model/employee_category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class EmployeeCategoryListBloc extends Bloc<EmployeeCategoryListEvents, EmployeeCategoryListStates> {

  EmployeeCategoryListBloc() : super(InitialEmployeeCategoryListStates()) {

    on<FetchEmployeeCategoryListEvents>((event, emit) async{
     emit(LoadingEmployeeCategoryListStates());
     try{
       final list = await fetchEmployeeCategoryList();

       emit(LoadedEmployeeCategoryListStates(list: list,));
     }catch(error){
       debugPrint("Error :: $error");
       emit(FailureEmployeeCategoryListStates(error: "An error occurred"));
     }
    });
  }

  fetchEmployeeCategoryList()async{

    final List<EmployeeCategoryListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };
    
    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getEmployeeCategoryList");
    final response = await http.post(url, body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];

      for (var index in resultList){
        EmployeeCategoryListModel model = EmployeeCategoryListModel(
            employeeCategoryId: index['id'],
            status: index['status'],
            employeeCategoryName: index['category_name'],
        );
        list.add(model);
      }
      return list;
    }
  }
}
