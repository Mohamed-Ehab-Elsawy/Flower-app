sealed class OccasionsEvents {}

class GetAllProductsByOccasionsEvents extends OccasionsEvents {
  final String occasionId;

  GetAllProductsByOccasionsEvents({required this.occasionId});
}
