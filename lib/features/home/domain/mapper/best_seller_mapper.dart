import 'package:flower_app/features/home/data/models/best_seller_dto.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_item_entity.dart';

extension BestSellerMapperX on BestSellerDto {
  BestSellerItemEntity toModel() {
    double discountPercent = 0;
    if (price != null && price! > 0 && priceAfterDiscount != null) {
      discountPercent = ((price! - priceAfterDiscount!) / price!) * 100;
    }
    return BestSellerItemEntity(
      id: id,
      title: title,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      discountPercentage: discountPercent,
      quantity: quantity,
      sold: sold,
      rateAvg: rateAvg,
    );
  }
}
