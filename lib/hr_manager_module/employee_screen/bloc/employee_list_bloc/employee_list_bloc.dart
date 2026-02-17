import 'dart:convert';

import 'package:erp_demo/hr_manager_module/employee_screen/model/employee_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../base_url/base_url.dart';
import 'employee_list_event.dart';
import 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  String searchValue = "";
  int page = 1;
  int totalCount = 0;
  bool hasNextPage = false;
  EmployeeListBloc() : super(InitialEmployeeListState()) {

    on<FetchEmployeeListEvent>((event, emit)async {
      emit(LoadingEmployeeListState());
      try{
        searchValue = event.searchValue;
        page = 1;
        final list = await fetchEmployeeList(
          pageNumber: page,
          searchValue: searchValue,
        );

        emit(LoadedEmployeeListState(
          list: list,
          hasNextPage: hasNextPage,
          totalCount: totalCount,
        ));
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(FailureEmployeeListState(error: "An error occurred"));
      }
    });
  }
  fetchEmployeeList({
    required int pageNumber,
    required String searchValue,
})async {
    List<EmployeeListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
      'search_text': searchValue,
      'page_number': pageNumber.toString(),
      'page_size': "15",
      'sort_type': ""
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}employeeList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data']['employeeList'];

      for (var index in resultList) {
        EmployeeListModel model = EmployeeListModel(
            employeeId: index['id'],
            name: index['name'],
            mobileNo: index['mobile_no'],
            empBioMaxDevice: index['emp_biomax_device'],
            categoryName: index['category_name'],
            salary:index['salary'],
            salaryPayType: index['salary_pay_type'],
            employeeCode: index['employee_code'],
            employeeProfile: index['employee_profile'],
            employeeFace: index['employee_face'],
            status: index['status'],
            ptStatus: index['pt_status'],
            pfStatus: index['pf_status'],
            esiStatus: index['esi_status'],
            pendingSalary: index['pending_salary'],
            perDaySalary: index['per_day_salary'],
            todayAttendance: index['today_attendance'],
        );
        list.add(model);
      }
      return list;
    }
  }
}
