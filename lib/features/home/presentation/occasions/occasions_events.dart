import 'package:flower_app/core/app/domain/entities/product_entity.dart';

sealed class OccasionsEvents {}

sealed class OccasionsUiEvent {}

class GetAllProductsByOccasionsEvents extends OccasionsEvents {
  final String occasionId;

  GetAllProductsByOccasionsEvents({required this.occasionId});
}

class NavigateToProductDetails extends OccasionsUiEvent {
  ProductEntity product;

  NavigateToProductDetails({required this.product});
}
