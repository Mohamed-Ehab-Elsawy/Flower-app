sealed class CategoriesViewIntents {}

class InitCategoriesViewIntent extends CategoriesViewIntents {
  int? index;

  InitCategoriesViewIntent({this.index});
}

class GetProductsByCategoryIntent extends CategoriesViewIntents {
  final String? categoryId;

  GetProductsByCategoryIntent({this.categoryId});
}
