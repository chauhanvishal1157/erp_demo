class CustomerDetailsModel{
  final int id;
  final String createdBy;
  final String updatedBy;
  final String branchId;
  final String productId;
  final String visitAreaId;
  final String customerName;
  final String email;
  final String mobileNo;
  final String whatsappNo;
  final String customerCompanyName;
  final String gstNo;
  final String address;
  final String latitude;
  final String longitude;
  final int customerLevelId;
  final String status;
  final String checkInCheckOutStatus;
  final String createdAt;
  final String updatedAt;
  final String customerLevelName;
  final String branchName;
  final String productName;

  CustomerDetailsModel({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.branchId,
    required this.productId,
    required this.visitAreaId,
    required this.customerName,
    required this.email,
    required this.mobileNo,
    required this.whatsappNo,
    required this.customerCompanyName,
    required this.gstNo,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.customerLevelId,
    required this.status,
    required this.checkInCheckOutStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.customerLevelName,
    required this.branchName,
    required this.productName,
});

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      id: json['id'] ?? 0,
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'] ?? '',
      branchId: json['branch_id'] ?? '',
      productId: json['product_id'] ?? '',
      visitAreaId: json['visit_area_id'] ?? '',
      customerName: json['customer_name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      customerCompanyName: json['customer_company_name'] ?? '',
      gstNo: json['gst_no'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      customerLevelId: json['customer_level_id'] ?? 0,
      status: json['status'] ?? '',
      checkInCheckOutStatus: json['check_in_check_out_status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      customerLevelName: json['customer_level_name'] ?? '',
      branchName: json['branch_name'] ?? '',
      productName: json['product_name'] ?? '',
    );
  }

}