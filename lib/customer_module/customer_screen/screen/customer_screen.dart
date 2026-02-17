import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_home_app_bar.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/customer_module/customer_screen/bloc/customer_list_bloc/customer_list_bloc.dart';
import 'package:erp_demo/customer_module/customer_screen/bloc/customer_list_bloc/customer_list_event.dart';
import 'package:erp_demo/customer_module/customer_screen/screen/delete_customer_bottom_sheet.dart';
import 'package:erp_demo/customer_module/customer_screen/screen/create_update_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../common/common_decoration.dart';
import '../bloc/customer_list_bloc/customer_list_state.dart';
import 'customer_details_screen.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:(context) => CustomerListBloc(),
      child: CustomerScreenWidget(),
    );
  }
}


class CustomerScreenWidget extends StatefulWidget {
  const CustomerScreenWidget({super.key});

  @override
  State<CustomerScreenWidget> createState() => _CustomerScreenWidgetState();
}

class _CustomerScreenWidgetState extends State<CustomerScreenWidget> {

  @override
  void initState() {
    BlocProvider.of<CustomerListBloc>(context).add(
        FetchCustomerListEvent()
    );
    super.initState();
  }

  final Set<int> selectedCustomerIds = {};
  bool isSelectionMode = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonHomeAppBar(),
      body: BlocBuilder<CustomerListBloc, CustomerListState>(
        builder: (context, state) {
          if (state is InitialCustomerListState) {
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingCustomerListState){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedCustomerListState){
            return Stack(
              children: [
                ListView.builder(
                    padding: EdgeInsets.only(top: 220),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.list.length,
                    itemBuilder: (context,index){
                      final customer = state.list[index];
                      final isSelected =
                      selectedCustomerIds.contains(customer.id);

                      return  InkWell(
                        onTap: () {
                          if (isSelectionMode) {
                            setState(() {
                              if (isSelected) {
                                selectedCustomerIds.remove(customer.id);
                                if (selectedCustomerIds.isEmpty) {
                                  isSelectionMode = false;
                                }
                              } else {
                                selectedCustomerIds.add(customer.id);
                              }
                            });
                          } else {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerDetailsScreen(
                                        customerId: state.list[index].id.toString(),
                                      customerName: state.list[index].customerName,
                                      mobileNo: state.list[index].mobileNo,
                                      whatsAppNo: state.list[index].whatsappNo,
                                      email: state.list[index].email,
                                      gstNo: state.list[index].gstNo,
                                      customerLevel: state.list[index].customerLevelId.toString(),
                                      address: state.list[index].address,
                                      productId: state.list[index].productId.toString(),
                                      productName: state.list[index].products.first.name,
                                      customerLevelName: state.list[index].customerLevelName,
                                    )
                                )
                            ).then(
                                    (value){
                                  if(value == true){
                                    BlocProvider.of<CustomerListBloc>(context).add(
                                        FetchCustomerListEvent()
                                    );
                                  }
                                }
                            );
                          }
                        },

                        child:  Container(
                          margin: EdgeInsets.fromLTRB(15,15,15,0),
                          padding: EdgeInsets.all(10),
                          decoration:  BoxDecoration(
                            color: isSelected ? Colors.blue.shade50 : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              width: 0.5
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:  Colors.grey.shade200,
                                blurRadius: 4,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primary,
                                          AppColors.primary.withValues(alpha: 0.8),
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      state.list[index].customerName[0].toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                         state.list[index].customerName,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          state.list[index].email,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (selectedCustomerIds.isEmpty)
                                  CommonPopMenuButton(
                                    textValue1: "Select",
                                    textValue2: "Delete",
                                    textValue3: "Get Direction",
                                    icon1: Icons.check_circle_outline,
                                    icon2: Icons.delete_outline,
                                    icon3: Icons.directions,
                                    containerColor2: Colors.red.shade50,
                                    iconColor2: Colors.red,
                                    textColor2: Colors.red,
                                    textColor3: AppColors.primary,
                                    value1: (){
                                      setState(() {
                                        isSelectionMode = true;
                                        selectedCustomerIds.add(customer.id);
                                      });
                                    },
                                    value2: (){
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context){
                                            return DeleteCustomerBottomSheet(
                                                customerId: state.list[index].id.toString()
                                            );
                                          }
                                      ).then(
                                              (value){
                                            if(value == true){
                                              BlocProvider.of<CustomerListBloc>(context).add(
                                                  FetchCustomerListEvent()
                                              );
                                            }
                                          }
                                      );
                                    },
                                    value3: (){

                                    },
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 15),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius:BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: AppColors.primary,
                                        size: 18,
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Text(
                                          state.list[index].mobileNo,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      if (state.list[index].customerLevelName.isNotEmpty)
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Colors.blue.shade100),
                                        ),
                                        child: Text(
                                          state.list[index].customerLevelName,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.screenBg
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15,15,15,0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Customer",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: AppColors.primary
                                        ),
                                      ),
                                      Text(
                                        "Manage Your Customer",
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                if(selectedCustomerIds.isNotEmpty)...[
                                  _actionButton(
                                    label: "Delete",
                                    color: Colors.red,
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context){
                                            return DeleteCustomerBottomSheet(
                                                customerId: selectedCustomerIds.first.toString()
                                            );
                                          }
                                      ).then(
                                              (value){
                                            if(value == true){
                                              BlocProvider.of<CustomerListBloc>(context).add(
                                                  FetchCustomerListEvent()
                                              );
                                            }
                                          }
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  _actionButton(
                                    label: "Cancel",
                                    color: AppColors.primary,
                                    onTap: () {
                                      setState(() {
                                        selectedCustomerIds.clear();
                                      });
                                    },
                                  ),

                                ] else ...[
                                  InkWell(
                                    onTap: (){},
                                    child: Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.tune_outlined,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context)=> CreateUpdateCustomerScreen(
                                                isEdit: false,
                                                customerId: '',
                                                customerName: '',
                                                mobileNo: '',
                                                whatsAppNo: '',
                                                email: '',
                                                gstNo: '',
                                                customerLevel: '',
                                                address: '',
                                                productId: '',
                                                productName: '',
                                                customerLevelName: '',
                                              ),
                                          ),
                                      ).then(
                                              (value){
                                            if(value == true){
                                              BlocProvider.of<CustomerListBloc>(context).add(
                                                  FetchCustomerListEvent()
                                              );
                                            }
                                          }
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ]

                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                            decoration: CommonDecorations.card(),
                            child: TextFormField(
                              style: TextStyle(
                                  fontWeight: FontWeight.w500
                              ),
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                                  hintText: "Enter Search Mobile Number",
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
                          Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue.shade100)
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration:BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    Icons.group_outlined,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Customer",
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12
                                      )
                                    ),
                                    Text(
                                      state.list.length.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            );
          }
          else if(state is FailureCustomerListState){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }


}
