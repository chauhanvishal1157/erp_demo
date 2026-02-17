import 'package:equatable/equatable.dart';

abstract class DeleteCategoryMasterEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class DeleteCategoryMasterEvents extends DeleteCategoryMasterEvent{
  final String categoryId;

  DeleteCategoryMasterEvents({
    required this.categoryId,
  });
  @override
  List<Object> get props => [categoryId];
}