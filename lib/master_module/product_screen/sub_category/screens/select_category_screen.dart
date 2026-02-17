import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/product_screen/category/screens/create_edit_category_master_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../common/common_action_button.dart';
import '../../category/bloc/category_master_bloc/category_list_bloc.dart';
import '../../category/bloc/category_master_bloc/category_list_event.dart';
import '../../category/bloc/category_master_bloc/category_list_state.dart';


class SelectCategoryScreen extends StatefulWidget {

  const SelectCategoryScreen({super.key});

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryListBlocs(),
      child: SelectCategoryWidget(),
    );
  }
}


class SelectCategoryWidget extends StatefulWidget {

  const SelectCategoryWidget({super.key});

  @override
  State<SelectCategoryWidget> createState() => _SelectCategoryWidgetState();
}

class _SelectCategoryWidgetState extends State<SelectCategoryWidget> {

  String selectedCategoryName = "";
  String selectedCategoryId = "";

  @override
  void initState() {
    BlocProvider.of<CategoryListBlocs>(context).add(
        FetchCategoryListEvents()
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Select Category",
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
                        status: ''
                    )
                  ],
                );
              },
            ).then(
                    (value){
                  if(value == true){
                    BlocProvider.of<CategoryListBlocs>(context).add(
                        FetchCategoryListEvents()
                    );
                  }
                }
            );
          }
      ),
      body: BlocBuilder<CategoryListBlocs, CategoryListStates>(
        builder: (context, state) {
          if (state is InitialCategoryListStates) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingCategoryListStates){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedCategoryListStates){
            return SingleChildScrollView(
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
                          hintText: "Enter category Name..",
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
                        bool isSelected = selectedCategoryName == state.list[index].categoryName;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryId = state.list[index].categoryId.toString();
                              selectedCategoryName = state.list[index].categoryName;
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
                                      selectedCategoryId = state.list[index].categoryId.toString();
                                      selectedCategoryName = state.list[index].categoryName;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    state.list[index].categoryName,
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
          else if(state is FailureCategoryListStates){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: CommonActionButton(
          title: "Save Selection",
          icon: Icons.save,
          horizontalMargin: 15,
          onTap: (){
            Navigator.of(context).pop([selectedCategoryId,selectedCategoryName,]);
          }
      ),
    );
  }
}
