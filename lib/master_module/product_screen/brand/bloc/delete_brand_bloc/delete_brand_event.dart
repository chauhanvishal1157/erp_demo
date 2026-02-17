import 'package:equatable/equatable.dart';

abstract class DeleteBrandEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class DeleteBrandEvents extends DeleteBrandEvent{
  final String brandId;

  DeleteBrandEvents({
    required this.brandId,
  });
  @override
  List<Object> get props => [brandId];
}