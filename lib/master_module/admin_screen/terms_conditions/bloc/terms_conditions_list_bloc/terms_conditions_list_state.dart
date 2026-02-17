import 'package:equatable/equatable.dart';
import 'package:erp_demo/master_module/admin_screen/terms_conditions/model/terms_conditions_list_model.dart';

abstract class TermsConditionsListStates extends Equatable{

  @override
  List<Object> get props => [];

}

class InitialTermsConditionsListStates extends TermsConditionsListStates{}

class LoadingTermsConditionsListStates extends TermsConditionsListStates{}

class LoadedTermsConditionsListStates extends TermsConditionsListStates{

  final List<TermsConditionsListModel> list;
  final bool hasNextPage;
  final int totalCount;

  LoadedTermsConditionsListStates({
    required this.list,
    required this.hasNextPage,
    required this.totalCount,
  });

  @override
  List<Object> get props => [list,hasNextPage];

}

class FailureTermsConditionsListStates extends TermsConditionsListStates{
  final String error;

  FailureTermsConditionsListStates({
    required this.error,
  });
  @override
  List<Object> get props => [error,];
}