import 'package:equatable/equatable.dart';

abstract class CreateEditCategoryMasterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateCategoryMasterEvent extends CreateEditCategoryMasterEvent {
  final String categoryName;
  final String status;

  CreateCategoryMasterEvent({
    required this.categoryName,
    required this.status,
  });
  @override
  List<Object> get props => [categoryName,status];
}

class EditCategoryMasterEvent extends CreateEditCategoryMasterEvent{
  final String categoryName;
  final String status;
  final String categoryId;

  EditCategoryMasterEvent({
    required this.categoryName,
    required this.status,
    required this.categoryId,
  });

  @override
  List<Object> get props => [categoryName,categoryId,status];

}