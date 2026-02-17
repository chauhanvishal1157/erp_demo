import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteProductListEvent extends Equatable{
  @override
  List<Object> get props => [];
}


class CreateProductListEvent extends CreateEditDeleteProductListEvent{

  final String categoryId;
  final String categoryName;
  final String subCategoryId;
  final String subCategoryName;
  final String brandId;
  final String brandName;
  final String unitId;
  final String unitName;
  final String name;
  final String productTypeId;
  final String productTypeName;
  final String productPrice;
  final String qty;
  final String tax1Name;
  final String tax1Rate;
  final String tax2Name;
  final String tax2Rate;
  final String tax3Name;
  final String tax3Rate;
  final String productData;
  final String description;
  final String hsnCode;
  final String jobNumber;

  CreateProductListEvent({
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.brandId,
    required this.brandName,
    required this.unitId,
    required this.unitName,
    required this.name,
    required this.productTypeId,
    required this.productTypeName,
    required this.productPrice,
    required this.qty,
    required this.tax1Name,
    required this.tax1Rate,
    required this.tax2Name,
    required this.tax2Rate,
    required this.tax3Name,
    required this.tax3Rate,
    required this.productData,
    required this.description,
    required this.hsnCode,
    required this.jobNumber,


  });
}

class EditProductListEvent extends CreateEditDeleteProductListEvent{
  final String productId;
  final String categoryId;
  final String categoryName;
  final String subCategoryId;
  final String subCategoryName;
  final String brandId;
  final String brandName;
  final String unitId;
  final String unitName;
  final String name;
  final String productTypeId;
  final String productTypeName;
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

  EditProductListEvent({
    required this.productId,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.brandId,
    required this.brandName,
    required this.unitId,
    required this.unitName,
    required this.name,
    required this.productTypeId,
    required this.productTypeName,
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

});

  @override
  List<Object> get props => [];



}

class DeleteProductListEvent extends CreateEditDeleteProductListEvent{
  final String productItemId;
  DeleteProductListEvent({
    required this.productItemId,
  });

  @override
  List<Object> get props => [];
}
