import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/sub_category_list_bloc/sub_category_list_bloc.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/sub_category_list_bloc/sub_category_list_event.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/sub_category_list_bloc/sub_category_list_state.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/screens/create_edit_sub_category_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/screens/delete_sub_category_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common_decoration.dart';


class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubCategoryListBloc(),
      child: SubCategoryScreenWidget(),
    );
  }
}


class SubCategoryScreenWidget extends StatefulWidget {
  const SubCategoryScreenWidget({super.key});

  @override
  State<SubCategoryScreenWidget> createState() => _SubCategoryScreenWidgetState();
}

class _SubCategoryScreenWidgetState extends State<SubCategoryScreenWidget> {



  @override
  void initState() {

    BlocProvider.of<SubCategoryListBloc>(context).add(FetchSubCategoryListEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Sub Category Master",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            context: context,
            builder:(context){
              return CreateEditSubCategoryBottomSheet(
                isEdit: false,
                subCategoryName: '',
                status: '',
                subCategoryId: '',
                categoryId: '',
                categoryName: '',
              );
            },
          ).then(
                  (value){
                if(value == true){
                  BlocProvider.of<SubCategoryListBloc>(context).add(
                      FetchSubCategoryListEvent()
                  );
                }
              }
          );
        },
      ),
      body: BlocBuilder<SubCategoryListBloc,SubCategoryListStates>(
          builder: (context,state){
            if (state is InitialSubCategoryListStates) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            else if(state is LoadingSubCategoryListStates){
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            else if(state is LoadedSubCategoryListStates){
              return  ListView.builder(
                itemCount: state.list.length  ,
                padding:  EdgeInsets.all(15),
                itemBuilder: (context, index) {

                  String statusLabel = state.list[index].status == 1
                      ? "Active"
                      : "Inactive";

                  Color statusColor = (state.list[index].status) == 1
                      ? Colors.green
                      : Colors.red;

                  return GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                        isScrollControlled:true,
                        context: context,
                        builder:(context){
                          return  CreateEditSubCategoryBottomSheet(
                            isEdit: true,
                            subCategoryName: state.list[index].subCategoryName,
                            status: state.list[index].status.toString(),
                            subCategoryId: state.list[index].subCategoryId.toString(),
                            categoryId: state.list[index].categoryId.toString(),
                            categoryName: state.list[index].categoryName,
                          );
                        },
                      ).then(
                              (value){
                            if(value == true){
                              BlocProvider.of<SubCategoryListBloc>(context).add(
                                  FetchSubCategoryListEvent()
                              );
                            }
                          }
                      );
                    },
                    child: Container(
                      margin:  EdgeInsets.only(bottom: 15),
                      decoration: CommonDecorations.card(),
                      child: Padding(
                        padding:  EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding:  EdgeInsets.all(10),
                              child:  Icon(
                                  state.list[index].status == 1
                                      ? Icons.check_circle_outline   // Active icon
                                      : Icons.pause_circle_outline,
                                  color: statusColor
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.list[index].subCategoryName,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(alpha: 0.1),
                                      border: Border.all(
                                        color: statusColor.withValues(alpha: 1),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child:  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          statusLabel,
                                          style: TextStyle(
                                            color: statusColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6,),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.blue.shade200,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.file_copy,
                                          size: 16,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            "Category: ${state.list[index].categoryName}",
                                            style:  TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonPopMenuButton(
                                value1: (){
                                  showModalBottomSheet(
                                    isScrollControlled:true,
                                    context: context,
                                    builder:(context){
                                      return CreateEditSubCategoryBottomSheet(
                                        isEdit: true,
                                        subCategoryName: state.list[index].subCategoryName,
                                        status: state.list[index].status.toString(),
                                        subCategoryId: state.list[index].subCategoryId.toString(),
                                        categoryId: state.list[index].categoryId.toString(),
                                        categoryName: state.list[index].categoryName,
                                      );
                                    },
                                  ).then(
                                          (value){
                                        if(value == true){
                                          BlocProvider.of<SubCategoryListBloc>(context).add(FetchSubCategoryListEvent());
                                        }
                                      }
                                  );
                                },
                                value2: (){
                                  showModalBottomSheet(
                                    isScrollControlled:true,
                                    context: context,
                                    builder:(context){
                                      return  DeleteSubCategoryBottomSheet(
                                        subCategoryId: state.list[index].subCategoryId.toString(),
                                      );
                                    },
                                  ).then(
                                          (value){
                                        if(value == true){
                                          BlocProvider.of<SubCategoryListBloc>(context).add(FetchSubCategoryListEvent());
                                        }
                                      }
                                  );
                                }
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else if(state is FailureSubCategoryListState){
              return Center(
                child: Text(state.error),
              );
            }
            return Container();
          }
      ),

    );
  }
}