import 'dart:convert';

import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/admin_screen/branch/bloc/create_edit_delete_master_branch_bloc/create_edit_master_branch_event.dart';
import 'package:erp_demo/master_module/admin_screen/branch/bloc/create_edit_delete_master_branch_bloc/create_edit_master_branch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CreateEditMasterBranchBloc extends Bloc<CreateEditMasterBranchEvent,CreateEditMasterBranchState> {
  CreateEditMasterBranchBloc() : super(InitialCreateMasterBranchState()) {

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

    on<EditMasterBranchEvent>((event, emit) async {
      emit(LoadingEditMasterBranchState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'branch_id': event.branchId,
          'name': event.branchName,
          'customer_id': event.multipleCustomerId,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editBranch");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditMasterBranchState(message: decode['message']));
          }
          else {
            emit(FailureEditMasterBranchState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditMasterBranchState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}