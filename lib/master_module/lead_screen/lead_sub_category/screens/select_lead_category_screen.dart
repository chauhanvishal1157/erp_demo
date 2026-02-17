import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/lead_category_list_bloc/lead_category_list_bloc.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/lead_category_list_bloc/lead_category_list_event.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/bloc/lead_category_list_bloc/lead_category_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/lead_category/screens/create_edit_lead_category_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SelectLeadCategoryScreen extends StatefulWidget {
  const SelectLeadCategoryScreen({super.key});

  @override
  State<SelectLeadCategoryScreen> createState() => _SelectLeadCategoryScreenState();
}

class _SelectLeadCategoryScreenState extends State<SelectLeadCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeadCategoryListBlocs(),
      child: SelectLeadCategoryScreenWidget(),
    );
  }
}

class SelectLeadCategoryScreenWidget extends StatefulWidget {
  const SelectLeadCategoryScreenWidget({super.key});

  @override
  State<SelectLeadCategoryScreenWidget> createState() => _SelectLeadCategoryScreenWidgetState();
}

class _SelectLeadCategoryScreenWidgetState extends State<SelectLeadCategoryScreenWidget> {

  String selectedLeadCategoryName = "";
  String selectedLeadCategoryId = "";

  @override
  void initState() {
    BlocProvider.of<LeadCategoryListBlocs>(context).add(
        FetchLeadCategoryListEvents()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Lead Category",
          showAdd: true,
          onAddTap: (){
            showModalBottomSheet(
              isScrollControlled:true,
              context: context,
              builder:(context){
                return Wrap(
                  children: [
                    CreateEditLeadCategoryBottomSheet(
                        isEdit: false,
                        leadCategoryId: '',
                        leadCategoryName: '',
                        status: ''
                    )
                  ],
                );
              },
            ).then(
                    (value){
                  if(value == true){
                    BlocProvider.of<LeadCategoryListBlocs>(context).add(
                        FetchLeadCategoryListEvents()
                    );
                  }
                }
            );
          }
      ),
      body: BlocBuilder<LeadCategoryListBlocs, LeadCategoryListStates>(
        builder: (context, state) {
          if (state is InitialLeadCategoryListStates) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingLeadCategoryListStates){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedLeadCategoryListStates){
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          padding: EdgeInsets.only(bottom: 80),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            bool isSelected = selectedLeadCategoryId == state.list[index].leadCategoryId.toString();
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedLeadCategoryId = state.list[index].leadCategoryId.toString();
                                  selectedLeadCategoryName = state.list[index].leadCategoryName;
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
                                    Transform.scale(
                                      scale: 1.2,
                                      child: Checkbox(
                                        shape: CircleBorder(),
                                        side: BorderSide(color: Colors.grey),
                                        activeColor: AppColors.primary,
                                        value: isSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedLeadCategoryId = state.list[index].leadCategoryId.toString();
                                            selectedLeadCategoryName = state.list[index].leadCategoryName;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.list[index].leadCategoryName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical:2,horizontal: 6),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
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
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF6FAFF)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop([selectedLeadCategoryId,selectedLeadCategoryName,]);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColors.action,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Save Selection",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          else if(state is FailureLeadCategoryListStates){
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
