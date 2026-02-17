import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteSubCategoryEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class CreateSubCategoryEvent extends CreateEditDeleteSubCategoryEvent{
  final String categoryId;
  final String categoryName;
  final String subCategoryName;
  final String status;

  CreateSubCategoryEvent({
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryName,
    required this.status,
  });

  @override
  List<Object> get props => [
    categoryId,
    categoryName,
    subCategoryName,
    status,
  ];

}

class EditSubCategoryEvent extends CreateEditDeleteSubCategoryEvent{
  final String subCategoryId;
  final String categoryId;
  final String categoryName;
  final String subCategoryName;
  final String status;

  EditSubCategoryEvent({
    required this.subCategoryId,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryName,
    required this.status,
  });

  @override
  List<Object> get props => [
    subCategoryId,
    categoryId,
    subCategoryName,
    categoryName,
    status,
  ];


}

class DeleteSubCategoryEvent extends CreateEditDeleteSubCategoryEvent{

  final String subCategoryId;

  DeleteSubCategoryEvent({
    required this.subCategoryId,
  });

  @override
  List<Object> get props => [
    subCategoryId,
  ];

}

