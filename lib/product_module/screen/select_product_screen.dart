import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/product_module/bloc/product_list_bloc/product_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/app_color.dart';
import '../../common/common_action_button.dart';
import '../bloc/product_list_bloc/product_list_event.dart';
import '../bloc/product_list_bloc/product_list_state.dart';

class SelectProductScreen extends StatefulWidget {
  final bool isMultiSelect;
  const SelectProductScreen({
    this.isMultiSelect = false,
    super.key});

  @override
  State<SelectProductScreen> createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductListBloc(),
      child: SelectProductScreenWidget(
        isMultiSelect: widget.isMultiSelect,
      ),
    );
  }
}


class SelectProductScreenWidget extends StatefulWidget {
  final bool isMultiSelect;
  const SelectProductScreenWidget({
    this.isMultiSelect = false,
    super.key});

  @override
  State<SelectProductScreenWidget> createState() => _SelectProductScreenWidgetState();
}

class _SelectProductScreenWidgetState extends State<SelectProductScreenWidget> {

  String selectedProductName = "";
  String selectedProductId = "";

  List<String> selectedProductIds = [];
  List<String> selectedProductNames = [];




  @override
  void initState() {
    BlocProvider.of<ProductListBloc>(context).add(
        FetchProductListEvent()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(title: "Select Product"),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is InitialProductListState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadingProductListState){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          else if(state is LoadedProductListState){
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                              hintText: "Enter sub category Name..",
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
                      ListView.builder(
                          padding: EdgeInsets.only(bottom: 80),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {

                            final bool isSelected = widget.isMultiSelect
                                ? selectedProductIds.contains(state.list[index].id.toString())
                                : selectedProductId == state.list[index].id.toString();

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (widget.isMultiSelect) {
                                    /// MULTI SELECT
                                    if (selectedProductIds.contains(state.list[index].id.toString())) {
                                      selectedProductIds.remove(state.list[index].id.toString());
                                      selectedProductNames.remove(state.list[index].name);
                                    } else {
                                      selectedProductIds.add(state.list[index].id.toString());
                                      selectedProductNames.add(state.list[index].name);
                                    }
                                  } else {
                                    /// SINGLE SELECT
                                    selectedProductId = state.list[index].id.toString();
                                    selectedProductName = state.list[index].name;
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 15),
                                margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                                decoration: BoxDecoration(
                                  color:  isSelected
                                      ? Colors.blue[50]
                                      : Colors.white,
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.blue.shade200
                                          : Colors.white,
                                      width: 1.2
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 2,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      shape: CircleBorder(),
                                      side: BorderSide(color: Colors.grey),
                                      activeColor: AppColors.primary,
                                      value: isSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          if (widget.isMultiSelect) {
                                            /// MULTI SELECT
                                            if (selectedProductIds.contains(state.list[index].id.toString())) {
                                              selectedProductIds.remove(state.list[index].id.toString());
                                              selectedProductNames.remove(state.list[index].name);
                                            } else {
                                              selectedProductIds.add(state.list[index].id.toString());
                                              selectedProductNames.add(state.list[index].name);
                                            }
                                          } else {
                                            /// SINGLE SELECT
                                            selectedProductId = state.list[index].id.toString();
                                            selectedProductName = state.list[index].name;
                                          }
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.list[index].name,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical:2,horizontal: 6),
                                        decoration: BoxDecoration(
                                          color: AppColors.action,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Selected",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.screenBg
                    ),
                    child: CommonActionButton(
                        title: "Save Selection",
                        icon: Icons.save,
                        horizontalMargin: 15,
                        onTap: (){
                          if (widget.isMultiSelect) {
                            Navigator.pop(context, [
                              selectedProductIds,
                              selectedProductNames,
                            ]);
                          } else {
                            Navigator.pop(context, [
                              selectedProductId,
                              selectedProductName,
                            ]);
                          }
                        }
                    ),
                  ),
                )
              ],
            );
          }
          else if(state is FailureProductListState){
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


// subProductId = state.list[index].productItemList.first.id.toString();
// categoryId = state.list[index].productItemList.first.categoryId.toString();
// categoryName = state.list[index].productItemList.first.categoryName;
// subCategoryId = state.list[index].productItemList.first.subCategoryId.toString();
// subCategoryName = state.list[index].productItemList.first.subCategoryName;
// brandId = state.list[index].productItemList.first.brandId.toString();
// brandName = state.list[index].productItemList.first.brandName;
// jobNumber = state.list[index].productItemList.first.jobNumber;
// productQty = state.list[index].productItemList.first.productQty.toString();
// productPrice = state.list[index].productItemList.first.productPrice;
// subProductMaxPurchasePrice = state.list[index].productItemList.first.subProductMaxPurchasePrice;
// subProductUsedQty = state.list[index].productItemList.first.subProductUsedQty;
// description = state.list[index].productItemList.first.description;
// qty = state.list[index].productItemList.first.qty;


// String categoryId = "";
// String categoryName = "";
//
// String subCategoryName = "";
// String subCategoryId = "";
//
// String brandName = "";
// String brandId = "";
// String subProductId = "";
// String jobNumber = "";
// String productQty = "";
// String productPrice = "";
// String subProductMaxPurchasePrice = "";
// String subProductUsedQty = "";
// String description = "";
// String qty = "";