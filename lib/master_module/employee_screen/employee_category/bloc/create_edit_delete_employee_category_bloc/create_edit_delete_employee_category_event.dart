import 'package:equatable/equatable.dart';

abstract class CreateEditDeleteEmployeeCategoryEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class CreateEmployeeCategoryEvent extends CreateEditDeleteEmployeeCategoryEvent{
  final String employeeCategoryName;
  final String status;

  CreateEmployeeCategoryEvent({
    required this.employeeCategoryName,
    required this.status,
  });

  @override
  List<Object?> get props => [employeeCategoryName,status];
}

class EditEmployeeCategoryEvent extends CreateEditDeleteEmployeeCategoryEvent{
  final String employeeCategoryId;
  final String employeeCategoryName;
  final String status;

  EditEmployeeCategoryEvent({
    required this.employeeCategoryId,
    required this.employeeCategoryName,
    required this.status,
  });

  @override
  List<Object?> get props => [employeeCategoryId,employeeCategoryName,status];
}

class DeleteEmployeeCategoryEvent extends CreateEditDeleteEmployeeCategoryEvent{
  final String employeeCategoryId;

  DeleteEmployeeCategoryEvent({
    required this.employeeCategoryId,
  });

  @override
  List<Object?> get props => [employeeCategoryId];

}