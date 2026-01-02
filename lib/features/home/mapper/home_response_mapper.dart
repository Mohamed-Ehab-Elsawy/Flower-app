import 'package:flower_app/core/app/data/mapper/product_mapper.dart';
import 'package:flower_app/core/app/data/mapper/product_type_mapper.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';

extension HomeResponseMapperX on HomeResponseDto {
  HomeResponseEntity toEntity() {
    return HomeResponseEntity(
      bestSeller: bestSeller?.map((element) => element.toEntity()).toList(),
      categories: categories?.map((element) => element.toEntity()).toList(),
      occasions: occasions?.map((element) => element.toEntity()).toList(),
      products: products?.map((element) => element.toEntity()).toList(),
      message: message,
    );
  }
}
