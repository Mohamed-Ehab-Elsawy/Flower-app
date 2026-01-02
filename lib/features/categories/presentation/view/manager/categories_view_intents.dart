sealed class CategoriesViewIntents {}

class InitCategoriesViewIntent extends CategoriesViewIntents {}


class GetProductsByCategoryIntent extends CategoriesViewIntents {
  final String? categoryId;

  GetProductsByCategoryIntent({this.categoryId});
}
