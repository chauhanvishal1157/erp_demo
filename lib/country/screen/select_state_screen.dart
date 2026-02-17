import 'package:erp_demo/country/bloc/state_list_bloc/state_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/app_color.dart';
import '../../common/common_action_button.dart';
import '../../common/common_app_bar.dart';
import '../bloc/state_list_bloc/state_list_bloc.dart';
import '../bloc/state_list_bloc/state_list_state.dart';

class SelectStateScreen extends StatefulWidget {
  final String countryId;

  const SelectStateScreen({
    required this.countryId,
    super.key});

  @override
  State<SelectStateScreen> createState() => _SelectStateScreenState();
}

class _SelectStateScreenState extends State<SelectStateScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => StateListBloc(),
      child: SelectStateScreenWidget(countryId: widget.countryId,),
    );
  }
}


class SelectStateScreenWidget extends StatefulWidget {
  final String countryId;

  const SelectStateScreenWidget({
    required this.countryId,
    super.key});

  @override
  State<SelectStateScreenWidget> createState() => _SelectStateScreenWidgetState();
}

class _SelectStateScreenWidgetState extends State<SelectStateScreenWidget> {

  @override
  void initState() {
    BlocProvider.of<StateListBloc>(context).add(
        FetchStateListEvent(
            countryId: widget.countryId,
        )
    );
    super.initState();
  }

  String selectedStateId = "";
  String selectedStateName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
        title: "Select State",
      ),
      body:  BlocBuilder<StateListBloc, StateListState>(
        builder: (context, state) {
          if (state is InitialStateListState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingStateListState){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedStateListState){

            if(state.list.isEmpty){
              return Container();
            }

            return  SingleChildScrollView(
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
                          hintText: "Search State Name..",
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
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.list.length,
                      itemBuilder: (context,index){

                        bool isSelected = selectedStateName.contains(state.list[index].name);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedStateId = state.list[index].id.toString();
                              selectedStateName = state.list[index].name;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                            decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue[50]
                                    : Colors.white,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blue.shade200
                                      : Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  )
                                ]
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        shape: CircleBorder(),
                                        side: BorderSide(
                                          color: Colors.grey,
                                        ),
                                        activeColor: AppColors.primary,
                                        value: isSelected,
                                        onChanged: (bool? value){
                                          setState(() {
                                            selectedStateId = state.list[index].id.toString();
                                            selectedStateName = state.list[index].name;
                                          }
                                          );
                                        }
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.list[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "Selected",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
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
          else if(state is FailureStateListState){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.transparent
        ),
        child:  CommonActionButton(
            icon: Icons.arrow_forward,
            horizontalMargin: 15,
            title: "Next",
            onTap: (){
              Navigator.of(context).pop([selectedStateId,selectedStateName,]);
            }
        ),
      ),
    );
  }
}
