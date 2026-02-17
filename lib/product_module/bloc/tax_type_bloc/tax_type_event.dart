import 'package:equatable/equatable.dart';

abstract class TaxTypeEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class FetchTaxTypeEvents extends TaxTypeEvent{

  final String taxType;

  FetchTaxTypeEvents({required this.taxType});


  @override
  List<Object?> get props => [];
}