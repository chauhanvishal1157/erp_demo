class CustomerListModel{
  final int id;
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
  final String customerLevelName;
  final List<CustomerProduct> products;

  CustomerListModel({
    required this.id,
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
    required this.customerLevelName,
    required this.products,
});

}

class CustomerProduct {
  final int id;
  final String name;

  CustomerProduct({
    required this.id,
    required this.name,
  });

  factory CustomerProduct.fromJson(Map<String, dynamic> json) {
    return CustomerProduct(
      id: json['id'],
      name: json['name'],
    );
  }
}

