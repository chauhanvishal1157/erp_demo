import 'package:equatable/equatable.dart';

abstract class EmployeeListEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchEmployeeListEvent extends EmployeeListEvent {
  final String searchValue;

  FetchEmployeeListEvent({required this.searchValue});

  @override
  List<Object> get props => [searchValue];
}



