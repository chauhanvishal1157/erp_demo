import 'dart:convert';
import 'dart:io';

import 'package:erp_demo/base_url/base_url.dart';
import 'package:erp_demo/master_module/admin_screen/branch/bloc/master_branch_bloc/master_branch_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/branch/bloc/master_branch_bloc/master_branch_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/branch/model/master_branch_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class BranchListBlocs extends Bloc<BranchListEvents,BranchListStates> {
  String searchValue = "";
  String multipleBranchId = '';
  int page = 1;
  int totalCount = 0;
  bool hasNextPage = false;
  List<BranchListModel> combineList = [];
  bool isLoadMore = false;
  ScrollController scrollController = ScrollController();
  bool showLoadingIndicator = false;
  bool isLoading = false;
  bool areaVisit = false;

  BranchListBlocs() : super(const InitialBranchListState(null)) {

    scrollController.addListener(() {
      if (!showLoadingIndicator && !isLoading) {
        _checkShouldLoadMore();
      }
      // add(LoadMoreBranchListEvent());
    });

    on<FetchBranchListEvents>((event, emit) async {
      emit(const LoadingBranchListState(null));
      try{
        searchValue = event.searchValue;
        multipleBranchId = event.multipleBranchId;
        // areaVisit = event.areaVisit;
        page = 1;
        final list = await fetchBranchList(
          pageNumber: page,
          multipleBranchId: event.multipleBranchId,
          searchValue: searchValue,
        );
        emit(LoadedBranchListState(
          list: list,
          hasNextPage: hasNextPage,
          totalCount: totalCount,
        ));
      }
      on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(const InternalServerErrorBranchListState(
              error: "Internal server error: 500"));
        }
        else {
          emit(ServerErrorBranchListState(
              error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      }
      catch(error){
        emit(const FailureBranchListState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<LoadMoreBranchListEvent>((event, emit) async {
      if (!isLoading) {
        isLoading = true;
        final newCustomer = await fetchBranchList(
          pageNumber: page,
          multipleBranchId: multipleBranchId,
          searchValue: searchValue,
        );

        combineList = [...state.branchList, ...newCustomer];
        emit(LoadedBranchListState(
          list: combineList,
          hasNextPage: hasNextPage,
          totalCount: totalCount,

        ));
        if(combineList.length == totalCount){
          isLoadMore = false;
        }
        isLoading = false;

      }
    });
  }

  void _checkShouldLoadMore() {
    double offsetFromBottom =
        scrollController.position.maxScrollExtent - scrollController.offset;
    if (offsetFromBottom < 250 && hasNextPage && !isLoading) {
      page++;
      add(LoadMoreBranchListEvent());
    }
  }

  fetchBranchList({
    required int pageNumber,
    required String multipleBranchId,
    required String searchValue,
  }) async {
    List<BranchListModel> list = [];
    Map data = {
      'db_connection': "erp_tata_steel_demo",
      'search_text': searchValue,
      'page_number': pageNumber.toString(),
      'page_size': "15",
    };
    final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}branchList");
    final response = await http.post(url,body: data);
    if(response.statusCode == 200){
      Map<String, dynamic> decode = json.decode(response.body);
      final resultList = decode['data'];
      hasNextPage = decode['hasNextPage'];
      totalCount = decode['totalCount'];
      // if (resultList.isEmpty) {
      //   isLoadMore = false;
      // }
      // else {
      //   isLoadMore = true;
      // }
      isLoadMore = resultList.isNotEmpty;

      for(var index in resultList) {
        BranchListModel model = BranchListModel(
          branchId: index['id'],
          branchName: index['name'],
          customerId: index['customer_id'],
        );
        list.add(model);
      }
      // if(areaVisit == true) {
      list.insert(0,BranchListModel(branchId: 0, branchName: "Master", customerId: "",),);
      // }
      for(var i = 0; i< list.length; i++) {
        if(multipleBranchId.contains(list[i].branchId.toString())) {
          list[i].isSelected = true;
        }
        else {
          list[i].isSelected = false;
        }
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