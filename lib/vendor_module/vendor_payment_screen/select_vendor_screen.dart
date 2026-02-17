import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/app_color.dart';
import '../../common/common_action_button.dart';
import '../../common/common_app_bar.dart';
import '../vendor_screen/bloc/vendor_list_bloc/vendor_list_bloc.dart';
import '../vendor_screen/bloc/vendor_list_bloc/vendor_list_event.dart';
import '../vendor_screen/bloc/vendor_list_bloc/vendor_list_state.dart';


class SelectVendorScreen extends StatefulWidget {
  const SelectVendorScreen({super.key});

  @override
  State<SelectVendorScreen> createState() => _SelectVendorScreenState();
}

class _SelectVendorScreenState extends State<SelectVendorScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:(context) => VendorListBloc(),
      child: SelectVendorScreenWidget(),
    );
  }
}


class SelectVendorScreenWidget extends StatefulWidget {
  const SelectVendorScreenWidget({super.key});

  @override
  State<SelectVendorScreenWidget> createState() => _SelectVendorScreenWidgetState();
}

class _SelectVendorScreenWidgetState extends State<SelectVendorScreenWidget> {


  String selectedVendorName = "";
  String selectedVendorId = "";


  @override
  void initState() {
    BlocProvider.of<VendorListBloc>(context).add(
        FetchVendorListEvent()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Select Vendor",
      ),
      body: BlocBuilder<VendorListBloc, VendorListState>(
        builder: (context, state) {
          if (state is InitialVendorListState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingVendorListState){
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedVendorListState){
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
                      cursorColor: AppColors.primary,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          hintText: "Search By Product Name..",
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
                      padding: EdgeInsets.only(bottom: 150),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedVendorId == state.list[index].id.toString();
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedVendorId = state.list[index].id.toString();
                              selectedVendorName = state.list[index].vendorName;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 15),
                            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                            decoration: BoxDecoration(
                              color:  isSelected
                                  ? Colors.blue.shade50
                                  : Colors.white,
                              border: Border.all(
                                  color: isSelected
                                      ? AppColors.arrow
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
                                      selectedVendorId = state.list[index].id.toString();
                                      selectedVendorName = state.list[index].vendorName;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    state.list[index].vendorName,
                                    style: TextStyle(
                                        fontSize: 14,
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
                                        fontSize: 10,
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
          else if(state is FailureVendorListState){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: CommonActionButton(
        title: "Save Selection",
        horizontalMargin: 15,
        icon: Icons.save,
        onTap: (){
          Navigator.of(context).pop([selectedVendorId,selectedVendorName,]);
        },
      ),
    );
  }
}
