import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/terms_conditions_list_bloc/terms_conditions_list_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/terms_conditions_list_bloc/terms_conditions_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/bloc/terms_conditions_list_bloc/terms_conditions_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/screens/create_edit_terms_condition_bottom_sheet.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/screens/delete_terms_condition_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;

import '../../../../common/app_color.dart';
import '../../../../common/common_decoration.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=> TermsConditionsListBlocs(),
      child: TermsConditions(),
    );
  }
}


class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {



  @override
  void initState() {
    BlocProvider.of<TermsConditionsListBlocs>(context).add(FetchTermsConditionsListEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
        title: "Terms And Conditions",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            context: context,
            builder:(context)=> CreateEditTermsConditionBottomSheet(
              isEdit: false,
              title: '',
              text: '',
              type: '',
              termConditionId: '',
            ),
          ).then(
                (value) {
              if(value == true) {
                BlocProvider.of<TermsConditionsListBlocs>(context).add(
                  FetchTermsConditionsListEvents(),
                );
              }
            },
          );
        },
      ),
      body: BlocBuilder<TermsConditionsListBlocs,TermsConditionsListStates>(
        builder: (context, state) {
          if(state is InitialTermsConditionsListStates) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingTermsConditionsListStates) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedTermsConditionsListStates) {
            return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context , index){

                  Color typeColor;
                  IconData typeIcon;
                  String typeLabel;

                  final typeValue = state.list[index].type.toString();

                  if (typeValue == "1,2" || typeValue == "2,1") {
                    typeColor = Colors.red;
                    typeIcon = Icons.grid_on;
                    typeLabel = "Order,Lead";
                  } else if (typeValue == "1") {
                    typeColor = Colors.blue;
                    typeIcon = Icons.shopping_cart_outlined;
                    typeLabel = "Order";
                  } else if (typeValue == "2") {
                    typeColor = Colors.orange;
                    typeIcon = Icons.person_outline;
                    typeLabel = "Lead";
                  } else {
                    typeColor = Colors.grey;
                    typeIcon = Icons.info_outline;
                    typeLabel = "Unknown";
                  }
                  return GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                        isScrollControlled:true,
                        context: context,
                        builder:(context)=> CreateEditTermsConditionBottomSheet(
                          isEdit: true,
                          title: state.list[index].title,
                          text: state.list[index].text,
                          type: state.list[index].type,
                          termConditionId: state.list[index].termsConditionId.toString(),
                        ),
                      ).then(
                            (value) {
                          if(value == true) {
                            BlocProvider.of<TermsConditionsListBlocs>(context).add(
                              FetchTermsConditionsListEvents(),
                            );
                          }
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      padding: EdgeInsets.all(15),
                      decoration: CommonDecorations.card(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color:typeColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:  EdgeInsets.all(10),
                            child:  Icon(
                              typeIcon,
                              size: 20,
                              color:typeColor,
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.list[index].title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  state.list[index].text,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding:  EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color:typeColor.withValues(alpha: 0.1),
                                    border: Border.all(
                                      color:typeColor.withValues(alpha: 0.3),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.bookmark_border,
                                        size: 18,
                                        color:typeColor,
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        "Type:",
                                        style: TextStyle(
                                          color:typeColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        typeLabel,
                                        style: TextStyle(
                                          color:typeColor,
                                          fontSize: 13,
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
                                  isScrollControlled:true,
                                  context: context,
                                  builder:(context)=> CreateEditTermsConditionBottomSheet(
                                    isEdit: true,
                                    title: state.list[index].title,
                                    text: state.list[index].text,
                                    type: state.list[index].type,
                                    termConditionId: state.list[index].termsConditionId.toString(),
                                  ),
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<TermsConditionsListBlocs>(context).add(
                                        FetchTermsConditionsListEvents(),
                                      );
                                    }
                                  },
                                );
                              },
                              value2: (){
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context){
                                    return  DeleteTermsConditionBottomSheet(
                                      termsConditionId: state.list[index].termsConditionId.toString(),
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<TermsConditionsListBlocs>(context).add(
                                        FetchTermsConditionsListEvents(),
                                      );
                                    }
                                  },
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
          else if(state is FailureTermsConditionsListStates) {
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
