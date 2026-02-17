class SubCategoryListModel{

  final int subCategoryId;
  final String subCategoryName;
  final int status;
  final int categoryId;
  final String categoryName;

  SubCategoryListModel({
    required this.categoryId,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.status,
    required this.categoryName,
  });
}