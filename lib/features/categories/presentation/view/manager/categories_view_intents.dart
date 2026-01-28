import 'package:flower_app/features/categories/presentation/view/manager/sort_enum.dart';

sealed class CategoriesViewIntents {}

class InitCategoriesViewIntent extends CategoriesViewIntents {
  int? index;

  InitCategoriesViewIntent({this.index});
}

class GetProductsByCategoryIntent extends CategoriesViewIntents {
  final String categoryId;

  GetProductsByCategoryIntent({required this.categoryId});
}

class CategoriesFilterIntent extends CategoriesViewIntents {
  SortBy sortBy;

  CategoriesFilterIntent({required this.sortBy});
}

class GetProductByFilterIntent extends CategoriesViewIntents {}
