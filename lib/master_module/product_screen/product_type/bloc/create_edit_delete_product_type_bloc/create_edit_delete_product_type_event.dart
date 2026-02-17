import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteProductTypeEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class CreateProductTypeEvent extends CreateEditDeleteProductTypeEvent{
  final String productName;
  final String status;

  CreateProductTypeEvent({
    required this.productName,
    required this.status,
  });

  @override
  List<Object> get props => [productName, status];
}

class EditProductTypeEvent extends CreateEditDeleteProductTypeEvent{
  final String productId;
  final String productName;
  final String status;

  EditProductTypeEvent({
    required this.productId,
    required this.productName,
    required this.status,
  });

  @override
  List<Object> get props => [productId, productName, status];
}

class DeleteProductTypeEvent extends CreateEditDeleteProductTypeEvent{
  final String productId;

  DeleteProductTypeEvent({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}
