import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_pop_menu_button.dart';
import 'package:erp_demo/product_module/bloc/product_list_bloc/product_list_bloc.dart';
import 'package:erp_demo/product_module/bloc/product_list_bloc/product_list_event.dart';
import 'package:erp_demo/product_module/bloc/product_list_bloc/product_list_state.dart';
import 'package:erp_demo/product_module/screen/add_update_product_screen.dart';
import 'package:erp_demo/product_module/screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../common/app_color.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => ProductListBloc(),
      child: ProductListScreenWidget(),
    );
  }
}


class ProductListScreenWidget extends StatefulWidget {
  const ProductListScreenWidget({super.key});

  @override
  State<ProductListScreenWidget> createState() => _ProductListScreenWidgetState();
}

class _ProductListScreenWidgetState extends State<ProductListScreenWidget> {

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
      appBar: CommonAppBar(
          title: "Product",
        showAdd: true,
        showFirstAction: true,
        firstActionIcon: Icons.search,
        firstActionColor: Colors.blue,
        onAddTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>AddUpdateProductScreen(
                      isEdit: false,
                      productId: '',
                      categoryId: '',
                      subCategoryId: '',
                      brandId: '',
                      unitId: '',
                      name: '',
                      productTypeId: '',
                      productPrice: '',
                      qty: '',
                      tax1Name: '',
                      tax1Rate: '',
                      tax2Name: '',
                      tax2Rate: '',
                      tax3Name: '',
                      tax3Rate: '',
                      productData: '',
                      maxPurchasePrice: '',
                      description: '',
                      hsnCode: '',
                      jobNumber: '',
                      categoryName: '',
                      subCategoryName: '',
                      brandName: '',
                      unitName: '',
                      productTypeName: '',
                    )
                )
            ).then(
                (value){
                  if(value == true) {
                    BlocProvider.of<ProductListBloc>(context).add(
                      FetchProductListEvent(),
                    );
                  }
                }
            );
        },
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is InitialProductListState) {
            return Center(
              child:  SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingProductListState){
            return Center(
              child:  SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedProductListState){
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: true,
                cacheExtent: 300,
                itemCount: state.list.length,
                itemBuilder: (context,index){
                  return  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=> ProductDetailsScreen(
                                  productId:  state.list[index].id.toString(),
                                categoryId: state.list[index].categoryId.toString(),
                                subCategoryId: state.list[index].subCategoryId.toString(),
                                brandId: state.list[index].brandId.toString(),
                                unitId: state.list[index].unitId.toString(),
                                name: state.list[index].name,
                                productTypeId: state.list[index].productTypeId.toString(),
                                productPrice: state.list[index].productPrice.toString(),
                                qty: state.list[index].qty.toString(),
                                tax1Name: state.list[index].tax1Name,
                                tax1Rate: state.list[index].tax1Rate,
                                tax2Name: state.list[index].tax2Name,
                                tax2Rate: state.list[index].tax2Rate,
                                tax3Name: state.list[index].tax3Name,
                                tax3Rate: state.list[index].tax3Rate,
                                productData: "",
                                maxPurchasePrice: state.list[index].maxPurchasePrice.toString(),
                                description: state.list[index].description,
                                hsnCode: state.list[index].hsnCode,
                                jobNumber: state.list[index].jobNumber,
                                categoryName: state.list[index].categoryName,
                                subCategoryName: state.list[index].subCategoryName,
                                brandName: state.list[index].brandName,
                                unitName: state.list[index].unitName,
                                productTypeName: state.list[index].productTypeName,
                              )
                          )
                      ).then(
                          (value) {
                            if (value == true) {
                              BlocProvider.of<ProductListBloc>(context).add(FetchProductListEvent(),);
                            }
                          }
                      );
                    },
                    child: Container(
                      margin:  EdgeInsets.fromLTRB(15, 15, 15, 0),
                      decoration: CommonDecorations.card(),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (state.list[index].jobNumber.isNotEmpty)
                                Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child:  Text(
                                   state.list[index].jobNumber,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    state.list[index].name,
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                CommonPopMenuButton(
                                  textValue1: "Copy",
                                  textValue2: "Delete",
                                  textColor2: Colors.red,
                                  icon1: Icons.copy,
                                  icon2: Icons.delete_outline,
                                  containerColor1: Colors.blue.shade50,
                                  containerColor2: Colors.red.shade50,
                                  iconColor1: Colors.blue,
                                  iconColor2: Colors.red,
                                  popMenuColor: Colors.blue.shade100,
                                  popMenuIconColor: AppColors.primary,
                                  value1: (){},
                                  value2: (){},
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoTile(
                                      icon: Icons.inventory_2_outlined,
                                      title: "Product Type",
                                      value: state.list[index].productTypeName,
                                      valueColor: Colors.green,
                                    ),
                                    _infoTile(
                                      icon: Icons.branding_watermark_outlined,
                                      title: "Brand",
                                      value:state.list[index].brandName
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoTile(
                                      icon: Icons.category_outlined,
                                      title: "Category",
                                      value: state.list[index].categoryName
                                    ),
                                    _infoTile(
                                      icon: Icons.subdirectory_arrow_right_outlined,
                                      title: "Sub-Category",
                                      value: state.list[index].subCategoryName
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoTile(
                                      icon: Icons.straighten_outlined,
                                      title: "Unit",
                                      value: state.list[index].unitName
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
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
  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
    Color valueColor = Colors.black87,
  }) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              size: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
