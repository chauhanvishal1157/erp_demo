import 'dart:convert';
import 'dart:io';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/customer_level_bloc/customer_level_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/bloc/customer_level_bloc/customer_level_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/customer_level/model/customer_level_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../../base_url/base_url.dart';

class CustomerLevelListBlocs extends Bloc<CustomerLevelListEvents, CustomerLevelListStates>{

  List<CustomerLevelListModel> combineList = [];
  bool isLoadMore = false;
  ScrollController scrollController = ScrollController();
  bool showLoadingIndicator = false;
  bool isLoading = false;
  bool areaVisit = false;

  CustomerLevelListBlocs() : super(const InitialCustomerLevelListState(null)){

    scrollController.addListener(() {
      if (!showLoadingIndicator && !isLoading) {

      }
      // add(LoadMoreBranchListEvent());
    });
    on<FetchCustomerLevelListEvent>((event, emit) async {
      emit(const LoadingCustomerLevelListState(null));
      try{
        final list = await fetchCustomerLevelList(
        );
        emit(LoadedCustomerLevelListState(list: list,));
      }
      on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(const InternalServerErrorCustomerLevelListState(
              error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorCustomerLevelListState(
              error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      }
      catch(error){
        debugPrint("Error :: $error");
        emit(const FailureCustomerLevelListState(error: "An error occurred"));
        throw Exception(error);
      }
    });


}


  fetchCustomerLevelList() async {
    List<CustomerLevelListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'user_id': "1",
    };

    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}getCustomerLevelList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];
      isLoadMore = resultList.isNotEmpty;

      for(var index in resultList) {
        CustomerLevelListModel model = CustomerLevelListModel(
          customerLevelId: index['id'],
          customerLevelName: index['name'],
        );
        list.add(model);
      }
      return list;
    }
    else {
      throw HttpException('Error: ${response.statusCode}');
    }

}

  @override
  Future<void> close(){
    scrollController.dispose();
    return super.close();
  }

}