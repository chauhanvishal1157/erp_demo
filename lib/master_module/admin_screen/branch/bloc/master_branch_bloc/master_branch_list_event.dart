import 'package:equatable/equatable.dart';

abstract class BranchListEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBranchListEvents extends BranchListEvents {
  final String multipleBranchId;
  final String searchValue;


  FetchBranchListEvents({
   required this.searchValue,
    required this.multipleBranchId,

  });

  @override
  List<Object> get props => [multipleBranchId,searchValue];

}

class LoadMoreBranchListEvent extends BranchListEvents {}