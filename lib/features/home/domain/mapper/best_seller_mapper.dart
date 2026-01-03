import 'package:flower_app/core/app/domain/entities/products_entity.dart';
import 'package:flower_app/features/home/data/models/best_seller_dto.dart';

extension BestSellerDtoMapper on BestSellerDto {
  ProductsEntity toProductsEntity() {
    double? discountPercent;
    if (price != null && price! > 0 && priceAfterDiscount != null) {
      discountPercent = ((price! - priceAfterDiscount!) / price!) * 100;
    }

    return ProductsEntity(
      id: id,
      title: title,
      description: description,
      imageCover: imgCover,
      images: images,
      price: price?.toDouble(),
      priceAfterDiscount: priceAfterDiscount?.toDouble(),
      discount: discountPercent,
      quantity: quantity,
      sold: sold,
      ratingAverage: rateAvg?.toDouble(),
    );
  }
}
