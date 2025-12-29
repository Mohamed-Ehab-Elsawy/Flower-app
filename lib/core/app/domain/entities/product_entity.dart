// lib/domain/entities/product_entity.dart
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
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

  const ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imageCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.categoryId,
    this.occasionId,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
    this.sold,
    this.ratingAverage,
    this.ratingCount,
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
