import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/product_screen/category/bloc/category_master_bloc/category_list_bloc.dart';
import 'package:erp_demo/master_module/product_screen/category/bloc/category_master_bloc/category_list_event.dart';
import 'package:erp_demo/master_module/product_screen/category/bloc/category_master_bloc/category_list_state.dart';
import 'package:erp_demo/master_module/product_screen/category/screens/create_edit_category_master_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/category/screens/delete_category_master_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common_decoration.dart';


class CategoryMasterScreen extends StatefulWidget {
  const CategoryMasterScreen({super.key});

  @override
  State<CategoryMasterScreen> createState() => _CategoryMasterScreenState();
}

class _CategoryMasterScreenState extends State<CategoryMasterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryListBlocs(),
    child: CategoryMasterScreenWidget(),
    );
  }
}


class CategoryMasterScreenWidget extends StatefulWidget {
  const CategoryMasterScreenWidget({super.key});

  @override
  State<CategoryMasterScreenWidget> createState() => _CategoryMasterScreenWidgetState();
}

class _CategoryMasterScreenWidgetState extends State<CategoryMasterScreenWidget> {


  @override
  void initState() {
    BlocProvider.of<CategoryListBlocs>(context).add(FetchCategoryListEvents());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
        title: "Category Master",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            context: context,
            builder:(context){
              return Wrap(
                children: [
                  CreateEditCategoryMasterBottomSheet(
                    isEdit: false,
                    categoryName: '',
                    categoryId: '',
                    status: '',
                  )
                ],
              );
            },
          ).then(
                (value) {
              if(value == true) {
                BlocProvider.of<CategoryListBlocs>(context).add(
                  FetchCategoryListEvents(),
                );
              }
            },
          );
        },
      ),
      body: BlocBuilder<CategoryListBlocs, CategoryListStates>(
        builder: (context, state) {
          if (state is InitialCategoryListStates) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadingCategoryListStates){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadedCategoryListStates){
            return ListView.builder(
              itemCount: state.list.length,
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
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return  CreateEditCategoryMasterBottomSheet(
                          isEdit: true,
                          categoryName: state.list[index].categoryName,
                          categoryId: state.list[index].categoryId.toString(),
                          status: state.list[index].status.toString(),
                        );
                      },
                    ).then(
                          (value) {
                        if(value == true) {
                          BlocProvider.of<CategoryListBlocs>(context).add(
                            FetchCategoryListEvents(),
                          );
                        }
                      },
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
                                    ? Icons.check_circle_outline
                                    : Icons.pause_circle_filled_outlined,
                                color: statusColor
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.list[index].categoryName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                          color:statusColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
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
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return  CreateEditCategoryMasterBottomSheet(
                                      isEdit: true,
                                      categoryName: state.list[index].categoryName,
                                      categoryId: state.list[index].categoryId.toString(),
                                      status: state.list[index].status.toString(),
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<CategoryListBlocs>(context).add(
                                        FetchCategoryListEvents(),
                                      );
                                    }
                                  },
                                );
                              },
                              value2: (){
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return  DeleteCategoryMasterBottomSheet(
                                      categoryId: state.list[index].categoryId.toString(),
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<CategoryListBlocs>(context).add(
                                        FetchCategoryListEvents(),
                                      );
                                    }
                                  },
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else if(state is FailureCategoryListStates){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}
