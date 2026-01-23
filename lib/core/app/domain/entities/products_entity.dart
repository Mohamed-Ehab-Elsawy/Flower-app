import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  finalString? id;
  finalString? title;
  finalString? slug;
  finalString? description;
  finalString? imageCover;
  finalList<String>? images;
  finaldouble? price;
  finaldouble? priceAfterDiscount;
  finalint? quantity;
  finalString? categoryId;
  finalString? occasionId;
  finalDateTime? createdAt;
  finalDateTime? updatedAt;
  finalbool? isSuperAdmin;
  finalint? sold;
  finaldouble? ratingAverage;
  finalint? ratingCount;
  final double? discount;

  constProductsEntity({
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
