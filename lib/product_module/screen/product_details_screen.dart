import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/product_module/bloc/product_details_bloc/product_details_bloc.dart';
import 'package:erp_demo/product_module/bloc/product_details_bloc/product_details_event.dart';
import 'package:erp_demo/product_module/bloc/product_details_bloc/product_details_state.dart';
import 'package:erp_demo/product_module/screen/add_update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../common/app_color.dart';
import '../../common/common_app_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
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

  const ProductDetailsScreen({
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

    super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => ProductDetailsBloc(),
      child: ProductDetailsScreenWidget(
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
      ),
    );
  }
}


class ProductDetailsScreenWidget extends StatefulWidget {

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

  const ProductDetailsScreenWidget({
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
  State<ProductDetailsScreenWidget> createState() => _ProductDetailsScreenWidgetState();
}

class _ProductDetailsScreenWidgetState extends State<ProductDetailsScreenWidget> {


  @override
  void initState() {
    BlocProvider.of<ProductDetailsBloc>(context).add(
        FetchProductDetailsEvent(
            productId: widget.productId
        )
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Product Details",
        showAdd: true,
        addIcon: Icons.edit,
        onAddTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddUpdateProductScreen(
                        isEdit: true,
                        productId: widget.productId,
                        categoryId:  widget.categoryId,
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
                )
            ).then(
                (value){
                  if(value == true) {
                    BlocProvider.of<ProductDetailsBloc>(context).add(
                      FetchProductDetailsEvent(
                        productId: widget.productId,
                      ),
                    );
                  }
                }
            );
        },
      ),
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is InitialProductDetailsState) {
            return Center(
              child:  SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadingProductDetailsState){
            return Center(
              child:  SpinKitFadingCircle(
                color: Colors.blue,
                size: 40,
              ),
            );
          }
          else if(state is LoadedProductDetailsState){

            final product = state.list.first;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade100)
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.inventory_2_outlined,
                            color: Colors.white,
                            size: 20,

                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                               product.brandName,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15,right: 15),
                    padding: EdgeInsets.all(15),
                    decoration: CommonDecorations.card(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Information",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 5,),
                        Product(
                            type: "Product Type",
                            value: product.productTypeName,
                            color: Colors.blue,
                            icon: Icons.category
                        ),
                        Product(
                            type: "Category",
                            value: product.categoryName,
                            color: Colors.green,
                            icon: Icons.folder
                        ),
                        Product(
                            type: "Sub-Category",
                            value: product.subCategoryName,
                            color: Colors.orange,
                            icon: Icons.star_border_outlined
                        ),
                        Product(
                            type: "Unit",
                            value: product.unitName,
                            color: Colors.purple,
                            icon: Icons.straighten
                        ),
                        Product(
                            type: "Quantity",
                            value: product.qty.toString(),
                            color: Colors.lightGreen,
                            icon: Icons.inventory_2
                        ),
                        Product(
                          type: "Price",
                          value: "₹${product.productPrice}",
                          color: Colors.red,
                          icon: Icons.currency_rupee,
                          valueColor: Colors.green,
                        ),
                        Product(
                          type: "Max Purchase Price",
                          value: "₹${product.maxPurchasePrice}.00",
                          color: Colors.red,
                          icon: Icons.currency_rupee,
                          valueColor: Colors.green,
                        ),
                        Product(
                            type: "HSN Code",
                            value: product.hsnCode,
                            color: Colors.deepPurple,
                            icon: Icons.qr_code
                        ),
                        Text(
                          "Tax Information",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Tax(
                          name: "CGST",
                          rate: product.tax1Rate,
                        ),
                        Tax(
                          name: "SGST",
                          rate: product.tax2Rate,
                        ),
                        Tax(
                          name: "IGST",
                          rate: product.tax3Rate,
                        ),
                        Tax(
                          name: "CESS Tax",
                          rate: product.cessTax,
                        ),
                      ],
                    ),
                  ),
                  if(product.productItemList.isNotEmpty)...[
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 15),
                      child: Row(
                        children: [
                          Text(
                              "Product Item",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade50,
                            ),
                            child: Text(
                             "${product.productItemList.length}",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: product.productItemList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return  Container(
                          margin: EdgeInsets.only(left: 15,right: 15,top: 10),
                          padding: EdgeInsets.all(15),
                          decoration: CommonDecorations.card(),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Icon(
                                      Icons.inventory_2_outlined,
                                      color: Colors.green,
                                      size: 20,

                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.productItemList[index].productName,
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                       "Job: ${product.productItemList[index].jobNumber}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              _productItem(
                                "Category",
                                product.productItemList[index].categoryName,
                                Icons.folder_outlined,
                              ),
                              _productItem(
                                "Sub-Category",
                                product.productItemList[index].subCategoryName,
                                Icons.folder_special,
                              ),
                              _productItem(
                                "Brand",
                                product.productItemList[index].brandName,
                                Icons.branding_watermark_outlined,
                              ),
                              _productItem(
                                "Quantity",
                                product.productItemList[index].qty,
                                Icons.note_add,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ]
                ],
              ),
            );
          }
          else if(state is FailureProductDetailsState){
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _productItem(
      String type,
      String value,
      IconData icon,
      ){
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.black54,
          ),
          SizedBox(width: 10,),
          Text(
            "$type:",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(width: 3,),
          Text(
            value,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }

}

class Product extends StatelessWidget {
  final String type;
  final String value;
  final Color color;
  final IconData icon;
  final Color? valueColor;

  const Product({
    required this.type,
    required this.value,
    required this.color,
    required this.icon,
    this.valueColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: color,
                )
              ),
              SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                      color: valueColor ?? Colors.black,
                    ),
                  )
                ],
              ),

            ],
          ),
          Divider(
            color: Colors.black12,
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class Tax extends StatelessWidget {
  final String name;
  final String rate;

  const Tax({
    required this.name,
    required this.rate,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "$rate%",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500
              ),
            ),
          )
        ],
      ),
    );
  }
}

