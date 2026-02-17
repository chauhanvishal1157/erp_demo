import 'package:equatable/equatable.dart';

abstract class DispatchListEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchDispatchListEvent extends DispatchListEvent {}