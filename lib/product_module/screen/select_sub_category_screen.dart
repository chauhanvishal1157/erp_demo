import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/sub_category_list_bloc/sub_category_list_bloc.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/sub_category_list_bloc/sub_category_list_event.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/bloc/sub_category_list_bloc/sub_category_list_state.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/screens/create_edit_sub_category_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../common/app_color.dart';
import '../../common/common_app_bar.dart';

class SelectSubCategoryScreen extends StatefulWidget {
  const SelectSubCategoryScreen({super.key});

  @override
  State<SelectSubCategoryScreen> createState() => _SelectSubCategoryScreenState();
}

class _SelectSubCategoryScreenState extends State<SelectSubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubCategoryListBloc(),
      child: SelectSubCategoryScreenWidget(),
    );
  }
}


class SelectSubCategoryScreenWidget extends StatefulWidget {
  const SelectSubCategoryScreenWidget({super.key});

  @override
  State<SelectSubCategoryScreenWidget> createState() => _SelectSubCategoryScreenWidgetState();
}

class _SelectSubCategoryScreenWidgetState extends State<SelectSubCategoryScreenWidget> {

  String selectedSubCategoryName = "";
  String selectedSubCategoryId = "";

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
          title: "Select Sub-Category",
          showAdd: true,
          onAddTap: (){
            showModalBottomSheet(
              isScrollControlled:true,
              context: context,
              builder:(context){
                return  CreateEditSubCategoryBottomSheet(
                    isEdit: false,
                    subCategoryName: '',
                    subCategoryId: '',
                    categoryName: '',
                    categoryId: '',
                    status: ''
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
          }
      ),
      body: BlocBuilder<SubCategoryListBloc,SubCategoryListStates>(
          builder: (context,state){
            if (state is InitialSubCategoryListStates) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            else if(state is LoadingSubCategoryListStates){
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            else if(state is LoadedSubCategoryListStates){
              return   SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            hintText: "Enter sub category Name..",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black26,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              size: 20,
                              color: Colors.grey,
                            ),
                            suffixIcon: Icon(
                              Icons.mic_none,
                              size: 20,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    ListView.builder(
                        padding: EdgeInsets.only(bottom: 80),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.list.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedSubCategoryName == state.list[index].subCategoryName;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSubCategoryId = state.list[index].subCategoryId.toString();
                                selectedSubCategoryName = state.list[index].subCategoryName;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 15),
                              margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                              decoration: BoxDecoration(
                                color:  isSelected
                                    ? Colors.blue[50]
                                    : Colors.white,
                                border: Border.all(
                                    color: isSelected
                                        ? Colors.blue.shade200
                                        : Colors.white,
                                    width: 1.2
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                    shape: CircleBorder(),
                                    side: BorderSide(color: Colors.grey),
                                    activeColor: AppColors.primary,
                                    value: isSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSubCategoryId = state.list[index].subCategoryId.toString();
                                        selectedSubCategoryName = state.list[index].subCategoryName;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.list[index].subCategoryName,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical:2,horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.action,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Selected",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ],
                ),
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
      bottomNavigationBar: CommonActionButton(
          title: "Save Selection",
          icon: Icons.save,
          horizontalMargin: 15,
          onTap: (){
            Navigator.of(context).pop([selectedSubCategoryId,selectedSubCategoryName,]);
          }
      ),
    );
  }
}
