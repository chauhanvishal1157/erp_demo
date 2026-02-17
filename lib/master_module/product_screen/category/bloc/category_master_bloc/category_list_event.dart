import 'package:equatable/equatable.dart';

abstract class CategoryListEvents extends Equatable{

  @override
  List<Object> get props => [];
}

class FetchCategoryListEvents extends CategoryListEvents{}