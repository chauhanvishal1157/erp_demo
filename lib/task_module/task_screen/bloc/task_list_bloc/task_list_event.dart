import 'package:equatable/equatable.dart';

abstract class TaskListEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class FetchTaskListEvent extends TaskListEvent {}


