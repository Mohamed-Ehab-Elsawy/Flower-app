import 'package:flower_app/features/home/data/models/best_seller_response.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';
import 'package:flower_app/features/home/domain/mapper/best_seller_mapper.dart';

extension BestSellerResponseMapperX on BestSellerResponse {
  BestSellerEntity toModel() => BestSellerEntity(
    massage: message,
    bestSellerItemEntityList: bestSeller
        ?.map((item) => item.toModel())
        .toList(),
  );
}
