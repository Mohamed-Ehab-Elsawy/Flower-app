import 'package:flower_app/features/home/data/models_dto/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/shared_models/models/product_dto.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "products")
  final List<ProductsDto>? productsDto;

  ProductResponse ({
    this.message,
    this.metadata,
    this.productsDto,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductResponseToJson(this);
  }
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  Metadata ({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataToJson(this);
  }
}



