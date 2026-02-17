import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/bloc/tax_master_list_bloc/tax_master_list_bloc.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/bloc/tax_master_list_bloc/tax_master_list_event.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/bloc/tax_master_list_bloc/tax_master_list_state.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/screens/create_edit_tax_master_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/screens/delete_tax_master_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common_decoration.dart';



class TaxMasterScreen extends StatefulWidget {
  const TaxMasterScreen({super.key});

  @override
  State<TaxMasterScreen> createState() => _TaxMasterScreenState();
}

class _TaxMasterScreenState extends State<TaxMasterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TaxMasterListBlocs(),
      child: TaxMasterScreenWidget(),
    );
  }
}




class TaxMasterScreenWidget extends StatefulWidget {
  const TaxMasterScreenWidget({super.key});

  @override
  State<TaxMasterScreenWidget> createState() => _TaxMasterScreenWidgetState();
}

class _TaxMasterScreenWidgetState extends State<TaxMasterScreenWidget> {

  @override
  void initState() {
    BlocProvider.of<TaxMasterListBlocs>(context).add(
        FetchTaxMasterListEvents(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Tax Master",
        showAdd: true,
        onAddTap: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context){
              return  CreateEditTaxMasterBottomSheet(
                  isEdit: false,
                  taxId: '',
                  taxType: '',
                  taxName: '',
                  taxRate: '',
                  status: ''
              );
            },
          ).then(
                (value) {
              if(value == true) {
                BlocProvider.of<TaxMasterListBlocs>(context).add(
                  FetchTaxMasterListEvents(),
                );
              }
            },
          );
        }
      ),
      body:  BlocBuilder<TaxMasterListBlocs, TaxMasterListStates>(
        builder: (context, state) {
          if (state is InitialTaxMasterListStates) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadingTaxMasterListStates){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadedTaxMasterListStates){
            return ListView.builder(
              itemCount: state.list.length  ,
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
                      builder: (context){
                        return  CreateEditTaxMasterBottomSheet(
                            isEdit: true,
                            taxId: state.list[index].taxId.toString(),
                            taxType: state.list[index].taxType,
                            taxName: state.list[index].taxName,
                            taxRate: state.list[index].taxRate,
                            status: state.list[index].status
                        );
                      },
                    ).then(
                          (value) {
                        if(value == true) {
                          BlocProvider.of<TaxMasterListBlocs>(context).add(
                            FetchTaxMasterListEvents(),
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
                            margin:  EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: state.list[index].status == "1"
                                  ? Colors.blue.shade50
                                  : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:  EdgeInsets.all(10),
                            child:  Icon(
                              state.list[index].status == "1"
                                  ? Icons.assignment_outlined   // Active icon
                                  : Icons.pause_circle_outline,
                              color: state.list[index].status == "1"
                                  ? AppColors.primary
                                  : Colors.red,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.list[index].taxName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding:  EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    border: Border.all(
                                      color:Colors.orange.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.percent,
                                        size: 14,
                                        color:Colors.orange,
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        "Rate: ${state.list[index].taxRate}",
                                        style: TextStyle(
                                          color:Colors.orange,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.percent,
                                        size: 14,
                                        color:Colors.orange,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6,),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.blue.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.category_outlined,
                                        size: 14,
                                        color: AppColors.primary,
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          "Type: ${ state.list[index].taxType}",
                                          style:  TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color:statusColor.withValues(alpha: 0.1),
                                    border: Border.all(
                                      color: statusColor
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
                                  builder: (context){
                                    return  CreateEditTaxMasterBottomSheet(
                                        isEdit: true,
                                        taxId: state.list[index].taxId.toString(),
                                        taxType: state.list[index].taxType,
                                        taxName: state.list[index].taxName,
                                        taxRate: state.list[index].taxRate,
                                        status: state.list[index].status
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<TaxMasterListBlocs>(context).add(
                                        FetchTaxMasterListEvents(),
                                      );
                                    }
                                  },
                                );
                              },
                              value2: (){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return  DeleteTaxMasterBottomSheet(
                                      taxId: state.list[index].taxId.toString(),
                                    );
                                  },
                                ).then(
                                      (value) {
                                    if(value == true) {
                                      BlocProvider.of<TaxMasterListBlocs>(context).add(
                                        FetchTaxMasterListEvents(),
                                      );
                                    }
                                  },
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
          else if(state is FailureTaxMasterListStates){
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
