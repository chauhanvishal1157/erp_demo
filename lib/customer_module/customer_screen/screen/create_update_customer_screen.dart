import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_toast.dart';
import 'package:erp_demo/customer_module/customer_screen/bloc/create_edit_delete_customer_bloc/create_edit_delete_customer_bloc.dart';
import 'package:erp_demo/customer_module/customer_screen/bloc/create_edit_delete_customer_bloc/create_edit_delete_customer_event.dart';
import 'package:erp_demo/customer_module/customer_screen/bloc/create_edit_delete_customer_bloc/create_edit_delete_customer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../common/common_decoration.dart';
import '../../../common/common_drop_down.dart';
import '../../../common/common_field.dart';
import '../../../master_module/admin_screen/customer_level/bloc/customer_level_bloc/customer_level_list_bloc.dart';
import '../../../master_module/admin_screen/customer_level/bloc/customer_level_bloc/customer_level_list_event.dart';
import '../../../master_module/admin_screen/customer_level/bloc/customer_level_bloc/customer_level_list_state.dart';
import '../../../product_module/screen/select_product_screen.dart';



class CreateUpdateCustomerScreen extends StatefulWidget {
  final bool isEdit;
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


  const CreateUpdateCustomerScreen({
    required this.isEdit,
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
  State<CreateUpdateCustomerScreen> createState() => _CreateUpdateCustomerScreenState();
}

class _CreateUpdateCustomerScreenState extends State<CreateUpdateCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CreateEditDeleteCustomerBloc()),
        BlocProvider(create: (context) => CustomerLevelListBlocs())
      ],
      child: CreateUpdateCustomerScreenWidget(
        isEdit: widget.isEdit,
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
      ),
    );
  }
}


class CreateUpdateCustomerScreenWidget extends StatefulWidget {
  final bool isEdit;
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
  const CreateUpdateCustomerScreenWidget({
    required this.isEdit,
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
  State<CreateUpdateCustomerScreenWidget> createState() => _CreateUpdateCustomerScreenWidgetState();
}

class _CreateUpdateCustomerScreenWidgetState extends State<CreateUpdateCustomerScreenWidget> {

  bool isChecked = false;
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController customerLevelController = TextEditingController();
  final TextEditingController addressController = TextEditingController();


  @override
  void initState() {
    super.initState();

    BlocProvider.of<CustomerLevelListBlocs>(context).add(
      FetchCustomerLevelListEvent(),
    );

    customerNameController.text = widget.customerName;
    companyController.text = widget.customerName;
    phoneController.text = widget.mobileNo;
    whatsController.text = widget.whatsAppNo;
    emailController.text = widget.email;
    gstController.text = widget.gstNo;
    customerLevelController.text = widget.customerLevel;
    addressController.text = widget.address;
    selectedProductNames = widget.productName.split(",");
    customerLevelValue = widget.customerLevelName;
    customerLevelId = widget.customerLevel;
    phoneController.addListener(() {
      if (isChecked) {
        whatsController.text = phoneController.text;
      }
    });
  }

  String? customerLevelValue;
  String? customerLevelId;
  List<String> selectedProductIds = [];
  List<String> selectedProductNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: widget.isEdit == true
              ? "Update Customer"
              : "New Customer",
      ),
      body: BlocConsumer<CreateEditDeleteCustomerBloc,CreateEditDeleteCustomerState>(
          listener: (context,state) async{
            if (state is LoadedCreateCustomerState) {
              CommonToast.show(context,state.message);
              Navigator.of(context).pop(true);
            }
            else if(state is FailureCreateCustomerState){
              CommonToast.show(context,state.error);

            }
            else if(state is LoadedEditCustomerState){
              CommonToast.show(context,state.message);
              Navigator.of(context).pop(true);
            }
            else if(state is FailureEditCustomerState){
              CommonToast.show(context,state.error);
            }
          },
          builder: (context,state){
            if (state is LoadingCreateCustomerState) {
              return  Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            else if (state is LoadingEditCustomerState) {
              return  Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  CommonTextField(
                    controller: customerNameController,
                    horizontalMargin: 15,
                    label: "Customer Name",
                    hint: "Write Customer Name..",

                  ),
                  CommonTextField(
                    controller: companyController,
                    horizontalMargin: 15,
                    label: "Customer Company Name",
                    hint: "Write Customer Company Name..",
                  ),
                  CommonTextField(
                    controller: phoneController,
                    horizontalMargin: 15,
                    label: "Customer Phone Number",
                    hint: "Write Customer Phone Number..",
                    keyboardType: TextInputType.number,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.messenger_outline_sharp,
                            color: Colors.green,
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "WhatsApp number is same as",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "phone number",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),

                              Text(
                                "Auto-fill WhatsApp number from phone",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: isChecked,
                            activeColor: AppColors.primary,
                            shape: CircleBorder(),
                            side: BorderSide(color: Colors.grey),
                            onChanged: (newBool) {
                              setState(() {
                                isChecked = newBool!;
                                if (isChecked) {
                                  whatsController.text = phoneController.text;
                                } else {
                                  whatsController.clear();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  CommonTextField(
                    controller: whatsController,
                    horizontalMargin: 15,
                    label: "Customer WhatsApp Number",
                    hint: "Write Customer WhatsApp Number..",
                    readOnly: isChecked,
                    keyboardType: TextInputType.number,
                  ),
                  CommonTextField(
                    controller: emailController,
                    horizontalMargin: 15,
                    label: "Customer Email Address ",
                    hint: "Write Customer Email Address..",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CommonTextField(
                    controller: gstController,
                    horizontalMargin: 15,
                    label: "GST Number",
                    hint: "Write GST Number..",
                  ),
                  BlocBuilder<CustomerLevelListBlocs, CustomerLevelListStates>(
                    builder: (context, state) {
                      if (state is InitialCustomerLevelListState) {
                        return  Center(
                          child: SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 40,
                          ),
                        );
                      }
                      else if(state is LoadingCustomerLevelListState){
                        return  Center(
                          child: SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 40,
                          ),
                        );
                      }
                      else if(state is LoadedCustomerLevelListState){
                        final levels = state.list;
                        return  CommonDropdown(
                          label: "Customer Level",
                          hint: "Customer Level name..",
                          value: levels.any((e) => e.customerLevelName == customerLevelValue)
                              ? customerLevelValue
                              : null,
                          horizontalMargin: 15,
                          items: levels
                              .map((e) => e.customerLevelName)
                              .toList(),
                          onChanged: (val) {
                            final selectedLevel =
                            levels.firstWhere((e) => e.customerLevelName == val);
                            setState(() {
                              customerLevelValue = selectedLevel.customerLevelName;
                              customerLevelId = selectedLevel.customerLevelId.toString();
                            });
                          },
                        );
                      }
                      else if(state is FailureCustomerLevelListState){
                        return Center(
                          child: Text(state.error),
                        );
                      }
                      return Container();
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                    decoration: CommonDecorations.card(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.inventory_2_outlined,
                                color: AppColors.primary,
                                size: 18,

                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Select Products",
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                        if (selectedProductNames.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 15),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(
                                selectedProductNames.length,
                                    (index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.blue.shade200,
                                      ),
                                    ),
                                    child: Text(
                                      selectedProductNames[index],
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectProductScreen(
                                      isMultiSelect: true,
                                    )
                                )
                            ).then(
                                  (value) {
                                selectedProductIds = value[0];
                                selectedProductNames = value[1];
                                setState(() {});
                              },
                            );

                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.blue.shade200,
                                )
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "Add Product",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CommonTextField(
                    controller: addressController,
                    maxLines: 3,
                    horizontalMargin: 15,
                    label: "Customer Address ",
                    hint: "Enter customer address..",
                  ),
                  CommonActionButton(

                    title: widget.isEdit == true
                        ? "Update Customer"
                        : "Add Customer",
                    horizontalMargin: 15,
                    icon: widget.isEdit == true
                        ?Icons.update
                        : Icons.data_saver_on_rounded,
                    onTap: (){

                      if (widget.isEdit == true) {
                        BlocProvider.of<CreateEditDeleteCustomerBloc>(context).add(
                           EditCustomerEvent(
                               customerId: widget.customerId,
                               customerName: customerNameController.text,
                               email: emailController.text,
                               mobileNo: phoneController.text,
                               whatsappNo: whatsController.text,
                               gstNo: gstController.text,
                               address: addressController.text,
                               productId: widget.productId
                           )
                        );
                      }
                      else {
                        BlocProvider.of<CreateEditDeleteCustomerBloc>(context).add(
                           CreateCustomerEvent(
                               customerName: customerNameController.text,
                               email: emailController.text,
                               mobileNo: phoneController.text,
                               whatsappNo: whatsController.text,
                               gstNo: gstController.text,
                               address: addressController.text,
                               customerLevelId:  widget.customerLevel,
                               productId: widget.productId
                           )
                        );
                      }
                    },
                  )
                ],
              ),
            );
          }
      )
    );
  }
}
