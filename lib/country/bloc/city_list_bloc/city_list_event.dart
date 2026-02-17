import 'package:equatable/equatable.dart';

abstract class CityListEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchCityListEvent extends CityListEvent{
  final String stateId;

  FetchCityListEvent({required this.stateId});
}
