import 'package:equatable/equatable.dart';

import '../../model/city_model/city_model.dart';

abstract class CityListState extends Equatable{
  
  @override
  List<Object> get props => [];
}


class InitialCityListState extends CityListState{}

class LoadingCityListState extends CityListState{}

class LoadedCityListState extends CityListState{
  final List<CityModel> list;

  LoadedCityListState({required this.list});

  @override
  List<Object> get props => [list];

}

class FailureCityListState extends CityListState{
  final String error;

  FailureCityListState({required this.error});

  @override
  List<Object> get props => [error];

}