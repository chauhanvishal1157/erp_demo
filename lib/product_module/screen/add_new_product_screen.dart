import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/product_module/screen/select_brand_screen.dart';
import 'package:erp_demo/product_module/screen/select_product_screen.dart';
import 'package:erp_demo/product_module/screen/select_sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/app_color.dart';
import '../../common/common_app_bar.dart';
import '../../common/common_drop_down.dart';
import '../../master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_bloc.dart';
import '../../master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_event.dart';
import '../../master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_state.dart';
import '../../master_module/product_screen/sub_category/screens/select_category_screen.dart';
import '../../master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_bloc.dart';
import '../../master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_event.dart';
import '../../master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_state.dart';
import 'tax_type_bottom_sheet.dart';


class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UnitListBlocs()),
          BlocProvider(create: (context) => ProductTypeListBlocs())
        ],
        child: AddNewProductScreenWidget()
    );
  }
}


class AddNewProductScreenWidget extends StatefulWidget {
  const AddNewProductScreenWidget({super.key});

  @override
  State<AddNewProductScreenWidget> createState() => _AddNewProductScreenWidgetState();
}

class _AddNewProductScreenWidgetState extends State<AddNewProductScreenWidget> {
  bool isProduct = false;
  TextEditingController selectProductController = TextEditingController();
  TextEditingController quantityCountController = TextEditingController();
  String selectedProductName = "";
  String selectedProductId = "";
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController jobNumberController = TextEditingController();
  TextEditingController selectCategoryController = TextEditingController();
  TextEditingController selectSubCategoryController = TextEditingController();
  TextEditingController selectBrandController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController maxPurchasePriceController = TextEditingController();
  TextEditingController hsnCodeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController selectUnitController = TextEditingController();
  TextEditingController selectProductTypesController = TextEditingController();
  TextEditingController cessController = TextEditingController();
  String selectedCategoryId = "";
  String selectedCategoryName = "";
  String selectedSubCategoryName = "";
  String selectedSubCategoryId = "";
  String selectedBrandName = "";
  String selectedBrandId = "";
  String cgstTaxRate ="";
  String sgstTaxRate ="";
  String igstTaxRate ="";
  String? selectedUnitId;
  String? selectedUnitName;
  String? selectedProductTypeId;
  String? selectedProductTypeName;

@override
  void initState() {
   selectProductController.text = selectedProductName;

   selectCategoryController.text = selectedCategoryName;
   selectSubCategoryController.text = selectedSubCategoryName;
   selectBrandController.text = selectedBrandName;


   BlocProvider.of<UnitListBlocs>(context).add(
       FetchUnitListEvents()
   );

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
        title: "Add New Product",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isProduct = !isProduct;
                });
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                padding:  EdgeInsets.fromLTRB(10,10,20,10),
                decoration: CommonDecorations.card(),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        value: isProduct,
                        activeColor: AppColors.primary,
                        side: BorderSide(color: Colors.black54,width: 1.5),
                        onChanged: (newBool) {
                          setState(() {
                            isProduct = newBool!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Create New Product",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      isProduct
                          ?Icons.toggle_on
                          : Icons.toggle_off,
                      size: 30,
                      color:
                      isProduct
                          ?AppColors.primary
                          : Colors.grey,
                    ),
        
                  ],
                ),
              ),
            ),
            if(isProduct == false)...[
              CommonTextField(
                controller: selectProductController,
                horizontalMargin: 15,
                label: "Select Product",
                hint: "Tap to select product...",
                suffixIconBoxed: false,
                suffixIcon: Icons.arrow_forward_ios,
                readOnly: true,
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectProductScreen()
                      )
                  ).then(
                        (value) {
                      selectedProductId = value[0];
                      selectedProductName = value[1];
                      selectProductController.text = value[1];
                      final count = selectedProductName
                          .split(',')
                          .where((e) => e.trim().isNotEmpty)
                          .length;
        
                      quantityCountController.text = count.toString();
                      setState(() {});
                    },
                  );
        
                },
              ),
              CommonTextField(
                  controller: quantityCountController,
                  label: "quantity",
                  hint: "Enter quantity...",
                  horizontalMargin: 15
              ),
            ],
            if(isProduct == true)...[
              CommonTextField(
                  controller: productNameController,
                  horizontalMargin: 15,
                  label: "Product Name",
                  hint: "Enter Product Name..."
              ),
              CommonTextField(
                  controller: productDescriptionController,
                  horizontalMargin: 15,
                  maxLines: 3,
                  label: "Product Description",
                  hint: "Enter additional product details..."
              ),
              CommonTextField(
                  controller: jobNumberController,
                  horizontalMargin: 15,
                  label: "Job Number",
                  hint: "Enter job number..."
              ),
              CommonTextField(
                controller: selectCategoryController,
                horizontalMargin: 15,
                readOnly: true,
                label: "Select Category",
                hint: "Tap to select category...",
                suffixIconBoxed: false,
                suffixIcon: Icons.arrow_forward_ios,
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectCategoryScreen()
                      )
                  ).then(
                        (value) {
                      selectedCategoryId = value[0];
                      selectedCategoryName = value[1];
                      selectCategoryController.text = value[1];
                      setState(() {});
                    },
                  );
                },
              ),
              CommonTextField(
                controller: selectSubCategoryController,
                horizontalMargin: 15,
                readOnly: true,
                label: "Select Sub-Category",
                hint: "Tap to select a sub category...",
                suffixIconBoxed: false,
                suffixIcon: Icons.arrow_forward_ios,
                onTap: (){
                  if (selectedCategoryId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select category first"),
                        backgroundColor: Colors.black,
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectSubCategoryScreen()
                      )
                  ).then(
                        (value) {
                      selectedSubCategoryId = value[0];
                      selectedSubCategoryName = value[1];
                      selectSubCategoryController.text = value[1];
                      setState(() {});
                    },
                  );
                },
              ),
              CommonTextField(
                controller: selectBrandController,
                horizontalMargin: 15,
                readOnly: true,
                label: "Select Brand",
                hint: "Tap to select brand...",
                suffixIconBoxed: false,
                suffixIcon: Icons.arrow_forward_ios,
                onTap:  (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectBrandScreen()
                      )
                  ).then(
                        (value) {
                      selectedBrandId = value[0];
                      selectedBrandName = value[1];
                      selectBrandController.text = value[1];
                      setState(() {});
                    },
                  );
                },
              ),
              CommonTextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  horizontalMargin: 15,
                  label: "Price",
                  hint: "Enter price for Product..."
              ),
              CommonTextField(
                  controller: maxPurchasePriceController,
                  keyboardType: TextInputType.number,
                  horizontalMargin: 15,
                  label: "Max Purchase Price",
                  hint: "Enter max purchase price for Product..."
              ),
              CommonTextField(
                  controller: hsnCodeController,
                  horizontalMargin: 15,
                  label: "HSN Code",
                  hint: "Enter HSN Code..."
              ),
              TaxType(
                taxType: "CGST",
                rate: cgstTaxRate,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return TaxTypeBottomSheet(
                          taxType: 'CGST',
                        );
                      }
                  ).then(
                          (value){
                        cgstTaxRate = value[0];
                        setState(() {});
                      }
                  );
                },
              ),
              TaxType(
                taxType: "SGST",
                rate: sgstTaxRate,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return TaxTypeBottomSheet(
                          taxType: 'SGST',
                        );
                      }
                  ).then(
                          (value){
                        sgstTaxRate = value[0];
                        setState(() {});
                      }
                  );
                },
              ),
              TaxType(
                taxType: "IGST",
                rate: igstTaxRate,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return TaxTypeBottomSheet(
                          taxType: 'IGST',
                        );
                      }
                  ).then(
                          (value){
                        igstTaxRate = value[0];
                        setState(() {});
                      }
                  );
                },
              ),
              CommonTextField(
                  controller: quantityController,
                  horizontalMargin: 15,
                  label: "Quantity ",
                  hint: "Enter quantity..."
              ),
              BlocBuilder<UnitListBlocs, UnitListStates>(
                builder: (context, state) {
                  if (state is InitialUnitListStates) {
                    return Center(
                      child:  SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 40,
                      ),
                    );
                  }
                  else if(state is LoadingUnitListStates){
                    return Center(
                      child:  SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 40,
                      ),
                    );
                  }
                  else if(state is LoadedUnitListStates){
                    return CommonDropdown(
                      label: "Unit",
                      hint: "Select Unit",
                      value: selectedUnitName,
                      horizontalMargin: 15,
                      items:state.list
                          .map((e) => e.unitName)
                          .toList(),
                      onChanged: (val) {
                        final selected = state.list.firstWhere(
                              (e) => e.unitName == val,
                        );
                        setState(() {
                          selectedUnitName = selected.unitName;
                          selectedUnitId = selected.unitId.toString();
                        });
                      },
                    );
                  }
                  else if(state is FailureUnitListStates){
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return Container();
                },
              ),
              BlocBuilder<ProductTypeListBlocs, ProductTypeListStates>(
                builder: (context, state) {
                  if (state is InitialProductTypeListStates) {
                    return Center(
                      child:  SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 40,
                      ),
                    );
                  }
                  else if(state is LoadingProductTypeListStates){
                    return Center(
                      child:  SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 40,
                      ),
                    );
                  }
                  else if(state is LoadedProductTypeListStates){
                    return  CommonDropdown(
                      label: "Product Type",
                      hint: "Select Product Type",
                      value: selectedProductTypeName,
                      horizontalMargin: 15,
                      items:state.list
                          .map((e) => e.productName)
                          .toList(),
                      onChanged: (val) {
                        final selected = state.list.firstWhere(
                              (e) => e.productName == val,
                        );
        
                        setState(() {
                          selectedProductTypeName = selected.productName;
                          selectedProductTypeId = selected.productId.toString();
                        });
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
            ],
            CommonActionButton(
              title: "Save",
              horizontalMargin: 15,
              onTap: (){},
            )
          ],
        ),
      ),
    );
  }
}

class TaxType extends StatelessWidget {
  final String taxType;
  final String rate;
  final VoidCallback? onTap;

  const TaxType({
    required this.taxType,
    required this.rate,
    required this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
        decoration: CommonDecorations.card(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tax Type",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  taxType,
                  style:
                  const TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                    "Tax Rate",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12
                    )
                ),
                const SizedBox(height: 4),
                Text(
                  rate,
                  style:
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
