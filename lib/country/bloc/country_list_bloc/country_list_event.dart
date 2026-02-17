import 'package:equatable/equatable.dart';

abstract class CountryListEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchCountryListEvent extends CountryListEvent{
  final String searchValue;

  FetchCountryListEvent({
    required this.searchValue,
  });

  @override
  List<Object> get props => [searchValue];
}
