import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  String? id;
  String? title;
  String? slug;
  String? description;
  String? imageCover;
  List<String>? images;
  double? price;
  double? priceAfterDiscount;
  int? quantity;
  String? categoryId;
  String? occasionId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isSuperAdmin;
  int? sold;
  double? ratingAverage;
  int? ratingCount;
  double? discount;

  ProductsEntity({
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
