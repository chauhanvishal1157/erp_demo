class ProductListModel {
  final int id;
  final String jobNumber;
  final String productSerialNumber;
  final String name;
  final String description;
  final String hsnCode;
  final int categoryId;
  final String categoryName;
  final int subCategoryId;
  final String subCategoryName;
  final String orderId;
  final int brandId;
  final String brandName;
  final int unitId;
  final String unitName;
  final int tax1Id;
  final String tax1Rate;
  final String tax1Name;
  final int tax2Id;
  final String tax2Rate;
  final String tax2Name;
  final int tax3Id;
  final String tax3Rate;
  final String tax3Name;
  final String cessTax;
  final int productTypeId;
  final String productTypeName;
  final String status;
  final String qty;
  final int taxOrNot;
  final String productPrice;
  final String maxPurchasePrice;
  final List<ProductItemList> productItemList;

  ProductListModel({
    required this.id,
    required this.jobNumber,
    required this.productSerialNumber,
    required this.name,
    required this.description,
    required this.hsnCode,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.orderId,
    required this.brandId,
    required this.brandName,
    required this.unitId,
    required this.unitName,
    required this.tax1Id,
    required this.tax1Rate,
    required this.tax1Name,
    required this.tax2Id,
    required this.tax2Rate,
    required this.tax2Name,
    required this.tax3Id,
    required this.tax3Rate,
    required this.tax3Name,
    required this.cessTax,
    required this.productTypeId,
    required this.productTypeName,
    required this.status,
    required this.qty,
    required this.taxOrNot,
    required this.productPrice,
    required this.maxPurchasePrice,
    required this.productItemList,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['id'],
      jobNumber: json['job_number'] ?? '',
      productSerialNumber: json['product_serial_number'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      hsnCode: json['hsn_code'] ?? '',
      categoryId: json['category_id'],
      categoryName: json['category_name'] ?? '',
      subCategoryId: json['sub_category_id'],
      subCategoryName: json['subCategory_name'] ?? '',
      orderId: json['order_id'] ?? '',
      brandId: json['brand_id'],
      brandName: json['brand_name'] ?? '',
      unitId: json['unit_id'],
      unitName: json['unit_name'] ?? '',
      tax1Id: json['tax1_id'],
      tax1Rate: json['tax1_rate'] ?? '',
      tax1Name: json['tax1_name'] ?? '',
      tax2Id: json['tax2_id'],
      tax2Rate: json['tax2_rate'] ?? '',
      tax2Name: json['tax2_name'] ?? '',
      tax3Id: json['tax3_id'],
      tax3Rate: json['tax3_rate'] ?? '',
      tax3Name: json['tax3_name'] ?? '',
      cessTax: json['cess_tax'] ?? '',
      productTypeId: json['product_type_id'],
      productTypeName: json['product_type_name'] ?? '',
      status: json['status'] ?? '',
      qty: json['qty'] ?? '',
      taxOrNot: json['taxOrNot'],
      productPrice: json['product_price'] ?? '',
      maxPurchasePrice: json['max_purchase_price'] ?? '',
      productItemList: (json['productItemList'] as List)
          .map((e) => ProductItemList.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "job_number": jobNumber,
      "product_serial_number": productSerialNumber,
      "name": name,
      "description": description,
      "hsn_code": hsnCode,
      "category_id": categoryId,
      "category_name": categoryName,
      "sub_category_id": subCategoryId,
      "subCategory_name": subCategoryName,
      "order_id": orderId,
      "brand_id": brandId,
      "brand_name": brandName,
      "unit_id": unitId,
      "unit_name": unitName,
      "tax1_id": tax1Id,
      "tax1_rate": tax1Rate,
      "tax1_name": tax1Name,
      "tax2_id": tax2Id,
      "tax2_rate": tax2Rate,
      "tax2_name": tax2Name,
      "tax3_id": tax3Id,
      "tax3_rate": tax3Rate,
      "tax3_name": tax3Name,
      "cess_tax": cessTax,
      "product_type_id": productTypeId,
      "product_type_name": productTypeName,
      "status": status,
      "qty": qty,
      "taxOrNot": taxOrNot,
      "product_price": productPrice,
      "max_purchase_price": maxPurchasePrice,
      "productItemList":
      productItemList.map((e) => e.toJson()).toList(),
    };
  }
}


class ProductItemList {
  final int id;
  final int categoryId;
  final String categoryName;
  final int subCategoryId;
  final String subCategoryName;
  final int brandId;
  final String brandName;
  final int productid;
  final String jobNumber;
  final String productName;
  final int productQty;
  final String productPrice;
  final String subProductMaxPurchasePrice;
  final String subProductUsedQty;
  final String qty;
  final String description;

  ProductItemList({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.brandId,
    required this.brandName,
    required this.productid,
    required this.jobNumber,
    required this.productName,
    required this.productQty,
    required this.productPrice,
    required this.subProductMaxPurchasePrice,
    required this.subProductUsedQty,
    required this.qty,
    required this.description,
  });

  factory ProductItemList.fromJson(Map<String, dynamic> json) {
    return ProductItemList(
      id: json['id'],
      categoryId: json['categoryId'],
      categoryName: json['category_name'] ?? '',
      subCategoryId: json['subCategoryId'],
      subCategoryName: json['subCategory_name'] ?? '',
      brandId: json['brandId'],
      brandName: json['brand_name'] ?? '',
      productid: json['productid'],
      jobNumber: json['job_number'] ?? '',
      productName: json['product_name'] ?? '',
      productQty: json['product_qty'],
      productPrice: json['product_price'] ?? '',
      subProductMaxPurchasePrice:
      json['sub_product_max_purchase_price'] ?? '',
      subProductUsedQty: json['sub_product_used_qty'] ?? '',
      qty: json['qty'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "categoryId": categoryId,
      "category_name": categoryName,
      "subCategoryId": subCategoryId,
      "subCategory_name": subCategoryName,
      "brandId": brandId,
      "brand_name": brandName,
      "productid": productid,
      "job_number": jobNumber,
      "product_name": productName,
      "product_qty": productQty,
      "product_price": productPrice,
      "sub_product_max_purchase_price":
      subProductMaxPurchasePrice,
      "sub_product_used_qty": subProductUsedQty,
      "qty": qty,
      "description": description,
    };
  }
}

