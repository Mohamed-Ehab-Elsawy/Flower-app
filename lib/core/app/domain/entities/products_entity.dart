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
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imageCover,
    this.images,
    int? quantity,
    double? price,
    double? priceAfterDiscount,
    this.categoryId,
    this.occasionId,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
    this.sold,
    this.ratingAverage,
    this.ratingCount,
    this.discount,
  })  : quantity = quantity ?? 1,
       price = price ?? 0.0,
       priceAfterDiscount = priceAfterDiscount ?? price ?? 0.0;

  bool get outOfStock => (quantity ?? 0) <= 0;

  double get totalPrice => (price ?? 0.0) * (quantity ?? 1);

  double get totalPriceAfterDiscount =>
      (priceAfterDiscount ?? price ?? 0.0) * totalPrice;

  bool get hasDiscount =>
      (discount != null && price != null) ? discount! < price! : false;

  double get priceHasDiscount =>
      hasDiscount ? (priceAfterDiscount ?? price ?? 0.0) : (price ?? 0.0);

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
