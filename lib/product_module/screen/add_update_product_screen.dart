import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_drop_down.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_bloc.dart';
import 'package:erp_demo/master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_event.dart';
import 'package:erp_demo/master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_bloc.dart';
import 'package:erp_demo/product_module/bloc/create_edit_delete_product_list_bloc/create_edit_delete_product_list_bloc.dart';
import 'package:erp_demo/product_module/bloc/create_edit_delete_product_list_bloc/create_edit_delete_product_list_event.dart';
import 'package:erp_demo/product_module/screen/add_new_product_screen.dart';
import 'package:erp_demo/product_module/screen/tax_type_bottom_sheet.dart';
import 'package:erp_demo/product_module/screen/select_brand_screen.dart';
import 'package:erp_demo/product_module/screen/select_sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../common/app_color.dart';
import '../../common/common_toast.dart';
import '../../master_module/product_screen/product_type/bloc/product_type_list_bloc/product_type_list_state.dart';
import '../../master_module/product_screen/sub_category/screens/select_category_screen.dart';
import '../../master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_event.dart';
import '../../master_module/product_screen/unit/bloc/unit_list_bloc/unit_list_state.dart';
import '../bloc/create_edit_delete_product_list_bloc/create_edit_delete_product_list_state.dart';


class AddUpdateProductScreen extends StatefulWidget {
  final bool isEdit;
  final String productId;
  final String categoryId;
  final String subCategoryId;
  final String brandId;
  final String unitId;
  final String name;
  final String productTypeId;
  final String productPrice;
  final String qty;
  final String tax1Name;
  final String tax1Rate;
  final String tax2Name;
  final String tax2Rate;
  final String tax3Name;
  final String tax3Rate;
  final String productData;
  final String maxPurchasePrice;
  final String description;
  final String hsnCode;
  final String jobNumber;
  final String categoryName;
  final String subCategoryName;
  final String brandName;
  final String unitName;
  final String productTypeName;


  const AddUpdateProductScreen({
    required this.isEdit,
    required this.productId,
    required this.categoryId,
    required this.subCategoryId,
    required this.brandId,
    required this.unitId,
    required this.name,
    required this.productTypeId,
    required this.productPrice,
    required this.qty,
    required this.tax1Name,
    required this.tax1Rate,
    required this.tax2Name,
    required this.tax2Rate,
    required this.tax3Name,
    required this.tax3Rate,
    required this.productData,
    required this.maxPurchasePrice,
    required this.description,
    required this.hsnCode,
    required this.jobNumber,
    required this.categoryName,
    required this.subCategoryName,
    required this.brandName,
    required this.unitName,
    required this.productTypeName,

    super.key
  });

  @override
  State<AddUpdateProductScreen> createState() => _AddUpdateProductScreenState();
}

class _AddUpdateProductScreenState extends State<AddUpdateProductScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CreateEditDeleteProductListBloc()),
          BlocProvider(create: (context) => UnitListBlocs()),
          BlocProvider(create: (context) => ProductTypeListBlocs())
        ],
        child: AddUpdateProductScreenWidget(
          isEdit: widget.isEdit,
          productId: widget.productId,
          categoryId: widget.categoryId,
          subCategoryId: widget.subCategoryId,
          brandId: widget.brandId,
          unitId: widget.unitId,
          name: widget.name,
          productTypeId: widget.productTypeId,
          productPrice: widget.productPrice,
          qty: widget.qty,
          tax1Name: widget.tax1Name,
          tax1Rate: widget.tax1Rate,
          tax2Name: widget.tax2Name,
          tax2Rate: widget.tax2Rate,
          tax3Name: widget.tax3Name,
          tax3Rate: widget.tax3Rate,
          productData: widget.productData,
          maxPurchasePrice: widget.maxPurchasePrice,
          description: widget.description,
          hsnCode: widget.hsnCode,
          jobNumber: widget.jobNumber,
          categoryName: widget.categoryName,
          subCategoryName: widget.subCategoryName,
          brandName: widget.brandName,
          unitName: widget.unitName,
          productTypeName: widget.productTypeName,

        )
    );
  }
}



class AddUpdateProductScreenWidget extends StatefulWidget {
  final bool isEdit;
  final String productId;
  final String categoryId;
  final String subCategoryId;
  final String brandId;
  final String unitId;
  final String name;
  final String productTypeId;
  final String productPrice;
  final String qty;
  final String tax1Name;
  final String tax1Rate;
  final String tax2Name;
  final String tax2Rate;
  final String tax3Name;
  final String tax3Rate;
  final String productData;
  final String maxPurchasePrice;
  final String description;
  final String hsnCode;
  final String jobNumber;
  final String categoryName;
  final String subCategoryName;
  final String brandName;
  final String unitName;
  final String productTypeName;

  const AddUpdateProductScreenWidget({
    required this.isEdit,
    required this.productId,
    required this.categoryId,
    required this.subCategoryId,
    required this.brandId,
    required this.unitId,
    required this.name,
    required this.productTypeId,
    required this.productPrice,
    required this.qty,
    required this.tax1Name,
    required this.tax1Rate,
    required this.tax2Name,
    required this.tax2Rate,
    required this.tax3Name,
    required this.tax3Rate,
    required this.productData,
    required this.maxPurchasePrice,
    required this.description,
    required this.hsnCode,
    required this.jobNumber,
    required this.categoryName,
    required this.subCategoryName,
    required this.brandName,
    required this.unitName,
    required this.productTypeName,
    super.key
  });

  @override
  State<AddUpdateProductScreenWidget> createState() => _AddUpdateProductScreenWidgetState();
}

class _AddUpdateProductScreenWidgetState extends State<AddUpdateProductScreenWidget> {


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
  TextEditingController cessController = TextEditingController();
  bool isSerialNumberSelected = false;
  bool isTaxSelected = false;
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

  String cleanTax(String value) {
    return value.replaceAll('%', '');
  }

  @override
  void initState() {
    selectCategoryController.text = selectedCategoryName;
    selectSubCategoryController.text = selectedSubCategoryName;
    selectBrandController.text = selectedBrandName;

    BlocProvider.of<UnitListBlocs>(context).add(
        FetchUnitListEvents()
    );

    BlocProvider.of<ProductTypeListBlocs>(context).add(
        FetchProductTypeListEvents()

    );

    productNameController.text = widget.name;
    productDescriptionController.text = widget.description;
    jobNumberController.text = widget.jobNumber;
    priceController.text = widget.productPrice;
    maxPurchasePriceController.text = widget.maxPurchasePrice;
    hsnCodeController.text = widget.hsnCode;
    quantityController.text = widget.qty;
    cgstTaxRate = widget.tax1Rate;
    sgstTaxRate = widget.tax2Rate;
    igstTaxRate = widget.tax3Rate;
    selectCategoryController.text = widget.categoryName;
    selectSubCategoryController.text = widget.subCategoryName;
    selectBrandController.text = widget.brandName;
    selectedUnitId =
    widget.unitId.isNotEmpty ? widget.unitId : null;

    selectedUnitId =
    (widget.unitId.isNotEmpty && widget.unitId != "0")
        ? widget.unitId
        : null;

    selectedProductTypeId =
    (widget.productTypeId.isNotEmpty && widget.productTypeId != "0")
        ? widget.productTypeId
        : null;

    selectedUnitName =
    widget.unitName.isNotEmpty ? widget.unitName : null;

    selectedProductTypeName =
    widget.productTypeName.isNotEmpty
        ? widget.productTypeName
        : null;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title:  widget.isEdit == true
              ? "Update Product"
              : "Add Product"
      ),
      body: BlocConsumer<CreateEditDeleteProductListBloc,CreateEditDeleteProductListState>(
          listener: (context,state){
            if (state is LoadedCreateProductListState) {
              CommonToast.show(context,state.message);
              Navigator.of(context).pop(true);
            }
            else if(state is FailureCreateProductListState){
              CommonToast.show(context,state.error);
            }
            else if(state is LoadedEditProductListState){
              CommonToast.show(context,state.message);
              Navigator.of(context).pop(true);
            }
            else if(state is FailureEditProductListState){
              CommonToast.show(context,state.error);
            }
          },
          builder: (context,state){
            if (state is LoadingCreateProductListState) {
              return Center(
                child:  SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            else if (state is LoadingEditProductListState) {
              return Center(
                child:  SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  if(widget.isEdit == false)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSerialNumberSelected = !isSerialNumberSelected;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                      padding:  EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSerialNumberSelected
                            ? Colors.blue.shade50
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: isSerialNumberSelected
                                ? AppColors.primary
                                : Colors.grey.shade200
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:  Colors.grey.shade200,
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isSerialNumberSelected
                                  ? AppColors.primary
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.confirmation_number_outlined,
                              color:isSerialNumberSelected
                                  ? Colors.white
                                  : Colors.grey,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Serial Number Tracking",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Manage products batch-wise using serial numbers",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 1,
                            child: Checkbox(
                              value: isSerialNumberSelected,
                              activeColor: AppColors.primary,
                              side: BorderSide(color: Colors.black54,width: 2),
                              onChanged: (newBool) {
                                setState(() {
                                  isSerialNumberSelected = newBool!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isTaxSelected = !isTaxSelected;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                      padding:  EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isTaxSelected
                              ? Colors.orange
                              : Colors.white,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:  Colors.grey.shade200,
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.payments_outlined,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Apply CESS Tax",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Add CESS Tax percentage for this orders",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 1.1,
                            child: Checkbox(
                              value: isTaxSelected,
                              activeColor: Colors.orange,
                              shape: CircleBorder(),
                              side: BorderSide(color: Colors.black54,width: 1.5),
                              onChanged: (newBool) {
                                setState(() {
                                  isTaxSelected = newBool!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isTaxSelected)
                    CommonTextField(
                      controller: cessController,
                      label: "CESS Tax",
                      hint: "Enter CESS Tax...",
                      horizontalMargin: 15,
                      suffixIconBoxed: false,
                      suffixIcon: Icons.percent,
                    ),
                  CommonTextField(
                      controller: quantityController,
                      horizontalMargin: 15,
                      keyboardType: TextInputType.number,
                      label: "Quantity ",
                      hint: "Enter quantity..."
                  ),
                  BlocBuilder<UnitListBlocs, UnitListStates>(
                    builder: (context, state) {
                      if (state is InitialUnitListStates) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
                      else if(state is LoadingUnitListStates){
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
                      else if(state is LoadedUnitListStates){

                        final unitItems = state.list.map((e) => e.unitName).toList();

                        return CommonDropdown(
                          label: "Unit",
                          hint: "Select Unit",
                          horizontalMargin: 15,
                          value: unitItems.contains(selectedUnitName)
                              ? selectedUnitName
                              : null,
                          items: unitItems,
                          onChanged: (val) {
                            final selected = state.list
                                .where((e) => e.unitName == val)
                                .toList();

                            if (selected.isNotEmpty) {
                              setState(() {
                                selectedUnitName = selected.first.unitName;
                                selectedUnitId = selected.first.unitId.toString();
                              });
                            }
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

                        final productTypeItems =
                        state.list.map((e) => e.productName).toList();

                        return CommonDropdown(
                          label: "Product Type",
                          hint: "Select Product Type",
                          horizontalMargin: 15,
                          value: productTypeItems.contains(selectedProductTypeName)
                              ? selectedProductTypeName
                              : null,
                          items: productTypeItems,
                          onChanged: (val) {
                            final selected = state.list
                                .where((e) => e.productName == val)
                                .toList();

                            if (selected.isNotEmpty) {
                              setState(() {
                                selectedProductTypeName = selected.first.productName;
                                selectedProductTypeId = selected.first.productId.toString();
                              });
                            }

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
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewProductScreen()
                          )
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        padding: EdgeInsets.all(10),
                        decoration: CommonDecorations.card(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.shade50
                              ),
                              child: Icon(
                                Icons.add_box_outlined,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Add New Product",
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                  CommonActionButton(
                    title: widget.isEdit == true
                        ? "Update"
                        : "Save Product",
                    horizontalMargin: 15,
                    icon:  widget.isEdit == true
                        ? Icons.update
                        : Icons.save,
                    onTap: (){
                      if(widget.isEdit == true){
                        BlocProvider.of<CreateEditDeleteProductListBloc>(context).add(
                           EditProductListEvent(
                             productId: widget.productId,

                             categoryName: selectCategoryController.text,
                             categoryId: selectedCategoryId.isNotEmpty
                                 ? selectedCategoryId
                                 : widget.categoryId,

                             subCategoryName: selectSubCategoryController.text,
                             subCategoryId: selectedSubCategoryId.isNotEmpty
                                 ? selectedSubCategoryId
                                 : widget.subCategoryId,

                             brandName: selectBrandController.text,
                             brandId: selectedBrandId.isNotEmpty
                                 ? selectedBrandId
                                 : widget.brandId,

                             unitName: selectedUnitName ?? widget.unitName,
                             unitId: selectedUnitId ?? widget.unitId,

                             productTypeName: selectedProductTypeName ?? widget.productTypeName,
                             productTypeId: selectedProductTypeId ?? widget.productTypeId,

                             name: productNameController.text,
                             productPrice: priceController.text,
                             qty: quantityController.text,

                             tax1Name: "CGST",
                             tax1Rate: cleanTax(cgstTaxRate),

                             tax2Name: "SGST",
                             tax2Rate: cleanTax(sgstTaxRate),

                             tax3Name: "IGST",
                             tax3Rate: cleanTax(igstTaxRate),

                             maxPurchasePrice: maxPurchasePriceController.text,
                             description: productDescriptionController.text,
                             hsnCode: hsnCodeController.text,
                             jobNumber: jobNumberController.text,
                             productData: widget.productData,
                           )
                        );
                      }
                      else{
                        BlocProvider.of<CreateEditDeleteProductListBloc>(context).add(
                           CreateProductListEvent(
                             categoryName: selectCategoryController.text,
                             categoryId: selectedCategoryId.isNotEmpty
                                 ? selectedCategoryId
                                 : widget.categoryId,

                             subCategoryName: selectSubCategoryController.text,
                             subCategoryId: selectedSubCategoryId.isNotEmpty
                                 ? selectedSubCategoryId
                                 : widget.subCategoryId,

                             brandName: selectBrandController.text,
                             brandId: selectedBrandId.isNotEmpty
                                 ? selectedBrandId
                                 : widget.brandId,

                             unitName: selectedUnitName ?? widget.unitName,
                             unitId: selectedUnitId ?? widget.unitId,

                             productTypeName: selectedProductTypeName ?? widget.productTypeName,
                             productTypeId: selectedProductTypeId ?? widget.productTypeId,

                             name: productNameController.text,
                             productPrice: priceController.text,
                             qty: quantityController.text,

                             tax1Name: "CGST",
                             tax1Rate: cleanTax(cgstTaxRate),

                             tax2Name: "SGST",
                             tax2Rate: cleanTax(sgstTaxRate),

                             tax3Name: "IGST",
                             tax3Rate: cleanTax(igstTaxRate),

                             description: productDescriptionController.text,
                             hsnCode: hsnCodeController.text,
                             jobNumber: jobNumberController.text,
                             productData: widget.productData,
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

