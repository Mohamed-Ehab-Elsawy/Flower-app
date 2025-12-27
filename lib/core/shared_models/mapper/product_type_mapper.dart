import 'package:flower_app/core/shared_models/models/product_type_dto.dart';
import 'package:flower_app/core/shared_models/entities/product_type_entity.dart';

extension ProductTypeDtoX on ProductTypeDto {
  ProductTypeEntity toEntity() => ProductTypeEntity(
    id: id,
    name: name,
    slug: slug,
    image: image,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isSuperAdmin: isSuperAdmin,
  );
}
