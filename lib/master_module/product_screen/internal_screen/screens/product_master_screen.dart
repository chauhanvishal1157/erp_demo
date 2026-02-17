import 'package:erp_demo/common/common_list_tile_screen.dart';
import 'package:erp_demo/common/custom_app_bar.dart';
import 'package:erp_demo/master_module/product_screen/brand/screens/brand_screen.dart';
import 'package:erp_demo/master_module/product_screen/category/screens/category_master_screen.dart';
import 'package:erp_demo/master_module/product_screen/payment_term/screens/payment_terms_screen.dart';
import 'package:erp_demo/master_module/product_screen/product_type/screens/product_type_screen.dart';
import 'package:erp_demo/master_module/product_screen/sub_category/screens/sub_category_screen.dart';
import 'package:erp_demo/master_module/product_screen/tax_master/screens/tax_master_screen.dart';
import 'package:erp_demo/master_module/product_screen/unit/screens/unit_screen.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';

class ProductMasterScreen extends StatefulWidget {
  const ProductMasterScreen({super.key});

  @override
  State<ProductMasterScreen> createState() => _ProductMasterScreenState();
}

class _ProductMasterScreenState extends State<ProductMasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  AppColors.screenBg,
        appBar: CustomAppBar(
            leadingIcon:  Icons.delete_outline_outlined,
            title:  "Product Master",
            subtitle: "Manage Your Product catalog",
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  CommonListTile(
                      title: "Category",
                      subTitle: "Manage product categories",
                      icon: Icons.category_outlined,
                      color: Colors.blue,
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>CategoryMasterScreen(),
                        ),);
                      }
                  ),
                  CommonListTile(
                      title:  "Sub Category",
                      subTitle: "Manage product sub categories",
                      icon:  Icons.subdirectory_arrow_right,
                      color: Colors.green,
                      onTap:(){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>SubCategoryScreen(),
                        ),);
                      },
                  ),
                  CommonListTile(
                      title: "Brand",
                      subTitle: "Manage product brands",
                      icon:  Icons.branding_watermark_outlined,
                      color: Colors.purple,
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context)=>BrandScreen()
                        ),);
                      },
                  ),
                  CommonListTile(
                      title:"Tax Master",
                      subTitle:  "Manage tax configurations",
                      icon:  Icons.assignment_outlined,
                      color:  Colors.orange,
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>TaxMasterScreen(),
                        ),);
                      },
                  ),
                  CommonListTile(
                      title:  "Product Type",
                      subTitle: "Manage product type",
                      icon:  Icons.chair_outlined,
                      color:  Colors.greenAccent.shade700,
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context)=>ProductTypeScreen()
                        ),);
                      },
                  ),
                  CommonListTile(
                      title:  "Payment Term",
                      subTitle: "Manage payment terms",
                      icon:  Icons.payment,
                      color:  Colors.deepPurple.shade600,
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>PaymentTermsScreen(),
                        ),);
                      },
                  ),
                  CommonListTile(
                      title: "Unit",
                      subTitle: "Manage measurement units",
                      icon:  Icons.piano,
                      color: Colors.red,
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>UnitScreen(),
                        ),);
                      },
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.screenBg,
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Configure your Product Management settings.",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black54
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: 60,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primary,
                              Colors.cyan,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        )
    );
  }
}
