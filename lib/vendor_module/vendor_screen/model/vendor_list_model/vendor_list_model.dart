class VendorListModel {
  final int id;
  final int createdBy;
  final int updatedBy;
  final String branchId;
  final String productId;
  final String vendorName;
  final String vendorEmail;
  final String mobileNumber;
  final String whatsappNo;
  final String vendorCompanyName;
  final String gstNo;
  final int vendorLevelId;
  final String countryId;
  final String stateId;
  final String cityId;
  final String address;
  final String latitude;
  final String longitude;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String vendorLevelName;
  final String branchName;
  final String vendorTransactionDate;
  final String countryName;
  final String stateName;
  final String cityName;
  final List<ProductModel> products;
  final String totalVendorPayment;
  final String totalGivenPayment;
  final String totalOutstandingPayment;

  VendorListModel({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.branchId,
    required this.productId,
    required this.vendorName,
    required this.vendorEmail,
    required this.mobileNumber,
    required this.whatsappNo,
    required this.vendorCompanyName,
    required this.gstNo,
    required this.vendorLevelId,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.vendorLevelName,
    required this.branchName,
    required this.vendorTransactionDate,
    required this.countryName,
    required this.stateName,
    required this.cityName,
    required this.products,
    required this.totalVendorPayment,
    required this.totalGivenPayment,
    required this.totalOutstandingPayment,
});

  factory VendorListModel.fromJson(Map<String, dynamic> json) {
    return VendorListModel(
      id: json['id'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      updatedBy: json['updated_by'] ?? 0,
      branchId: json['branch_id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      vendorName: json['vendor_name'] ?? '',
      vendorEmail: json['vendor_email'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      vendorCompanyName: json['vendor_company_name'] ?? '',
      gstNo: json['gst_no'] ?? '',
      vendorLevelId: json['vendor_level_id'] ?? 0,
      countryId: json['country_id']?.toString() ?? '',
      stateId: json['state_id']?.toString() ?? '',
      cityId: json['city_id']?.toString() ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      vendorLevelName: json['vendor_level_name'] ?? '',
      branchName: json['branch_name'] ?? '',
      vendorTransactionDate: json['vendor_transaction_date'] ?? '',
      countryName: json['country_name'] ?? '',
      stateName: json['state_name'] ?? '',
      cityName: json['city_name'] ?? '',
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      totalVendorPayment: json['totalVendorPayment']?.toString() ?? '0',
      totalGivenPayment: json['totalGivenPayment']?.toString() ?? '0',
      totalOutstandingPayment:
      json['totalOutstandingPayment']?.toString() ?? '0',
    );
  }
}

class ProductModel {
  final int id;
  final String name;

  ProductModel({
    required this.id,
    required this.name,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
