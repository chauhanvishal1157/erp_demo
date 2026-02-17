import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/vendor_level_list_bloc/vendor_level_list_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/vendor_level_list_bloc/vendor_level_list_event.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/vendor_level_list_bloc/vendor_level_list_state.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/screens/create_edit_vendor_level_bottom_sheet.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/screens/delete_vendor_level_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;
import '../../../../common/app_color.dart';
import '../../../../common/common_decoration.dart';

class VendorLevelScreen extends StatefulWidget {
  const VendorLevelScreen({super.key});

  @override
  State<VendorLevelScreen> createState() => _VendorLevelScreenState();
}

class _VendorLevelScreenState extends State<VendorLevelScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorLevelListBloc(),
      child: VendorLevel(),
    );
  }
}


class VendorLevel extends StatefulWidget {
  const VendorLevel({super.key});

  @override
  State<VendorLevel> createState() => _VendorLevelState();
}

class _VendorLevelState extends State<VendorLevel> {

  @override
  void initState() {
    BlocProvider.of<VendorLevelListBloc>(context).add(
      FetchVendorLevelListEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Vendor Level",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
              isScrollControlled:true,
              context: context,
              builder:(context)=>CreateEditVendorLevelBottomSheet(
                isEdit: false,
                vendorLevelName: '',
                vendorLevelId: '',
              )
          ).then(
                (value) {
              if(value == true) {
                BlocProvider.of<VendorLevelListBloc>(context).add(
                  FetchVendorLevelListEvent(),
                );
              }
            },
          );
        }
      ),
      body: BlocBuilder<VendorLevelListBloc,VendorLevelListStates>(
          builder: (context,state){
        if (state is InitialVendorLevelListStates) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadingVendorLevelListStates){
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadedVendorLevelListStates){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              return  GestureDetector(
                onTap: ()  {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => CreateEditVendorLevelBottomSheet(
                      isEdit: true,
                      vendorLevelName: state.list[index].vendorLevelName,
                      vendorLevelId: state.list[index].vendorLevelId.toString(),
                    )
                  ).then(
                        (value) {
                      if(value == true) {
                        BlocProvider.of<VendorLevelListBloc>(context).add(
                          FetchVendorLevelListEvent(),
                        );
                      }
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                  padding: EdgeInsets.all(15),
                  decoration: CommonDecorations.card(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.business_sharp,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          state.list[index].vendorLevelName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      CommonPopMenuButton(
                          value1: (){
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => CreateEditVendorLevelBottomSheet(
                                  isEdit: true,
                                  vendorLevelName: state.list[index].vendorLevelName,
                                  vendorLevelId: state.list[index].vendorLevelId.toString(),
                                )
                            ).then(
                                  (value) {
                                if(value == true) {
                                  BlocProvider.of<VendorLevelListBloc>(context).add(
                                    FetchVendorLevelListEvent(),
                                  );
                                }
                              },
                            );
                          },
                          value2: (){
                            showModalBottomSheet(
                              context: context,
                              builder: (context){
                                return DeleteVendorLevelBottomSheet(
                                  vendorLevelId: state.list[index].vendorLevelId.toString(),
                                );
                              },
                            ).then(
                                  (value) {
                                if(value == true) {
                                  BlocProvider.of<VendorLevelListBloc>(context).add(
                                    FetchVendorLevelListEvent(),
                                  );
                                }
                              },
                            );
                          }
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
        else if(state is FailureVendorLevelListStates){
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      })
    );
  }
}
