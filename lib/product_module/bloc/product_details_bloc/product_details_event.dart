import 'package:equatable/equatable.dart';

abstract class ProductDetailsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchProductDetailsEvent extends ProductDetailsEvent {
  final String productId;

  FetchProductDetailsEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}

