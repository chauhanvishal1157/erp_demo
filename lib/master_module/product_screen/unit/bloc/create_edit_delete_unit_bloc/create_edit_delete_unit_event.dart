import 'package:equatable/equatable.dart';

abstract  class CreateEditDeleteUnitEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CreateUnitEvent extends CreateEditDeleteUnitEvent{
  final String unitName;
  final String status;

  CreateUnitEvent({
    required this.unitName,
    required this.status,
  });
  @override
  List<Object> get props => [unitName,status];
}

class EditUnitEvent extends CreateEditDeleteUnitEvent{
  final String unitId;
  final String unitName;
  final String status;


  EditUnitEvent({
    required this.unitName,
    required this.status,
    required this.unitId,
  });
  @override
  List<Object> get props => [unitName,status,unitId];
}

class DeleteUnitEvent extends CreateEditDeleteUnitEvent{
  final String unitId;

  DeleteUnitEvent({
    required this.unitId,
  });
  @override
  List<Object> get props => [unitId];
}


