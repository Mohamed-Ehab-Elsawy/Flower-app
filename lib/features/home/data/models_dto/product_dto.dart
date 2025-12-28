import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductsDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "priceAfterDiscount")
  final int? priceAfterDiscount;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "occasion")
  final String? occasion;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "favoriteId")
  final dynamic? favoriteId;
  @JsonKey(name: "isInWishlist")
  final bool? isInWishlist;

  ProductsDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.V,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.favoriteId,
    this.isInWishlist,
  });

  factory ProductsDto.fromJson(Map<String, dynamic> json) {
    return _$ProductsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsDtoToJson(this);
  }

  ProductsEntity toEntity() => ProductsEntity(
    id: id,
    category: category,
    description: description,
    imgCover: imgCover,
    images: images,
    price: price,
    priceAfterDiscount: priceAfterDiscount,
    quantity: quantity,
    title: title,
    slug: slug,
    createdAt: createdAt,
    updatedAt: updatedAt,
    V: V,
    isSuperAdmin: isSuperAdmin,
    sold: sold,
    rateAvg: rateAvg,
    rateCount: rateCount,
    favoriteId: favoriteId,
    isInWishlist: isInWishlist,
    occasion: occasion
  );
}
