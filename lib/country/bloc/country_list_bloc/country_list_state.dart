import 'package:equatable/equatable.dart';
import 'package:erp_demo/country/model/country_model/country_model.dart';

abstract class CountryListState extends Equatable{

  @override
  List<Object> get props => [];
}

class InitialCountryListState extends CountryListState{}

class LoadingCountryListState extends CountryListState{}

class LoadedCountryListState extends CountryListState{
  final List<CountryModel> list;

  LoadedCountryListState({required this.list});

  @override
  List<Object> get props => [list];

}

class FailureCountryListState extends CountryListState{
  final String error;

  FailureCountryListState({required this.error});

  @override
  List<Object> get props => [error];

}