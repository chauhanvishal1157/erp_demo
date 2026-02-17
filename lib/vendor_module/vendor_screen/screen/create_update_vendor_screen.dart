import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_toast.dart';
import 'package:erp_demo/country/screen/select_city_screen.dart';
import 'package:erp_demo/country/screen/select_country_screen.dart';
import 'package:erp_demo/country/screen/select_state_screen.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/vendor_level_list_bloc/vendor_level_list_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/vendor_level/bloc/vendor_level_list_bloc/vendor_level_list_state.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/screens/select_branch_screen.dart';
import 'package:erp_demo/vendor_module/vendor_screen/bloc/create_edit_delete_vendor_bloc/create_edit_delete_vendor_bloc.dart';
import 'package:erp_demo/vendor_module/vendor_screen/bloc/create_edit_delete_vendor_bloc/create_edit_delete_vendor_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../common/common_action_button.dart';
import '../../../common/common_decoration.dart';
import '../../../common/common_drop_down.dart';
import '../../../common/common_field.dart';
import '../../../master_module/admin_screen/vendor_level/bloc/vendor_level_list_bloc/vendor_level_list_event.dart';
import '../../../product_module/screen/select_product_screen.dart';
import '../bloc/create_edit_delete_vendor_bloc/create_edit_delete_vendor_state.dart';


class CreateUpdateVendorScreen extends StatefulWidget {
  final bool isEdit;
  final String vendorId;
  final String vendorName;
  final String vendorEmail;
  final String vendorMobileNo;
  final String address;
  final String vendorLevel;
  final String vendorLevelId;
  final String productId;
  final String productName;
  final String branchId;
  final String branchName;
  final String vendorWhatsAppNo;
  final String gstNo;
  final String countryId;
  final String stateId;
  final String cityId;
  final String countryName;
  final String stateName;
  final String cityName;

  const CreateUpdateVendorScreen({
    required this.isEdit,
    required this.vendorId,
    required this.vendorName,
    required this.vendorEmail,
    required this.vendorMobileNo,
    required this.address,
    required this.vendorLevel,
    required this.vendorLevelId,
    required this.productId,
    required this.productName,
    required this.branchId,
    required this.branchName,
    required this.vendorWhatsAppNo,
    required this.gstNo,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.countryName,
    required this.stateName,
    required this.cityName,
    super.key});

  @override
  State<CreateUpdateVendorScreen> createState() => _CreateUpdateVendorScreenState();
}

class _CreateUpdateVendorScreenState extends State<CreateUpdateVendorScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => VendorLevelListBloc()),
          BlocProvider(create: (context) => CreateEditDeleteVendorBloc()),
        ],
        child: CreateUpdateVendorScreenWidget(
          isEdit: widget.isEdit,
          vendorId: widget.vendorId,
          vendorName: widget.vendorName,
          vendorEmail: widget.vendorEmail,
          vendorMobileNo: widget.vendorMobileNo,
          address: widget.address,
          vendorLevel: widget.vendorLevel,
          vendorLevelId: widget.vendorLevelId,
          productId: widget.productId,
          productName: widget.productName,
          branchId: widget.branchId,
          branchName: widget.branchName,
          vendorWhatsAppNo: widget.vendorWhatsAppNo,
          gstNo: widget.gstNo,
          countryId: widget.countryId,
          stateId: widget.stateId,
          cityId: widget.cityId,
          countryName: widget.countryName,
          stateName: widget.stateName,
          cityName: widget.cityName,
        )
    );
  }
}


class CreateUpdateVendorScreenWidget extends StatefulWidget {
  final bool isEdit;
  final String vendorId;
  final String vendorName;
  final String vendorEmail;
  final String vendorMobileNo;
  final String address;
  final String vendorLevel;
  final String vendorLevelId;
  final String productId;
  final String productName;
  final String branchId;
  final String branchName;
  final String vendorWhatsAppNo;
  final String gstNo;
  final String countryId;
  final String stateId;
  final String cityId;
  final String countryName;
  final String stateName;
  final String cityName;




  const CreateUpdateVendorScreenWidget({
    required this.isEdit,
    required this.vendorId,
    required this.vendorName,
    required this.vendorEmail,
    required this.vendorMobileNo,
    required this.address,
    required this.vendorLevel,
    required this.vendorLevelId,
    required this.productId,
    required this.productName,
    required this.branchId,
    required this.branchName,
    required this.vendorWhatsAppNo,
    required this.gstNo,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.countryName,
    required this.stateName,
    required this.cityName,
    super.key});

  @override
  State<CreateUpdateVendorScreenWidget> createState() => _CreateUpdateVendorScreenWidgetState();
}

class _CreateUpdateVendorScreenWidgetState extends State<CreateUpdateVendorScreenWidget> {

  TextEditingController vendorNameController = TextEditingController();
  TextEditingController vendorCompanyNameController = TextEditingController();
  TextEditingController vendorPhoneNumController = TextEditingController();
  TextEditingController vendorWhatsAppNoController = TextEditingController();
  TextEditingController vendorEmailAddressController = TextEditingController();
  TextEditingController gstNoController = TextEditingController();
  TextEditingController vendorLevelController = TextEditingController();
  TextEditingController selectBranchController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  bool isChecked = false;
  String? vendorLevelName;
  String? vendorLevelIds;
  List<String> selectedProductIds = [];
  List<String> selectedProductNames = [];
  String selectedBranchId = "";
  String selectedCountryId = "";
  String selectedStateId = "";
  String selectedCityId = "";



  @override
  void initState() {
    BlocProvider.of<VendorLevelListBloc>(context).add(
      FetchVendorLevelListEvent(),
    );

    if(widget.isEdit == true) {
      vendorNameController.text = widget.vendorName;
      vendorCompanyNameController.text = widget.vendorName;
      vendorPhoneNumController.text = widget.vendorMobileNo;
      vendorWhatsAppNoController.text = widget.vendorWhatsAppNo;
      vendorEmailAddressController.text = widget.vendorEmail;
      gstNoController.text = widget.gstNo;

      vendorLevelName = widget.vendorLevel;
      vendorLevelIds = widget.vendorLevelId;

      selectedBranchId = widget.branchId;
      selectBranchController.text = widget.branchName;

      selectedProductIds = widget.productId.split(",");
      selectedProductNames = widget.productName.split(",");

      customerAddressController.text = widget.address;

      selectedCountryId = widget.countryId;
      countryController.text = widget.countryName;

      selectedStateId = widget.stateId;
      stateController.text = widget.stateName;

      selectedCityId = widget.cityId;
      cityController.text = widget.cityName;


      vendorPhoneNumController.addListener(() {
        if (isChecked) {
          vendorWhatsAppNoController.text = vendorPhoneNumController.text;
        }
      });
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title:  widget.isEdit == true
              ? "Update Vendor"
              : "New Vendor",
      ),
      body: BlocConsumer<CreateEditDeleteVendorBloc,CreateEditDeleteVendorState>(
          listener: (context,state){
            if (state is LoadedCreateVendorState) {
              CommonToast.show(context,state.message);
              Navigator.of(context).pop(true);
            }
            else if(state is FailureCreateVendorState){
              CommonToast.show(context,state.error);
            }
            else if(state is LoadedEditVendorState){
              CommonToast.show(context,state.message);
              Navigator.of(context).pop(true);
            }
            else if(state is FailureEditVendorState){
              CommonToast.show(context,state.error);
            }
          },
          builder: (context,state){
            if (state is LoadingCreateVendorState) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            else if (state is LoadingEditVendorState) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            return  SingleChildScrollView(
              child: Column(
                children: [
                  CommonTextField(
                    controller: vendorNameController,
                    horizontalMargin: 15,
                    label: "Vendor Name",
                    hint: "Write Vendor Name..",
                  ),
                  CommonTextField(
                    controller: vendorCompanyNameController,
                    horizontalMargin: 15,
                    label: "Vendor Company Name",
                    hint: "Write Vendor Company Name..",
                  ),
                  CommonTextField(
                    controller: vendorPhoneNumController,
                    horizontalMargin: 15,
                    label: "Vendor Phone Number",
                    hint: "Write Vendor Phone Number..",
                    keyboardType: TextInputType.number,
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isChecked = !isChecked;
                        if (isChecked) {
                          vendorWhatsAppNoController.text =
                              vendorPhoneNumController.text;
                        } else {
                          vendorWhatsAppNoController.clear();
                        }
                      });
                    },
                    child: Container(
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
                                    vendorWhatsAppNoController.text = vendorPhoneNumController.text;
                                  } else {
                                    vendorWhatsAppNoController.clear();
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommonTextField(
                    controller: vendorWhatsAppNoController,
                    horizontalMargin: 15,
                    label: "Vendor WhatsApp Number",
                    hint: "Write Vendor WhatsApp Number..",
                    readOnly: isChecked,
                    keyboardType: TextInputType.number,
                  ),
                  CommonTextField(
                    controller: vendorEmailAddressController,
                    horizontalMargin: 15,
                    label: "Vendor Email Address ",
                    hint: "Write Vendor Email Address..",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CommonTextField(
                    controller: gstNoController,
                    horizontalMargin: 15,
                    label: "GST Number",
                    hint: "Write GST Number..",
                  ),
                  BlocBuilder<VendorLevelListBloc, VendorLevelListStates>(
                    builder: (context, state) {
                      if (state is InitialVendorLevelListStates) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
                      else if(state is LoadingVendorLevelListStates){
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
                      else if(state is LoadedVendorLevelListStates){
                        final levels = state.list;
                        return  CommonDropdown(
                          label: "Vendor Level",
                          hint: "Vendor Level name..",
                          value: levels.any((e) => e.vendorLevelName == vendorLevelName)
                              ? vendorLevelName
                              : null,
                          horizontalMargin: 15,
                          items: levels
                              .map((e) => e.vendorLevelName)
                              .toList(),
                          onChanged: (val) {
                            final selectedLevel =
                            levels.firstWhere((e) => e.vendorLevelName == val);
                            setState(() {
                              vendorLevelName = selectedLevel.vendorLevelName;
                              vendorLevelIds = selectedLevel.vendorLevelId.toString();
                            });
                          },
                        );
                      }
                      else if(state is FailureVendorLevelListStates){
                        return Center(
                          child: Text(state.error),
                        );
                      }
                      return Container();
                    },
                  ),
                  CommonTextField(
                      controller: selectBranchController,
                      horizontalMargin: 15,
                      label: "Select Branch",
                      hint: "Enter Select Branch..",
                      suffixIconBoxed: false,
                      suffixIcon:Icons.arrow_forward_ios,
                      readOnly: true,
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectBranchScreen()
                            )
                        ).then(
                                (value){
                              selectedBranchId = value[0];
                              selectBranchController.text = value[1];
                              setState(() {});
                            }
                        );
                      }
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
                    controller: customerAddressController,
                    maxLines: 3,
                    horizontalMargin: 15,
                    label: "Customer Address ",
                    hint: "Enter customer address..",
                  ),
                  CommonTextField(
                      controller: countryController,
                      horizontalMargin: 15,
                      label: "Select Country",
                      hint: "Tap to select Country Name..",
                      suffixIconBoxed: false,
                      suffixIcon:Icons.arrow_forward_ios,
                      readOnly: true,
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCountryScreen()
                            )
                        ).then(
                                (value){
                              selectedCountryId = value[0];
                              countryController.text = value[1];
                              setState(() {});
                            }
                        );
                      }
                  ),
                  if(selectedCountryId.isNotEmpty)
                  CommonTextField(
                      controller: stateController,
                      horizontalMargin: 15,
                      label: "Select State",
                      hint: "Tap to Select Select State..",
                      suffixIconBoxed: false,
                      suffixIcon:Icons.arrow_forward_ios,
                      readOnly: true,
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectStateScreen(
                                    countryId: selectedCountryId
                                )
                            )
                        ).then(
                                (value){
                              selectedStateId = value[0];
                              stateController.text = value[1];
                              setState(() {});
                            }
                        );
                      }
                  ),
                  if(selectedStateId.isNotEmpty)
                  CommonTextField(
                      controller: cityController,
                      horizontalMargin: 15,
                      label: "Select City",
                      hint: "Tap to Select City..",
                      suffixIconBoxed: false,
                      suffixIcon:Icons.arrow_forward_ios,
                      readOnly: true,
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCityScreen(
                                    stateId: selectedStateId
                                )
                            )
                        ).then(
                                (value){
                              selectedCityId = value[0];
                              cityController.text = value[1];
                              setState(() {});
                            }
                        );
                      }
                  ),
                  CommonActionButton(
                    title: widget.isEdit == true
                        ? "Update Vendor"
                        : "Add Vendor",
                    horizontalMargin: 15,
                    icon: widget.isEdit == true
                        ? Icons.update
                        : Icons.data_saver_on_rounded,
                    onTap: (){
                      if (widget.isEdit == true) {
                        BlocProvider.of<CreateEditDeleteVendorBloc>(context).add(
                            EditVendorEvent(
                              vendorId: widget.vendorId,
                              vendorName: vendorNameController.text,
                              vendorEmail: vendorEmailAddressController.text,
                              mobileNumber: vendorPhoneNumController.text,
                              address: customerAddressController.text,
                              vendorLevelId: vendorLevelIds ?? "",
                              productId: selectedProductIds.join(","),
                              branchId: selectedBranchId,
                              whatsAppNo: vendorWhatsAppNoController.text,
                            )
                        );
                      }
                      else {
                        BlocProvider.of<CreateEditDeleteVendorBloc>(context).add(
                            CreateVendorEvent(
                              vendorName: vendorNameController.text,
                              vendorEmail: vendorEmailAddressController.text,
                              mobileNumber: vendorPhoneNumController.text,
                              address: customerAddressController.text,
                              vendorLevelId: vendorLevelIds ?? "",
                              productId: selectedProductIds.join(","),
                              countryId: selectedCountryId,
                              stateId: selectedStateId,
                              cityId: selectedCityId,
                            )
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }
      )
    );
  }
}
