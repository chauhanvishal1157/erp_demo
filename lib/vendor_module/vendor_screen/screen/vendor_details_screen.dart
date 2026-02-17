import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/vendor_module/vendor_screen/bloc/vendor_details_bloc/vendor_details_bloc.dart';
import 'package:erp_demo/vendor_module/vendor_screen/bloc/vendor_details_bloc/vendor_details_event.dart';
import 'package:erp_demo/vendor_module/vendor_screen/bloc/vendor_details_bloc/vendor_details_state.dart';
import 'package:erp_demo/vendor_module/vendor_screen/screen/create_update_vendor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../common/app_color.dart';

class VendorDetailsScreen extends StatefulWidget {
  final String vendorId;

  const VendorDetailsScreen({
    required this.vendorId,
    super.key});

  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context) => VendorDetailsBloc(),
      child: VendorDetailsScreenWidget(
        vendorId: widget.vendorId,
      ),
    );
  }
}


class VendorDetailsScreenWidget extends StatefulWidget {
  final String vendorId;
  const VendorDetailsScreenWidget({
    required this.vendorId,
    super.key});

  @override
  State<VendorDetailsScreenWidget> createState() => _VendorDetailsScreenWidgetState();
}

class _VendorDetailsScreenWidgetState extends State<VendorDetailsScreenWidget> {


  @override
  void initState() {
    BlocProvider.of<VendorDetailsBloc>(context).add(
       FetchVendorDetailsEvent(vendorId: widget.vendorId)
    );
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorDetailsBloc, VendorDetailsState>(
      builder: (context, state) {
        if (state is InitialVendorDetailsState) {
          return  Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadingVendorDetailsState){
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadedVendorDetailsState){

          final vendor = state.list.first;

          return   Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          vendor.vendorName[0],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vendor Details",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              vendor.vendorName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateUpdateVendorScreen(
                                      isEdit: true,
                                      vendorId: widget.vendorId,
                                      vendorName: vendor.vendorName,
                                      vendorEmail: vendor.vendorEmail,
                                      vendorMobileNo: vendor.mobileNumber,
                                      address: vendor.address,
                                     vendorLevel: vendor.vendorLevelName,
                                    vendorLevelId: vendor.vendorLevelId.toString(),
                                     productId: vendor.productId.toString(),
                                     productName: vendor.productName,
                                      branchId: vendor.branchId.toString(),
                                     branchName: vendor.branchName,
                                    vendorWhatsAppNo: vendor.whatsappNo,
                                     gstNo: vendor.gstNo,
                                    countryId: vendor.countryId,
                                    stateId: vendor.stateId,
                                    cityId: vendor.cityId,
                                    countryName: vendor.countryName,
                                    stateName: vendor.stateName,
                                    cityName: vendor.cityName,
                                  )
                              )
                          ).then(
                              (value){
                                if(value == true){
                                  BlocProvider.of<VendorDetailsBloc>(context).add(
                                      FetchVendorDetailsEvent(vendorId: widget.vendorId)
                                  );
                                }
                              }
                          );
                        },
                        child: Container(
                         padding: const EdgeInsets.all(6),
                         decoration: BoxDecoration(
                           color: Colors.blue.shade50,
                           border: Border.all(color: Colors.blue.shade100),
                           borderRadius: BorderRadius.circular(6),
                         ),
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: AppColors.primary,
                            )
                                             ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.close_sharp,
                              size: 20,
                              color: Colors.grey,
                            )
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Basic Information",
                    style: TextStyle(
                      color: Colors.black87.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    )
                  ),
                  if(vendor.vendorCompanyName.isNotEmpty)...[
                    _information(
                        "COMPANY NAME",
                        vendor.vendorCompanyName,
                        Icons.business_outlined
                    )
                  ],
                  if(vendor.vendorEmail.isNotEmpty)...[
                    _information(
                        "EMAIL ADDRESS",
                        vendor.vendorEmail,
                        Icons.email_outlined
                    )
                  ],
                  if(vendor.mobileNumber.isNotEmpty)...[
                    _information(
                        "MOBILE NUMBER",
                        vendor.mobileNumber,
                        Icons.phone_outlined,
                       isLink: true,
                    )
                  ],
                  if(vendor.whatsappNo.isNotEmpty)...[
                    _information(
                        "WHATSAPP NUMBER",
                        vendor.whatsappNo,
                        Icons.message_outlined,
                        isLink: true,
                    )
                 ],
                  Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 5),
                    child: Text(
                        "Business Information",
                        style: TextStyle(
                          color: Colors.black87.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        )
                    ),
                  ),
                  if(vendor.branchName.isNotEmpty)...[
                    _information(
                        "BRANCH NAME",
                        vendor.branchName,
                        Icons.location_on_outlined
                    )

                  ],
                  if(vendor.productName.isNotEmpty)...[
                    _information(
                        "PRODUCT NAME",
                        vendor.productName,
                        Icons.shopping_bag_outlined
                    )

                  ],
                  if(vendor.address.isNotEmpty)...[
                    _information(
                        "ADDRESS",
                        vendor.address,
                        Icons.location_on
                    )
                  ]
                ],
              ),
            ),
          );
        }
        else if(state is FailureVendorDetailsState){
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    );
  }

  Widget _information (
      String label,
      String value,
      IconData icon, {
        bool isLink = false,
      }){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: CommonDecorations.card(),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                size: 20,
                color: AppColors.primary,
              )
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                 value,
                  style:  TextStyle(
                    color: isLink ? AppColors.primary : Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration:
                    isLink ? TextDecoration.underline : TextDecoration.none,
                    decorationColor: AppColors.primary
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
