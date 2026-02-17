import 'package:equatable/equatable.dart';

abstract class CreateEditBrandEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class CreateBrandEvent extends CreateEditBrandEvent{
  final String brandName;
  final String status;
  CreateBrandEvent({
    required this.brandName,
    required this.status,
  });
  @override
  List<Object> get props => [brandName,status];
}

class EditBrandEvent extends CreateEditBrandEvent{
  final String brandId;
  final String brandName;
  final String status;
  EditBrandEvent({
    required this.brandId,
    required this.brandName,
    required this.status,
  });
  @override
  List<Object> get props => [brandId,brandName,status];

}


