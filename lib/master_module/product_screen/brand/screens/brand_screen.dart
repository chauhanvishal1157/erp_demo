import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/brand_list_bloc/brand_list_bloc.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/brand_list_bloc/brand_list_event.dart';
import 'package:erp_demo/master_module/product_screen/brand/bloc/brand_list_bloc/brand_list_state.dart';
import 'package:erp_demo/master_module/product_screen/brand/screens/create_edit_brand_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/brand/screens/delete_brand_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common_decoration.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BrandListBlocs(),
        child: BrandScreenWidget()
    );
  }
}


class BrandScreenWidget extends StatefulWidget {
  const BrandScreenWidget({super.key});

  @override
  State<BrandScreenWidget> createState() => _BrandScreenWidgetState();
}

class _BrandScreenWidgetState extends State<BrandScreenWidget> {

  @override
  void initState() {
    BlocProvider.of<BrandListBlocs>(context).add(
        FetchBrandListEvents()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.screenBg,
      appBar: CommonAppBar(
        title: "Brands Master",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            isScrollControlled:true,
            backgroundColor: Colors.transparent,
            context: context,
            builder:(context){
              return CreateEditBrandBottomSheet(
                isEdit: false,
                brandName: '',
                brandId: '',
                status: '',
              );
            },
          ).then(
                  (value){
                BlocProvider.of<BrandListBlocs>(context).add(
                    FetchBrandListEvents()
                );
              }
          );
        },
      ),
      body: BlocBuilder<BrandListBlocs, BrandListStates>(
        builder: (context, state) {
          if (state is InitialBrandListStates) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadingBrandListStates){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadedBrandListStates){
            return  ListView.builder(
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
                      builder: (context){
                        return  CreateEditBrandBottomSheet(
                          isEdit: true,
                          brandName: state.list[index].brandName,
                          brandId: state.list[index].brandId.toString(),
                          status: state.list[index].status.toString(),
                        );
                      },
                    ).then(
                            (value){
                          BlocProvider.of<BrandListBlocs>(context).add(
                              FetchBrandListEvents()
                          );
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
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:statusColor.withValues(alpha: 0.1),
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
                            ],
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.list[index].brandName,
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
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          CommonPopMenuButton(
                              value1: (){
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context){
                                    return  CreateEditBrandBottomSheet(
                                      isEdit: true,
                                      brandName: state.list[index].brandName,
                                      brandId: state.list[index].brandId.toString(),
                                      status: state.list[index].status.toString(),
                                    );
                                  },
                                ).then(
                                        (value){
                                      BlocProvider.of<BrandListBlocs>(context).add(
                                          FetchBrandListEvents()
                                      );
                                    }
                                );
                              },
                              value2: (){
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context){
                                    return  DeleteBrandBottomSheet(
                                      brandId: state.list[index].brandId.toString(),
                                    );
                                  },
                                ).then(
                                        (value){
                                      BlocProvider.of<BrandListBlocs>(context).add(
                                          FetchBrandListEvents()
                                      );
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
          else if(state is FailureBrandListStates){
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
