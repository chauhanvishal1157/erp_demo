import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_bloc.dart';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_event.dart';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_state.dart';
import 'package:erp_demo/master_module/product_screen/product_type/screens/create_edit_product_type_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/product_type/screens/delete_product_type_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_color.dart';
import '../../../../common/common_decoration.dart';


class ProductTypeScreen extends StatefulWidget {
  const ProductTypeScreen({super.key});

  @override
  State<ProductTypeScreen> createState() => _ProductTypeScreenState();
}

class _ProductTypeScreenState extends State<ProductTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductTypeListBlocs(),
      child: ProductTypeScreenWidget(),
    );
  }
}

class ProductTypeScreenWidget extends StatefulWidget {
  const ProductTypeScreenWidget({super.key});

  @override
  State<ProductTypeScreenWidget> createState() => _ProductTypeScreenWidgetState();
}

class _ProductTypeScreenWidgetState extends State<ProductTypeScreenWidget> {


  @override
  void initState() {
    BlocProvider.of<ProductTypeListBlocs>(context).add(
        FetchProductTypeListEvents()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Product Type",
          showAdd: true,
          onAddTap: (){
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return  CreateEditProductTypeBottomSheet(
                    isEdit: false,
                    productName: '',
                    status: '',
                    productId: ''
                );
              },
            ).then(
                  (value) {
                if(value == true) {
                  BlocProvider.of<ProductTypeListBlocs>(context).add(
                    FetchProductTypeListEvents(),
                  );
                }
              },
            );
          }
      ),
      body:  BlocBuilder<ProductTypeListBlocs, ProductTypeListStates>(
        builder: (context, state) {
          if (state is InitialProductTypeListStates) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadingProductTypeListStates){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadedProductTypeListStates){
            return ListView.builder(
              itemCount: state.list.length,
              padding:  EdgeInsets.all(15),
              itemBuilder: (context, index) {

                String statusLabel = state.list[index].status == "1"
                    ? "Active"
                    : "Inactive";

                Color statusColor = (state.list[index].status) == "1"
                    ? Colors.green
                    : Colors.red;

                return GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return CreateEditProductTypeBottomSheet(
                          isEdit: true,
                          productName: state.list[index].productName,
                          status: state.list[index].status,
                          productId: state.list[index].productId.toString(),
                        );
                      },
                    ).then(
                          (value) {
                        if(value == true) {
                          BlocProvider.of<ProductTypeListBlocs>(context).add(
                            FetchProductTypeListEvents(),
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
                              color:statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:  EdgeInsets.all(10),
                            child:  Icon(
                                state.list[index].status == "1"
                                    ? Icons.check_circle_outline   // Active icon
                                    : Icons.pause_circle_outline,
                                color: statusColor
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.list[index].productName,
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
                          CommonPopMenuButton(
                              value1: (){
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return CreateEditProductTypeBottomSheet(
                                      isEdit: true,
                                      productName: state.list[index].productName,
                                      status: state.list[index].status,
                                      productId: state.list[index].productId.toString(),
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<ProductTypeListBlocs>(context).add(
                                        FetchProductTypeListEvents(),
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
                                    return DeleteProductTypeBottomSheet(
                                      productId: state.list[index].productId.toString(),
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<ProductTypeListBlocs>(context).add(
                                        FetchProductTypeListEvents(),
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
          else if(state is FailureProductTypeListStates){
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
