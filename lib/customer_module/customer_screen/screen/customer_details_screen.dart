import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/customer_module/customer_screen/bloc/customer_details_bloc/customer_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/customer_details_bloc/customer_details_event.dart';
import '../bloc/customer_details_bloc/customer_details_state.dart';
import 'create_update_customer_screen.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final String customerId;
  final String customerName;
  final String mobileNo;
  final String whatsAppNo;
  final String email;
  final String gstNo;
  final String customerLevel;
  final String address;
  final String productId;
  final String productName;
  final String customerLevelName;

  const CustomerDetailsScreen({
    required this.customerId,
    required this.customerName,
    required this.mobileNo,
    required this.whatsAppNo,
    required this.email,
    required this.gstNo,
    required this.customerLevel,
    required this.address,
    required this.productId,
    required this.productName,
    required this.customerLevelName,
    super.key});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) => CustomerDetailsBloc(),
        child: CustomerDetailsScreenWidget(
          customerId: widget.customerId,
          customerName: widget.customerName,
          mobileNo: widget.mobileNo,
          whatsAppNo: widget.whatsAppNo,
          email: widget.email,
          gstNo: widget.gstNo,
          customerLevel: widget.customerLevel,
          address: widget.address,
          productId: widget.productId,
          productName: widget.productName,
          customerLevelName: widget.customerLevelName,
        )
    );
  }
}

class CustomerDetailsScreenWidget extends StatefulWidget {
  final String customerId;
  final String customerName;
  final String mobileNo;
  final String whatsAppNo;
  final String email;
  final String gstNo;
  final String customerLevel;
  final String address;
  final String productId;
  final String productName;
  final String customerLevelName;

  const CustomerDetailsScreenWidget({
    required this.customerId,
    required this.customerName,
    required this.mobileNo,
    required this.whatsAppNo,
    required this.email,
    required this.gstNo,
    required this.customerLevel,
    required this.address,
    required this.productId,
    required this.productName,
    required this.customerLevelName,
    super.key});

  @override
  State<CustomerDetailsScreenWidget> createState() => _CustomerDetailsScreenWidgetState();
}

class _CustomerDetailsScreenWidgetState extends State<CustomerDetailsScreenWidget> {

  @override
  void initState() {
    BlocProvider.of<CustomerDetailsBloc>(context).add(
        FetchCustomerDetailsEvent(
            customerId: widget.customerId
        )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Customer Details",
        showAdd: true,
        addIcon: Icons.edit,
        addIconColor: Colors.black,
        onAddTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUpdateCustomerScreen(
                isEdit: true,
                customerId: widget.customerId,
                customerName: widget.customerName,
                mobileNo: widget.mobileNo,
                whatsAppNo: widget.whatsAppNo,
                email: widget.email,
                gstNo: widget.gstNo,
                customerLevel: widget.customerLevelName,
                address: widget.address,
                productId: widget.productId,
                productName: widget.productName,
                customerLevelName: widget.customerLevelName,
              ),
            ),
          ).then(
                  (value) {
                if (value == true) {
                  BlocProvider.of<CustomerDetailsBloc>(context)
                      .add(
                      FetchCustomerDetailsEvent(
                          customerId: widget.customerId
                      )
                  );
                }
              });
        },
      ),
      body: BlocBuilder<CustomerDetailsBloc, CustomerDetailsState>(
        builder: (context, state) {
          if (state is InitialCustomerDetailsState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingCustomerDetailsState){
            return  Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedCustomerDetailsState){

            final customer = state.list.first;

            return  Column(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade100)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.primary,
                              child: Text(
                                customer.customerName[0],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                              )
                          ),
                          SizedBox(width: 10,),
                          Text(
                            customer.customerName,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _actionButton(
                              AppColors.primary,
                              "Call",
                              Icons.call,
                              Colors.white
                          ),
                          SizedBox(width: 10,),
                          _actionButton(
                              Colors.transparent,
                              "Email",
                              Icons.mail,
                              AppColors.primary

                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 15),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  decoration: CommonDecorations.card(),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.contact_phone_outlined,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Contact Information",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _information(
                          "Phone Number",
                          customer.mobileNo,
                          Icons.phone_outlined
                      ),
                      _information(
                          "WhatsApp Number",
                          customer.whatsappNo,
                          Icons.message_outlined
                      ),
                      _information(
                          "Email Address",
                          customer.email,
                          Icons.mail_outline
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          else if(state is FailureCustomerDetailsState){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),

    );
  }

  Widget _actionButton (
      Color color,
      String label,
      IconData icon,
      Color iconColor

      ){
    return Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
              SizedBox(width: 10,),
              Text(
                label,
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _information (
      String label,
      String value,
      IconData icon,

      ){
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 15),
      child: Row(
        children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 18,
          ),
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w500
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
                decorationThickness: 1.5,
              ),
            ),
          ],
        )
        ],
      ),
    );
  }

}
