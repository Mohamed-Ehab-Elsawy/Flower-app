// lib/core/shared_models/mapper/product_mapper.dart

import 'package:flower_app/core/app/data/models/products_dto.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';

extension ProductModelX on ProductsDto {
  ProductsEntity toEntity() => ProductsEntity(
    id: id,
    title: title,
    slug: slug,
    description: description,
    imageCover: imgCover,
    images: images,
    price: price,
    priceAfterDiscount: priceAfterDiscount,
    quantity: quantity,
    categoryId: category,
    occasionId: occasion,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isSuperAdmin: isSuperAdmin,
    sold: sold,
    ratingAverage: rateAvg,
    ratingCount: rateCount,
    discount: discount,
  );
}
