import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imageCover;
  final List<String>? images;
  final double? price;
  final double? priceAfterDiscount;
  final int? quantity;
  final String? categoryId;
  final String? occasionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isSuperAdmin;
  final int? sold;
  final double? ratingAverage;
  final int? ratingCount;
  final double? discount;

  const ProductsEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imageCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.categoryId,
    required this.occasionId,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
    required this.sold,
    required this.ratingAverage,
    required this.ratingCount,
    this.discount,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    price,
    priceAfterDiscount,
    quantity,
    categoryId,
    occasionId,
    createdAt,
    updatedAt,
    sold,
    ratingAverage,
    ratingCount,
    discount,
  ];
}
