sealed class CategoriesViewIntents {}

class GetProductsByCategoryIntent extends CategoriesViewIntents {
  final String? categoryId;

  GetProductsByCategoryIntent({this.categoryId});
}
