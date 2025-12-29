sealed class OccasionsEvents {}

sealed class OccasionsUiEvent {}

class GetAllProductsByOccasionsEvents extends OccasionsEvents {
  final String occasionId;

  GetAllProductsByOccasionsEvents({required this.occasionId});
}

class NavigateToProductDetails extends OccasionsUiEvent {}
