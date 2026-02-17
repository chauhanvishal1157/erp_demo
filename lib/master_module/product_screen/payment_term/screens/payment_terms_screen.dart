import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/payment_terms_list_bloc/payment_term_list_bloc.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/payment_terms_list_bloc/payment_term_list_event.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/bloc/payment_terms_list_bloc/payment_term_list_state.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/screens/create_edit_payment_terms_bottom_sheet.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/screens/delete_payment_terms_bottom_sheet.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common_decoration.dart';

class PaymentTermsScreen extends StatefulWidget {
  const PaymentTermsScreen({super.key});

  @override
  State<PaymentTermsScreen> createState() => _PaymentTermsScreenState();
}

class _PaymentTermsScreenState extends State<PaymentTermsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PaymentTermListBlocs(),
      child: PaymentTermsScreenWidget(),
    );
  }
}


class PaymentTermsScreenWidget extends StatefulWidget {
  const PaymentTermsScreenWidget({super.key});

  @override
  State<PaymentTermsScreenWidget> createState() => _PaymentTermsScreenWidgetState();
}

class _PaymentTermsScreenWidgetState extends State<PaymentTermsScreenWidget> {


  @override
  void initState() {
    BlocProvider.of<PaymentTermListBlocs>(context).add(FetchPaymentTermListEvents());
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Payment Terms",
          showAdd: true,
          onAddTap: (){
            showModalBottomSheet(
              isScrollControlled:true,
              backgroundColor: Colors.transparent,
              context: context,
              builder:(context){
                return  CreateEditPaymentTermsBottomSheet(
                    isEdit: false,
                    paymentTermsName: '',
                    paymentTermsId: '',
                    status: ''
                );
              },
            ).then(
                    (value){
                  if(value == true){
                    BlocProvider.of<PaymentTermListBlocs>(context).add(
                        FetchPaymentTermListEvents()
                    );
                  }
                }
            );
          }
      ),
      body:  BlocBuilder<PaymentTermListBlocs, PaymentTermListStates>(
        builder: (context, state) {
          if (state is InitialPaymentTermListStates) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadingPaymentTermListStates){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadedPaymentTermListStates){
            return  ListView.builder(
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
                        return  CreateEditPaymentTermsBottomSheet(
                            isEdit: true,
                            paymentTermsName: state.list[index].paymentTermsName,
                            paymentTermsId: state.list[index].paymentTermsId.toString(),
                            status: state.list[index].status
                        );
                      },
                    ).then(
                            (value){
                          if(value == true){
                            BlocProvider.of<PaymentTermListBlocs>(context).add(
                                FetchPaymentTermListEvents()
                            );
                          }
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
                                 state.list[index].paymentTermsName,
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
                                  builder: (context){
                                    return  CreateEditPaymentTermsBottomSheet(
                                        isEdit: true,
                                        paymentTermsName: state.list[index].paymentTermsName,
                                        paymentTermsId: state.list[index].paymentTermsId.toString(),
                                        status: state.list[index].status
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true){
                                        BlocProvider.of<PaymentTermListBlocs>(context).add(
                                            FetchPaymentTermListEvents()
                                        );
                                      }
                                    }
                                );
                              },
                              value2: (){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context){
                                    return  DeletePaymentTermsBottomSheet(
                                      paymentTermsId: state.list[index].paymentTermsId.toString(),
                                    );
                                  },
                                ).then(
                                        (value){
                                      if(value == true){
                                        BlocProvider.of<PaymentTermListBlocs>(context).add(
                                            FetchPaymentTermListEvents()
                                        );
                                      }
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
          else if(state is FailurePaymentTermListStates){
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

