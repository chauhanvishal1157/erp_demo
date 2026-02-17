import 'package:equatable/equatable.dart';

abstract class StateListEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchStateListEvent extends StateListEvent{
  final String countryId;

  FetchStateListEvent({required this.countryId});
}
