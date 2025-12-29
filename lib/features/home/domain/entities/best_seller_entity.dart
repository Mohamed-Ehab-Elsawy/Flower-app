import 'package:equatable/equatable.dart';

class BestSellerEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imgCover;
  final List<String> images;
  final num price;
  final num priceAfterDiscount;
  final double discountPercentage;
  final int quantity;
  final int sold;
  final num rateAvg;

  const BestSellerEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.discountPercentage,
    required this.quantity,
    required this.sold,
    required this.rateAvg,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imgCover,
    images,
    price,
    priceAfterDiscount,
    discountPercentage,
    quantity,
    sold,
    rateAvg,
  ];
}
