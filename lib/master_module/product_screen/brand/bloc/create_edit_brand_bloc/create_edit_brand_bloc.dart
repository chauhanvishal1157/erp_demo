import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../../../base_url/base_url.dart';
import 'create_edit_brand_event.dart';
import 'create_edit_brand_state.dart';

class CreateEditBrandBloc extends Bloc<CreateEditBrandEvent, CreateEditBrandState> {

  CreateEditBrandBloc() : super(InitialCreateBrandState()) {
    on<CreateBrandEvent>((event, emit)async{
      emit(LoadingCreateBrandState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'name': event.brandName,
          'status':event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}createBrand");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedCreateBrandState(message: decode['message']));
          }
          else {
            emit(FailureCreateBrandState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureCreateBrandState(error: "An error occurred"));
        throw Exception(error);
      }
    });

    on<EditBrandEvent>((event, emit) async {
      emit(LoadingEditBrandState());
      try{
        Map data = {
          'db_connection': "erp_tata_steel_demo",
          'user_id': "1",
          'brand_id': event.brandId,
          'name': event.brandName,
          'status': event.status,
        };
        final Uri url = Uri.parse("${CrmBaseAppUrl.crmBaseAppUrl}editBrand");
        final response = await http.post(url,body: data);
        Map<String,dynamic> decode = json.decode(response.body);
        if(response.statusCode == 200) {
          if(decode['status'] == 200) {
            emit(LoadedEditBrandState(message: decode['message']));
          }
          else {
            emit(FailureEditBrandState(error: decode['message']));
          }
        }
      }
      catch(error){
        emit(FailureEditBrandState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }
}
