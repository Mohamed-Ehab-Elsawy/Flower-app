import 'package:flower_app/core/app/domain/entities/products_entity.dart';

sealed class SearchIntent {}

final class SearchKeywordChanged extends SearchIntent {
  final String keyword;
  SearchKeywordChanged(this.keyword);
}

class SearchCleared extends SearchIntent {}

final class ProductTapped extends SearchIntent {
  final ProductsEntity product;
  ProductTapped(this.product);
}

sealed class SearchUIEvents {}

final class OpenProductDetails extends SearchUIEvents {
  final ProductsEntity product;
  OpenProductDetails({required this.product});
}
