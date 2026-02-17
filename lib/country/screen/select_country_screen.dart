import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/country/bloc/country_list_bloc/country_list_bloc.dart';
import 'package:erp_demo/country/bloc/country_list_bloc/country_list_event.dart';
import 'package:erp_demo/country/bloc/country_list_bloc/country_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/app_color.dart';
import '../../common/common_app_bar.dart';


class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
      create:(context) => CountryListBloc(),
      child: SelectCountryScreenWidget(),
    );
  }
}


class SelectCountryScreenWidget extends StatefulWidget {
  const SelectCountryScreenWidget({super.key});

  @override
  State<SelectCountryScreenWidget> createState() => _SelectCountryScreenWidgetState();
}

class _SelectCountryScreenWidgetState extends State<SelectCountryScreenWidget> {



  String selectedCountryId = "";
  String selectedCountryName = "";

  @override
  void initState() {
    BlocProvider.of<CountryListBloc>(context).add(
        FetchCountryListEvent(searchValue: '')
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
        title: "Select Country",
      ),
      body:  BlocBuilder<CountryListBloc, CountryListState>(
        builder: (context, state) {
          if (state is InitialCountryListState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingCountryListState){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedCountryListState){
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
                      onChanged: (value) {
                        BlocProvider.of<CountryListBloc>(context).add(
                          FetchCountryListEvent(searchValue: value),
                        );
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          hintText: "Search Country Name..",
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

                        bool isSelected = selectedCountryName.contains(state.list[index].name);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCountryId = state.list[index].id.toString();
                              selectedCountryName = state.list[index].name;
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
                                            selectedCountryId = state.list[index].id.toString();
                                            selectedCountryName = state.list[index].name;
                                          }
                                          );
                                        }
                                    ),
                                    Text(
                                        state.list[index].emoji,
                                        style: TextStyle(
                                            fontSize: 16
                                        )
                                    ),
                                    SizedBox(width: 10,),
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
          else if(state is FailureCountryListState){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar:  CommonActionButton(
          icon: Icons.arrow_forward,
          horizontalMargin: 15,
          title: "Next",
          onTap: (){
            Navigator.of(context).pop([selectedCountryId,selectedCountryName,]);
          }
      ),
    );
  }
}
